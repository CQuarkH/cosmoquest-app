import 'dart:ui';

import 'package:cosmo_quest/screens/main_screens/apod_screen.dart';
import 'package:cosmo_quest/screens/main_screens/home_screen.dart';
import 'package:cosmo_quest/screens/main_screens/learning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class BottomBarScreen {
  final Widget screen;
  final String iconPath;
  const BottomBarScreen({required this.screen, required this.iconPath});
}

List<BottomBarScreen> screens = [
  const BottomBarScreen(
      screen: HomeScreen(), iconPath: 'assets/icons/home.png'),
  const BottomBarScreen(
      screen: APODScreen(), iconPath: 'assets/icons/camera.png'),
  const BottomBarScreen(
      screen: LearningScreen(), iconPath: 'assets/icons/learning.png'),
];

class ScreenHandler extends HookWidget {
  const ScreenHandler({super.key});

  @override
  Widget build(BuildContext context) {
    final currentIndex = useState<int>(0);

    List<Widget> barItems = List.generate(screens.length, (index) {
      return IconButton(
        icon: Image.asset(
          screens[index].iconPath,
          height: 26,
          width: 26,
          color: currentIndex.value == index
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onPrimary.withOpacity(0.5),
        ),
        onPressed: () => currentIndex.value = index,
      );
    });

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(fit: StackFit.expand, children: [
        screens[currentIndex.value].screen,
        // bottombar
        Positioned(
            bottom: 1,
            left: 10,
            right: 10,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Theme.of(context)
                          .colorScheme
                          .secondary
                          .withOpacity(0.3),
                    ),
                    height: 70,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: barItems,
                      ),
                    ),
                  )),
            ))
      ]),
    );
  }
}
