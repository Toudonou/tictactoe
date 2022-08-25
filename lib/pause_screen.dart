// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/logo_widget.dart';
import 'package:tictactoe/menu.dart';

class Pause extends StatefulWidget {
  Pause({Key? key, required this.pause}) : super(key: key);
  bool pause;
  @override
  State<Pause> createState() => _PauseState();
}

class _PauseState extends State<Pause> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          Spacer(flex: 4),
          LogoWidget(),
          Spacer(flex: 3),
          Button(
              label: "Pause",
              onPress: () {
                setState(() {
                  widget.pause = !widget.pause;
                });
              }),
          Spacer(),
          Button(
              label: "Menu",
              onPress: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: ((context) {
                  return Menu();
                })));
              }),
          Spacer(flex: 5),
        ],
      ),
    );
  }
}
