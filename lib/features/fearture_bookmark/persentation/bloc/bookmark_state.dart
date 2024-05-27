part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;
  final DeleteCityStatus deleteCityStatus;
  final GetAllCityStatus getAllCityStatus;

  const BookmarkState({
    required this.getCityStatus,
    required this.saveCityStatus,
    required this.deleteCityStatus,
    required this.getAllCityStatus,
  });

  BookmarkState copyWith({
    GetCityStatus? newCityStatus,
    SaveCityStatus? newSaveCityStatus,
    DeleteCityStatus? newDeleteCityStatus,
    GetAllCityStatus? newGetAllCitiesStatus,
  }) {
    return BookmarkState(
      getCityStatus: newCityStatus ?? getCityStatus,
      saveCityStatus: newSaveCityStatus ?? saveCityStatus,
      deleteCityStatus: newDeleteCityStatus ?? deleteCityStatus,
      getAllCityStatus: newGetAllCitiesStatus ?? getAllCityStatus,
    );
  }

  @override
  List<Object?> get props => [
        getCityStatus,
        saveCityStatus,
        deleteCityStatus,
        getAllCityStatus,
      ];
}
