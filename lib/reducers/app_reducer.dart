import 'package:unsplash/actions/actions.dart';
import 'package:unsplash/reducers/photo_reducer.dart';
import 'package:unsplash/store/app_state.dart';

AppState appReducer(AppState state, action) {
  if( action == FetchPhotoCollectionLoadedAction) {
    state.state = LoadingState.loading;
    return state;
  }
  if( action == FetchPhotoCollectionFailedAction) {
    state.state = LoadingState.error;
    return state;
  }
  if(action is FetchPhotoCollectionSuccessAction) {
    state.state = LoadingState.none;
    final nextState = photosReducer(state, action);
    return state.copyWith(photoCollection: nextState);
  }
  return state;
}
