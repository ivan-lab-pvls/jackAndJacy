import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';
import 'package:flutter_application_1/game/rewardCoins/constText.dart';
import 'package:flutter_application_1/game/rewardCoins/rewardOpened.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RewardCoins extends StatefulWidget {
  @override
  State<RewardCoins> createState() => _RewardCoinsState();
}

class _RewardCoinsState extends State<RewardCoins> {
  int currentCoins = 0;
  String countdownText = '24:00:00';
  bool canGetCoins = true;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initializePrefs();
  }

  Future<void> initializePrefs() async {
    prefs = await SharedPreferences.getInstance();
    currentCoins = prefs.getInt('coins') ?? 0;
    final lastUpdateTime = prefs.getInt('lastUpdateTime') ?? 0;

    if (currentCoins == 0 || lastUpdateTime == 0) {
      // Если текущее значение монеток равно 0 или времени последнего обновления нет,
      // разрешаем получение монет.
      canGetCoins = true;
    } else {
      // Вычисляем оставшееся время и запускаем обратный отсчет.
      final currentTime = DateTime.now().millisecondsSinceEpoch;
      final timeElapsed = currentTime - lastUpdateTime;
      final timeRemaining = 24 * 60 * 60 * 1000 - timeElapsed;

      if (timeRemaining > 0) {
        startCountdown(timeRemaining);
      } else {
        canGetCoins = true;
      }
    }

    setState(() {});
  }

  void startCountdown(int timeRemaining) {
    var duration = Duration(milliseconds: timeRemaining);
    Timer.periodic(duration, (timer) {
      final hours = duration.inHours;
      final minutes = (duration.inMinutes % 60);
      final seconds = (duration.inSeconds % 60);
      countdownText =
          '$hours:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
      if (duration.inSeconds <= 0) {
        canGetCoins = true;
        countdownText = '24:00:00';
        prefs.setInt('coins', 0);
        timer.cancel();
      } else {
        duration -= const Duration(seconds: 1);
      }
      setState(() {});
    });
  }

  Future<void> updateCoinsValue(int newValue) async {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    prefs.setInt('coins', currentCoins + newValue);
    prefs.setInt('lastUpdateTime', currentTime);
    canGetCoins = false;
    startCountdown(24 * 60 * 60 * 1000);
    setState(() {});
  }

  Future<void> getCoins() async {
    if (canGetCoins) {
      final randomValue = generateRandomCoinValue();
      await updateCoinsValue(randomValue);
    }
  }

  int generateRandomCoinValue() {
    final random = Random();
    return random.nextInt(301) + 200;
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
                        width: 40,
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
                          const SizedBox(
                            width: 100,
                          ),
                          Container(
                            height: ParamsAxis(context).height * .7,
                            width: ParamsAxis(context).width * .5,
                            child: Image.asset(
                              'assets/images/icons/chest.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            width: 80,
                          ),
                          Text(
                            textRewardDefauly,
                            style: GoogleFonts.bebasNeue(
                              color: const Color.fromARGB(255, 196, 48, 222),
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 480.0, top: 200),
                        child: Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              // coinsRandom();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => RewardOpened(
                                      coins: generateRandomCoinValue()),
                                ),
                              );
                            },
                            child: Container(
                              height: 65,
                              width: ParamsAxis(context).width * .15,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
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
                          ),
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
}
