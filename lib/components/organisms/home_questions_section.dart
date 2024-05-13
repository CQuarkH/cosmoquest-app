import 'package:cosmo_quest/components/molecules/question_card.dart';
import 'package:cosmo_quest/components/organisms/carousel_slider.dart';
import 'package:cosmo_quest/models/question.dart';
import 'package:cosmo_quest/services/learning_service.dart';
import 'package:flutter/material.dart';

class HomeQuestionsSection extends StatelessWidget {
  const HomeQuestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LearningService learningService = LearningService();

    return FutureBuilder<List<Question>>(
        future: learningService.fetchAnswersToBigQuestions(limit: 4),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return SizedBox(
              height: 350,
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Answers to Big Questions",
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Expanded(
                    child: CarouselSlider(
                        autoPlay: false,
                        itemCount: snapshot.data!.length,
                        builder: (context, index) =>
                            QuestionCard(question: snapshot.data![index])),
                  )
                ],
              ),
            );
          }
        });
  }
}
