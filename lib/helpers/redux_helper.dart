import 'package:redux/redux.dart';
import 'package:redux_logging/redux_logging.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:unsplash/reducers/app_reducer.dart';
import 'package:unsplash/store/app_state.dart';

class Redux {
  static Store<AppState> _store;

  static Store<AppState> get store {
    if (_store == null) {
      throw Exception("store is not initialized");
    } else {
      return _store;
    }
  }

  static Future<void> init() async {
    _store = Store<AppState>(
      appReducer,
      middleware: [thunkMiddleware, new LoggingMiddleware.printer()],
      initialState: AppState(),
    );
  }
}