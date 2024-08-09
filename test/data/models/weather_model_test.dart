import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tdd/data/models/weather_model.dart';
import 'package:tdd/domain/entities/weather.dart';

import '../../helpers/dummy_data/json_reader.dart';

void main() {
  const testWeatherModel = WeatherModel(
    cityName: 'New York',
    main: 'Clear',
    description: 'clear sky',
    iconCode: '01n',
    temperature: 292.87,
    pressure: 1012,
    humidity: 70,
  );
  test(
    "should be a subclass of WeatherEntity",
    () async {
      //Assert
      expect(testWeatherModel, isA<WeatherEntity>());
    },
  );

  test('Should return a valid WeatherModel from', () {
    //Arange
    final Map<String, dynamic> jsonMap =
        jsonDecode(readJson('helpers/dummy_data/dummy_weather_response.json'));

    //Act
    final result = WeatherModel.fromJson(jsonMap);

    //Asert
    expect(result, equals(testWeatherModel));
  });

  test(
      'Given a json map, when calling fromJson , then return a valid json map containing proper data',
      () {
   
    //Arange
      final expectedJsonMap = {
        'weather': [{
          'main': 'Clear',
          'description': 'clear sky',
          'icon': '01n',
        }],
        'main': {
          'temp': 292.87,
          'pressure': 1012,
          'humidity': 70,
        },
        'name': 'New York',
      };

    //Act
    final result = testWeatherModel.toJson();

    //Asert
    expect(result, equals(expectedJsonMap));
  });
}
