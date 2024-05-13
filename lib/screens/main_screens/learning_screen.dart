import 'package:cosmo_quest/components/organisms/questions_section.dart';
import 'package:cosmo_quest/components/organisms/sliver_appbar_scaffold.dart';
import 'package:cosmo_quest/components/organisms/solar_system_section.dart';
import 'package:flutter/material.dart';

class LearningScreen extends StatelessWidget {
  const LearningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverAppbarScaffold(
        title: 'Learning',
        onExpandedBackgroundImage: BackgroundImage(
            image: AssetImage('assets/images/learning_background.jpg')),
        onExpandedWidget: ExpandedWidget(
            widget: Column(
          children: [
            SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Learning',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Learn about the universe and the cosmos',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                        )),
                  ],
                )),
          ],
        )),
        child: SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 350, child: SolarSystemSection()),
                  SizedBox(height: 50),
                  AnswersToBigQuestionsSection()
                ],
              ),
            ),
          ),
        ));
  }
}
