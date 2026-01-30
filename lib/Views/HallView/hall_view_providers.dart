import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/HallView/hall_model.dart';
import 'package:the_movies_flutter_app/Views/HallView/hall_viewModel.dart';

class HallViewProviders {
  static var hallViewProviders = StateNotifierProvider.autoDispose<HallViewModel, HallModel>((ref) => HallViewModel());
}
