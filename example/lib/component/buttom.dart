import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final String text;
  final Function onTap;

  const MyButton(this.text,{Key key,@required this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        child: Text('$text',style: TextStyle(color: Colors.white),),
        onPressed: onTap,
      ),
    );
  }
}
