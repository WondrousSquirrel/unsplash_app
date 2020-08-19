import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash/models/models.dart';

class DetailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Photo photo = ModalRoute.of(context).settings.arguments;
    return Scaffold(body: Image.network(photo.urls.regular));
  }
}