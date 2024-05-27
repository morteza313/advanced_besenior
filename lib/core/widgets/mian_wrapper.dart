import 'package:advanced_besenior/core/widgets/app_bacground.dart';
import 'package:advanced_besenior/core/widgets/bottom_nav.dart';
import 'package:advanced_besenior/features/fearture_bookmark/persentation/bloc/bookmark_bloc.dart';
import 'package:advanced_besenior/features/fearture_bookmark/persentation/screens/bookmark_screen.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/screens/home_screen.dart';
import 'package:advanced_besenior/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      BlocProvider(
        create: (context) => locator<BookmarkBloc>(),
        child: const HomeScreen(),
      ),
      BlocProvider(
        create: (context) => locator<BookmarkBloc>(),
        child: BookmarkScreen(
          pageController: pageController,
        ),
      ),
    ];
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNav(
        pageController: pageController,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AppBackground.getBackGroundImage(), fit: BoxFit.cover)),
        child: PageView(
          controller: pageController,
          children: pageViewWidget,
        ),
      ),
    );
  }
}
