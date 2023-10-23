import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/articles/articleFullPreview.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/articlesData.dart';

class ArticlesPreviewScreen extends StatefulWidget {
  @override
  State<ArticlesPreviewScreen> createState() => _ArticlesStatePreviewScreen();
}

class _ArticlesStatePreviewScreen extends State<ArticlesPreviewScreen> {
  int coins = 0;
  List<int> selectedIndexes = [];
  @override
  void initState() {
    super.initState();
    _loadCoins();
    loadSelectedIndexes();
  }

  void loadSelectedIndexes() async {
    final prefs = await SharedPreferences.getInstance();
    final indexesString = prefs.getString('selectedIndexes') ?? '';
    if (indexesString.isNotEmpty) {
      selectedIndexes = indexesString.split(',').map(int.parse).toList();
    }
  }

  void saveSelectedIndexes() async {
    final prefs = await SharedPreferences.getInstance();
    final indexesString = selectedIndexes.join(',');
    prefs.setString('selectedIndexes', indexesString);
    setState(() {
      coins = prefs.getInt('coins') ?? 0;
      coins += 200;
      prefs.setInt('coins', coins);
    });
  }

  bool switchValueSound = true;
  bool switchValueVibro = false;
  Future<void> _loadCoins() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      coins = prefs.getInt('coins') ?? 0;
    });
    print(coins);
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
            return Stack(
              children: [
                Container(
                  height: ParamsAxis(context).height,
                  width: ParamsAxis(context).width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/bg/bgMainScreenChooseGame.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: Image.asset(
                                  'assets/images/icons/arrowBack.png'),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Color.fromARGB(130, 94, 33, 105),
                            ),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                SizedBox(
                                  width: 100,
                                  child: Text(
                                    'Balance: ',
                                    style: GoogleFonts.bebasNeue(
                                      color: Color.fromARGB(255, 209, 63, 235),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10.0),
                                  child: Text(
                                    coins.toString(),
                                    style: GoogleFonts.bebasNeue(
                                      color: Color.fromARGB(255, 209, 63, 235),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: ParamsAxis(context).height * .65,
                              width: ParamsAxis(context).width * .4,
                              child: ListView.builder(
                                itemCount: articlesData.length,
                                shrinkWrap: false,
                                itemBuilder: (BuildContext context, int index) {
                                  if (index >= 0 && index < 4) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (selectedIndexes.contains(index)) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleFull(
                                                  image: articlesData[index]
                                                      .mainImage,
                                                  title:
                                                      articlesData[index].name,
                                                  bigText: articlesData[index]
                                                      .mainText,
                                                ),
                                              ),
                                            );
                                          } else {
                                            selectedIndexes.add(index);
                                            saveSelectedIndexes();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleFull(
                                                  image: articlesData[index]
                                                      .mainImage,
                                                  title:
                                                      articlesData[index].name,
                                                  bigText: articlesData[index]
                                                      .mainText,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: articleItem(
                                          context,
                                          articlesData[index].image,
                                          articlesData[index].name,
                                          articlesData[index].reward,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Container(
                              height: ParamsAxis(context).height * 0.65,
                              width: ParamsAxis(context).width * 0.4,
                              child: ListView.builder(
                                itemCount: articlesData.length,
                                shrinkWrap: false,
                                itemBuilder: (BuildContext context, index) {
                                  if (index >= 4 && index <= 8) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 10.0),
                                      child: InkWell(
                                        onTap: () {
                                          if (selectedIndexes.contains(index)) {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleFull(
                                                  image: articlesData[index]
                                                      .mainImage,
                                                  title:
                                                      articlesData[index].name,
                                                  bigText: articlesData[index]
                                                      .mainText,
                                                ),
                                              ),
                                            );
                                          } else {
                                            selectedIndexes.add(index);
                                            saveSelectedIndexes();
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ArticleFull(
                                                  image: articlesData[index]
                                                      .mainImage,
                                                  title:
                                                      articlesData[index].name,
                                                  bigText: articlesData[index]
                                                      .mainText,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: articleItem(
                                          context,
                                          articlesData[index].image,
                                          articlesData[index].name,
                                          articlesData[index].reward,
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container();
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
