import 'package:cosmo_quest/models/question.dart';
import 'package:cosmo_quest/screens/nested_screens/question_details_screen.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final double? height;
  final double? width;
  const QuestionCard(
      {super.key,
      required this.question,
      this.height = 300,
      this.width = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14.0),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => QuestionDetailsScreen(question: question)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Hero(
                tag: 'question-${question.title}-image',
                child: Image.network(
                  question.photo.url,
                  fit: BoxFit.cover,
                  width: width!,
                  height: height!,
                ),
              ),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          question.title,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          question.answer,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: Colors.white70),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
