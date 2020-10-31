import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog(this.title, this.content, this.callback,
      [this.actionText = "Reset"]);
  @override
  Widget build(BuildContext context) {
    return new AlertDialog(
      title: new Text(title,style: TextStyle(fontSize: 25),),
      content: new Text(content),
      actions: <Widget>[
        new FlatButton(
          onPressed: callback,
          color: Colors.greenAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Text(actionText,style: TextStyle(fontSize: 18.0,color: Colors.black),),
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
              side: BorderSide(color: Colors.black,width: 2)
          ),
        )
      ],
    );
  }
}
