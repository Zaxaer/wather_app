import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/domain/factory/screen_factory.dart';
import 'package:weather_app/ui/screen/main_tap_screen/main_tab_screen_widget_cubit.dart';
import 'package:weather_app/ui/themes/app_colors.dart';
import 'package:weather_app/ui/themes/app_text_style.dart';

class MainTabScreenWidget extends StatelessWidget {
  static final _screenFactory = ScreenFactory();
  const MainTabScreenWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MainTabScreenWidgetCubit>();
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.gradientTop,
            AppColors.gradientBot,
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Weather',
            style: AppTextStyle.button,
          ),
        ),
        drawer: const _DrawerWidget(),
        body: IndexedStack(
          index: cubit.state.currentTabIndex,
          children: [
            _screenFactory.mainWeatherScreenWidgetModel(),
            _screenFactory.dataWeatherWidgetModel(),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.thermostat),
              label: 'Weather',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.storage),
              label: 'List data',
            ),
          ],
          currentIndex: cubit.state.currentTabIndex,
          onTap: (indexSelect) => cubit.setCurrentTabIndex(indexSelect),
        ),
      ),
    );
  }
}

class _DrawerWidget extends StatelessWidget {
  const _DrawerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<MainTabScreenWidgetCubit>();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.mainColor,
            ),
            child: Text('Weather menu'),
          ),
          ListTile(
            title: const Text('Weather tooday'),
            onTap: () {
              cubit.setCurrentTabIndex(0);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: const Text('Data weather'),
            onTap: () {
              cubit.setCurrentTabIndex(1);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
