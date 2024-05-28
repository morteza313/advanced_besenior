import 'package:advanced_besenior/core/params/forcast_params.dart';
import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/current_city_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/entities/forcast_days_entities.dart';
import 'package:advanced_besenior/features/feature_weather/domain/use_cases/get_current_weather_useCase.dart';
import 'package:advanced_besenior/features/feature_weather/domain/use_cases/get_forcast_weather_useCase.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/cw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/fw_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_bloc.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_event.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'home_bloc_test.mocks.dart';
import 'package:bloc_test/bloc_test.dart';

@GenerateMocks([GetCurrentWeatherUsecase, GetForcastWeatherUsecase])
void main() {
  MockGetCurrentWeatherUsecase mockGetCurrentWeatherUsecase =
      MockGetCurrentWeatherUsecase();
  MockGetForcastWeatherUsecase mockGetForcastWeatherUsecase =
      MockGetForcastWeatherUsecase();

  String cityName = "Tehran";
  String error = "error";
  ForcastParams forcastParams = ForcastParams(35.689198, 51.388973);
  group(
    'cw event test',
    () {
      when(mockGetCurrentWeatherUsecase.call(any)).thenAnswer(
        (_) async => Future.value(DataSuccess(CurrentCityEntity())),
      );

      blocTest<HomeBloc, HomeState>(
        'emits Loading and completed state',
        build: () => HomeBloc(
            mockGetCurrentWeatherUsecase, mockGetForcastWeatherUsecase),
        act: (bloc) => bloc.add(LoadCwEvent(cityName: cityName)),
        expect: () => <HomeState>[
          HomeState(cwStatus: CwLoading(), fwStatus: FwLoading()),
          HomeState(
              cwStatus: CwCompleated(CurrentCityEntity()),
              fwStatus: FwLoading())
        ],
      );
      //seconde way
      test(
        "emit Loading and Error state",
        () {
          when(mockGetCurrentWeatherUsecase.call(any)).thenAnswer(
            (_) async => Future.value(DataFailed(error)),
          );

          final bloc = HomeBloc(
              mockGetCurrentWeatherUsecase, mockGetForcastWeatherUsecase);
          bloc.add(LoadCwEvent(cityName: cityName));

          expectLater(
              bloc.stream,
              emitsInOrder([
                HomeState(cwStatus: CwLoading(), fwStatus: FwLoading()),
                HomeState(cwStatus: CWError(error), fwStatus: FwLoading())
              ]));
        },
      );
    },
  );

  group(
    'Fw Event Test',
    () {
      when(mockGetForcastWeatherUsecase.call(any)).thenAnswer(
        (_) async => Future.value(DataSuccess(ForecastDaysEntity())),
      );
      test(
        "test for fw event ",
        () {
          //callin Home Bloc
          var bloc = HomeBloc(
              mockGetCurrentWeatherUsecase, mockGetForcastWeatherUsecase);
          bloc.add(LoadFwEvent(forcastParams: forcastParams));

          //expected
          expectLater(
              bloc.stream,
              emitsInOrder([
                HomeState(cwStatus: CwLoading(), fwStatus: FwLoading()),
                HomeState(
                    cwStatus: CwLoading(),
                    fwStatus: FwCompleated(ForecastDaysEntity())),
              ]));
        },
      );

      blocTest<HomeBloc, HomeState>(
        "FW test with BlocTest",
        build: () => HomeBloc(
            mockGetCurrentWeatherUsecase, mockGetForcastWeatherUsecase),
        act: (bloc) => bloc.add(LoadFwEvent(forcastParams: forcastParams)),
        expect: () => <HomeState>[
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwLoading(),
          ),
          HomeState(
            cwStatus: CwLoading(),
            fwStatus: FwCompleated(ForecastDaysEntity()),
          )
        ],
      );
    },
  );
}
