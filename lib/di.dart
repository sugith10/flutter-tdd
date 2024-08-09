import 'package:get_it/get_it.dart';
import 'package:tdd/data/data_sources/remote_data_source_impl.dart';
import 'package:tdd/data/repositories/weather_repo_impl.dart';
import 'package:tdd/domain/repositories/weather_repository.dart';
import 'package:tdd/domain/usecases/get_current_weather_use_case.dart';
import 'package:tdd/presentation/bloc/weather_bloc.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => http.Client());

  locator.registerLazySingleton<WeatherRemoteDataSource>(
      () => WeatherRemoteDataSourceImpl(client: locator()));

  locator.registerLazySingleton<WeatherRepository>(
      () => WeatherRepositoryImpl(weatherRemoteDataSource: locator()));

  locator.registerLazySingleton(() => GetCurrentWeatherUseCase(locator()));

  locator.registerFactory(() => WeatherBloc(locator()));
}
