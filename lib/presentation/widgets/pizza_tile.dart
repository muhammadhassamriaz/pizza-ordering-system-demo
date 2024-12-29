import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/domain/entities/pizza.dart';

class PizzaTile extends StatelessWidget {
  final int buttonColor;
  final Pizza pizza;
  final int textColor;

  const PizzaTile(
      {super.key,
      required this.buttonColor,
      required this.pizza,
      required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: WidgetStateColor.resolveWith(
          (states) {
            return Color(buttonColor);
          },
        ),
        borderRadius: BorderRadius.circular(
          8,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: pizza.imageSize - 50.w,
            width: pizza.imageSize - 50.w,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(pizza.image),
              ),
            ),
          ),
          SizedBox(
            height: 8.h,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pizza.name,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Color(textColor),
                        fontWeight: FontWeight.w500,
                      ),
                ),
                Text(
                  "\$${pizza.price.toDouble().toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Color(textColor),
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
