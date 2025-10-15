import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/product.dart';
import '../models/order.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Product>> getProducts() {
    return _db
        .collection('products')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Product.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  Stream<List<Product>> getFeaturedProducts() {
    return _db
        .collection('products')
        .where('featured', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Product.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  Future<Product?> getProduct(String productId) async {
    try {
      final doc = await _db.collection('products').doc(productId).get();
      if (doc.exists) {
        return Product.fromFirestore(doc.data()!, doc.id);
      }
      return null;
    } catch (e) {
      print('Error fetching product: $e');
      return null;
    }
  }

  Future<String?> createOrder(Order order) async {
    try {
      final docRef = await _db.collection('orders').add(order.toFirestore());
      return docRef.id;
    } catch (e) {
      print('Error creating order: $e');
      return null;
    }
  }

  Future<Order?> getOrder(String orderId) async {
    try {
      final doc = await _db.collection('orders').doc(orderId).get();
      if (doc.exists) {
        final data = doc.data()!;
        return Order(
          orderId: data['orderId'],
          businessName: data['businessName'],
          items: List<Map<String, dynamic>>.from(data['items']),
          total: (data['total']).toDouble(),
          delivery: DeliveryDetails(
            fullName: data['delivery']['fullName'],
            phone: data['delivery']['phone'],
            address: data['delivery']['address'],
            city: data['delivery']['city'],
            postalCode: data['delivery']['postalCode'],
          ),
          notes: data['notes'] ?? '',
          status: data['status'],
          webClient: data['webClient'] ?? true,
          createdAt: DateTime.parse(data['createdAt']),
        );
      }
      return null;
    } catch (e) {
      print('Error fetching order: $e');
      return null;
    }
  }
}
