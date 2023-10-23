import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/allGames/widgets/plus_minus_buttons.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:math' as _math;

class RouleletePreviewScreen extends StatefulWidget {
  @override
  State<RouleletePreviewScreen> createState() => _RouletePreviewScreenState();
}

class _RouletePreviewScreenState extends State<RouleletePreviewScreen> {
  StreamController<int> selected = StreamController<int>.broadcast();
  Stream<int>? selectedx;
  int bet = 0;
  bool shouldSpin = false;

  @override
  void dispose() {
    selected.close();
    super.dispose();
  }

  int coins = 0;

  @override
  void initState() {
    super.initState();
    _loadCoins();
  }

  Future<void> _loadCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('coins') ?? 0;
    });
  }

  int prize = 0;
  int prizex = 0;
  Future<void> getPrise(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    setState(() {
      coins -= bet;
      prefs.setInt('coins', coins);
    });
    switch (index) {
      case 0:
        setState(() {
          prize = -bet;
        });

        break;
      case 1:
        setState(() {
          prize = bet * 4;
        });
        break;
      case 2:
        setState(() {
          prize = 100;
        });
        break;
      case 3:
        setState(() {
          prize = 40;
        });
        break;
      case 4:
        setState(() {
          prize = bet * 20;
        });
        break;
      case 5:
        setState(() {
          prize = bet * 10;
        });
        break;
      case 6:
        setState(() {
          prize = -bet;
        });
        break;
      case 7:
        setState(() {
          prize = 10000;
        });
        break;
      case 8:
        setState(() {
          prize = -bet;
        });
        break;
      case 9:
        setState(() {
          prize = bet * 10;
        });
        break;
      case 10:
        setState(() {
          prize = 20;
        });
        break;
      case 11:
        setState(() {
          prize = bet * 20;
        });
        break;
      case 12:
        setState(() {
          prize = 20;
        });
        break;
      case 13:
        setState(() {
          prize = bet * 40;
        });
        break;
    }
    await Future.delayed(const Duration(seconds: 5));

    setState(() {
      prizex = prize;
      coins += prize;
      prefs.setInt('coins', coins);
    });
  }

  void _setBet(String operation) {
    setState(() {
      if (operation == 'minus') {
        if (bet != 0) {
          bet -= 50;
        }
      } else {
        if (bet != coins) {
          bet += 50;
        }
      }
    });
  }

  Future<void> _betClearAndMinusBet() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      coins -= bet;
      prefs.setInt('coins', coins);
      bet = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    final String sample = 'assets/images/slots/bets';
    final items = <String>[
      '$sample/2.png',
      '$sample/13.png',
      '$sample/5.png',
      '$sample/6.png',
      '$sample/11.png',
      '$sample/9.png',
      '$sample/4.png',
      '$sample/7.png',
      '$sample/0.png',
      '$sample/8.png',
      '$sample/3.png',
      '$sample/10.png',
      '$sample/1.png',
      '$sample/12.png',
    ];

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Container(
              height: ParamsAxis(context).height,
              width: ParamsAxis(context).width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg/bgRouletePreview.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Image.asset(
                          'assets/images/icons/arrowBack.png',
                          height: 40,
                          width: 40,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: SizedBox(
                          height: ParamsAxis(context).height * .7,
                          width: ParamsAxis(context).width * .4,
                          child: Stack(
                            children: [
                              SizedBox(
                                  height: ParamsAxis(context).height * .8,
                                  width: ParamsAxis(context).width * .44,
                                  child: Image.asset(
                                      'assets/images/bg/bgRouleteWheel.png')),
                              FortuneWheel(
                                animateFirst: false,
                                selected: selected.stream,
                                indicators: const [
                                  FortuneIndicator(
                                    alignment: Alignment.topCenter,
                                    child: TriangleIndicator(),
                                  ),
                                ],
                                items: [
                                  for (var it in items)
                                    FortuneItem(
                                      style: FortuneItemStyle(
                                        color: items.indexOf(it) % 2 == 0
                                            ? const Color(0xFF571675)
                                                .withOpacity(0.5)
                                            : const Color(0xFF277a94)
                                                .withOpacity(0.5),
                                        borderColor: const Color(0xFF5e3770),
                                        borderWidth: 2,
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 60),
                                        child: Container(
                                          child: Image.asset(
                                            it,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: SizedBox(
                          height: ParamsAxis(context).height * .7,
                          width: ParamsAxis(context).width * .14,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset('assets/images/icons/prize1.png'),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset('assets/images/icons/prize2.png'),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset('assets/images/icons/prize3.png'),
                              const SizedBox(
                                height: 10,
                              ),
                              Image.asset('assets/images/icons/prize4.png'),
                              const SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 30.0),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: SizedBox(
                              height: ParamsAxis(context).height * .7,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Balance: ',
                                    style: GoogleFonts.bebasNeue(
                                      color: const Color.fromARGB(
                                        255,
                                        134,
                                        57,
                                        147,
                                      ),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    coins.toString(),
                                    style: GoogleFonts.bebasNeue(
                                      color: const Color.fromARGB(
                                          255, 134, 57, 147),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Expanded(
                                    child: PlusMinusButtons(
                                      onMinusTap: () => _setBet('minus'),
                                      onPlusTap: () => _setBet('plus'),
                                    ),
                                    // child: SizedBox(
                                    //   width: 85,
                                    //   child: Center(
                                    //     child: Stack(
                                    //       children: [
                                    //         Container(
                                    //           height:
                                    //               ParamsAxis(context).height *
                                    //                   .35,
                                    //           width: 85,
                                    //           child: Image.asset(
                                    //               'assets/images/icons/bg.png'),
                                    //         ),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               top: 5.0),
                                    //           child: Align(
                                    //             alignment: Alignment.topCenter,
                                    //             child: InkWell(
                                    //               onTap: () {
                                    //                 _setBet('plus');
                                    //               },
                                    //               child: Container(
                                    //                 height: ParamsAxis(context)
                                    //                         .height *
                                    //                     .15,
                                    //                 width: 85,
                                    //                 child: Image.asset(
                                    //                     'assets/images/icons/plus.png'),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //         Padding(
                                    //           padding: const EdgeInsets.only(
                                    //               bottom: 30.0),
                                    //           child: Align(
                                    //             alignment:
                                    //                 Alignment.bottomCenter,
                                    //             child: InkWell(
                                    //               onTap: () {
                                    //                 _setBet('minus');
                                    //               },
                                    //               child: Container(
                                    //                 height: ParamsAxis(context)
                                    //                         .height *
                                    //                     .15,
                                    //                 width: 85,
                                    //                 child: Image.asset(
                                    //                     'assets/images/icons/minus.png'),
                                    //               ),
                                    //             ),
                                    //           ),
                                    //         ),
                                    //       ],
                                    //     ),
                                    //   ),
                                    // ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: ParamsAxis(context).width * .07),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'WIN:',
                            style: GoogleFonts.bebasNeue(
                              color: Color.fromARGB(255, 209, 63, 235),
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            prizex.toString(),
                            style: GoogleFonts.bebasNeue(
                              color: Color.fromARGB(255, 209, 63, 235),
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            'Bet: $bet',
                            style: GoogleFonts.bebasNeue(
                              color: Color.fromARGB(255, 209, 63, 235),
                              fontWeight: FontWeight.bold,
                              fontSize: 35,
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              int selectedIndex =
                                  Fortune.randomInt(0, items.length);
                              if (bet != 0) {
                                setState(() {
                                  shouldSpin = true;
                                });
                                if (shouldSpin) {
                                  selected.add(selectedIndex);
                                  getPrise(selectedIndex);

                                  setState(() {
                                    shouldSpin = false;
                                    prizex = 0;
                                  });
                                }
                              }
                            },
                            child: Container(
                              height: 67,
                              width: 99,
                              child:
                                  Image.asset('assets/images/icons/spin.png'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class TriangleIndicator extends StatelessWidget {
  const TriangleIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Transform.rotate(
      angle: _math.pi,
      child: SizedBox(
          width: 36,
          height: 36,
          child: Transform.rotate(
            angle: 3.14159265,
            child: Image.asset('assets/images/icons/arrowx.png'),
          )),
    );
  }
}
