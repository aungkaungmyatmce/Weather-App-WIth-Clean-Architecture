import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:weather_app_with_clean_architecture/data/core/error/exception.dart';
import 'package:weather_app_with_clean_architecture/data/data_sources/weather_remote_data_source.dart';
import 'package:weather_app_with_clean_architecture/data/models/WeatherModel.dart';

import 'package:weather_app_with_clean_architecture/domain/entities/app_error.dart';

import 'package:weather_app_with_clean_architecture/domain/entities/weather_entity.dart';

import '../../domain/repositories/weather_repository.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError, WeatherModel>> getCurrentWeather(
      Map<String, dynamic> params) async {
    try {
      final weather = await remoteDataSource.getCurrentWeather(params);
      return Right(weather);
    } on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, WeatherEntity>> getForecastWeather(
      Map<String, dynamic> params) async {
    try {
      final weather = await remoteDataSource.getForecastWeather(params);
      return Right(weather);
    }on ContentNotFoundException{
      return Left(AppError(AppErrorType.contentNotFound));
    }
    on SocketException {
      return Left(AppError(AppErrorType.network));
    } on Exception {
      return Left(AppError(AppErrorType.api));
    }
  }
}
