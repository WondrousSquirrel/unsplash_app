import 'dart:convert';

import 'package:unsplash/models/models.dart';

enum LoadingState { none, loading, error }

class AppState {
  final List<Photo> photoCollection;

  AppState({this.photoCollection});

  LoadingState state = LoadingState.loading;

  dynamic toJson() => {
    'photoCollection': photoCollection,
  };

  AppState copyWith({
    List<Photo> photoCollection,
  }) {
    return AppState(
        photoCollection: photoCollection ?? this.photoCollection
    );
  }

  @override
  String toString() {
    return 'App state: ${JsonEncoder.withIndent('  ').convert(this)}';
  }
}