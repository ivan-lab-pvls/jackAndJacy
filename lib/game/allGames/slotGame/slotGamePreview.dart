import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/allGames/widgets/plus_minus_buttons.dart';
import 'package:flutter_application_1/game/allGames/widgets/roll_slot/roll_slot.dart';
import 'package:flutter_application_1/game/allGames/widgets/roll_slot/roll_slot_controller.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

const int minBet = 50;

const List<List<String>> itemsIcons = [
  [
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
  ],
  [
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot5.png',
  ],
  [
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot5.png',
  ],
  [
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot3.png',
  ],
  [
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot3.png',
    'assets/images/slots/slot4.png',
    'assets/images/slots/slot5.png',
    'assets/images/slots/slot2.png',
    'assets/images/slots/slot1.png',
    'assets/images/slots/slot4.png',
  ]
];

class SlotGame extends StatefulWidget {
  @override
  State<SlotGame> createState() => _RewardCoinsState();
}

class _RewardCoinsState extends State<SlotGame> {
  late final SharedPreferences _shPref;
  var _spinning = false;
  var coins = 0;
  var bet = minBet;
  var win = 0;

  final _rollSlotController = RollSlotController(secondsBeforeStop: 3);
  final _rollSlotController1 = RollSlotController(secondsBeforeStop: 3);
  final _rollSlotController2 = RollSlotController(secondsBeforeStop: 3);
  final _rollSlotController3 = RollSlotController(secondsBeforeStop: 3);
  final _rollSlotController4 = RollSlotController(secondsBeforeStop: 3);

  final random = Random();
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

  // int coins = 0;
  // late SlotMachineController _controller;
  // @override
  // void initState() {
  //   super.initState();
  //   _loadCoins();
  // }

  // void onButtonTap({required int index}) {
  //   _controller.stop(reelIndex: index);
  // }

  // void onStart() {
  //   final index = Random().nextInt(20);
  //   _controller.start(hitRollItemIndex: index < 5 ? index : null);
  // }

  Future<void> _loadCoins() async {
    _shPref = await SharedPreferences.getInstance();
    setState(() {
      coins = _shPref.getInt('coins') ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);

    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.landscape) {
            return Container(
              height: ParamsAxis(context).height,
              width: ParamsAxis(context).width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg/bgSlotsPreview.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(width: 24),
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
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          children: [
                            const Spacer(),
                            SizedBox(
                              height: ParamsAxis(context).height * 0.6,
                              child: Row(
                                children: [
                                  _Slot(
                                    rollSlotController: _rollSlotController,
                                    items: itemsIcons[0],
                                  ),
                                  const SizedBox(width: 8),
                                  _Slot(
                                    rollSlotController: _rollSlotController1,
                                    items: itemsIcons[1],
                                  ),
                                  const SizedBox(width: 8),
                                  _Slot(
                                    rollSlotController: _rollSlotController2,
                                    items: itemsIcons[2],
                                  ),
                                  const SizedBox(width: 8),
                                  _Slot(
                                    rollSlotController: _rollSlotController3,
                                    items: itemsIcons[3],
                                  ),
                                  const SizedBox(width: 8),
                                  _Slot(
                                    rollSlotController: _rollSlotController4,
                                    items: itemsIcons[4],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 12),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color.fromARGB(127, 122, 58, 94),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'WIN:',
                                            style: GoogleFonts.bebasNeue(
                                              color: Color.fromARGB(
                                                  255, 209, 63, 235),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            win.toString(),
                                            style: GoogleFonts.bebasNeue(
                                              color: Color.fromARGB(
                                                  255, 209, 63, 235),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Center(
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                            'Bet: $bet',
                                            style: GoogleFonts.bebasNeue(
                                              color: Color.fromARGB(
                                                  255, 209, 63, 235),
                                              fontWeight: FontWeight.bold,
                                              fontSize: 35,
                                            ),
                                          ),
                                          // const SizedBox(width: 12),
                                          // Text(
                                          //   bet.toString(),
                                          //   style: TextStyle(
                                          //     color: Colors.white,
                                          //     fontWeight: FontWeight.w500,
                                          //     fontSize: 40,
                                          //   ),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        children: [
                          Spacer(),
                          Container(
                            height: ParamsAxis(context).height * 0.6,
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color.fromARGB(177, 122, 58, 94),
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Balance: ',
                                        style: GoogleFonts.bebasNeue(
                                          color:
                                              Color.fromARGB(255, 226, 60, 255),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        coins.toString(),
                                        style: GoogleFonts.bebasNeue(
                                          color:
                                              Color.fromARGB(255, 226, 60, 255),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 40,
                                        ),
                                      ),
                                    ],
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
              ),
              // child: SafeArea(
              // child: Stack(
              //   children: [

              // Column(
              //   mainAxisAlignment: MainAxisAlignment.start,
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: <Widget>[
              //     const SizedBox(
              //       height: 40,
              //     ),
              //     Row(
              //       mainAxisAlignment: MainAxisAlignment.start,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         const SizedBox(
              //           width: 80,
              //         ),
              //         InkWell(
              //           onTap: () {
              //             Navigator.pop(context);
              //           },
              //           child: Container(
              //             height: 40,
              //             width: 40,
              //             child: Image.asset(
              //                 'assets/images/icons/arrowBack.png'),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 20,
              //         ),
              //         Container(
              //           height: ParamsAxis(context).height * .7,
              //           width: ParamsAxis(context).width * .6,
              //           child: SlotMachine(
              //             rollItems: [
              //               RollItem(
              //                   index: 0,
              //                   child: Container(
              //                     height: 30,
              //                     width: 30,
              //                     child: Image.asset(
              //                         "assets/images/slots/1.png"),
              //                   )),
              //               RollItem(index: 1, child: Text("Y")),
              //               RollItem(index: 2, child: Text("Z")),
              //             ],
              //             onCreated: (controller) {
              //               _controller = controller;
              //             },
              //             onFinished: (resultIndexes) {
              //               print('Result: $resultIndexes');
              //             },
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 20.0),
              //           child: Container(
              //             height: ParamsAxis(context).height * .7,
              //             width: 160,
              //             child: Column(
              //               mainAxisAlignment: MainAxisAlignment.start,
              //               crossAxisAlignment: CrossAxisAlignment.center,
              //               children: [
              //                 Image.asset(
              //                     'assets/images/texts/balance.png'),
              //                 const SizedBox(
              //                   height: 10,
              //                 ),
              //                 Text(
              //                   coins.toString(),
              //                   style: GoogleFonts.bebasNeue(
              //                     color: const Color.fromARGB(
              //                         255, 134, 57, 147),
              //                     fontWeight: FontWeight.bold,
              //                     fontSize: 35,
              //                   ),
              //                 ),
              //                 const SizedBox(
              //                   height: 10,
              //                 ),
              //                 Container(
              //                   height: ParamsAxis(context).height * .42,
              //                   width: 85,
              //                   child: Center(
              //                     child: Stack(
              //                       children: [
              //                         Container(
              //                           height: ParamsAxis(context).height *
              //                               .35,
              //                           width: 85,
              //                           child: Image.asset(
              //                               'assets/images/icons/bg.png'),
              //                         ),
              //                         Padding(
              //                           padding:
              //                               const EdgeInsets.only(top: 5.0),
              //                           child: Align(
              //                             alignment: Alignment.topCenter,
              //                             child: InkWell(
              //                               onTap: () {
              //                                 //plus bet
              //                               },
              //                               child: Container(
              //                                 height: ParamsAxis(context)
              //                                         .height *
              //                                     .15,
              //                                 width: 85,
              //                                 child: Image.asset(
              //                                     'assets/images/icons/plus.png'),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                         Padding(
              //                           padding: const EdgeInsets.only(
              //                               bottom: 30.0),
              //                           child: Align(
              //                             alignment: Alignment.bottomCenter,
              //                             child: InkWell(
              //                               onTap: () {
              //                                 //minus bet
              //                               },
              //                               child: Container(
              //                                 height: ParamsAxis(context)
              //                                         .height *
              //                                     .15,
              //                                 width: 85,
              //                                 child: Image.asset(
              //                                     'assets/images/icons/minus.png'),
              //                               ),
              //                             ),
              //                           ),
              //                         ),
              //                       ],
              //                     ),
              //                   ),
              //                 ),
              //               ],
              //             ),
              //           ),
              //         )
              //       ],
              //     ),
              //   ],
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 30, right: 60),
              //   child: Align(
              //     alignment: Alignment.bottomRight,
              //     child: InkWell(
              //       onTap: () {
              //         //spin
              //       },
              //       child: Container(
              //         height: 67,
              //         width: 99,
              //         child: Image.asset('assets/images/icons/spin.png'),
              //       ),
              //     ),
              //   ),
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(bottom: 35.0, right: 100.0),
              //   child: Align(
              //     alignment: Alignment.bottomCenter,
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       crossAxisAlignment: CrossAxisAlignment.center,
              //       children: [
              //         Image.asset('assets/images/texts/win.png'),
              //         const SizedBox(
              //           width: 10,
              //         ),
              //         Text(
              //           '0',
              //           style: GoogleFonts.bebasNeue(
              //             color: const Color.fromARGB(255, 134, 57, 147),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 35,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              //   ],
              // ),
              // ),
            );
          } else {
            return Container();
          }
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
    final items = List.generate(5, (index) => Random().nextInt(10));
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
    _rollSlotController3.animateRandomly(
      topIndex: Random().nextInt(itemAssets.length),
      centerIndex: items[3],
      bottomIndex: Random().nextInt(itemAssets.length),
    );
    _rollSlotController4.animateRandomly(
      topIndex: Random().nextInt(itemAssets.length),
      centerIndex: items[4],
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
      case 3:
        changeCoins(bet * 4);
      case 4:
        changeCoins(bet * 5);
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
  });

  final RollSlotController rollSlotController;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: IgnorePointer(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/slots/bg.png'),
              ),
            ),
            child: RollSlot(
              itemExtend: 90,
              rollSlotController: rollSlotController,
              children: items.map((e) => Image.asset(e)).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
