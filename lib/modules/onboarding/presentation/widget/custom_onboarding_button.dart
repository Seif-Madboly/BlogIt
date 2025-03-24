
import 'package:flutter/material.dart';
import 'package:news_app/core/utils/media_query_values.dart';

class CustomOnBoardingButton extends StatelessWidget {
  const CustomOnBoardingButton({
    super.key,
    required this.onPress,
    required this.text,
    required this.backgroundColor,
    required this.padding,
  });
  final VoidCallback onPress;
  final String text;
  final Color backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    double width = SizeConfig.screenW!;
    return ElevatedButton(
      onPressed: onPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        padding: padding,
        textStyle: TextStyle(fontSize: (width <= 550) ? 13 : 17),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}