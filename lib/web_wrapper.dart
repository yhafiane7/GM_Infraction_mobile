import 'package:flutter/material.dart';
import 'main.dart'; // Import your mobile app

/// A wrapper that centers your app inside a phone-like frame on the web.
class WebWrapper extends StatelessWidget {
  const WebWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[200], // Background outside phone frame
        body: Center(
          child: Container(
            width: 390, // iPhone 14 width
            height: 844, // iPhone 14 height
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(40),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            clipBehavior: Clip.hardEdge,
            child: MyApp(), // <-- Your existing app goes here
          ),
        ),
      ),
    );
  }
}
