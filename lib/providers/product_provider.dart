import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/firestore_service.dart';

class ProductProvider with ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();

  List<Product> _products = [];
  bool _isLoading = false;
  String? _error;

  List<Product> get products => _products;
  bool get isLoading => _isLoading;
  String? get error => _error;

  List<Product> get featuredProducts =>
      _products.where((p) => p.featured).toList();

  ProductProvider() {
    loadProducts();
  }

  void loadProducts() {
    _isLoading = true;
    notifyListeners();

    _firestoreService.getProducts().listen(
      (products) {
        _products = products;
        _isLoading = false;
        _error = null;
        notifyListeners();
      },
      onError: (error) {
        _error = error.toString();
        _isLoading = false;
        notifyListeners();
      },
    );
  }

  Product? getProductById(String id) {
    try {
      return _products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }
}
