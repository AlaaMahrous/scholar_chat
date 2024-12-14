import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onTap,
    required this.text,
    this.height = 48,
  });
  final String text;
  final VoidCallback onTap;
  final double height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white),
        width: double.infinity,
        height: height,
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
      ),
    );
  }
}