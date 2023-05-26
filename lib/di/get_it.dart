import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:weather_app_with_clean_architecture/domain/usecases/get_current_weather.dart';
import 'package:weather_app_with_clean_architecture/domain/usecases/get_forecast_weather.dart';
import 'package:weather_app_with_clean_architecture/presentation/blocs/weather_detail/weather_detail_bloc.dart';

import '../data/core/api_client.dart';
import '../data/data_sources/weather_remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';
import '../presentation/blocs/loading/loading_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  ///DataSources
  getItInstance.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(getItInstance()));

  ///Repositories
  getItInstance.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(getItInstance()));

  ///UseCases
  getItInstance.registerLazySingleton<GetCurrentWeather>(
      () => GetCurrentWeather(getItInstance()));
  getItInstance.registerLazySingleton<GetForecastWeather>(
      () => GetForecastWeather(getItInstance()));

  ///Blocs
  getItInstance.registerLazySingleton<LoadingCubit>(() => LoadingCubit());
  getItInstance.registerFactory(() => WeatherDetailBloc(
      getForecastWeather: getItInstance(), loadingCubit: getItInstance()));
}
