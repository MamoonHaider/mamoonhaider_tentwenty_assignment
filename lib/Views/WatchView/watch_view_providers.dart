import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/WatchView/watch_model.dart';
import 'package:the_movies_flutter_app/Views/WatchView/watch_viewModel.dart';

import '../../Services/dio_client_service.dart';

class WatchViewProviders {
  static var watchViewProviders = StateNotifierProvider.autoDispose<WatchViewModel, WatchModel>(
    (ref) => WatchViewModel(),
  );
}
