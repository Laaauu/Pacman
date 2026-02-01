import 'package:flutter/material.dart';

class Fantome extends StatelessWidget{
  const Fantome({super.key});

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset('assets/fantome_rose.png'),
    );
  }
}