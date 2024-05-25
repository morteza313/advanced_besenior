import 'package:advanced_besenior/core/widgets/app_bacground.dart';
import 'package:advanced_besenior/core/widgets/bottom_nav.dart';
import 'package:advanced_besenior/features/feature_bookmark/persentation/screens/bookmark_screen.dart';
import 'package:advanced_besenior/features/feature_weather/persentation/screens/home_screen.dart';
import 'package:flutter/material.dart';

class MainWrapper extends StatelessWidget {
  MainWrapper({super.key});
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    List<Widget> pageViewWidget = [
      const HomeScreen(),
      const BookmarkScreen(),
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
// class MainWrapper extends StatefulWidget {
//   const MainWrapper({super.key});

//   @override
//   State<MainWrapper> createState() => _MainWrapperState();
// }

// class _MainWrapperState extends State<MainWrapper> {
//   @override
//   void initState() {
//     super.initState();

//     BlocProvider.of<HomeBloc>(context).add(LoadCwEvent(cityName: 'tehran'));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Scaffold(
//         appBar: AppBar(
//           title: const Text('MainWrapper'),
//           centerTitle: true,
//         ),
//         body: BlocBuilder<HomeBloc, HomeState>(
//           builder: (context, state) {
//             if (state.cwStatus is CwLoading) {
//               return const Center(
//                 child: Text('Loading ...'),
//               );
//             }
//             if (state.cwStatus is CwCompleated) {
//               final CwCompleated cwCompleated = state.cwStatus as CwCompleated;
//               final CurrentCityEntity currentCityEntity =
//                   cwCompleated.currentCityEntity;
//               return Center(
//                 child: Text(currentCityEntity.name.toString()),
//               );
//             }
//             if (state.cwStatus is CWError) {
//               return const Center(
//                 child: Text('Error'),
//               );
//             }

//             return Container();
//           },
//         ),
//       ),
//     );
//   }
// }
