import 'package:flutter/material.dart';

class InvalidQrCodePopup extends StatelessWidget {
  final String message; // Optional message to display (defaults to "Invalid QR Code")
  final VoidCallback onPressed; // Callback for the button press

  const InvalidQrCodePopup({
    Key? key,
    this.message = 'Invalid QR Code',
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(
            Icons.error_outline,
            color: Colors.red[300],
          ),
          SizedBox(width: 10.0),
          Text('Invalid QR Code'),
        ],
      ),
      // content: Text(message),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text('Dismiss'),
        ),
      ],
    );
  }
}
