
class HomeModel {
  HomeModel();

  int index = 0;

  HomeModel.copy(HomeModel state) {
    index = state.index;
  }
}
