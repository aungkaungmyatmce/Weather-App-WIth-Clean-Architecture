import 'package:dartz/dartz.dart';
import 'package:weather_app_with_clean_architecture/domain/entities/app_error.dart';
import 'package:weather_app_with_clean_architecture/domain/entities/weather_entity.dart';
import 'package:weather_app_with_clean_architecture/domain/repositories/weather_repository.dart';
import 'package:weather_app_with_clean_architecture/domain/usecases/usecase.dart';

import '../entities/current_weather_params.dart';

class GetCurrentWeather extends UseCase<WeatherEntity, CurrentWeatherParams> {
  final WeatherRepository weatherRepository;

  GetCurrentWeather(this.weatherRepository);
  @override
  Future<Either<AppError, WeatherEntity>> call(
      CurrentWeatherParams params) async {
    return await weatherRepository.getCurrentWeather(params.toJson());
  }
}
