import 'package:flutter/cupertino.dart';
import 'package:unsplash/presentation/image_list.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(child: Column(children: [
        Container(
            child: Expanded(child: AsyncImageList())
        ),
      ],))
    ]);
  }
}