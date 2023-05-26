import 'package:dartz/dartz.dart';
import 'package:weather_app_with_clean_architecture/domain/entities/weather_entity.dart';

import '../entities/app_error.dart';

abstract class WeatherRepository {
  Future<Either<AppError, WeatherEntity>> getCurrentWeather(
      Map<String, dynamic> params);
  Future<Either<AppError, WeatherEntity>> getForecastWeather(
      Map<String, dynamic> params);
}
