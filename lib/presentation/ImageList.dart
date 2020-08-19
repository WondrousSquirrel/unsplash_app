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

class AsyncImageList extends StatelessWidget {
  final Completer completer = new Completer();
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, dynamic>(
      onInit: (store) => store.dispatch(FetchPhotoCollectionActions().fetchListOfPictures(1)),
      converter: (store) => store.state.photoCollection,
      builder: (context, photoCollection) {
        return Scaffold(body: photoCollection != null ? ImageListBuilder(photoCollection) : Center(child:  CircularProgressIndicator()));
      }
    );
  }
}

class ImageListBuilder extends StatefulWidget {
  final List<Photo> photoCollection;
  @override
  _ImageListBuilder createState() => _ImageListBuilder();

  ImageListBuilder(this.photoCollection);
}

class _ImageListBuilder extends State<ImageListBuilder> {
  Completer completer = new Completer();
  List<Photo> photoCollection;
  bool isLoading = false;

  int page = 1;

  @override
  void initState(){
    super.initState();
    photoCollection = widget.photoCollection;
  }

  _loadMore()  async{
    setState(() {
      isLoading = true;
      page++;
    });
    await Redux.store.dispatch(FetchPhotoCollectionActions().fetchListOfPictures(page));
    final newCollection = Redux.store.state.photoCollection;
    setState(() {
      print('new collection $newCollection');
      photoCollection.addAll(newCollection);
      isLoading = false;
    });
  }

  Widget _buildRow(Photo photo) {
    return CardWidget(photo);
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
              return _buildRow(photoCollection[i]);
            }
        )
    ) : Text('Loading') ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
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
