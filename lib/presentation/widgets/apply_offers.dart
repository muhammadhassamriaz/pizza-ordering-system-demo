import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/presentation/providers/cart_provider.dart';
import 'package:pizza/utils/constants.dart';
import 'package:provider/provider.dart';

class ApplyOffersWidget extends StatelessWidget {
  const ApplyOffersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CartProvider>();
    if (cartProvider.canApplyAnyOffer() && !cartProvider.offersApplied) {
      return Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(Constants.kPrimaryColor),
            width: 1,
          ),
          color: Color(Constants.kHighlightedColor),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.error,
                  color: Color(Constants.kPrimaryColor),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Expanded(
                  child: Text(
                    "Promotional Offers",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Color(
                            Constants.kPrimaryColor,
                          ),
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                IconButton(
                  style:
                      ButtonStyle(backgroundColor: WidgetStateColor.resolveWith(
                    (state) {
                      return Color(Constants.kPrimaryColor);
                    },
                  )),
                  onPressed: () {
                    context.read<CartProvider>().applyOffers();
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Offers Applied"),
                      ),
                    );
                  },
                  icon: Icon(
                    Icons.done,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Color(
                          Constants.kPrimaryColor,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: Text(
                    "1 Medium Pizza with 2 toppings = \$5",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color(
                            Constants.kPrimaryColor,
                          ),
                        ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Color(
                          Constants.kPrimaryColor,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: Text(
                    "2 Medium Pizzas with 4 toppings each = \$9",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color(
                            Constants.kPrimaryColor,
                          ),
                        ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "• ",
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Color(
                          Constants.kPrimaryColor,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Expanded(
                  child: Text(
                    "1 Large Pizza with 4 toppings (Pepperoni and Barbecue Chicken count as 2 toppings each) = 50% discount",
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Color(
                            Constants.kPrimaryColor,
                          ),
                        ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return const SizedBox();
  }
}
