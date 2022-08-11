import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget
{
  final String? message;

  ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!,textAlign: TextAlign.center,),
      actions: [
        ElevatedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Center(
              child: Text("حسنا"),
            ),
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
        ),
      ],
    );
  }
}
