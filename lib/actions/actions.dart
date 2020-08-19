
import 'dart:convert';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:http/http.dart' as http;

import 'package:unsplash/keys.dart';
import 'package:unsplash/models/models.dart';
import 'package:unsplash/store/app_state.dart';


import 'dart:async';
import 'package:redux/redux.dart';

class FetchPhotoCollectionActions {
  ThunkAction<AppState> fetchListOfPictures (int page) {
    return (Store<AppState> store) async {
      final photoCollection = await fetchPhotos(page);
      await store.dispatch(FetchPhotoCollectionSuccessAction(photoCollection));
    };
  }
  List<Photo> parsePhotos(String responseBody){
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

  Future<dynamic> fetchPhotos(int page) async {
    const ACCESS_KEY = KeyStorage.UNSPLASH_ACCESS_KEY;
    final response = await http.get('https://api.unsplash.com/photos/?client_id=$ACCESS_KEY&page=$page');
    return parsePhotos(response.body);
  }
}

class FetchPhotoCollectionLoadedAction {}

class FetchPhotoCollectionFailedAction {}

class FetchPhotoCollectionSuccessAction {
  List<Photo> photoCollection;

  FetchPhotoCollectionSuccessAction(this.photoCollection);
}