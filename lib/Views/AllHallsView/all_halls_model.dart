class AllHallsModel {
  AllHallsModel();

  AllHallsModel.copy(AllHallsModel state) {
    selectedDateIndex = state.selectedDateIndex;
    selectedHallIndex = state.selectedHallIndex;
  }

  int? selectedDateIndex;
  int? selectedHallIndex;
}
