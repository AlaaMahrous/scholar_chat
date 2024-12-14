import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        constraints: const BoxConstraints(
          maxWidth: 350, 
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            height: 1.52,
          ),
        ),
      ),
    );
  }
}

class ChatBubleFromFriend extends StatelessWidget {
  const ChatBubleFromFriend({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        constraints: const BoxConstraints(
          maxWidth: 350, 
        ),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 19, 82, 133),
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
            bottomLeft: Radius.circular(35),
          ),
        ),
        child: Text(
          message,
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w400,
            height: 1.52,
          ),
        ),
      ),
    );
  }
}