import 'package:flutter/material.dart';

class ChatTextFeild extends StatelessWidget {
  const ChatTextFeild({
    super.key,
    required this.onSubmitted,
    required this.controller,
  });

  final Function(String) onSubmitted;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          hintText: 'Send Message',
          hintStyle: TextStyle(color: Colors.grey),
          suffixIcon: IconButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                onSubmitted(controller.text);
              }
            },
            icon: Icon(Icons.send),
          ),
          suffixIconColor: Theme.of(context).primaryColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).primaryColor,
              width: 1.4,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.blue,
              width: 2,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
        ),
      ),
    );
  }
}
