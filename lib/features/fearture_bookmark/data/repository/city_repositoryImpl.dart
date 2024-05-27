import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/features/fearture_bookmark/data/dataSource/local/city_dao.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/entities/city_entity.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/repository/city_repository.dart';

class CityRepositoryimpl extends CityRepository {
  CityDao cityDao;
  CityRepositoryimpl(this.cityDao);
//call delete city from Db and set Status
  @override
  Future<DataState<String>> deleteCityByName(String name) async {
    try {
      await cityDao.deleteCityByName(name);
      return DataSuccess(name);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

//call get city by name from  Db and set Status
  @override
  Future<DataState<City?>> findCityByName(String name) async {
    try {
      City? city = await cityDao.findCityByName(name);
      return DataSuccess(city);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

//call get all cities from Db and set Status
  @override
  Future<DataState<List<City>>> getAllCityFromDB() async {
    try {
      List<City> cities = await cityDao.getAllCity();
      return DataSuccess(cities);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }

//call save city to Db and set Status
  @override
  Future<DataState<City>> saveCityToDB(String cityName) async {
    try {
      //check city exist or not
      City? checkCity = await cityDao.findCityByName(cityName);
      if (checkCity != null) {
        return DataFailed('$cityName has Already exist');
      }

      //insert city to database
      City city = City(name: cityName);
      await cityDao.insertCity(city);
      return DataSuccess(city);
    } catch (e) {
      return DataFailed(e.toString());
    }
  }
}
