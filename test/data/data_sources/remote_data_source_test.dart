import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tdd/core/constants/constants.dart';
import 'package:tdd/core/error/exception.dart';
import 'package:tdd/data/data_sources/remote_data_source_impl.dart';
import 'package:http/http.dart' as http;
import 'package:tdd/data/models/weather_model.dart';

import '../../helpers/dummy_data/json_reader.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockHttpClient mockHttpClient;
  late WeatherRemoteDataSourceImpl weatherRemoteDataSourceImpl;

  setUp(() {
    mockHttpClient = MockHttpClient();
    weatherRemoteDataSourceImpl =
        WeatherRemoteDataSourceImpl(client: mockHttpClient);
  });
  const testCityName = 'New York';

  group(
    'Get Curent weather',
    () {
      test(
        "Should return weather model when the response code is 200",
        () async {
          //Arange
          when(
            mockHttpClient.get(
              Uri.parse(Urls.currentWeatherByName(testCityName)),
            ),
          ).thenAnswer((_) async {
            return http.Response(
              readJson('helpers/dummy_data/dummy_weather_response.json'),
              200,
            );
          });
          //Act

          final result =
              await weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
          //Assert

          expect(result, isA<WeatherModel>());
        },
      );

//TODo: how we can see status code pass it in the test message
      test(
        'should throw a server exception when the response code is 404 or other',
        () async {
          //Arange
          when(
            mockHttpClient.get(
              Uri.parse(Urls.currentWeatherByName(testCityName)),
            ),
          ).thenAnswer((_) async {
            return http.Response(
              "Not found",
              404,
            );
          });
          //Act

          final result =
              weatherRemoteDataSourceImpl.getCurrentWeather(testCityName);
          //Assert

          expect(result, throwsA(isA<ServerException>()));
        },
      );
    },
  );
}
