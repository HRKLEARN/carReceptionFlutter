import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final onPress;
  final Widget child;
  final color;

  CustomButton({this.onPress, required this.child, this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 56.0,
      onPressed: onPress,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      textColor: Colors.white,
      color: color ?? Theme.of(context).colorScheme.secondary,
      child: child,
    );
  }
}
