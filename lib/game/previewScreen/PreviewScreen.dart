import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/allGames/pookies/pookies_game.dart';
import 'package:flutter_application_1/game/allGames/rouleteGame/rouletePreview.dart';
import 'package:flutter_application_1/game/allGames/slotGame/slotGamePreview.dart';
import 'package:flutter_application_1/game/articles/articlesPreviewScreen.dart';
import 'package:flutter_application_1/game/music.dart';
import 'package:flutter_application_1/game/rewardCoins/rewardCoins.dart';
import 'package:flutter_application_1/game/settings/settingsPreview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';

import 'chooseGame/chooseGame.dart';

class PreviewScreenGame extends StatefulWidget {
  @override
  State<PreviewScreenGame> createState() => _PreviewScreenGameState();
}

class _PreviewScreenGameState extends State<PreviewScreenGame> {
  final audioControl = AudioControl();
  late Timer timer;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 5), (Timer t) {
      _loadSharedPreferences();
    });
  }

  bool vibroValue = false;
  Future<void> _loadSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    bool soundValue = prefs.getBool('music') ?? false;
    vibroValue = prefs.getBool('vibro') ?? false;
    if (soundValue == true) {
      audioControl.playAudio();
    } else {
      audioControl.stopAudio();
    }
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
              height: double.infinity,
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image:
                      AssetImage('assets/images/bg/bgMainScreenChooseGame.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              child: SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 40,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => RewardCoins(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/icons/rewardDaily.png',
                            width: 40,
                            height: 40,
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => SettingsPreview(),
                              ),
                            );
                          },
                          child: Image.asset(
                            'assets/images/icons/settings.png',
                            width: 36,
                            height: 36,
                          ),
                        ),
                        const SizedBox(
                          width: 40,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(
                          flex: 10,
                        ),
                        gameItemchoose(context, () {
                          if (vibroValue == true) {
                            Vibration.vibrate();
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => SlotGame(),
                            ),
                          );
                        }, 'assets/images/texts/slotMachine.png',
                            'assets/images/gamesChoose/slot.png'),
                        const Spacer(),
                        gameItemchoose(context, () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PookiesGame(),
                            ),
                          );
                        }, 'assets/images/texts/pookies.png',
                            'assets/images/gamesChoose/pook.png'),
                        const Spacer(),
                        gameItemchoose(context, () {
                          if (vibroValue == true) {
                            Vibration.vibrate();
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => RouleletePreviewScreen(),
                            ),
                          );
                        }, 'assets/images/texts/roulette.png',
                            'assets/images/gamesChoose/roulete.png'),
                        const Spacer(),
                        gameItemchoosex(context, () {
                          if (vibroValue == true) {
                            Vibration.vibrate();
                          }
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ArticlesPreviewScreen(),
                            ),
                          );
                        }, 'assets/images/texts/articles.png',
                            'assets/images/gamesChoose/article.png'),
                        const Spacer(
                          flex: 10,
                        ),
                      ],
                    ),
                    const Spacer(),
                  ],
                ),
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
