import 'package:flutter_riverpod/legacy.dart';

import 'home_model.dart';

class HomeViewModel extends StateNotifier<HomeModel> {
  HomeViewModel() : super(HomeModel());

  void setIndex(int index) {
    if (state.index != index) {
      state = HomeModel.copy(state)..index = index;
    }
  }
}
