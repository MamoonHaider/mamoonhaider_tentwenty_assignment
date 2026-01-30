import 'package:flutter_riverpod/legacy.dart';
import 'home_model.dart';
import 'home_viewModel.dart';

class HomeViewProviders {
  static var homeViewModelProvider =
  StateNotifierProvider.autoDispose<HomeViewModel, HomeModel>((ref) => HomeViewModel());
}