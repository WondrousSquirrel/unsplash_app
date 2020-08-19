import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/services.dart';

import 'package:unsplash/Routes.dart';
import 'package:unsplash/helpers/redux_helper.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
  ));

  Redux.init();
  runApp(StoreProvider(store: Redux.store, child: MyApp()));
}

class MyApp extends StatelessWidget {
  final Completer completer = new Completer();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: Routes.getRoutes(),
      initialRoute: '/',
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      )
    );
  }
}

