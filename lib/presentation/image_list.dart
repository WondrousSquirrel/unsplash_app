import 'dart:async';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:unsplash/actions/actions.dart';
import 'package:unsplash/helpers/redux_helper.dart';
import 'package:unsplash/models/models.dart';
import 'package:unsplash/presentation/card_widget.dart';
import 'package:unsplash/store/app_state.dart';

class ImageList extends StatefulWidget {
  @override
  _ImageList createState() => _ImageList();
}

class _ImageList extends State<ImageList> {
  Completer completer = new Completer();
  List<Photo> photoCollection;
  bool isLoading = false;

  int page = 1;

  @override
  void initState(){
    super.initState();
    _loadMore();
  }

  _loadMore()  async{
    setState(() {
      isLoading = true;
      page++;
    });
    await Redux.store.dispatch(FetchPhotoCollectionActions().fetchListOfPictures(page));
    final newCollection = Redux.store.state.photoCollection;
    setState(() {
      if(photoCollection == null) {
        photoCollection = newCollection;
      } else {
        photoCollection.addAll(newCollection);
      }
      isLoading = false;
    });
  }

  Widget _buildList() {
    return photoCollection != null ?
    LazyLoadScrollView(
        isLoading: isLoading,
        onEndOfPage: () => _loadMore(),
        child: ListView.builder(
            itemCount: photoCollection.length,
            padding: EdgeInsets.all(16.0),
            itemBuilder: (context, i) {
              return CardWidget(photoCollection[i]);
            }
        )
    ) : Text('Loading') ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: photoCollection != null? _buildList() : CircularProgressIndicator(),
    );
  }
}

/*
class AsyncImageList extends StatelessWidget {
  final Completer completer = new Completer();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: Redux.store.dispatch(FetchPhotoCollectionActions().fetchListOfPictures(completer)), // async work
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return Center(child: CircularProgressIndicator(),);
          default:
            if (snapshot.hasError)
              return Text('Error: ${snapshot.error}');
            else {
              return StoreConnector<AppState, dynamic> (
                  converter: (store) => store.state.photoCollection,
                  builder: (context, photoCollection) {
                    return ImageListBuilder(photoCollection);
                  }
              );
            }

        }
      },
    );
  }
}

*/
