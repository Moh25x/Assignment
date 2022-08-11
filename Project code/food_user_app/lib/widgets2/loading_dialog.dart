import 'package:flutter/material.dart';
import 'package:food_user_app/widgets2/progres_bar.dart';

class LoadingDialog extends StatelessWidget
{
  final String? message;

  LoadingDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
    content: Column(
    mainAxisSize: MainAxisSize.min,
      children: [
        circularProgress(),
        SizedBox(height: 10,),
        Text(message!+",من فضلك انتظر")
    ],

    ),
    );
  }
}
