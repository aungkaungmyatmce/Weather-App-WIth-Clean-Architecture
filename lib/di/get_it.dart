import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import '../data/core/network/api_client.dart';
import '../data/data_sources/weather_local_data_source.dart';
import '../data/data_sources/weather_remote_data_source.dart';
import '../data/repositories/weather_repository_impl.dart';
import '../domain/repositories/weather_repository.dart';
import '../domain/usecases/check_if_city_favorite.dart';
import '../domain/usecases/delete_favorite_city.dart';
import '../domain/usecases/get_current_weather.dart';
import '../domain/usecases/get_favourite_cities.dart';
import '../domain/usecases/get_forecast_weather.dart';
import '../domain/usecases/save_city.dart';
import '../presentation/blocs/favourite/favourite_cubit.dart';
import '../presentation/blocs/loading/loading_cubit.dart';
import '../presentation/blocs/weather_detail/weather_detail_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));

  ///DataSources
  getItInstance.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<WeatherLocalDataSource>(
      () => WeatherLocalDataSourceImpl());

  ///Repositories
  getItInstance.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(getItInstance(), getItInstance()));

  ///UseCases
  getItInstance.registerLazySingleton<GetCurrentWeather>(
      () => GetCurrentWeather(getItInstance()));
  getItInstance.registerLazySingleton<GetForecastWeather>(
      () => GetForecastWeather(getItInstance()));
  getItInstance
      .registerLazySingleton<SaveCity>(() => SaveCity(getItInstance()));

  getItInstance.registerLazySingleton<GetFavoriteCities>(
      () => GetFavoriteCities(getItInstance()));

  getItInstance.registerLazySingleton<DeleteFavoriteCity>(
      () => DeleteFavoriteCity(getItInstance()));

  getItInstance.registerLazySingleton<CheckIfCityFavorite>(
      () => CheckIfCityFavorite(getItInstance()));

  ///Blocs
  getItInstance.registerLazySingleton<LoadingCubit>(() => LoadingCubit());
  getItInstance.registerFactory(() => WeatherDetailBloc(
      getForecastWeather: getItInstance(),
      loadingCubit: getItInstance(),
      favoriteCubit: getItInstance()));
  getItInstance.registerFactory(() => FavoriteCubit(
        saveCity: getItInstance(),
        getFavoriteCities: getItInstance(),
        deleteFavoriteCity: getItInstance(),
        checkIfCityFavorite: getItInstance(),
      ));
}
