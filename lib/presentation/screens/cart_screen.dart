import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/presentation/providers/cart_provider.dart';
import 'package:pizza/presentation/providers/pizza_provider.dart';
import 'package:pizza/presentation/widgets/apply_offers.dart';
import 'package:pizza/presentation/widgets/button.dart';
import 'package:pizza/presentation/widgets/cart_item.dart';
import 'package:pizza/utils/constants.dart';
import 'package:pizza/utils/enum/pizza_size.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final pizzaProvider = Provider.of<PizzaProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: Text(
          "Cart",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(Constants.kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ApplyOffersWidget(),
            SizedBox(
              height: 10.h,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartProvider.cartItems.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CartItem(
                    image: cartProvider.cartItems[index].pizza.image,
                    pizzaName: cartProvider.cartItems[index].pizza.name,
                    pizzaSize: formatPizzaSize(
                        cartProvider.cartItems[index].pizza.pizzaSize),
                    toppings: cartProvider.cartItems[index].selectedToppings,
                    totalPrice: cartProvider.cartItems[index].totalPrice
                        .toStringAsFixed(2),
                    cartItemLength: cartProvider.cartItems.length,
                    currentIndex: index + 1,
                  );
                },
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: SharedButton(
                onPressed: () {
                  cartProvider.placeOrder(pizzaProvider);
                },
                buttonText: "Place Order \$${cartProvider.totalCartPrice.toStringAsFixed(2)}".toUpperCase(),
                textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(
              height: 10.h,
            )
          ],
        ),
      ),
    );
  }
}
