import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardOpened extends StatefulWidget {
  final int coins;
  const RewardOpened({super.key, required this.coins});
  @override
  State<RewardOpened> createState() => _RewardOpenedState();
}

class _RewardOpenedState extends State<RewardOpened> {
  late final SharedPreferences _shPrefs;

  DateTime timeOfNextReward = DateTime(2000);
  Duration? timeLeft;

  Timer timer = Timer(const Duration(seconds: 1), () {});
  var _inited = false;

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  void init() async {
    _shPrefs = await SharedPreferences.getInstance();
    final cachedTime = _shPrefs.getString('lastRewardGiven');
    final lastAwardGivenTime = DateTime.tryParse(cachedTime ?? '');
    if (lastAwardGivenTime == null) {
      setState(() {
        _inited = true;
      });
      return;
    }

    if (DateTime.now().difference(lastAwardGivenTime).inSeconds >=
        60 * 60 * 24) {
      setState(() {
        _inited = true;
      });
      return;
    }

    startTimer(lastAwardGivenTime);
    setState(() {
      _inited = true;
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
                  image:
                      AssetImage('assets/images/bg/bgMainScreenChooseGame.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 40,
                          child:
                              Image.asset('assets/images/icons/arrowBack.png'),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // const SizedBox(
                          //   width: 50,
                          // ),
                          Spacer(),
                          Container(
                            height: ParamsAxis(context).height * .7,
                            width: ParamsAxis(context).width * .5,
                            child: Image.asset(
                              'assets/images/icons/chestOpened.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          // const SizedBox(
                          //   width: 50,
                          // ),
                          // Spacer(),
                          Spacer(flex: 2),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0, top: 40),
                            child: Text(
                              'WE GIVE YOU 200\nCOINS FOR DAILY\nLOGIN TO THE APPLICATION. WE ARE\nWAITING FOR YOU IN\n24 HOURS!',
                              style: GoogleFonts.bebasNeue(
                                color: const Color.fromARGB(255, 196, 48, 222),
                                fontWeight: FontWeight.w400,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          Spacer(flex: 2),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 400.0, top: 200),
                        child: Align(
                          alignment: Alignment.center,
                          child: _inited
                              ? (timeLeft?.inSeconds ?? 0) <= 1
                                  ? InkWell(
                                      onTap: getReward,
                                      child: Container(
                                        height: 65,
                                        width: ParamsAxis(context).width * .15,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color.fromARGB(236, 29, 11, 35),
                                              Color.fromARGB(232, 135, 33, 142)
                                            ],
                                          ),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                              'assets/images/texts/getReward.png'),
                                        ),
                                      ),
                                    )
                                  : Container(
                                      height: 85,
                                      width: ParamsAxis(context).width * .17,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            const Color.fromARGB(
                                                    236, 29, 11, 35)
                                                .withOpacity(0.5),
                                            const Color.fromARGB(
                                                    232, 135, 33, 142)
                                                .withOpacity(0.5),
                                          ],
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'NEXT:\n${_getTimeLeft(timeLeft!)}',
                                          style: GoogleFonts.bebasNeue(
                                            color: const Color.fromARGB(
                                                255, 196, 48, 222),
                                            fontWeight: FontWeight.w400,
                                            fontSize: 24,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                              : const SizedBox(),
                        ),
                      ),
                    ],
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

  Future<void> getReward() async {
    var coins = _shPrefs.getInt('coins') ?? 0;
    coins += 200;
    await _shPrefs.setInt('coins', coins);

    final lastAwardGivenTime = DateTime.now();
    _shPrefs.setString('lastRewardGiven', lastAwardGivenTime.toString());

    startTimer(lastAwardGivenTime);
  }

  void startTimer(DateTime lastAwardGivenTime) {
    timeOfNextReward = lastAwardGivenTime.add(const Duration(days: 1));

    setState(() {
      timeLeft = timeOfNextReward.difference(DateTime.now());
    });

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeLeft = timeOfNextReward.difference(DateTime.now());
      });
      if (timeLeft!.inSeconds <= 1) {
        timer.cancel();
      }
    });
  }

  String _getTimeLeft(Duration duration) {
    final generalSeconds = duration.inSeconds;
    final seconds = generalSeconds.remainder(60);
    final minutes = (generalSeconds.remainder(60 * 60) / 60).floor();
    final hours = (generalSeconds / (60 * 60)).floor();

    final secondsFormatted = seconds.toString().padLeft(2, '0');
    final minutesFormatted = minutes.toString().padLeft(2, '0');
    final hoursFormatted = hours.toString().padLeft(2, '0');
    return '$hoursFormatted:$minutesFormatted:$secondsFormatted';
  }
}
