import 'package:flutter/material.dart';

class WaitingPopup extends StatelessWidget {
  final String message; // Optional message to display in the popup

  const WaitingPopup({Key? key, this.message = 'Please wait...'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent, // Makes the popup semi-transparent
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.white, // Background color for the popup
          ),
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Center the content horizontally
            children: [
              CircularProgressIndicator(), // Activity indicator
              SizedBox(width: 10.0), // Spacing between indicator and text
              Text(message), // Optional message to display
            ],
          ),
        ),
      ),
    );
  }
}