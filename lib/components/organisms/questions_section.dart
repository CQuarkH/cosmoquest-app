import 'package:cosmo_quest/components/molecules/question_card.dart';
import 'package:cosmo_quest/models/question.dart';
import 'package:cosmo_quest/services/learning_service.dart';
import 'package:flutter/material.dart';

class AnswersToBigQuestionsSection extends StatelessWidget {
  const AnswersToBigQuestionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LearningService learningService = LearningService();

    return FutureBuilder<List<Question>>(
        future: learningService.fetchAnswersToBigQuestions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
                child: Text('Error fetching answers to big questions!'));
          }
          final List<Question> questions = snapshot.data!;
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Answers to Big Questions",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Find answers to some of the biggest questions about the universe.",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(color: Colors.grey[400]),
                            textAlign: TextAlign.start,
                          ))
                    ],
                  ),
                ),
              ),
              ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) =>
                      QuestionCard(question: questions[index]))
            ],
          );
        });
  }
}
