import 'package:flutter/material.dart';

class Joueur extends StatelessWidget {
  const Joueur({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset(
        'assets/pacman.png'
      ),
    );
  }
}