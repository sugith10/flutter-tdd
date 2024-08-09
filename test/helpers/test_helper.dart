import 'package:mockito/annotations.dart';
import 'package:tdd/data/data_sources/remote_data_source_impl.dart';
import 'package:tdd/domain/repositories/weather_repository.dart';
import 'package:http/http.dart' as http;
import 'package:tdd/domain/usecases/get_current_weather_use_case.dart';

@GenerateMocks(
  [
    WeatherRepository,
    WeatherRemoteDataSource,
    GetCurrentWeatherUseCase,
  ],
  customMocks: [MockSpec<http.Client>(as: #MockHttpClient)],
)
void main() {}
