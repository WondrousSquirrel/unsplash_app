import 'package:flutter/cupertino.dart';

import 'package:unsplash/presentation/detail_page.dart';
import 'package:unsplash/presentation/home_page.dart';

class Routes {
  static const String Detail = '/detail';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => HomePage(),
      Routes.Detail: (context) => DetailPage(),
    };
  }
}