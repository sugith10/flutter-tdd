import 'package:dartz/dartz.dart';
import 'package:tdd/core/error/failure.dart';
import 'package:tdd/domain/entities/weather.dart';
import 'package:tdd/domain/repositories/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Either<Failure, WeatherEntity>> execute(String city) async {
    return await weatherRepository.getCurrentWeather(city);
  }
}
