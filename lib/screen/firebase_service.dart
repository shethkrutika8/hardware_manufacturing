import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hardware_manufacturing/screen/product_model.dart';
import 'package:hardware_manufacturing/screen/cart_store.dart';

class FirebaseService {
  FirebaseService._();
  static final FirebaseService instance = FirebaseService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  FirebaseAuth get auth => _auth;
  FirebaseFirestore get firestore => _firestore;
  User? get currentUser => _auth.currentUser;
  String? get currentUid => _auth.currentUser?.uid;

  // =========================================================================
  // 1. AUTHENTICATION & USERS
  // =========================================================================

  /// Register a new user with email, password and profile data
  Future<UserCredential> registerWithEmail({
    required String name,
    required String email,
    required String password,
    required String mobile,
    String role = 'Customer',
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );

    await cred.user?.updateDisplayName(name.trim());

    // Save profile in Firestore
    await _firestore.collection('users').doc(cred.user!.uid).set({
      'uid': cred.user!.uid,
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'mobile': mobile.trim(),
      'role': role,
      'address': '',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return cred;
  }

  /// Sign in user with email and password
  Future<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: password,
    );
  }

  /// Send password reset link to user email
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  /// Fetch user profile role and information
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
  }

  /// Stream of current user's profile
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamCurrentUserProfile() {
    final uid = currentUid;
    if (uid == null) {
      return const Stream.empty();
    }
    return _firestore.collection('users').doc(uid).snapshots();
  }

  /// Update user profile
  Future<void> updateUserProfile({
    required String uid,
    String? name,
    String? mobile,
    String? address,
  }) async {
    final Map<String, dynamic> data = {
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (name != null) data['name'] = name.trim();
    if (mobile != null) data['mobile'] = mobile.trim();
    if (address != null) data['address'] = address.trim();

    await _firestore.collection('users').doc(uid).update(data);
  }

  /// Sign out current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // =========================================================================
  // 2. PRODUCTS (CRUD)
  // =========================================================================

  /// Stream of products from Firestore (falls back to sample if collection is empty)
  Stream<List<Product>> streamProducts() {
    return _firestore
        .collection('products')
        .snapshots()
        .map((snapshot) {
      if (snapshot.docs.isEmpty) {
        return kSampleProducts;
      }
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Product(
          id: doc.id,
          name: data['name'] ?? '',
          price: data['price'] ?? 'Rs. 0.00',
          numericPrice: (data['numericPrice'] as num?)?.toDouble() ?? 0.0,
          image: data['image'] ?? 'assets/images/HEX_NUT.PNG',
          shortInfo: data['shortInfo'] ?? '',
          description: data['description'] ?? '',
          specifications: data['specifications'] ?? '',
          category: data['category'] ?? 'General',
          stock: data['stock']?.toString() ?? 'In Stock',
          material: data['material'] ?? 'High Grade Steel',
          size: data['size'] ?? 'Standard',
          threadType: data['threadType'] ?? 'Standard Metric',
          headType: data['headType'] ?? 'Standard',
          finish: data['finish'] ?? 'Zinc Plated',
          grade: data['grade'] ?? '8.8 Industrial',
          application: data['application'] ?? 'Structural & Manufacturing Engineering',
        );
      }).toList();
    });
  }

  /// Add a product to Firestore
  Future<DocumentReference<Map<String, dynamic>>> addProduct({
    required String name,
    required String category,
    required double numericPrice,
    required int stock,
    required String description,
    String? image,
    String material = 'High Grade Steel',
    String size = 'Standard',
  }) async {
    return await _firestore.collection('products').add({
      'name': name.trim(),
      'category': category.trim(),
      'numericPrice': numericPrice,
      'price': 'Rs. ${numericPrice.toStringAsFixed(2)}',
      'stock': '$stock pcs',
      'stockCount': stock,
      'description': description.trim(),
      'image': image ?? 'assets/images/HEX_NUT.PNG',
      'shortInfo': description.trim().split('\n').first,
      'specifications': 'Category: $category\nStock: $stock pcs',
      'material': material,
      'size': size,
      'threadType': 'Standard Metric',
      'headType': 'Standard',
      'finish': 'Zinc Plated',
      'grade': '8.8 Industrial',
      'application': 'Structural & Manufacturing',
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update an existing product
  Future<void> updateProduct(String productId, Map<String, dynamic> data) async {
    data['updatedAt'] = FieldValue.serverTimestamp();
    await _firestore.collection('products').doc(productId).update(data);
  }

  /// Delete a product
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  // =========================================================================
  // 3. ORDERS (CRUD)
  // =========================================================================

  /// Place an order and save in Firestore
  Future<String> placeOrder({
    required String customerName,
    required String phone,
    required String address,
    required String paymentLabel,
    required List<CartItem> items,
    required double subtotal,
    required double tax,
    required double shipping,
    required double total,
  }) async {
    final stamp = DateTime.now();
    final orderId =
        'BTD${stamp.millisecondsSinceEpoch.toString().substring(stamp.millisecondsSinceEpoch.toString().length - 10)}';

    final orderData = {
      'orderId': orderId,
      'userId': currentUid ?? 'guest',
      'customerName': customerName,
      'phone': phone,
      'address': address,
      'paymentMethod': paymentLabel,
      'status': 'Processing', // 'Processing', 'Pick Up', 'In Progress', 'Shipped', 'Delivered', 'Cancelled'
      'subtotal': subtotal,
      'tax': tax,
      'shipping': shipping,
      'total': total,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
      'assignedStaff': '',
      'items': items
          .map((i) => {
                'productId': i.product.id,
                'name': i.product.name,
                'price': i.product.numericPrice,
                'quantity': i.quantity,
                'image': i.product.image,
              })
          .toList(),
    };

    await _firestore.collection('orders').doc(orderId).set(orderData);
    return orderId;
  }

  /// Update order status (Processing, Pick Up, In Progress, Shipped, Delivered, Cancelled)
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': newStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Assign order to delivery staff
  Future<void> assignOrder(String orderId, String staffNameOrId) async {
    await _firestore.collection('orders').doc(orderId).update({
      'assignedStaff': staffNameOrId,
      'status': 'In Progress',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Stream of all orders for Admin
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllOrders() {
    return _firestore
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Stream of orders by specific status
  Stream<QuerySnapshot<Map<String, dynamic>>> streamOrdersByStatus(String status) {
    return _firestore
        .collection('orders')
        .where('status', isEqualTo: status)
        .snapshots();
  }

  /// Stream of orders for current customer
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCustomerOrders() {
    final uid = currentUid;
    if (uid == null) {
      return const Stream.empty();
    }
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .snapshots();
  }

  /// Stream single order by ID
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamOrder(String orderId) {
    return _firestore.collection('orders').doc(orderId).snapshots();
  }

  // =========================================================================
  // 4. NOTIFICATIONS
  // =========================================================================

  /// Stream of notifications
  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotifications() {
    final uid = currentUid;
    return _firestore
        .collection('notifications')
        .where('userId', whereIn: [uid ?? '', 'all'])
        .snapshots();
  }

  /// Add a notification
  Future<void> addNotification({
    required String title,
    required String message,
    String? targetUserId,
  }) async {
    await _firestore.collection('notifications').add({
      'title': title,
      'message': message,
      'userId': targetUserId ?? currentUid ?? 'all',
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Mark notification as read
  Future<void> markNotificationRead(String notificationId, bool isRead) async {
    await _firestore.collection('notifications').doc(notificationId).update({
      'isRead': isRead,
    });
  }

  // =========================================================================
  // 5. WISHLIST
  // =========================================================================

  /// Toggle product in wishlist in Firestore
  Future<void> toggleWishlist(String productId) async {
    final uid = currentUid;
    if (uid == null) return;

    final docRef = _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .doc(productId);

    final doc = await docRef.get();
    if (doc.exists) {
      await docRef.delete();
    } else {
      await docRef.set({
        'productId': productId,
        'addedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Stream wishlist product IDs for the current user
  Stream<List<String>> streamWishlistIds() {
    final uid = currentUid;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection('users')
        .doc(uid)
        .collection('wishlist')
        .snapshots()
        .map((snap) => snap.docs.map((d) => d.id).toList());
  }

  // =========================================================================
  // 6. CATEGORIES & STATS (Dashboard)
  // =========================================================================

  /// Stream dashboard statistics
  Future<Map<String, dynamic>> fetchAdminDashboardStats() async {
    try {
      final productsCount = (await _firestore.collection('products').count().get()).count;
      final ordersCount = (await _firestore.collection('orders').count().get()).count;
      final customersCount = (await _firestore.collection('users').where('role', isEqualTo: 'Customer').count().get()).count;

      return {
        'totalProducts': productsCount ?? 0,
        'totalOrders': ordersCount ?? 0,
        'totalCustomers': customersCount ?? 0,
      };
    } catch (_) {
      return {
        'totalProducts': 0,
        'totalOrders': 0,
        'totalCustomers': 0,
      };
    }
  }
}
