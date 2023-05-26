import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app_with_clean_architecture/common/extensions/size_extensions.dart';
import 'package:weather_app_with_clean_architecture/di/get_it.dart';
import 'package:weather_app_with_clean_architecture/presentation/blocs/weather_detail/weather_detail_bloc.dart';
import 'package:weather_app_with_clean_architecture/presentation/journeys/detail/weather_detail_argument.dart';
import 'package:weather_app_with_clean_architecture/presentation/journeys/detail/weather_detail_widget.dart';
import '../../../common/constants/size_constants.dart';
import '../../../data/core/api_constants.dart';
import '../../widgets/app_error_widget.dart';

class WeatherDetailScreen extends StatefulWidget {
  final WeatherDetailArguments weatherDetailArguments;

  const WeatherDetailScreen({Key? key, required this.weatherDetailArguments})
      : super(key: key);

  @override
  State<WeatherDetailScreen> createState() => _WeatherDetailScreenState();
}

class _WeatherDetailScreenState extends State<WeatherDetailScreen> {
  late WeatherDetailBloc weatherDetailBloc;

  @override
  void initState() {
    weatherDetailBloc = getItInstance<WeatherDetailBloc>();
    weatherDetailBloc.add(LoadWeatherDetailEvent(
        widget.weatherDetailArguments.cityName.toLowerCase().trim()));
    super.initState();
  }

  @override
  void dispose() {
    weatherDetailBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<WeatherDetailBloc>(
      create: (context) => weatherDetailBloc,
      child: BlocBuilder<WeatherDetailBloc, WeatherDetailState>(
        builder: (context, state) {
          if (state is WeatherDetailLoadedState) {
            return WeatherDetailWidget(weather: state.weather);
          } else if (state is WeatherDetailErrorState) {
            return AppErrorWidget(
              errorType: state.errorType,
              onPressed: () {
                Navigator.pop(context);
              },
            );
          }
          return SizedBox.shrink();
        },
      ),
    );
  }
}
