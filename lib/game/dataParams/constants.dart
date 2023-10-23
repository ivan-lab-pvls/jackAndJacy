import 'package:flutter/widgets.dart';

class ParamsAxis {
  final double width;
  final double height;

  ParamsAxis(BuildContext context)
      : width = MediaQuery.of(context).size.width,
        height = MediaQuery.of(context).size.height;
}
