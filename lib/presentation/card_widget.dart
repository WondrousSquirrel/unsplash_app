import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unsplash/Routes.dart';
import 'package:unsplash/models/models.dart';

class CardWidget extends StatelessWidget {
  final Photo photo;
  CardWidget(this.photo);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.Detail, arguments: photo);
          },
          child: Column(
            children: [
              Image.network(photo.urls.small),
              Container(
                margin: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Text(photo.user.name, textAlign: TextAlign.center,),
                      Text(photo.description != null ? photo.description : '' )],)
              ),

            ],
          ),
        )
        );
  }

}