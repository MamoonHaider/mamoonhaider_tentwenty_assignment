import 'package:flutter_riverpod/legacy.dart';
import 'package:the_movies_flutter_app/Views/AllHallsView/all_halls_model.dart';

class AllHallsViewModel extends StateNotifier<AllHallsModel> {
  AllHallsViewModel() : super(AllHallsModel());

  void setSelectedDate(int index) {
    state = AllHallsModel.copy(state)..selectedDateIndex = index;
  }

  void setSelectedHall(int index) {
    state = AllHallsModel.copy(state)..selectedHallIndex = index;
  }
}
