
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/dataParams/constants.dart';

class ArticleFull extends StatefulWidget {
  final String image;
  final String title;
  final String bigText;

  const ArticleFull(
      {super.key,
      required this.image,
      required this.title,
      required this.bigText});

  @override
  State<ArticleFull> createState() => _ArticleFullPreview();
}

class _ArticleFullPreview extends State<ArticleFull> {
  bool switchValueSound = true;
  bool switchValueVibro = false;

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
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
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
                          const SizedBox(
                            width: 20,
                          ),
                          Container(
                            height: 50,
                            width: ParamsAxis(context).width * .76,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromARGB(159, 29, 11, 35),
                                  Color.fromARGB(149, 135, 33, 142)
                                ],
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Image.asset(
                                          'assets/images/articles/${widget.image}'),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  const Spacer(),
                                  Center(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        widget.title,
                                        maxLines: 1,
                                        style: const TextStyle(
                                          color: Color.fromARGB(
                                              191, 247, 245, 248),
                                          fontWeight: FontWeight.w300,
                                          fontSize: 19,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20.0),
                                    child: Container(
                                      height: 50,
                                      width: 81,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(45),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(45),
                                        child: Image.asset(
                                            'assets/images/articles/reward.png'),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 60,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: ParamsAxis(context).height * .65,
                        width: ParamsAxis(context).width * .7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: const LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              Color.fromARGB(182, 99, 0, 104),
                              Color.fromARGB(175, 46, 99, 129),
                            ],
                          ),
                        ),
                        child: Container(
                          height: ParamsAxis(context).height * .64,
                          width: ParamsAxis(context).width * .69,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: ParamsAxis(context).height * .64,
                                width: ParamsAxis(context).width * .3,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(25),
                                  child: Image.asset(
                                    'assets/images/articles/${widget.image}',
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              Container(
                                height: ParamsAxis(context).height * .64,
                                width: ParamsAxis(context).width * .34,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: SingleChildScrollView(
                                  child: Text(
                                    widget.bigText,
                                    textAlign: TextAlign.right,
                                    style: const TextStyle(
                                      color: Color.fromARGB(191, 247, 245, 248),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      )
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
