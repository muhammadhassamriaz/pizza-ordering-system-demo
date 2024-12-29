import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:pizza/domain/entities/pizza.dart';
import 'package:pizza/domain/entities/topping.dart';
import 'package:pizza/utils/constants.dart';
import 'package:pizza/utils/enum/pizza_size.dart';
import 'package:pizza/utils/enum/pizza_type.dart';

class PizzaProvider extends ChangeNotifier {
  final List<Pizza> _pizzas = [
    Pizza(
      name: Constants.kNonVegPizza,
      image: Constants.kNonVegPizzaAsset,
      pizzaSize: PizzaSize.small,
      pizzaType: PizzaType.nonVegetarian,
    ),
    Pizza(
      name: Constants.kVegPizza,
      image: Constants.kVegPizzaAsset,
      pizzaSize: PizzaSize.small,
      pizzaType: PizzaType.vegetarian,
    ),
  ];

  final List<PizzaSize> _pizzaSizes = PizzaSize.values;
  List<PizzaSize> get pizzaSizes => _pizzaSizes;

  List<Pizza> get pizzas => _pizzas;

  final List<String> pizzaCategories = [
    Constants.kPopular,
    Constants.kForYou,
    Constants.kTopRated,
    Constants.kNew,
  ];

  int selectedIndex = 0;

  Pizza _selectedPizza = Pizza(
    name: Constants.kNonVegPizza,
    image: Constants.kNonVegPizzaAsset,
    pizzaSize: PizzaSize.large,
    pizzaType: PizzaType.nonVegetarian,
  );

  Pizza get selectedPizza => _selectedPizza;

  void selectPizza(Pizza pizza) {
    if (_selectedPizza != pizza) {
      _selectedPizza = pizza;
      notifyListeners();
    }
    return;
  }

  void setSelectedIndex(int index) {
    selectedIndex = index;
    notifyListeners();
  }

  bool isIndexSelected(int i) {
    return i == selectedIndex;
  }

  int selectedTileColor(index) => selectedPizza == pizzas[index]
      ? Constants.kPrimaryColor
      : Constants.kDisableColor;

  int selectedTileTextColor(index) => selectedPizza == pizzas[index]
      ? Colors.white.value
      : Constants.kTextColor;

  int _current = 0;

  int get current => _current;

  void pizzaSelectionIndex(int index) {
    _current = index;
    notifyListeners();
    return;
  }

  final List<Topping> _selectedToppings = [];
  List<Topping> get selectedToppings => _selectedToppings;

  void addTopping(Topping topping) {
    _selectedToppings.add(topping);
    notifyListeners();
    return;
  }

  void removeTopping(Topping topping) {
    _selectedToppings.remove(topping);
    notifyListeners();
    return;
  }

  void addRemoveToppings(Topping topping) {
    if (_selectedToppings.contains(topping)) {
      removeTopping(topping);
      return;
    }
    addTopping(topping);
    return;
  }

  bool isToppingAdded(Topping topping) {
    return _selectedToppings.contains(topping);
  }

  final CarouselSliderController _controller = CarouselSliderController();
  CarouselSliderController get controller => _controller;

  void initializeSelectedPizza() {
    _selectedPizza = Pizza(
      name: Constants.kNonVegPizza,
      image: Constants.kNonVegPizzaAsset,
      pizzaSize: PizzaSize.large,
      pizzaType: PizzaType.nonVegetarian,
    );
    _selectedToppings.clear();
    _current = 0;
    _controller.jumpToPage(0);
    notifyListeners();
    return;
  }

  String get selectedPizzaPrice {
    final a = pizzas
        .firstWhere(
          (pizza) => pizza.pizzaSize == PizzaSize.values[current],
          orElse: () => _selectedPizza,
        )
        .price
        .toStringAsFixed(2);
    return a;
  }
}
