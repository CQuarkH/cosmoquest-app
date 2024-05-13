import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class CarouselSlider extends HookWidget {
  final int itemCount;
  final bool? autoPlay;
  final Function(BuildContext, int) builder;
  const CarouselSlider(
      {super.key,
      required this.itemCount,
      this.autoPlay = true,
      required this.builder});

  @override
  Widget build(BuildContext context) {
    final pageController = usePageController();
    final currentPage = useState<int>(0);

    useEffect(() {
      if (autoPlay!) {
        final timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
          if (currentPage.value < itemCount - 1) {
            currentPage.value++;
          } else {
            currentPage.value = 0;
          }
          pageController.animateToPage(
            currentPage.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOutCirc,
          );
        });

        return () => timer.cancel();
      } else {
        return () => {};
      }
    }, []);
    return PageView.builder(
        controller: pageController,
        itemCount: itemCount,
        itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: builder(context, index),
            ));
  }
}
