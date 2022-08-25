// ignore_for_file: prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tictactoe/logo_widget.dart';
import 'package:tictactoe/play_screen.dart';

Color backgroundColor = Color(0xFF2A363B);
Color buttonColor = Color(0xFFFEA0B7);

class LevelSelection extends StatelessWidget {
  const LevelSelection({Key? key}) : super(key: key);

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
                  label: "Level 0",
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return Play(versusAl: true, level: 0);
                    })));
                  }),
              Spacer(),
              Button(
                  label: "Level 1",
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return Play(versusAl: true, level: 1);
                    })));
                  }),
              Spacer(),
              Button(
                  label: "Level 2",
                  onPress: () {
                    Navigator.pop(context);
                    Navigator.push(context,
                        MaterialPageRoute(builder: ((context) {
                      return Play(versusAl: true, level: 2);
                    })));
                  }),
              Spacer(),
              Spacer(flex: 5),
            ],
          ),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button({Key? key, required this.label, required this.onPress})
      : super(key: key);
  final String label;
  final Function() onPress;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: onPress,
      color: buttonColor,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      height: 0,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(0),
        width: 200,
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
        ),
      ),
    );
  }
}

class XPainter extends CustomPainter {
  final double percent;

  XPainter(this.percent);
  @override
  void paint(Canvas canvas, Size size) {
    var length = min(size.width, size.height);

    var paint1 = Paint()
      ..color = Color(0xFFFD242D)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.23333 * length;

    var paint2 = Paint()
      ..color = Color(0xFFFE9FB6)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.16666 * length;

    var paint0 = Paint()
      ..color = Color(0xFFFDFFFF)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.05555 * length;

    canvas.drawLine(Offset.zero, Offset(length, length) * percent, paint1);
    canvas.drawLine(Offset(length, 0) + Offset(-length, length) * percent,
        Offset(length, 0), paint1);

    canvas.drawLine(Offset.zero, Offset(length, length) * percent, paint2);
    canvas.drawLine(Offset(length, 0) + Offset(-length, length) * percent,
        Offset(length, 0), paint2);

    canvas.drawLine(
      Offset(length, length) * percent -
          Offset(length, length) * (0.4 * 0.009 * length) * percent,
      Offset(length, length) * percent,
      paint0,
    );
    canvas.drawLine(
      Offset(length, 0) +
          Offset(-length, length) * (0.4 * 0.009 * length) * percent,
      Offset(length, 0),
      paint0,
    );
  }

  @override
  bool shouldRepaint(XPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(XPainter oldDelegate) => false;
}

class OPainter extends CustomPainter {
  final double percent;

  OPainter(this.percent);
  @override
  void paint(Canvas canvas, Size size) {
    var radius = min(size.width, size.height) / 2;
    var center = Offset(size.width, size.height) / 2;
    var paint3 = Paint()
      ..color = Color(0xFFFD242D)
      ..strokeWidth = 0.08547 * radius
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius + 0.1709 * radius),
      -pi / 2 - 50,
      2 * pi * percent,
      false,
      paint3,
    );

    var paint2 = Paint()
      ..color = Color(0xFFFE9FB6)
      ..strokeWidth = 0.3205 * radius
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 0.02136 * radius),
      -pi / 2 - 50,
      2 * pi * percent,
      false,
      paint2,
    );

    var paint1 = Paint()
      ..color = Color(0xFFFD242D)
      ..strokeWidth = 0.08547 * radius
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 0.2136 * radius),
      -pi / 2 - 50,
      2 * pi * percent,
      false,
      paint1,
    );

    var paint0 = Paint()
      ..color = Color(0xFFFDFFFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.1068 * radius
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 0.0641 * radius),
      -pi / 2 - 50,
      2 * pi * 0.15 * percent,
      false,
      paint0,
    );
  }

  @override
  bool shouldRepaint(OPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(OPainter oldDelegate) => false;
}

class LogoXPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var length = min(size.width, size.height);

    var paint1 = Paint()
      ..color = Color(0xFFFD242D)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.23333 * length;
    canvas.drawLine(Offset.zero, Offset(length, length), paint1);
    canvas.drawLine(Offset(0, length), Offset(length, 0), paint1);

    var paint2 = Paint()
      ..color = Color(0xFFFE9FB6)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.16666 * length;
    canvas.drawLine(Offset.zero, Offset(length, length), paint2);
    canvas.drawLine(Offset(length, 0), Offset(0, length), paint2);

    var paint0 = Paint()
      ..color = Color(0xFFFDFFFF)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.05555 * length;
    canvas.drawLine(
      Offset(length, length) -
          Offset(length, length) / (0.5 * 0.11111 * length),
      Offset(length, length),
      paint0,
    );
    canvas.drawLine(
      Offset(length, 0) + Offset(-length, length) / (0.5 * 0.11111 * length),
      Offset(length, 0),
      paint0,
    );
  }

  @override
  bool shouldRepaint(LogoXPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(LogoXPainter oldDelegate) => false;
}

class LogoOPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var radius = min(size.width, size.height) / 2;
    var center = Offset(size.width, size.height) / 2;
    var paint3 = Paint()
      ..color = Color(0xFFFD242D)
      ..strokeWidth = 0.08547 * radius
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius + 0.1709 * radius, paint3);

    var paint2 = Paint()
      ..color = Color(0xFFFE9FB6)
      ..strokeWidth = 0.3205 * radius
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - 0.02136 * radius, paint2);

    var paint1 = Paint()
      ..color = Color(0xFFFD242D)
      ..strokeWidth = 0.08547 * radius
      ..style = PaintingStyle.stroke;
    canvas.drawCircle(center, radius - 0.2136 * radius, paint1);

    var paint0 = Paint()
      ..color = Color(0xFFFDFFFF)
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 0.1068 * radius;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius - 0.0641 * radius),
      -pi / 2 - 50,
      2 * pi * 0.15,
      false,
      paint0,
    );
  }

  @override
  bool shouldRepaint(LogoOPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(LogoOPainter oldDelegate) => false;
}
