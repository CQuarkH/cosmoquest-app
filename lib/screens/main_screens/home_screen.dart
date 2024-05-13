import 'package:cosmo_quest/components/organisms/home_apod_section.dart';
import 'package:cosmo_quest/components/organisms/home_bodies_section.dart';
import 'package:cosmo_quest/components/organisms/home_questions_section.dart';
import 'package:cosmo_quest/components/organisms/sliver_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppbarScaffold(
        onExpandedBackgroundImage: const BackgroundImage(
            image: AssetImage('assets/images/home_background.jpg'),
            opacity: 0.6),
        title: 'COSMOQUEST',
        onExpandedWidget: ExpandedWidget(
            widget: Column(
          children: [
            Text("COSMOQUEST", style: Theme.of(context).textTheme.displayLarge),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  "Explore the Universe, Quest for Knowledge",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )),
        child: SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8),
                    child: SizedBox(
                      width: double.infinity,
                      child: Text(
                        "Explore",
                        style: Theme.of(context).textTheme.displayMedium,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),

                  // apod picture
                  const HomeAPODSection(),

                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 20),

                        // celestial bodies section
                        HomeBodiesSection(),
                        SizedBox(height: 20),

                        // questions section
                        HomeQuestionsSection()
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
