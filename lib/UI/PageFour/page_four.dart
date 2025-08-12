import 'package:flutter/material.dart';

class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(

        children: [

          Expanded(
            child: Container(

            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Enter message",
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.send)
              ),
            ),
          )
        ],
      ),
    );
  }
}
