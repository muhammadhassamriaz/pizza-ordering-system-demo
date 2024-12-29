import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/domain/entities/topping.dart';
import 'package:pizza/utils/constants.dart';

class CartItem extends StatelessWidget {
  final String image;
  final String pizzaName;
  final String pizzaSize;
  final List<Topping> toppings;
  final String totalPrice;
  final int currentIndex;
  final int cartItemLength;

  const CartItem({
    super.key,
    required this.image,
    required this.pizzaName,
    required this.pizzaSize,
    required this.toppings,
    required this.totalPrice,
    required this.currentIndex,
    required this.cartItemLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100.h,
              height: 100.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                  ),
                  border: Border.all(
                    color: Color(Constants.kSecondaryColor),
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(20)),
            ),
            SizedBox(
              width: 10.w,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pizzaName.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Color(Constants.kTextColor),
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  Text(
                    pizzaSize,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  if (toppings.isNotEmpty)
                    ...List.generate(
                      toppings.length,
                      (i) {
                        return Text(
                          "+ ${toppings[i].name}",
                          style: Theme.of(context).textTheme.bodySmall,
                        );
                      },
                    ),
                ],
              ),
            ),
            Text(
              "\$$totalPrice",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Color(Constants.kTextColor),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ],
        ),
        SizedBox(
          height: 5.h,
        ),
        Divider(
          color: Color(Constants.kDisableColor),
        ),
      ],
    );
  }
}
