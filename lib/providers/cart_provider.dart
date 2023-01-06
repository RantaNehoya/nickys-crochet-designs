import 'package:flutter/material.dart';
import 'package:nickys_designs/models/product_model.dart';
import 'package:nickys_designs/presentation/screens/cart_screen.dart';

class CartProvider with ChangeNotifier {
  double _totalPrice;

  bool _switchValue = false;

  final List<ProductModel> _cartItems = [];
  final List<double> _cartItemsPrice = [];

  List<ProductModel> get getCartItems => [..._cartItems];

  bool get getSwitchValue => _switchValue;

  void clearCart() {
    _cartItems.clear();
    _cartItemsPrice.clear();
    notifyListeners();
  }

  void changeSwitchValue() {
    _switchValue = !_switchValue;

    if (_switchValue) {
      addPrice(40.00);
    } else {
      _cartItemsPrice.remove(40.00);
    }
    notifyListeners();
  }

  void addToCart(ProductModel product) {
    _cartItems.add(product);
    notifyListeners();
  }

  void removeFromCart(int index) {
    _cartItems.removeAt(index);
    notifyListeners();
  }

  void addPrice(double price) {
    _cartItemsPrice.add(price);
  }

  void removePrice(int index) {
    _cartItemsPrice.removeAt(index);
  }

  double sumPrice() {
    _totalPrice = 0.0;
    for (var itemPrice in _cartItemsPrice) {
      _totalPrice += itemPrice;
    }
    return _totalPrice;
  }

  Widget showCart(BuildContext context) {
    if (_cartItems.isNotEmpty) {
      return FloatingActionButton(
        child: const Icon(
          Icons.shopping_bag_outlined,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const CartScreen())));
        },
      );
    } else {
      return null;
    }
  }
}
