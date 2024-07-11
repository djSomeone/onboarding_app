import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:onboarding_app/utility/constant.dart';

class SuccessPopup extends StatelessWidget {
  final String message; // Optional message to display (defaults to "Successfully Registered")
  final IconData icon; // Icon to display (defaults to checkmark)
  final String buttonText; // Text for the button (defaults to "OK")
  final VoidCallback onButtonPressed; // Callback for button press

   SuccessPopup({
    Key? key,
    this.message = 'Successfully Registered',
    this.icon = Icons.check_circle_outline_sharp,
    this.buttonText = 'OK',
    required this.onButtonPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisSize: MainAxisSize.min, // Center the icon and title
        children: [
          Icon(icon, color: Colors.green), // Green checkmark for success
          SizedBox(width: 6.0), // Spacing between icon and text
          Text('Success',style: GoogleFonts.poppins(),),
        ],
      ),
      content: Text(message,style: GoogleFonts.poppins(),), // Optional message content
      actions: [
        TextButton(
          onPressed: onButtonPressed,
          child: Text(buttonText,style: GoogleFonts.poppins(color: ConstColor.primery),),
        ),
      ],
    );
  }
}
