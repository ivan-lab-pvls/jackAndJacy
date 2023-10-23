import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/game/allGames/widgets/plus_minus_buttons.dart';
import 'package:flutter_application_1/game/allGames/widgets/roll_slot/roll_slot.dart';
import 'package:flutter_application_1/game/allGames/widgets/roll_slot/roll_slot_controller.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<List<String>> itemsIcons = [
  [
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
  ],
  [
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot5.png',
  ],
  [
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot5.png',
  ],
];

const int minBet = 50;

class PookiesGame extends StatefulWidget {
  const PookiesGame({super.key});

  @override
  State<PookiesGame> createState() => _PookiesGameState();
}

class _PookiesGameState extends State<PookiesGame> {
  late final SharedPreferences _shPref;
  var _spinning = false;
  var coins = 0;
  var bet = minBet;
  var win = 0;

  final _rollSlotController = RollSlotController(secondsBeforeStop: 3);
  final _rollSlotController1 = RollSlotController(secondsBeforeStop: 3);
  final _rollSlotController2 = RollSlotController(secondsBeforeStop: 3);

  final List<String> itemAssets = [
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
  ];

  @override
  void initState() {
    super.initState();
    _loadCoins();
    _rollSlotController.addListener(() {
      // trigger setState method to reload ui with new index
      // in our case the AppBar title will change
      setState(() {});
    });
  }

  Future<void> _loadCoins() async {
    _shPref = await SharedPreferences.getInstance();
    setState(() {
      coins = _shPref.getInt('coins') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Container(
              height: ParamsAxis(context).height,
              width: ParamsAxis(context).width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/pookies/bg.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Image.asset(
                              'assets/images/icons/arrowBack.png',
                              width: 32,
                              height: 32,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 160,
                          child: Text(
                            'Bet: $bet',
                            style: GoogleFonts.bebasNeue(
                              color: Color.fromARGB(255, 209, 63, 235),
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.fitHeight,
                            image:
                                AssetImage('assets/images/pookies/machine.png'),
                          ),
                        ),
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final height = constraints.maxHeight;
                            final width = constraints.maxWidth;

                            return Stack(
                              children: [
                                // Positioned(
                                //   bottom: height * 0.14,
                                //   left: width * 0.11,
                                //   child: Image.asset(
                                //     'assets/images/pookies/bg_slots.png',
                                //     height: height * 0.4,
                                //   ),
                                // ),
                                Positioned(
                                  bottom: height * 0.14,
                                  left: width * 0.11,
                                  child: SizedBox(
                                    height: height * 0.4,
                                    width: width * 0.7,
                                    child: Row(
                                      children: [
                                        _Slot(
                                          items: itemsIcons[0],
                                          rollSlotController:
                                              _rollSlotController,
                                          bgPath:
                                              'assets/images/pookies/bg_left.png',
                                        ),
                                        _Slot(
                                          items: itemsIcons[1],
                                          rollSlotController:
                                              _rollSlotController1,
                                          bgPath:
                                              'assets/images/pookies/bg_center.png',
                                        ),
                                        _Slot(
                                          items: itemsIcons[2],
                                          rollSlotController:
                                              _rollSlotController2,
                                          bgPath:
                                              'assets/images/pookies/bg_right.png',
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: height * 0.3,
                                  left: width * 0.095,
                                  child: Image.asset(
                                    'assets/images/pookies/marker.png',
                                    height: 30,
                                  ),
                                ),
                                Positioned(
                                  top: height * 0.28,
                                  left: width * 0.55,
                                  child: SizedBox(
                                    width: 160,
                                    child: Text(
                                      win.toString(),
                                      style: GoogleFonts.bebasNeue(
                                        color: Colors.white,
                                        // color: const Color.fromARGB(
                                        //   255,
                                        //   134,
                                        //   57,
                                        //   147,
                                        // ),
                                        fontWeight: FontWeight.w500,
                                        fontSize: 45,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      // child: Column(
                      //   children: [
                      //     const Spacer(),
                      //     SizedBox(
                      //       height: ParamsAxis(context).height * 0.6,
                      //       child: Row(
                      //         children: [
                      //           _Slot(
                      //             rollSlotController: _rollSlotController,
                      //             items: itemsIcons[0],
                      //           ),
                      //           const SizedBox(width: 8),
                      //           _Slot(
                      //             rollSlotController: _rollSlotController1,
                      //             items: itemsIcons[1],
                      //           ),
                      //           const SizedBox(width: 8),
                      //           _Slot(
                      //             rollSlotController: _rollSlotController2,
                      //             items: itemsIcons[2],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //     const SizedBox(height: 12),
                      //     Expanded(
                      //       flex: 2,
                      //       child: Row(
                      //         mainAxisAlignment:
                      //             MainAxisAlignment.spaceEvenly,
                      //         children: [
                      //           Row(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Image.asset(
                      //                 'assets/images/slots/win.png',
                      //                 width: 110,
                      //               ),
                      //               const SizedBox(width: 12),
                      //               Text(
                      //                 '2408',
                      //                 style: GoogleFonts.bebasNeue(
                      //                   color: const Color.fromARGB(
                      //                     255,
                      //                     134,
                      //                     57,
                      //                     147,
                      //                   ),
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 50,
                      //                 ),
                      //               ),
                      //             ],
                      //           ),
                      //           Row(
                      //             mainAxisSize: MainAxisSize.min,
                      //             children: [
                      //               Text(
                      //                 'Bet: $bet',
                      //                 style: GoogleFonts.bebasNeue(
                      //                   color: const Color.fromARGB(
                      //                     255,
                      //                     134,
                      //                     57,
                      //                     147,
                      //                   ),
                      //                   fontWeight: FontWeight.bold,
                      //                   fontSize: 50,
                      //                 ),
                      //               ),
                      //               // const SizedBox(width: 12),
                      //               // Text(
                      //               //   bet.toString(),
                      //               //   style: TextStyle(
                      //               //     color: Colors.white,
                      //               //     fontWeight: FontWeight.w500,
                      //               //     fontSize: 40,
                      //               //   ),
                      //               // ),
                      //             ],
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ),
                    const SizedBox(width: 8),
                    Column(
                      children: [
                        Spacer(),
                        SizedBox(
                          height: ParamsAxis(context).height * 0.6,
                          child: Column(
                            children: [
                              SizedBox(
                                width: 150,
                                child: Text(
                                  'Balance: ',
                                  style: GoogleFonts.bebasNeue(
                                    color: Color.fromARGB(255, 209, 63, 235),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 50,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                coins.toString(),
                                style: GoogleFonts.bebasNeue(
                                  color: Color.fromARGB(255, 209, 63, 235),
                                  fontWeight: FontWeight.bold,
                                  fontSize: 45,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Expanded(
                                child: PlusMinusButtons(
                                  onPlusTap: () => setState(() {
                                    bet += minBet;
                                  }),
                                  onMinusTap: () {
                                    if (bet > minBet) {
                                      setState(() {
                                        bet -= minBet;
                                      });
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          flex: 2,
                          child: InkWell(
                            onTap: _onSpinTap,
                            child: Image.asset(
                              'assets/images/slots/spin.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }

          return Container();
        },
      ),
    );
  }

  Future<void> _onSpinTap() async {
    if (coins < bet) return;

    if (_spinning) {
      print('hello');
      return;
    }

    setState(() {
      coins -= bet;
    });
    _shPref.setInt('coins', coins);

    print('spin');

    _spinning = true;
    final items = List.generate(3, (index) => Random().nextInt(10));
    //win
    // final items = [0, 1, 0, 7, 8];

    _rollSlotController.animateRandomly(
      topIndex: Random().nextInt(itemAssets.length),
      centerIndex: items[0],
      bottomIndex: Random().nextInt(itemAssets.length),
    );
    _rollSlotController1.animateRandomly(
      topIndex: Random().nextInt(itemAssets.length),
      centerIndex: items[1],
      bottomIndex: Random().nextInt(itemAssets.length),
    );
    _rollSlotController2.animateRandomly(
      topIndex: Random().nextInt(itemAssets.length),
      centerIndex: items[2],
      bottomIndex: Random().nextInt(itemAssets.length),
    );

    await Future.delayed(const Duration(seconds: 7));

    final List<String> gotItems = [];

    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      gotItems.add(itemsIcons[i][item]);
    }
    final gotItemsInitialLength = gotItems.length;

    final gotItemsSet = gotItems.toSet();

    final gotItemSetLength = gotItemsSet.length;

    switch (gotItemsInitialLength - gotItemSetLength) {
      case 1:
        changeCoins(bet * 2);
      case 2:
        changeCoins(bet * 3);
      default:
        setState(() {
          win = 0;
        });
    }
    _spinning = false;
  }

  Future<void> changeCoins(int amount) async {
    setState(() {
      coins += amount;
      win = amount;
    });
    await _shPref.setInt('coins', coins);
  }
}

class _Slot extends StatelessWidget {
  const _Slot({
    super.key,
    required this.rollSlotController,
    required this.items,
    required this.bgPath,
  });

  final RollSlotController rollSlotController;
  final List<String> items;
  final String bgPath;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IgnorePointer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                fit: BoxFit.fitWidth,
                image: AssetImage(bgPath),
              ),
            ),
            child: RollSlot(
              itemExtend: 60,
              rollSlotController: rollSlotController,
              children: items
                  .map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Image.asset(e)))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
