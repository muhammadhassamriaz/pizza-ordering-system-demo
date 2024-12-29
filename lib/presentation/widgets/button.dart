import 'package:flutter/material.dart';
import 'package:pizza/utils/constants.dart';

class SharedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttonText;
  final TextStyle? textStyle;

  const SharedButton({
    super.key,
    required this.onPressed,
    required this.buttonText,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(Constants.kPrimaryColor),
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        elevation: 2,
      ),
      child: Text(
        buttonText,
        style: textStyle ??
            Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                ),
      ),
    );
  }
}
