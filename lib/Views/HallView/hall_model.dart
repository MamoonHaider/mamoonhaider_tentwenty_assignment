class HallModel {
  HallModel();

  HallModel.copy(HallModel state) {
    selectedSeats = List.from(state.selectedSeats);
    vipSeats = List.from(state.vipSeats);
    regularSeats = List.from(state.regularSeats);
    unavailableSeats = List.from(state.unavailableSeats);
  }

  List<String> selectedSeats = [];
  List<String> vipSeats = [];
  List<String> regularSeats = [];
  List<String> unavailableSeats = [];
}
