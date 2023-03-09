import 'package:flutter/material.dart';

class ProfileIcon extends StatelessWidget {

  final String text;
  final VoidCallback callback;

  const ProfileIcon({super.key, required this.text, required this.callback});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: Column(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.png'),
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.pink)
          )
        ],
      ),
    );
  }
}