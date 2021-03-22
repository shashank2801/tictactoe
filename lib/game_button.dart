import 'package:flutter/material.dart';

class gameButton{
  final id;
  String text;
  Color bg;
  bool enabled;

  gameButton(
  {this.id, this.text="",this.bg= Colors.orange, this.enabled = true}
  );
}

