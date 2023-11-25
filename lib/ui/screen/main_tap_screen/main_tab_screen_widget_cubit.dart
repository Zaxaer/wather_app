import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/ui/screen/main_tap_screen/main_tab_screen_state.dart';

class MainTabScreenWidgetCubit extends Cubit<MainTabScreenState> {
  MainTabScreenWidgetCubit(MainTabScreenState initialState)
      : super(initialState);

  void setCurrentTabIndex(int value) {
    if (value == state.currentTabIndex) return;
    final newState = state.copyWith(currentTabIndex: value);
    emit(newState);
  }
}
