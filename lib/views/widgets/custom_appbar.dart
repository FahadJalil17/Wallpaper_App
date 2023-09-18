import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  String word1, word2;
  CustomAppBar({Key? key, required this.word1, required this.word2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
        children: [
          TextSpan(
            text: word1, style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w600
          )
          ),

          TextSpan(
            text: " $word2",style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 20,
            fontWeight: FontWeight.w600
          )
          )
        ]
      ),

      ),

    );
  }
}

