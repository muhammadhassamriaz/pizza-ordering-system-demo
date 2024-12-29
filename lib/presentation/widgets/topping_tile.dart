import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pizza/presentation/widgets/category_chips.dart';
import 'package:pizza/utils/constants.dart';

class ToppingTile extends StatelessWidget {
  final String url;
  final String toppingName;
  final String price;
  final String buttonText;
  final int buttonColor;
  final int textColor;
  final Function onTap;

  const ToppingTile({
    super.key,
    required this.url,
    required this.toppingName,
    required this.price,
    required this.buttonText,
    required this.buttonColor,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 70.w,
              width: 70.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                  image: NetworkImage(url),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toppingName,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
                Text(price.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
            const Spacer(),
            CategoryChips(
              title: buttonText,
              buttonColor: buttonColor,
              textColor: textColor,
              onTap: () {
                onTap();
              },
            ),
          ],
        ),
        Divider(
          color: Color(Constants.kSecondaryColor),
        ),
      ],
    );
  }
}
