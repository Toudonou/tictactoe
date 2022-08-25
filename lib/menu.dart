// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/logo_widget.dart';

class Menu extends StatelessWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: backgroundColor,
          ),
          child: Column(
            children: <Widget>[
              Spacer(flex: 4),
              LogoWidget(),
              Spacer(flex: 3),
              Button(
                  label: "Play",
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return LevelSelection();
                    })));
                  }),
              Spacer(),
              Button(
                  label: "Exit",
                  onPress: () {
                    SystemNavigator.pop(animated: true);
                  }),
              Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}
