import 'package:advanced_besenior/core/widgets/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'click icon button in bottom nav should navigate to page 0 in pageview ',
    (widgetTester) async {
      PageController pageController = PageController();
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNav(pageController: pageController),
            body: PageView(
              controller: pageController,
              children: [
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      );

      await widgetTester.tap(find.widgetWithIcon(IconButton, Icons.home));

      await widgetTester.pumpAndSettle();

      expect(pageController.page, 0);
    },
  );

  testWidgets(
    'click icon button in bottom nav should navigate to page 1 in pageview',
    (widgetTester) async {
      PageController pageController = PageController();
      await widgetTester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            bottomNavigationBar: BottomNav(pageController: pageController),
            body: PageView(
              controller: pageController,
              children: [
                Container(),
                Container(),
              ],
            ),
          ),
        ),
      );

      //tap to icon button
      await widgetTester.tap(find.widgetWithIcon(IconButton, Icons.bookmark));

      //rebuild the widget after the state has changed
      await widgetTester.pumpAndSettle();

      //expect to move to bookmark screen
      expect(pageController.page, 1);
    },
  );
}
