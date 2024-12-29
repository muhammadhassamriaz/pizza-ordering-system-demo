import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/domain/entities/topping.dart';
import 'package:pizza/utils/enum/pizza_size.dart';
import 'package:pizza/utils/enum/pizza_type.dart';

class Pizza {
  final String name;
  final String image;
  final PizzaSize pizzaSize;
  final PizzaType pizzaType;
  final bool isHomeScreen;

  const Pizza({
    required this.name,
    required this.image,
    required this.pizzaSize,
    required this.pizzaType,
    this.isHomeScreen = false,
  });

  double get price {
    if (pizzaSize == PizzaSize.small) {
      return 5;
    } else if (pizzaSize == PizzaSize.medium) {
      return 7;
    } else if (pizzaSize == PizzaSize.large) {
      return 8;
    }
    return 9;
  }

  double get imageSize {
    if (pizzaSize == PizzaSize.small) {
      return isHomeScreen ? 50.w : 150.w;
    } else if (pizzaSize == PizzaSize.medium) {
      return isHomeScreen ? 80.w : 200.w;
    } else if (pizzaSize == PizzaSize.large) {
      return isHomeScreen ? 100.w : 250.w;
    }
    return isHomeScreen ? 120.w : 320.w;
  }

  List<Topping> get toppingName {
    if (pizzaType == PizzaType.vegetarian) {
      return [
        Topping(
            name: 'Onion',
            price: 0.50,
            url: "https://cdn-icons-png.freepik.com/256/14087/14087218.png"),
        Topping(
            name: 'Tomatoes',
            price: 1.00,
            url:
                "https://img.freepik.com/premium-vector/tomato-sauce-icon-logo-vector-design-template_827767-4819.jpg"),
        Topping(
            name: 'Bell Pepper',
            price: 1.00,
            url:
                "https://cdn2.iconfinder.com/data/icons/pizza-toppings/200/bellpepper-512.png"),
        Topping(
            name: 'Mushrooms',
            price: 1.20,
            url:
                "https://cdn2.iconfinder.com/data/icons/pizza-toppings/200/mushroom-512.png"),
        Topping(
            name: 'Pineapple',
            price: 0.75,
            url:
                "https://cbx-prod.b-cdn.net/COLOURBOX55930538.jpg?width=800&height=800&quality=70"),
      ];
    }
    return [
      Topping(
          name: 'Pepperoni',
          price: 2.00,
          url:
              "https://cdn2.iconfinder.com/data/icons/pizza-toppings/200/pepperoni-512.png"),
      Topping(
          name: 'Sausage',
          price: 1.00,
          url:
              "https://img.freepik.com/free-vector/grill-sausages-meat-icon-isolated_24911-109426.jpg"),
      Topping(
          name: 'Barbecue Chicken',
          price: 3.00,
          url:
              "https://static.vecteezy.com/system/resources/thumbnails/047/086/294/small_2x/fried-chicken-leg-piece-on-transparent-background-png.png"),
    ];
  }

  Pizza copyWith({
    String? name,
    String? image,
    PizzaSize? pizzaSize,
    PizzaType? pizzaType,
    bool? isHomeScreen,
  }) {
    return Pizza(
      name: name ?? this.name,
      image: image ?? this.image,
      pizzaSize: pizzaSize ?? this.pizzaSize,
      pizzaType: pizzaType ?? this.pizzaType,
      isHomeScreen: isHomeScreen ?? this.isHomeScreen,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is Pizza &&
        other.name == name &&
        other.image == image &&
        other.pizzaSize == pizzaSize &&
        other.pizzaType == pizzaType;
  }

  @override
  int get hashCode => Object.hash(
        name,
        image,
        pizzaSize,
        pizzaType,
        isHomeScreen,
      );
}
