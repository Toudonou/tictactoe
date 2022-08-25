// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, prefer_const_constructors_in_immutables, non_constant_identifier_names, no_leading_underscores_for_local_identifiers
import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:tictactoe/constants.dart';
import 'package:tictactoe/logo_widget.dart';
import 'package:tictactoe/menu.dart';
import 'package:xrandom/xrandom.dart';

bool toPlayer1ToPlay = true;
bool toAlToPlay = false;
bool playerVsAI = false;
int AIchoice = -1;

class Play extends StatefulWidget {
  const Play({Key? key, required this.versusAl, required this.level})
      : super(key: key);
  final bool versusAl;
  final int level;
  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  List<int> listState = [0, 0, 0, 0, 0, 0, 0, 0, 0];

  bool pause = false;
  double percent = 0.0;
  double blur = 0;
  int blurWaiting = 50;
  int waiting = 50;
  int winner = 0;
  int lineWinningNumber = -1;
  double lineWinningPercent = 0;
  int lineWinningWaiting = 100;
  bool finised = false;
  String name1 = "Player 1";
  String name2 = "";
  int score1 = 0;
  int score2 = 0;

  //LEVEL 2 VARIABLES
  List<int> numberPcWin = [];
  List<int> numberPcLoose = [];
  List<int> numberNull = [];

  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      Timer.periodic(Duration(milliseconds: 500), (timer) {
        setState(() {});
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    playerVsAI = widget.versusAl;
    name2 =
        "${widget.versusAl ? "AI (level ${widget.level})" : name2.toUpperCase()} ";

    Timer.periodic(Duration(milliseconds: waiting), (timer) {
      if (percent < 0.999999) {
        setState(() {
          percent += 0.01;
        });
      } else {
        waiting = 1000000;
      }
    });
    setState(() {
      winner = twoPlayerModeWinnerCalculating();
      if (winner != 0 || listState.contains(0) == false) {
        toAlToPlay = false;
        if (!finised) {
          Future.delayed(Duration(milliseconds: 500), () {
            finised = true;
          });
        }
      }

      if (winner != 0) {
        Timer.periodic(Duration(milliseconds: lineWinningWaiting), (timer) {
          if (lineWinningPercent < 0.999999) {
            setState(() {
              lineWinningPercent += 0.01;
            });
          } else {
            lineWinningWaiting = 1000000;
          }
        });
      }

      if (finised || pause) {
        Timer.periodic(Duration(milliseconds: blurWaiting), (timer) {
          if (blur < 10) {
            setState(() {
              blur += 1;
            });
          } else {
            blurWaiting = 1000000;
          }
        });
      }

      if (playerVsAI) {
        alAlgo(widget.level);
      }
    });
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: backgroundColor,
        actions: [
          Container(
            child: finised
                ? null
                : !pause
                    ? IconButton(
                        color: pause ? Colors.transparent : buttonColor,
                        iconSize: 40,
                        splashRadius: 18,
                        onPressed: () {
                          setState(() {
                            blur = 0;
                            blurWaiting = 50;
                            pause = !pause;
                          });
                        },
                        icon: Icon(Icons.pause_circle),
                      )
                    : null,
          )
        ],
      ),

      //BODY
      body: Stack(
        children: [
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "${name1.toUpperCase()} : $score1",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  "$name2: $score2",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                Spacer(flex: 2),
                TicTacToe(
                  listState: listState,
                  percent: percent,
                  lineWinningNumber: lineWinningNumber,
                  lineWinningPercent: lineWinningPercent,
                ),
                Spacer(flex: 2),
                InkWell(
                  onTap: () {
                    setState(() {
                      Future.delayed(Duration.zero, () {
                        Reset();
                      });
                    });
                  },
                  borderRadius: BorderRadius.circular(15),
                  child: Ink(
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    width: 150,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 7),
                    child: Center(
                      child: Text(
                        "Reset",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
            child: pause
                ? SafeArea(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Column(
                        children: <Widget>[
                          Spacer(flex: 6),
                          LogoPauseWidget(),
                          Spacer(flex: 3),
                          FlatButton(
                            onPressed: () {
                              setState(() {
                                pause = !pause;
                              });
                            },
                            color: buttonColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(0),
                              width: 150,
                              height: 40,
                              child: Text(
                                "Resume",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          Spacer(),
                          FlatButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: ((context) {
                                return Menu();
                              })));
                            },
                            color: buttonColor,
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.all(0),
                              width: 150,
                              height: 40,
                              child: Text(
                                "Menu",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ),
                          ),
                          Spacer(flex: 4),
                        ],
                      ),
                    ),
                  )
                : finised
                    ? SafeArea(
                        child: Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.transparent,
                          child: Column(
                            children: <Widget>[
                              Spacer(flex: 6),
                              Text(
                                winner != 0
                                    ? "${winner == 1 ? name1 : name2} win"
                                        .toUpperCase()
                                    : "match null".toUpperCase(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              Spacer(flex: 3),
                              FlatButton(
                                onPressed: () {
                                  setState(() {
                                    finised = false;
                                    Future.delayed(Duration.zero, () {
                                      Reset();
                                    });
                                    if (winner == 1) {
                                      Future.delayed(
                                          Duration(milliseconds: 100), () {
                                        score1++;
                                      });
                                    } else if (winner == -1) {
                                      Future.delayed(
                                          Duration(milliseconds: 100), () {
                                        score2++;
                                      });
                                    }
                                  });
                                },
                                color: buttonColor,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(0),
                                  width: 150,
                                  height: 40,
                                  child: Text(
                                    "Play Again",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(),
                              FlatButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: ((context) {
                                    return Menu();
                                  })));
                                },
                                color: buttonColor,
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(0),
                                  width: 150,
                                  height: 40,
                                  child: Text(
                                    "Menu",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                              ),
                              Spacer(flex: 4),
                            ],
                          ),
                        ),
                      )
                    : null,
          )
        ],
      ),
    );
  }

  int pseudoCheckingWinner(List<int> list) {
    if ((list[0] + list[1] + list[2]) == 3 ||
        (list[0] + list[1] + list[2]) == -3) {
      return (list[0] + list[1] + list[2]).sign;
    }
    if (list[3] + list[4] + list[5] == 3 ||
        (list[3] + list[4] + list[5]) == -3) {
      return (list[3] + list[4] + list[5]).sign;
    }
    if ((list[6] + list[7] + list[8]) == 3 ||
        (list[6] + list[7] + list[8]) == -3) {
      return (list[6] + list[7] + list[8]).sign;
    }
    if (list[0] + list[3] + list[6] == 3 || list[0] + list[3] + list[6] == -3) {
      return (list[0] + list[3] + list[6]).sign;
    }
    if (list[1] + list[4] + list[7] == 3 || list[1] + list[4] + list[7] == -3) {
      return (list[1] + list[4] + list[7]).sign;
    }
    if (list[2] + list[5] + list[8] == 3 || list[2] + list[5] + list[8] == -3) {
      return (list[2] + list[5] + list[8]).sign;
    }
    if ((list[0] + list[4] + list[8]) == 3 ||
        (list[0] + list[4] + list[8]) == -3) {
      return (list[0] + list[4] + list[8]).sign;
    }
    if (list[2] + list[4] + list[6] == 3 || list[2] + list[4] + list[6] == -3) {
      return (list[2] + list[4] + list[6]).sign;
    }
    return 0;
  }

  void alAlgo(int level) {
    if (level == 0 && listState.contains(0) && toAlToPlay) {
      List<int> listPossibilites = [];
      for (int i = 0; i < listState.length; i++) {
        if (listState[i] == 0) {
          listPossibilites.add(i);
        }
      }
      AIchoice = listPossibilites[Xrandom().nextInt(listPossibilites.length)];
    }

    if (level == 1 && listState.contains(0) && toAlToPlay) {
      List<int> listStateCopy = [];
      List<int> listPossibilites = [];
      List<int> listWinning = [];
      List<int> listNull = [];
      List<int> listLoosing = [];

      for (int i = 0; i < listState.length; i++) {
        listStateCopy.add(listState[i]);
        if (listState[i] == 0) {
          listPossibilites.add(i);
        }
      }

      for (int i = 0; i < listPossibilites.length; i++) {
        listStateCopy[listPossibilites[i]] = -1;
        if (pseudoCheckingWinner(listStateCopy) == -1) {
          listWinning.add(listPossibilites[i]);
        }
        listStateCopy = [];
        for (int i = 0; i < listState.length; i++) {
          listStateCopy.add(listState[i]);
        }
      }
      for (int i = 0; i < listPossibilites.length; i++) {
        listStateCopy[listPossibilites[i]] = 1;
        if (pseudoCheckingWinner(listStateCopy) == 1) {
          listLoosing.add(listPossibilites[i]);
        }
        listStateCopy = [];
        for (int i = 0; i < listState.length; i++) {
          listStateCopy.add(listState[i]);
        }
      }
      for (int i = 0; i < listPossibilites.length; i++) {
        listStateCopy[listPossibilites[i]] = -1;
        if (pseudoCheckingWinner(listStateCopy) == 0) {
          listNull.add(listPossibilites[i]);
        }
        listStateCopy = [];
        for (int i = 0; i < listState.length; i++) {
          listStateCopy.add(listState[i]);
        }
      }

      if (listWinning.isNotEmpty) {
        AIchoice = listWinning[Xrandom().nextInt(listWinning.length)];
      } else if (listLoosing.isNotEmpty) {
        AIchoice = listLoosing[Xrandom().nextInt(listLoosing.length)];
      } else if (listNull.isNotEmpty) {
        AIchoice = listNull[Xrandom().nextInt(listNull.length)];
      }
    }

    if (level == 2 && listState.contains(0) && toAlToPlay) {
      int bestScore = 10;
      for (int i = 0; i < listState.length; i++) {
        if (listState[i] == 0) {
          listState[i] = -1;
          int score = minimax(listState, false);
          if (score < bestScore) {
            bestScore = score;
            AIchoice = i;
          }
          listState[i] = 0;
        }
      }
    }
  }

  int minimax(List<int> list, bool isMinimizing) {
    if (list.contains(0) == false) {
      return pseudoCheckingWinner(list);
    }

    int absolue = 10;
    int bestScore = 10;

    if (isMinimizing) {
      bestScore = absolue;
      for (int i = 0; i < list.length; i++) {
        if (list[i] == 0) {
          list[i] = -1;
          int score = minimax(list, !isMinimizing);
          bestScore = min(score, bestScore);
          list[i] = 0;
        }
      }
    } else {
      bestScore = -absolue;
      for (int i = 0; i < list.length; i++) {
        if (list[i] == 0) {
          list[i] = 1;
          int score = minimax(list, !isMinimizing);
          bestScore = max(score, bestScore);
          list[i] = 0;
        }
      }
    }

    return bestScore;
  }

  int playerWinChecking(List<int> list, int sign) {
    int number = 0;
    if ((list[0] + list[1] + list[2]) == (3 * sign)) {
      lineWinningNumber = 0;
      number = sign;
    }
    if (list[3] + list[4] + list[5] == (3 * sign)) {
      lineWinningNumber = 1;
      number = sign;
    }
    if (list[6] + list[7] + list[8] == (3 * sign)) {
      lineWinningNumber = 2;
      number = sign;
    }
    if (list[0] + list[3] + list[6] == (3 * sign)) {
      lineWinningNumber = 3;
      number = sign;
    }
    if (list[1] + list[4] + list[7] == (3 * sign)) {
      lineWinningNumber = 4;
      number = sign;
    }
    if (list[2] + list[5] + list[8] == (3 * sign)) {
      lineWinningNumber = 5;
      number = sign;
    }
    if ((list[0] + list[4] + list[8]) == (3 * sign)) {
      lineWinningNumber = 6;
      number = sign;
    }
    if (list[2] + list[4] + list[6] == (3 * sign)) {
      lineWinningNumber = 7;
      number = sign;
    }
    return number;
  }

  int twoPlayerModeWinnerCalculating() {
    if (playerWinChecking(listState, 1) == 1) {
      return 1;
    } else if (playerWinChecking(listState, -1) == -1) {
      return -1;
    } else {
      return 0;
    }
  }

  void Reset() {
    listState = [0, 0, 0, 0, 0, 0, 0, 0, 0];
    toPlayer1ToPlay = true;
    winner = 0;
    percent = 0;
    blur = 0;
    lineWinningNumber = -1;
    lineWinningPercent = 0;
    lineWinningWaiting = 300;
    blurWaiting = 50;
    waiting = 50;
  }
}

class TicTacToe extends StatefulWidget {
  TicTacToe(
      {Key? key,
      required this.listState,
      required this.percent,
      required this.lineWinningPercent,
      required this.lineWinningNumber})
      : super(key: key);
  List<int> listState;
  final double percent;
  final double lineWinningPercent;
  final int lineWinningNumber;
  @override
  State<TicTacToe> createState() => _TicTacToeState();
}

class _TicTacToeState extends State<TicTacToe> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double lenght = min(size.width, size.height) <= 300
        ? min(size.width, size.height) - 2 * 50
        : 300;

    return SizedBox(
      width: lenght,
      height: lenght,
      child: CustomPaint(
        foregroundPainter: TrayPainter(
          widget.percent,
          widget.lineWinningNumber,
          widget.lineWinningPercent,
        ),
        child: Column(
          children: [
            SizedBox(height: 0.058461538461538464 * lenght),
            Row(
              children: [
                SizedBox(width: 0.058461538461538464 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 0,
                  listState: widget.listState,
                ),
                SizedBox(width: 0.1146153846153846 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 1,
                  listState: widget.listState,
                ),
                SizedBox(width: 0.1156153846153846 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 2,
                  listState: widget.listState,
                ),
              ],
            ),
            SizedBox(height: 0.1146153846153846 * lenght),
            Row(
              children: [
                SizedBox(width: 0.058461538461538464 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 3,
                  listState: widget.listState,
                ),
                SizedBox(width: 0.1146153846153846 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 4,
                  listState: widget.listState,
                ),
                SizedBox(width: 0.1166153846153846 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 5,
                  listState: widget.listState,
                ),
              ],
            ),
            SizedBox(height: 0.1146153846153846 * lenght),
            Row(
              children: [
                SizedBox(width: 0.058461538461538464 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 6,
                  listState: widget.listState,
                ),
                SizedBox(width: 0.1166153846153846 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 7,
                  listState: widget.listState,
                ),
                SizedBox(width: 0.1146153846153846 * lenght),
                DrawXO(
                  lenght: lenght,
                  index: 8,
                  listState: widget.listState,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DrawXO extends StatefulWidget {
  DrawXO({
    Key? key,
    required this.lenght,
    required this.index,
    required this.listState,
  }) : super(key: key);
  List<int> listState;
  final double lenght;
  final int index;

  @override
  State<DrawXO> createState() => _DrawXOState();
}

class _DrawXOState extends State<DrawXO> {
  double percent = 0;
  int waiting = 1000000;

  @override
  Widget build(BuildContext context) {
    if (playerVsAI && toAlToPlay) {
      if (AIchoice == widget.index && widget.listState[widget.index] == 0) {
        percent = 0;
        waiting = 50;
        widget.listState[widget.index] = -1;
        toPlayer1ToPlay = !toPlayer1ToPlay;
        toAlToPlay = false;
      }
    }

    Timer.periodic(Duration(milliseconds: waiting), (timer) {
      if (percent < 0.9) {
        setState(() {
          percent += 0.1;
        });
      } else {
        waiting = 1000000;
      }
    });

    return GestureDetector(
      key: ValueKey(UniqueKey()),
      onTap: () {
        setState(() {
          if (widget.listState[widget.index] == 0) {
            percent = 0;
            waiting = 50;
            widget.listState[widget.index] = toPlayer1ToPlay ? 1 : -1;
            toPlayer1ToPlay = !toPlayer1ToPlay;
            Future.delayed(Duration.zero, () {
              if (playerVsAI) {
                toAlToPlay = true;
              }
            });
          }
        });
      },
      child: Container(
        width: widget.lenght / 3 -
            0.038461538461538464 * widget.lenght -
            0.07692307692307693 * widget.lenght,
        height: widget.lenght / 3 -
            0.038461538461538464 * widget.lenght -
            0.07692307692307693 * widget.lenght,
        color: Colors.transparent,
        child: widget.listState[widget.index] != 0
            ? CustomPaint(
                painter: widget.listState[widget.index] == 1
                    ? XPainter(percent)
                    : OPainter(percent),
              )
            : null,
      ),
    );
  }
}

class TrayPainter extends CustomPainter {
  final double percent;
  final int lineNumber;
  final double lineWinningPercent;

  TrayPainter(this.percent, this.lineNumber, this.lineWinningPercent);
  @override
  void paint(Canvas canvas, Size size) {
    var lenght = min(size.width, size.height);
    var paint = Paint()
      ..color = buttonColor
      ..strokeWidth = 0.038461538461538464 * lenght
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(
        Offset(lenght / 3, 0), Offset(lenght / 3, lenght * percent), paint);
    canvas.drawLine(Offset(2 * lenght / 3, 0),
        Offset(2 * lenght / 3, lenght * percent), paint);

    canvas.drawLine(
        Offset(0, lenght / 3), Offset(lenght * percent, lenght / 3), paint);
    canvas.drawLine(Offset(0, 2 * lenght / 3),
        Offset(lenght * percent, 2 * lenght / 3), paint);

    //WINNING LINES
    var panit2 = Paint()
      ..color = Colors.white
      ..strokeWidth = 0.038461538461538464 * lenght
      ..strokeCap = StrokeCap.round;
    var begin;
    var end;

    switch (lineNumber) {
      case 0:
        begin = Offset(0, lenght / 6);
        end = Offset(lenght * lineWinningPercent, lenght / 6);
        break;
      case 1:
        begin = Offset(0, 3 * lenght / 6);
        end = Offset(lenght * lineWinningPercent, 3 * lenght / 6);
        break;
      case 2:
        begin = Offset(0, 5 * lenght / 6);
        end = Offset(lenght * lineWinningPercent, 5 * lenght / 6);
        break;
      case 3:
        begin = Offset(lenght / 6, 0);
        end = Offset(lenght / 6, lenght * lineWinningPercent);
        break;
      case 4:
        begin = Offset(3 * lenght / 6, 0);
        end = Offset(3 * lenght / 6, lenght * lineWinningPercent);
        break;
      case 5:
        begin = Offset(5 * lenght / 6, 0);
        end = Offset(5 * lenght / 6, lenght * lineWinningPercent);
        break;

      case 6:
        begin = Offset(lenght, lenght) * 0.07;
        end = Offset(lenght, lenght) * 0.925 * lineWinningPercent;
        break;
      case 7:
        begin =
            Offset(0, lenght) + Offset(1, -1) * 0.06666666666666667 * lenght;
        end = Offset(lenght, 0) +
            Offset(-lenght, lenght) * (1 - lineWinningPercent + 0.06);
        break;
      default:
    }

    if (lineNumber != -1) {
      canvas.drawLine(begin, end, panit2);
    }
  }

  @override
  bool shouldRepaint(TrayPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(TrayPainter oldDelegate) => false;
}
