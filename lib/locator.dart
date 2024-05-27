import 'package:advanced_besenior/features/fearture_bookmark/data/dataSource/local/city_dao.dart';
import 'package:advanced_besenior/features/fearture_bookmark/data/dataSource/local/database.dart';
import 'package:advanced_besenior/features/fearture_bookmark/data/repository/city_repositoryImpl.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/repository/city_repository.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/use_cases/get_all_city_usecase.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/use_cases/get_city_usecase.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/use_cases/save_city_usecase.dart';
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
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  //repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryimpl(locator()));
  locator
      .registerSingleton<CityRepository>(CityRepositoryimpl(database.cityDao));

  //useCases
  locator.registerSingleton<GetCurrentWeatherUsecase>(
      GetCurrentWeatherUsecase(locator()));

  locator.registerSingleton<GetForcastWeatherUsecase>(
      GetForcastWeatherUsecase(locator()));
  locator.registerSingleton<GetCityUseCase>(GetCityUseCase(locator()));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));

  //bloc
  locator.registerSingleton<HomeBloc>(HomeBloc(locator(), locator()));
}
