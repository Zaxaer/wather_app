import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/ui/screen/view_weather_screen/view_weather_screen_widget_cubit.dart';
import 'package:weather_app/ui/themes/app_colors.dart';
import 'package:weather_app/ui/themes/app_text_style.dart';

class ViewWeatherScreenWidget extends StatefulWidget {
  const ViewWeatherScreenWidget({Key? key}) : super(key: key);

  @override
  State<ViewWeatherScreenWidget> createState() =>
      _ViewWeatherScreenWidgetState();
}

class _ViewWeatherScreenWidgetState extends State<ViewWeatherScreenWidget> {
  @override
  void didChangeDependencies() {
    final snackMessage =
        context.watch<ViewWeatherScreenWidgetCubit>().state.snackMessage;
    if (snackMessage.isNotEmpty) {
      Future.microtask(
        () => ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(snackMessage),
          ),
        ),
      );
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ViewWeatherScreenWidgetCubit>();
    return Scaffold(
      floatingActionButton: const _AddWeatherInFB(),
      body: RefreshIndicator(
        onRefresh: () => cubit.weatherBloc.getPosition(),
        child: ListView(
          children: [
            const SizedBox(height: 10),
            cubit.state.errorMessage.isEmpty
                ? const _CardWeatherWidget()
                : _ErrorText(errorMessage: cubit.state.errorMessage),
            const SizedBox(height: 10),
            _TextWidget(text: cubit.state.data, size: 25),
            const SizedBox(height: 10),
            const RepaintBoundary(
              child: SizedBox(
                width: 200,
                height: 50,
                child: Center(
                  child: _TimerWidget(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorText extends StatelessWidget {
  const _ErrorText({
    Key? key,
    required this.errorMessage,
  }) : super(key: key);

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: _TextWidget(
          text: errorMessage,
          size: 20,
        ),
      ),
    );
  }
}

class _AddWeatherInFB extends StatelessWidget {
  const _AddWeatherInFB({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ViewWeatherScreenWidgetCubit>();
    return FloatingActionButton(
      backgroundColor: AppColors.mainColor,
      child: const Icon(Icons.add),
      onPressed: () => cubit.addDataWeather(),
    );
  }
}

class _CardWeatherWidget extends StatelessWidget {
  const _CardWeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<ViewWeatherScreenWidgetCubit>().state;
    if (cubit.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 30),
      color: AppColors.mainColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            _TextWidget(text: cubit.sityName, size: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _TextWidget(
                    text: cubit.temp,
                    size: 30,
                  ),
                ),
                Image.network(cubit.icon),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: _TextWidget(
                    text: cubit.windSpeed,
                    size: 20,
                  ),
                ),
                Expanded(
                  child: _TextWidget(
                    size: 30,
                    text: cubit.humidity,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _TextWidget extends StatelessWidget {
  final double size;
  final String text;
  const _TextWidget({
    Key? key,
    required this.size,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      softWrap: true,
      style: AppTextStyle.button.copyWith(fontSize: size),
    );
  }
}

class _TimerWidget extends StatefulWidget {
  const _TimerWidget({Key? key}) : super(key: key);

  @override
  __TimerWidgetState createState() => __TimerWidgetState();
}

class __TimerWidgetState extends State<_TimerWidget>
    with SingleTickerProviderStateMixin {
  late final Ticker _ticker;
  String timer = '';
  @override
  void initState() {
    super.initState();
    _ticker = createTicker((elapsed) {
      setState(() {
        timer = DateFormat.Hms().format(DateTime.now()).toString();
      });
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context)
          .copyWith(textScaler: const TextScaler.linear(1)),
      child: _TextWidget(text: timer, size: 25),
    );
  }
}
