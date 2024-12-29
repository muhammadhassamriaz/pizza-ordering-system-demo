import 'package:flutter/material.dart';
import 'package:pizza/domain/entities/cart_item.dart';
import 'package:pizza/presentation/providers/pizza_provider.dart';
import 'package:pizza/utils/enum/pizza_size.dart';

class CartProvider with ChangeNotifier {
  final List<CartItem> _cartItems = [];
  final List<Order> _orders = [];

  List<CartItem> get cartItems => _cartItems;

  List<Order> get orders => _orders;

  void addPizzaToCart(CartItem cartItem) {
    _cartItems.add(CartItem(
      pizza: cartItem.pizza,
      selectedToppings: List.from(cartItem.selectedToppings),
      discountedPrice: cartItem.discountedPrice,
    ));
    notifyListeners();
    return;
  }

  void removePizzaFromCart(CartItem cartItem, PizzaProvider pizzaProvider) {
    _cartItems.remove(cartItem);
    if (!_cartItems.contains(cartItem)) {
      _resetPizzaSelection(pizzaProvider);
    }
    notifyListeners();
    return;
  }

  void clearCart(PizzaProvider pizzaProvider) {
    _cartItems.clear();
    _resetPizzaSelection(pizzaProvider);
    notifyListeners();
    return;
  }

  void _resetPizzaSelection(PizzaProvider pizzaProvider) {
    pizzaProvider.initializeSelectedPizza();
    return;
  }

  bool canApplyOffer1(CartItem item) {
    return item.pizza.pizzaSize == PizzaSize.medium &&
        item.selectedToppings.length == 2;
  }

  bool canApplyOffer2() {
    int mediumPizzas = _cartItems
        .where((item) =>
            item.pizza.pizzaSize == PizzaSize.medium &&
            item.selectedToppings.length == 4)
        .length;
    return mediumPizzas >= 2;
  }

  bool canApplyOffer3(CartItem item) {
    if (item.pizza.pizzaSize == PizzaSize.large) {
      int toppingCount = item.selectedToppings.fold(0, (sum, topping) {
        if (topping.name == "Pepperoni" || topping.name == "Barbecue Chicken") {
          return sum + 2;
        }
        return sum + 1;
      });
      return toppingCount == 4;
    }
    return false;
  }

  void applyOffers() {
    for (var item in _cartItems) {
      item.discountedPrice = item.basePrice + item.toppingsPrice;
      item.appliedOffer = null;
    }

    for (var item in _cartItems) {
      if (canApplyOffer3(item)) {
        item.discountedPrice = (item.basePrice + item.toppingsPrice) * 0.5;
        item.appliedOffer = "Offer 3";
      }
    }

    if (canApplyOffer2()) {
      double offer2Price = 9.0;
      int mediumPizzas = 0;

      for (var item in _cartItems) {
        if (item.pizza.pizzaSize == PizzaSize.medium &&
            item.selectedToppings.length == 4) {
          mediumPizzas++;
          item.appliedOffer = "Offer 2";
          item.discountedPrice = 0;
          if (mediumPizzas == 2) {
            item.discountedPrice = offer2Price / 2;
            _cartItems
                .firstWhere((el) =>
                    el.appliedOffer == "Offer 2" && el.discountedPrice == 0)
                .discountedPrice = offer2Price / 2;
            break;
          }
        }
      }
    }

    for (var item in _cartItems) {
      if (canApplyOffer1(item) && item.appliedOffer == null) {
        item.discountedPrice = 5.0;
        item.appliedOffer = "Offer 1";
      }
    }
    _offersApplied = true;
    notifyListeners();
    return;
  }

  bool canApplyAnyOffer() {
    for (var item in _cartItems) {
      if (canApplyOffer1(item) || canApplyOffer2() || canApplyOffer3(item)) {
        return true;
      }
    }
    return false;
  }

  double get totalCartPrice {
    return _cartItems.fold(0, (sum, item) {
      if (item.discountedPrice > 0) {
        return sum + item.discountedPrice;
      }
      return sum + item.basePrice + item.toppingsPrice;
    });
  }

  void placeOrder(PizzaProvider pizzaProvider) {
    if (_cartItems.isNotEmpty) {
      _orders.add(
          Order(items: List.from(_cartItems), totalAmount: totalCartPrice));
      clearCart(pizzaProvider);
    }
    _resetOffers();
    notifyListeners();
    return;
  }

  bool _offersApplied = false;
  bool get offersApplied => _offersApplied;

  void setOffersApplied(bool value) {
    _offersApplied = value;
    notifyListeners();
    return;
  }

  void _resetOffers() {
    for (var item in _cartItems) {
      item.discountedPrice = 0;
      item.appliedOffer = null;
    }
    _offersApplied = false;
    notifyListeners();
    return;
  }
}
