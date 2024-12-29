import 'package:collection/collection.dart';
import 'package:pizza/domain/entities/pizza.dart';
import 'package:pizza/domain/entities/topping.dart';

class CartItem {
  final Pizza pizza;
  final List<Topping> selectedToppings;
  String? appliedOffer;
  double discountedPrice;

  CartItem({
    required this.pizza,
    required this.selectedToppings,
    this.appliedOffer,
    double? discountedPrice,
  }) : discountedPrice = discountedPrice ?? 0.0;

  double get basePrice => pizza.price;

  double get toppingsPrice =>
      selectedToppings.fold(0, (sum, topping) => sum + topping.price);

  double get totalPrice {
    if (appliedOffer == "Offer 1") {
      return 5.0; // Fixed price for Offer 1
    } else if (appliedOffer == "Offer 2") {
      return 9.0; // Fixed price for Offer 2
    } else if (appliedOffer == "Offer 3") {
      return (basePrice + toppingsPrice) * 0.5; // 50% discount for Offer 3
    }
    return basePrice + toppingsPrice; // Default total price without any offer
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.pizza == pizza &&
        ListEquality().equals(other.selectedToppings, selectedToppings) &&
        other.appliedOffer == appliedOffer;
  }

  @override
  int get hashCode =>
      pizza.hashCode ^
      ListEquality().hash(selectedToppings) ^
      appliedOffer.hashCode;
}

class Order {
  final List<CartItem> items;
  final double totalAmount;

  Order({
    required this.items,
    required this.totalAmount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Order &&
        ListEquality().equals(other.items, items) &&
        other.totalAmount == totalAmount;
  }

  @override
  int get hashCode => ListEquality().hash(items) ^ totalAmount.hashCode;
}
