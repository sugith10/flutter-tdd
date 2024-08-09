import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/domain/entities/weather.dart';
import 'package:tdd/domain/usecases/get_current_weather_use_case.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentWeatherUseCase getCurrentWeatherUseCase;
  late MockWeatherRepository mockWeatherRepository;

  setUp(() {
    mockWeatherRepository = MockWeatherRepository();
    getCurrentWeatherUseCase = GetCurrentWeatherUseCase(mockWeatherRepository);
  });

  const testWeatherDetail = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  const testCityName = 'New York';

  group("Get current weather from the repo", () {
    test('Get current weather from the repo', () async {
      // arrange
      when(mockWeatherRepository.getCurrentWeather(testCityName))
          .thenAnswer((_) async => const Right(testWeatherDetail));

      // act
      final result = await getCurrentWeatherUseCase.execute(testCityName);

      // assert
      expect(result, const Right(testWeatherDetail));
    });
  });
}
