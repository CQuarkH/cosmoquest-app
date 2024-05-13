import 'dart:ui';

import 'package:cosmo_quest/screens/nested_screens/about_screen.dart';
import 'package:cosmo_quest/screens/nested_screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ExpandedWidget {
  final Widget? widget;
  final MainAxisAlignment? alignment;
  final ImageProvider? backgroundImage;
  const ExpandedWidget(
      {this.widget,
      this.alignment = MainAxisAlignment.start,
      this.backgroundImage});
}

class BackgroundImage {
  final ImageProvider image;
  final double? opacity;
  final String? heroTag;
  const BackgroundImage({required this.image, this.opacity = 1, this.heroTag});
}

class SliverAppbarScaffold extends HookWidget {
  final String title;
  final ExpandedWidget? onExpandedWidget;
  final BackgroundImage? onExpandedBackgroundImage;
  final bool? icons;
  final double? expandedHeight;
  final double? bottomSpace;
  final double? topSpace;
  final ScrollPhysics? physics;
  final Widget child;
  const SliverAppbarScaffold(
      {super.key,
      required this.title,
      this.onExpandedWidget,
      this.onExpandedBackgroundImage,
      this.icons = true,
      this.expandedHeight = 250.0,
      this.bottomSpace = 100.0,
      this.topSpace = 20,
      this.physics = const BouncingScrollPhysics(),
      required this.child});

  @override
  Widget build(BuildContext context) {
    final isAppBarExpanded = useState(true);
    final scrollController = useScrollController();

    useEffect(() {
      void scrollListener() {
        if (scrollController.hasClients) {
          final isExpanded =
              scrollController.offset < (expandedHeight! - kToolbarHeight);
          if (isAppBarExpanded.value != isExpanded) {
            isAppBarExpanded.value = isExpanded;
          }
        }
      }

      scrollController.addListener(scrollListener);

      return () => scrollController.removeListener(scrollListener);
    }, [scrollController]);

    return Scaffold(
      body: CustomScrollView(
        controller: scrollController,
        physics: physics!,
        slivers: [
          // expandable appbar
          SliverAppBar(
            backgroundColor:
                Theme.of(context).appBarTheme.backgroundColor!.withOpacity(0.5),
            expandedHeight: expandedHeight,
            pinned: true,
            centerTitle: true,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: icons!
                  ? [
                      IconButton(
                        icon: Image.asset(
                          'assets/icons/search.png',
                          height: 24,
                          width: 24,
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen())),
                      ),
                      const SizedBox(),
                      IconButton(
                        icon: const Icon(FontAwesomeIcons.circleInfo),
                        onPressed: () => Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const AboutScreen())),
                      ),
                    ]
                  : [],
            ),
            flexibleSpace: isAppBarExpanded.value
                ? FlexibleSpaceBar(
                    background: Hero(
                      tag: onExpandedBackgroundImage?.heroTag ?? '',
                      child: Container(
                        height: expandedHeight,
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .primary
                              .withOpacity(1),
                          image: onExpandedBackgroundImage == null
                              ? null
                              : DecorationImage(
                                  image: onExpandedBackgroundImage!.image,
                                  fit: BoxFit.cover,
                                  opacity: onExpandedBackgroundImage!.opacity!),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: onExpandedWidget?.alignment ??
                              MainAxisAlignment.start,
                          children: [
                            const SizedBox(height: kToolbarHeight * 2),
                            onExpandedWidget?.widget ?? Container(),
                          ],
                        ),
                      ),
                    ),
                  )
                : ClipRect(
                    child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 10),
                        child: Column(
                          children: [
                            const SizedBox(height: kToolbarHeight),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  constraints: BoxConstraints(
                                      maxWidth:
                                          MediaQuery.of(context).size.width /
                                              2),
                                  child: Text(
                                    title,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayMedium,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                          ],
                        )),
                  ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(height: topSpace!),
          ),

          // screen content
          child,

          SliverToBoxAdapter(
            child: SizedBox(height: bottomSpace!),
          ),
        ],
      ),
    );
  }
}
