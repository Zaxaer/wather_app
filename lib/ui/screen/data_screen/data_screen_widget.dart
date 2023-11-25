import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/screen/data_screen/data_screen_widget_model.dart';
import 'package:weather_app/ui/themes/app_text_style.dart';

class DataWeatherWidget extends StatelessWidget {
  const DataWeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DataWeatherWidgetCubit>();
    if (cubit.state.dataList == null) {
      return const Center(
        child: Text(
          'Список пуст',
          style: AppTextStyle.button,
        ),
      );
    }
    return ListView.separated(
      itemCount: cubit.state.dataList?.length ?? 0,
      itemBuilder: (BuildContext context, int index) {
        return _CardDataWeather(
          index: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1);
      },
    );
  }
}

class _CardDataWeather extends StatelessWidget {
  final int index;
  const _CardDataWeather({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<DataWeatherWidgetCubit>();
    return Dismissible(
      onDismissed: (_) {
        cubit.deleteDataWeather(index, cubit.state.dataList);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Данные удалены'),
          ),
        );
      },
      key: Key(cubit.state.dataList![index].id),
      child: ListTile(
        title: Text(
          cubit.value(index, 'temp'),
          style: AppTextStyle.button.copyWith(fontSize: 16),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Text(
                cubit.value(index, 'humidity'),
                style: AppTextStyle.button.copyWith(fontSize: 16),
              ),
            ),
            Expanded(
              child: Text(
                cubit.value(index, 'speed'),
                style: AppTextStyle.button.copyWith(fontSize: 16),
              ),
            ),
          ],
        ),
        subtitle: Text(
          cubit.value(index, 'data'),
          style: AppTextStyle.button.copyWith(fontSize: 16),
        ),
        leading: Text(
          '${index + 1}',
          style: AppTextStyle.button.copyWith(fontSize: 18),
        ),
      ),
    );
  }
}
