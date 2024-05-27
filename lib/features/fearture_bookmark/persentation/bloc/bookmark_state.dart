part of 'bookmark_bloc.dart';

class BookmarkState extends Equatable {
  final GetCityStatus getCityStatus;
  final SaveCityStatus saveCityStatus;

  const BookmarkState({
    required this.getCityStatus,
    required this.saveCityStatus,
  });

  BookmarkState copyWith({
    GetCityStatus? newCityStatus,
    SaveCityStatus? newSaveCityStatus,
  }) {
    return BookmarkState(
      getCityStatus: newCityStatus ?? getCityStatus,
      saveCityStatus: newSaveCityStatus ?? saveCityStatus,
    );
  }

  @override
  List<Object?> get props => [getCityStatus, saveCityStatus];
}
