import 'package:dartz/dartz.dart';
import 'package:weather_app_with_clean_architecture/domain/entities/app_error.dart';
import 'package:weather_app_with_clean_architecture/domain/entities/forecast_weather_params.dart';
import 'package:weather_app_with_clean_architecture/domain/entities/weather_entity.dart';
import 'package:weather_app_with_clean_architecture/domain/repositories/weather_repository.dart';
import 'package:weather_app_with_clean_architecture/domain/usecases/usecase.dart';

class GetForecastWeather extends UseCase<WeatherEntity, ForecastWeatherParams> {
  final WeatherRepository weatherRepository;

  GetForecastWeather(this.weatherRepository);

  @override
  Future<Either<AppError, WeatherEntity>> call(
      ForecastWeatherParams params) async {
    return await weatherRepository.getForecastWeather(params.toJson());
  }
}
