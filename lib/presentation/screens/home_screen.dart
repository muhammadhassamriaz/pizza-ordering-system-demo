import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/presentation/providers/pizza_provider.dart';
import 'package:pizza/presentation/screens/pizza_selection_screen.dart';
import 'package:pizza/presentation/widgets/category_chips.dart';
import 'package:pizza/presentation/widgets/drink_tile.dart';
import 'package:pizza/presentation/widgets/pizza_tile.dart';
import 'package:pizza/utils/constants.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = "/";
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PizzaProvider>(
      builder: (_, state, child) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.person),
                onPressed: () {},
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {},
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(Constants.kDefaultPadding),
                  child: Text(
                    "What sort of pizza do you want?",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Constants.kDefaultPadding),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        state.pizzaCategories.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.all(4.0.r),
                            child: CategoryChips(
                              title: state.pizzaCategories[index],
                              buttonColor: state.isIndexSelected(index)
                                  ? Constants.kPrimaryColor
                                  : Constants.kDisableColor,
                              textColor: state.isIndexSelected(index)
                                  ? Colors.white.value
                                  : Constants.kTextColor,
                              onTap: () {
                                state.setSelectedIndex(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.h,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Constants.kDefaultPadding),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        state.pizzas.length,
                        (index) {
                          return GestureDetector(
                            onTap: () {
                              state.selectPizza(state.pizzas[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return PizzaSelectionScreen(
                                      pizza: state.pizzas[index],
                                    );
                                  },
                                ),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.all(4.0.r),
                              child: PizzaTile(
                                buttonColor: state.selectedTileColor(index),
                                pizza: state.pizzas[index],
                                textColor: state.selectedTileTextColor(index),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(Constants.kDefaultPadding),
                  child: Text(
                    "Drinks",
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: Constants.kDefaultPadding),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                        state.pizzas.length,
                        (index) {
                          return Padding(
                            padding: EdgeInsets.all(4.0.r),
                            child: DrinkTile(),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                
              ],
            ),
          ),
        );
      },
    );
  }
}
