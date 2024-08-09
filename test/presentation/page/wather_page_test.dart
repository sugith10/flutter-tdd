import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tdd/domain/entities/weather.dart';
import 'package:tdd/presentation/bloc/weather_bloc.dart';
import 'package:tdd/presentation/page/wather_page.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(
    () {
      mockWeatherBloc = MockWeatherBloc();
      HttpOverrides.global = null;
    },
  );

  Widget makeTestWidget(Widget body) {
    return BlocProvider<WeatherBloc>(
      create: (context) => mockWeatherBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const testWeather = WeatherEntity(
    cityName: 'New York',
    main: 'Clouds',
    description: 'few clouds',
    iconCode: '02d',
    temperature: 302.28,
    pressure: 1009,
    humidity: 70,
  );

  testWidgets(
    'Given text field When something added in text filed, Then the state change to empty to load',
    (tester) async {
      //Arange
      when(() => mockWeatherBloc.state).thenReturn(WeatherEmpty());

      //Act
      await tester.pumpWidget(makeTestWidget(const WeatherPage()));

      //Asset
      var textField = find.byType(TextField);

      expect(textField, findsOneWidget);

      await tester.enterText(textField, 'New York');

      await tester.pump();

      expect(find.text('New York'), findsOneWidget);
    },
  );

  testWidgets(
    'Given text field When something added in text filed, Then the state change to empty to loading',
    (tester) async {
      //Arange
      when(() => mockWeatherBloc.state).thenReturn(WeatherLoading());

      //Act
      await tester.pumpWidget(makeTestWidget(const WeatherPage()));

      //Asset
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    },
  );

testWidgets(
  'should show widget contain weather data when state is weather loaded',
  (widgetTester) async {
    await widgetTester.runAsync(() async {
      // arrange
      when(() => mockWeatherBloc.state).thenReturn(const WeatherLoaded(testWeather));
      
      // act
      await widgetTester.pumpWidget(makeTestWidget(const WeatherPage()));
      await widgetTester.pumpAndSettle();
      
      // assert
      expect(find.byKey(const Key('weather_data')), findsOneWidget);
    });
  },
);

}
