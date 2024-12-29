import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/domain/entities/cart_item.dart';
import 'package:pizza/domain/entities/pizza.dart';
import 'package:pizza/presentation/providers/cart_provider.dart';
import 'package:pizza/presentation/providers/pizza_provider.dart';
import 'package:pizza/presentation/screens/cart_screen.dart';
import 'package:pizza/presentation/widgets/button.dart';
import 'package:pizza/presentation/widgets/carousel_pizza_slider.dart';
import 'package:pizza/presentation/widgets/topping_tile.dart';
import 'package:pizza/utils/constants.dart';
import 'package:pizza/utils/enum/pizza_size.dart';
import 'package:provider/provider.dart';

class PizzaSelectionScreen extends StatefulWidget {
  static const String routeName = "/pizza-detail";
  final Pizza pizza;
  const PizzaSelectionScreen({super.key, required this.pizza});

  @override
  State<PizzaSelectionScreen> createState() => _PizzaSelectionScreenState();
}

class _PizzaSelectionScreenState extends State<PizzaSelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            context.read<PizzaProvider>().initializeSelectedPizza();
            Navigator.pop(context);
          },
        ),
        title: Text(
          widget.pizza.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Consumer<PizzaProvider>(builder: (context, state, child) {
        return Column(
          spacing: 10.h,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Constants.kDefaultPadding),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Size - ${formatPizzaSize(PizzaSize.values[state.current])}",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Color(Constants.kTextColor),
                                  ),
                            ),
                          ),
                          Text(
                            "\$${widget.pizza.copyWith(
                                  pizzaSize: PizzaSize.values[state.current],
                                ).price.toStringAsFixed(2)}",
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(Constants.kTextColor),
                                ),
                          ),
                        ],
                      ),
                    ),
                    CarouselPizzaSlider(pizza: widget.pizza),
                    Padding(
                      padding: const EdgeInsets.all(Constants.kDefaultPadding),
                      child: Text(
                        "Toppings",
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Color(Constants.kTextColor),
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: Constants.kDefaultPadding),
                      child: Column(
                        children: List.generate(
                          widget.pizza.toppingName.length,
                          (index) {
                            return ToppingTile(
                              url: widget.pizza.toppingName[index].url,
                              toppingName: widget.pizza.toppingName[index].name,
                              price:
                                  "\$${widget.pizza.toppingName[index].price.toStringAsFixed(2)}",
                              buttonText: state.isToppingAdded(
                                      widget.pizza.toppingName[index])
                                  ? "Remove"
                                  : "Add",
                              buttonColor: state.isToppingAdded(
                                      widget.pizza.toppingName[index])
                                  ? Colors.red.value
                                  : Constants.kPrimaryColor,
                              textColor: Colors.white.value,
                              onTap: () {
                                state.addRemoveToppings(
                                    widget.pizza.toppingName[index]);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 8.h,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: Constants.kDefaultPadding),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Total Price: \$${widget.pizza.copyWith(
                                pizzaSize: PizzaSize.values[state.current],
                              ).price + state.selectedToppings.fold(
                            0,
                            (previousValue, element) =>
                                previousValue + element.price,
                          )}",
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(Constants.kTextColor),
                              ),
                    ),
                  ),
                  SharedButton(
                    onPressed: () {
                      context.read<CartProvider>().addPizzaToCart(
                            CartItem(
                              pizza: widget.pizza.copyWith(
                                pizzaSize: PizzaSize.values[state.current],
                              ),
                              selectedToppings: state.selectedToppings,
                            ),
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Pizza added to cart!'),
                        ),
                      );
                      context.read<CartProvider>().setOffersApplied(false);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CartScreen(),
                        ),
                      ).then((value) {
                        state.initializeSelectedPizza();
                      });
                    },
                    buttonText: "Add to Cart",
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
          ],
        );
      }),
    );
  }
}
