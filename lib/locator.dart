import 'package:advanced_besenior/features/feature_weather/data/dataSource/remote/api_provider.dart';
import 'package:advanced_besenior/features/feature_weather/data/repository/weather_repositoryimpl.dart';
import 'package:advanced_besenior/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:advanced_besenior/features/feature_weather/domain/use_cases/get_current_weather_useCase.dart';
import 'package:advanced_besenior/features/feature_weather/domain/use_cases/get_forcast_weather_useCase.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

setup() async {
  //components
  locator.registerSingleton<APiProvider>(APiProvider());

  //repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryimpl(locator()));

  //useCases
  locator.registerSingleton<GetCurrentWeatherUsecase>(
      GetCurrentWeatherUsecase(locator()));

  locator.registerSingleton<GetForcastWeatherUsecase>(
      GetForcastWeatherUsecase(locator()));

  //bloc
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
}
