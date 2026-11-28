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

  // =========================================================================
  // 1. AUTHENTICATION & USER MANAGEMENT
  // =========================================================================

  /// Register a new user with email, password, and profile record
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

    // Save profile in Firestore users collection
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

  /// Send password reset email
  Future<void> sendPasswordReset(String email) async {
    await _auth.sendPasswordResetEmail(email: email.trim());
  }

  /// Fetch user profile
  Future<Map<String, dynamic>?> getUserProfile(String uid) async {
    final doc = await _firestore.collection('users').doc(uid).get();
    return doc.data();
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

  /// Stream list of all customers (for Admin)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCustomers() {
    return _firestore
        .collection('users')
        .where('role', isEqualTo: 'Customer')
        .snapshots();
  }

  /// Sign out current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // =========================================================================
  // 2. PRODUCTS CATALOG
  // =========================================================================

  /// Stream of products from Firestore (falls back to sample if collection is empty)
  Stream<List<Product>> streamProducts() {
    return _firestore.collection('products').snapshots().map((snapshot) {
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
  Future<void> addProduct({
    required String name,
    required String category,
    required double numericPrice,
    required int stock,
    required String description,
    String? image,
  }) async {
    await _firestore.collection('products').add({
      'name': name.trim(),
      'category': category.trim(),
      'numericPrice': numericPrice,
      'price': 'Rs. ${numericPrice.toStringAsFixed(2)}/pcs',
      'stock': '$stock pcs',
      'stockCount': stock,
      'description': description.trim(),
      'image': image ?? 'assets/images/HEX_NUT.PNG',
      'shortInfo': description.trim().split('\n').first,
      'specifications': 'Category: $category\nStock: $stock pcs',
      'material': 'High Grade Steel',
      'size': 'Standard',
      'threadType': 'Standard Metric',
      'headType': 'Standard',
      'finish': 'Zinc Plated',
      'grade': '8.8 Industrial',
      'application': 'Structural & Manufacturing',
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Update existing product
  Future<void> updateProduct(String productId, Map<String, dynamic> data) async {
    data['updatedAt'] = FieldValue.serverTimestamp();
    await _firestore.collection('products').doc(productId).update(data);
  }

  /// Delete a product
  Future<void> deleteProduct(String productId) async {
    await _firestore.collection('products').doc(productId).delete();
  }

  // =========================================================================
  // 3. ORDERS
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
      'userId': currentUser?.uid ?? 'guest',
      'customerName': customerName,
      'phone': phone,
      'address': address,
      'paymentMethod': paymentLabel,
      'status': 'Processing',
      'assignedStaff': '',
      'subtotal': subtotal,
      'tax': tax,
      'shipping': shipping,
      'total': total,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
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

    // Also send an automated notification to the user in Firestore
    if (currentUser?.uid != null) {
      await addNotification(
        userId: currentUser!.uid,
        title: 'Order Confirmed',
        message: 'Your order $orderId has been placed and is being processed.',
      );
    }

    return orderId;
  }

  /// Stream of all orders (for Admin & Delivery)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllOrders() {
    return _firestore
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Stream of orders for current customer
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCustomerOrders() {
    final uid = currentUser?.uid;
    if (uid == null) {
      return _firestore.collection('orders').limit(0).snapshots();
    }
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Update order status (e.g. Processing -> Pick Up -> Out for Delivery -> Delivered)
  Future<void> updateOrderStatus({
    required String orderId,
    required String status,
    String? assignedStaff,
  }) async {
    final Map<String, dynamic> updateData = {
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (assignedStaff != null) {
      updateData['assignedStaff'] = assignedStaff;
    }
    await _firestore.collection('orders').doc(orderId).update(updateData);
  }

  // =========================================================================
  // 4. NOTIFICATIONS
  // =========================================================================

  /// Stream user notifications
  Stream<QuerySnapshot<Map<String, dynamic>>> streamUserNotifications(String userId) {
    return _firestore
        .collection('notifications')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Add a notification
  Future<void> addNotification({
    required String userId,
    required String title,
    required String message,
  }) async {
    await _firestore.collection('notifications').add({
      'userId': userId,
      'title': title,
      'message': message,
      'isRead': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Mark notification as read
  Future<void> markNotificationAsRead(String notificationId) async {
    await _firestore
        .collection('notifications')
        .doc(notificationId)
        .update({'isRead': true});
  }

  // =========================================================================
  // 5. WISHLIST
  // =========================================================================

  /// Stream user wishlist product IDs
  Stream<QuerySnapshot<Map<String, dynamic>>> streamWishlist(String userId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots();
  }

  /// Add item to user wishlist
  Future<void> addToWishlist(String userId, Product product) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(product.id)
        .set({
      'productId': product.id,
      'name': product.name,
      'price': product.price,
      'image': product.image,
      'addedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Remove item from user wishlist
  Future<void> removeFromWishlist(String userId, String productId) async {
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(productId)
        .delete();
  }
}
