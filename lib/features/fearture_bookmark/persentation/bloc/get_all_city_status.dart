import 'package:advanced_besenior/features/fearture_bookmark/domain/entities/city_entity.dart';

abstract class GetAllCityStatus {}

//loading state

class GetAllCityLoading extends GetAllCityStatus {}

//loaded state
class GetAllCityCompleted extends GetAllCityStatus {
  List<City> cities;
  GetAllCityCompleted(this.cities);
}

//error state
class GetAllCitiesError extends GetAllCityStatus {
  String message;
  GetAllCitiesError(this.message);
}
