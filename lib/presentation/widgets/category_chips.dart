import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final String title;
  final int buttonColor;
  final int textColor;
  final VoidCallback onTap;

  const CategoryChips(
      {super.key,
      required this.title,
      required this.buttonColor,
      required this.textColor,
      required this.onTap
      });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: WidgetStateColor.resolveWith(
            (states) {
              return Color(buttonColor);
            },
          ),
          borderRadius: BorderRadius.circular(20,),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0) + EdgeInsets.symmetric(horizontal: 12,),
          child: Center(
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Color(textColor),
                    fontWeight: FontWeight.w500,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
