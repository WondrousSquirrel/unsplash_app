import 'package:unsplash/models/models.dart';
import 'package:unsplash/store/app_state.dart';

List<Photo> photosReducer(AppState prevState, dynamic action) {
    return action.photoCollection;
}
/*
TODO: вынести все что относится к Photo в этот редбюсер, а
 appReducer будет собирать все редьюсеры воедино.
*/