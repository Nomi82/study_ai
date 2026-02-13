import 'package:flutter_bloc/flutter_bloc.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void setTab(HomeTab tab) {
    emit(state.copyWith(currentTab: tab));
  }

  void setTabByIndex(int index) {
    if (index >= 0 && index < HomeTab.values.length) {
      emit(state.copyWith(currentTab: HomeTab.values[index]));
    }
  }
}
