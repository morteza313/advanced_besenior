import 'package:advanced_besenior/core/resources/data_state.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/use_cases/get_city_usecase.dart';
import 'package:advanced_besenior/features/fearture_bookmark/domain/use_cases/save_city_usecase.dart';
import 'package:advanced_besenior/features/fearture_bookmark/persentation/bloc/get_city_status.dart';
import 'package:advanced_besenior/features/fearture_bookmark/persentation/bloc/save_city_status.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'bookmark_event.dart';
part 'bookmark_state.dart';

class BookmarkBloc extends Bloc<BookmarkEvent, BookmarkState> {
  GetCityUseCase getCityUseCase;
  SaveCityUseCase saveCityUseCase;
  BookmarkBloc(
    this.getCityUseCase,
    this.saveCityUseCase,
  ) : super(
          BookmarkState(
            getCityStatus: GetCityLoading(),
            saveCityStatus: SaveCityInitial(),
          ),
        ) {
    //get city by name event
    on<GetCityByNameEvent>((event, emit) async {
      //emit loading state
      emit(state.copyWith(newCityStatus: GetCityLoading()));

      DataState dataState = await getCityUseCase(event.cityName);

      //emit compleated state
      if (dataState is DataSuccess) {
        emit(state.copyWith(newCityStatus: GetCityCompleted(dataState.data)));
      }

      //emit error state
      if (dataState is DataFailed) {
        emit(state.copyWith(newCityStatus: GetCityError(dataState.error)));
      }
    });

    //save city event
    on<SaveCwEvent>((event, emit) async {
      //emit loading state
      emit(state.copyWith(newSaveCityStatus: SaveCityLoading()));

      DataState dataState = await saveCityUseCase(event.name);

      //emit cpmpleted state
      if (dataState is DataSuccess) {
        emit(state.copyWith(
            newSaveCityStatus: SaveCityCompleted(dataState.data)));
      }

      //emit error state
      if (dataState is DataFailed) {
        emit(state.copyWith(newSaveCityStatus: SaveCityError(dataState.error)));
      }
    });
    //set save city state to initiall again
    on<SaveCityInitialEvent>((event, emit) async {
      emit(state.copyWith(newSaveCityStatus: SaveCityInitial()));
    });
  }
}
