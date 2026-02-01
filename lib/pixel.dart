import 'package:flutter/material.dart';

class Pixel extends StatelessWidget {

  final Color? couleurInt;
  final Color? couleurExt;
  final Widget? child;

  const Pixel({super.key, this.couleurInt,this.couleurExt,this.child});
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child : Container(
          padding: EdgeInsets.all(4),
          color: couleurExt,
          child : ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child : Container(
              color: couleurInt,
              child : Center(child: child,),
            ),
          ),
        ),
      )
    );
  }
}