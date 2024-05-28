import 'dart:ui';

import 'package:advanced_besenior/features/fearture_bookmark/domain/entities/city_entity.dart';
import 'package:advanced_besenior/features/fearture_bookmark/persentation/bloc/bookmark_bloc.dart';
import 'package:advanced_besenior/features/fearture_bookmark/persentation/bloc/get_all_city_status.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_bloc.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/bloc/home_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen({
    super.key,
    required this.pageController,
  });
  final PageController pageController;

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BookmarkBloc>(context).add(GetAllCityEvent());
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return BlocBuilder<BookmarkBloc, BookmarkState>(
      buildWhen: (previous, current) {
        //rebuild UI just when allCities state changed
        if (current.getAllCityStatus == previous.getAllCityStatus) {
          return false;
        }
        return true;
      },
      builder: (context, state) {
        //show Loading for AllCityStatus
        if (state.getAllCityStatus is GetAllCityLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        //show error for AllCityStatus
        if (state.getAllCityStatus is GetAllCitiesError) {
          //casting for getting error
          GetAllCitiesError getAllCitiesError =
              state.getAllCityStatus as GetAllCitiesError;
          return Center(
            child: Text(getAllCitiesError.message),
          );
        }

        //show Completed for AllCitiesStatus
        if (state.getAllCityStatus is GetAllCityCompleted) {
          //casting to get data
          GetAllCityCompleted getAllCityCompleted =
              state.getAllCityStatus as GetAllCityCompleted;
          List<City> cities = getAllCityCompleted.cities;

          //ui
          return SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "WatchList",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: (cities.isEmpty)
                      ? const Center(
                          child: Text(
                            'there is no bookmark city',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: cities.length,
                          itemBuilder: (context, index) {
                            City city = cities[index];
                            return GestureDetector(
                              onTap: () {
                                /// call for getting bookmarked city Data
                                BlocProvider.of<HomeBloc>(context)
                                    .add(LoadCwEvent(cityName: city.name));

                                /// animate to HomeScreen for showing Data
                                widget.pageController.animateToPage(0,
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ClipRect(
                                  child: BackdropFilter(
                                    filter: ImageFilter.blur(
                                        sigmaX: 5.0, sigmaY: 5.0),
                                    child: Container(
                                      width: width,
                                      height: 60.0,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                        color: Colors.grey.withOpacity(0.1),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 20.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              city.name,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20),
                                            ),
                                            IconButton(
                                              onPressed: () {
                                                BlocProvider.of<BookmarkBloc>(
                                                        context)
                                                    .add(DeleteCityEvent(
                                                        city.name));
                                                BlocProvider.of<BookmarkBloc>(
                                                        context)
                                                    .add(GetAllCityEvent());
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.redAccent,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          );
        }

        //default value
        return Container();
      },
    );
  }
}
