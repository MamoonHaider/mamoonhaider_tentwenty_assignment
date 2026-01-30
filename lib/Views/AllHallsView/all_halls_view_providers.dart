import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/AllHallsView/all_halls_model.dart';
import 'package:the_movies_flutter_app/Views/AllHallsView/all_halls_viewModel.dart';

class AllHallsViewProviders {
  static var allHallsViewProviders =
  StateNotifierProvider.autoDispose<AllHallsViewModel, AllHallsModel>((ref) =>AllHallsViewModel());
}