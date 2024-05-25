import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key, required this.pageController});
  PageController pageController;
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      color: Colors.grey[300],
      child: SizedBox(
        height: 63,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                pageController.animateToPage(0,
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: Icon(Icons.home),
            ),
            IconButton(
              onPressed: () {
                pageController.animateToPage(1,
                    duration: Duration(microseconds: 300),
                    curve: Curves.easeInOut);
              },
              icon: Icon(Icons.bookmark),
            ),
          ],
        ),
      ),
    );
  }
}
