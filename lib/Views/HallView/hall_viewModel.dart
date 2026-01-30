import 'package:flutter_riverpod/legacy.dart';

import 'hall_model.dart';

import 'package:flutter_riverpod/legacy.dart';
import 'hall_model.dart';

class HallViewModel extends StateNotifier<HallModel> {
  HallViewModel() : super(HallModel());

  void toggleSeat(String seatId) {
    if (!state.unavailableSeats.contains(seatId)) {
      final newState = HallModel.copy(state);
      if (newState.selectedSeats.contains(seatId)) {
        newState.selectedSeats.remove(seatId);
      } else {
        newState.selectedSeats.add(seatId);
      }
      state = newState;
    }
  }
}
