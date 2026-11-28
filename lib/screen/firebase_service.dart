import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
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

    // Save profile in Firestore users collection
    await _firestore.collection('users').doc(cred.user!.uid).set({
      'uid': cred.user!.uid,
      'name': name.trim(),
      'email': email.trim().toLowerCase(),
      'phone': mobile.trim(),
      'mobile': mobile.trim(),
      'role': role,
      'profileImage': '',
      'isActive': true,
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
    String? profileImage,
  }) async {
    final Map<String, dynamic> data = {
      'updatedAt': FieldValue.serverTimestamp(),
    };
    if (name != null) data['name'] = name.trim();
    if (mobile != null) {
      data['mobile'] = mobile.trim();
      data['phone'] = mobile.trim();
    }
    if (address != null) data['address'] = address.trim();
    if (profileImage != null) data['profileImage'] = profileImage;

    await _firestore.collection('users').doc(uid).update(data);
  }

  /// Stream all registered users (For Admin User Management)
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllUsers() {
    return _firestore.collection('users').snapshots();
  }

  /// Activate or deactivate user account
  Future<void> toggleUserActiveStatus(String uid, bool isActive) async {
    await _firestore.collection('users').doc(uid).update({
      'isActive': isActive,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Sign out current user
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // =========================================================================
  // 2. PRODUCTS (CRUD)
  // =========================================================================

  /// Stream of products from Firestore
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
          name: data['productName'] ?? data['name'] ?? '',
          price: data['price'] ?? 'Rs. 0.00',
          numericPrice: (data['numericPrice'] as num?)?.toDouble() ??
              (data['price'] is num ? (data['price'] as num).toDouble() : 0.0),
          image: data['imageUrl'] ?? data['image'] ?? 'assets/images/HEX_NUT.PNG',
          shortInfo: data['shortInfo'] ?? '',
          description: data['description'] ?? '',
          specifications: data['specifications'] ?? '',
          category: data['category'] ?? data['categoryId'] ?? 'General',
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
    String brand = 'BuildTech',
  }) async {
    return await _firestore.collection('products').add({
      'productId': '',
      'productName': name.trim(),
      'name': name.trim(),
      'categoryId': category.trim(),
      'category': category.trim(),
      'numericPrice': numericPrice,
      'price': 'Rs. ${numericPrice.toStringAsFixed(2)}',
      'stock': '$stock pcs',
      'stockCount': stock,
      'brand': brand,
      'description': description.trim(),
      'imageUrl': image ?? 'assets/images/HEX_NUT.PNG',
      'image': image ?? 'assets/images/HEX_NUT.PNG',
      'shortInfo': description.trim().split('\n').first,
      'specifications': 'Category: $category\nStock: $stock pcs',
      'material': material,
      'size': size,
      'isAvailable': stock > 0,
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
  // 3. CATEGORIES
  // =========================================================================

  /// Stream categories from Firestore
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCategories() {
    return _firestore.collection('categories').snapshots();
  }

  /// Add Category
  Future<void> addCategory({
    required String categoryName,
    required String description,
    String? imageUrl,
  }) async {
    await _firestore.collection('categories').add({
      'categoryName': categoryName.trim(),
      'description': description.trim(),
      'imageUrl': imageUrl ?? '',
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  /// Delete Category
  Future<void> deleteCategory(String categoryId) async {
    await _firestore.collection('categories').doc(categoryId).delete();
  }

  // =========================================================================
  // 4. CARTS (Document ID: User UID)
  // =========================================================================

  /// Save Cart to Firestore
  Future<void> syncCartToFirestore(List<CartItem> items) async {
    final uid = currentUid;
    if (uid == null) return;

    await _firestore.collection('carts').doc(uid).set({
      'userId': uid,
      'items': items
          .map((i) => {
                'productId': i.product.id,
                'productName': i.product.name,
                'quantity': i.quantity,
                'price': i.product.numericPrice,
                'image': i.product.image,
              })
          .toList(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Stream Cart items for current user
  Stream<DocumentSnapshot<Map<String, dynamic>>> streamUserCart() {
    final uid = currentUid;
    if (uid == null) return const Stream.empty();
    return _firestore.collection('carts').doc(uid).snapshots();
  }

  // =========================================================================
  // 5. WISHLISTS (Document ID: User UID)
  // =========================================================================

  /// Toggle product in wishlist
  Future<void> toggleWishlist(String productId) async {
    final uid = currentUid;
    if (uid == null) return;

    final docRef = _firestore.collection('wishlists').doc(uid);
    final doc = await docRef.get();

    if (doc.exists) {
      final List<dynamic> list = doc.data()?['productIds'] ?? [];
      if (list.contains(productId)) {
        await docRef.update({
          'productIds': FieldValue.arrayRemove([productId]),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      } else {
        await docRef.update({
          'productIds': FieldValue.arrayUnion([productId]),
          'updatedAt': FieldValue.serverTimestamp(),
        });
      }
    } else {
      await docRef.set({
        'userId': uid,
        'productIds': [productId],
        'updatedAt': FieldValue.serverTimestamp(),
      });
    }
  }

  /// Stream wishlist product IDs for the current user
  Stream<List<String>> streamWishlistIds() {
    final uid = currentUid;
    if (uid == null) return Stream.value([]);

    return _firestore
        .collection('wishlists')
        .doc(uid)
        .snapshots()
        .map((snap) {
      if (!snap.exists) return [];
      final list = snap.data()?['productIds'];
      if (list is List) {
        return list.map((e) => e.toString()).toList();
      }
      return [];
    });
  }

  // =========================================================================
  // 6. ORDERS (CRUD)
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
      'deliveryAddress': address,
      'paymentMethod': paymentLabel,
      'paymentStatus': 'Completed',
      'orderStatus': 'Processing',
      'status': 'Processing',
      'totalAmount': total,
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
                'productName': i.product.name,
                'price': i.product.numericPrice,
                'quantity': i.quantity,
                'imageUrl': i.product.image,
                'image': i.product.image,
              })
          .toList(),
    };

    await _firestore.collection('orders').doc(orderId).set(orderData);
    return orderId;
  }

  /// Update order status
  Future<void> updateOrderStatus(String orderId, String newStatus) async {
    await _firestore.collection('orders').doc(orderId).update({
      'orderStatus': newStatus,
      'status': newStatus,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  /// Stream all orders for Admin
  Stream<QuerySnapshot<Map<String, dynamic>>> streamAllOrders() {
    return _firestore
        .collection('orders')
        .orderBy('createdAt', descending: true)
        .snapshots();
  }

  /// Stream orders for current customer
  Stream<QuerySnapshot<Map<String, dynamic>>> streamCustomerOrders() {
    final uid = currentUid;
    if (uid == null) return const Stream.empty();
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .snapshots();
  }

  // =========================================================================
  // 7. SEEDING INITIAL PRODUCTS & CATEGORIES
  // =========================================================================

  /// Seed initial categories and products into Firestore if collections are empty
  Future<void> seedInitialDataIfEmpty() async {
    try {
      // 1. Seed categories
      final catSnap = await _firestore.collection('categories').limit(1).get();
      if (catSnap.docs.isEmpty) {
        final initialCategories = [
          'Power Tools',
          'Hand Tools',
          'Fasteners',
          'Plumbing',
          'Electrical',
          'Safety',
          'Building Materials',
          'Equipment',
          'Tool Kits',
        ];
        for (final cat in initialCategories) {
          await _firestore.collection('categories').add({
            'categoryName': cat,
            'description': 'High performance industrial $cat',
            'imageUrl': '',
            'isActive': true,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }
      }

      // 2. Seed products
      final prodSnap = await _firestore.collection('products').limit(1).get();
      if (prodSnap.docs.isEmpty) {
        for (final p in kSampleProducts) {
          await _firestore.collection('products').doc(p.id).set({
            'productId': p.id,
            'productName': p.name,
            'name': p.name,
            'categoryId': p.category,
            'category': p.category,
            'numericPrice': p.numericPrice,
            'price': p.price,
            'stock': p.stock,
            'stockCount': 100,
            'brand': 'BuildTech',
            'description': p.description,
            'imageUrl': p.image,
            'image': p.image,
            'shortInfo': p.shortInfo,
            'specifications': p.specifications,
            'material': p.material,
            'size': p.size,
            'isAvailable': true,
            'isActive': true,
            'createdAt': FieldValue.serverTimestamp(),
            'updatedAt': FieldValue.serverTimestamp(),
          });
        }
      }
    } catch (e) {
      debugPrint('Seeding error: $e');
    }
  }

  // =========================================================================
  // 8. NOTIFICATIONS & REVIEWS
  // =========================================================================

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotifications() {
    final uid = currentUid;
    return _firestore
        .collection('notifications')
        .where('userId', whereIn: [uid ?? '', 'all'])
        .snapshots();
  }

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

  Future<void> markNotificationRead(String notificationId, bool isRead) async {
    await _firestore.collection('notifications').doc(notificationId).update({
      'isRead': isRead,
    });
  }
}
