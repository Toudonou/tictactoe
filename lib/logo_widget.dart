// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';
import 'package:flutter/material.dart';
import 'constants.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double xSize = min(size.width, size.height) >= 400
        ? 0.2 * 400
        : 0.2 * min(size.width, size.height);
    double oSize = min(size.width, size.height) >= 400
        ? 0.21 * 400
        : 0.21 * min(size.width, size.height);
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: xSize,
              height: xSize,
              child: CustomPaint(
                painter: LogoXPainter(),
              ),
            ),
            SizedBox(width: 0.0495 * min(size.width, size.height)),
            SizedBox(
              width: oSize,
              height: oSize,
              child: CustomPaint(
                painter: LogoOPainter(),
              ),
            ),
          ],
        ),
        SizedBox(height: 0.061 * min(size.width, size.height)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: xSize,
              height: xSize,
              child: Transform.rotate(
                angle: pi,
                child: CustomPaint(
                  painter: LogoXPainter(),
                ),
              ),
            ),
            SizedBox(width: 0.0495 * min(size.width, size.height)),
            SizedBox(
              width: oSize,
              height: oSize,
              child: Transform.rotate(
                angle: pi,
                child: CustomPaint(
                  painter: LogoOPainter(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class LogoPauseWidget extends StatelessWidget {
  const LogoPauseWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double xSize = 0.15 * 400;
    double oSize = 0.15 * 400;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: xSize,
              height: xSize,
              child: CustomPaint(
                painter: LogoXPainter(),
              ),
            ),
            SizedBox(width: 0.0495 * min(size.width, size.height)),
            SizedBox(
              width: oSize,
              height: oSize,
              child: CustomPaint(
                painter: LogoOPainter(),
              ),
            ),
          ],
        ),
        SizedBox(height: 0.061 * min(size.width, size.height)),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: xSize,
              height: xSize,
              child: Transform.rotate(
                angle: pi,
                child: CustomPaint(
                  painter: LogoXPainter(),
                ),
              ),
            ),
            SizedBox(width: 0.0495 * min(size.width, size.height)),
            SizedBox(
              width: oSize,
              height: oSize,
              child: Transform.rotate(
                angle: pi,
                child: CustomPaint(
                  painter: LogoOPainter(),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
