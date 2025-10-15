import 'package:flutter/material.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => _items;

  int get itemCount => _items.length;

  int get totalQuantity => _items.values
      .fold(0, (sum, item) => sum + item.quantity);

  double get totalAmount => _items.values
      .fold(0.0, (sum, item) => sum + item.subtotal);

  bool get isEmpty => _items.isEmpty;

  List<CartItem> get cartItems => _items.values.toList();

  void addItem(Product product, {int quantity = 1}) {
    if (_items.containsKey(product.id)) {
      _items[product.id]!.quantity += quantity;
    } else {
      _items[product.id] = CartItem(
        product: product,
        quantity: quantity,
      );
    }
    notifyListeners();
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }

    if (_items.containsKey(productId)) {
      _items[productId]!.quantity = quantity;
      notifyListeners();
    }
  }

  void incrementQuantity(String productId) {
    if (_items.containsKey(productId)) {
      _items[productId]!.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity(String productId) {
    if (_items.containsKey(productId)) {
      if (_items[productId]!.quantity > 1) {
        _items[productId]!.quantity--;
        notifyListeners();
      } else {
        removeItem(productId);
      }
    }
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
