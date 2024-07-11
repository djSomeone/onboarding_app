import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:onboarding_app/utility/constant.dart';

// import 'controller/controller.dart';

class WaitingPopup extends StatelessWidget {
  final String message;// Optional message to display in the popup

   WaitingPopup({Key? key, this.message = 'Please wait...'});

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