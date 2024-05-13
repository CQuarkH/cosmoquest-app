import 'package:cosmo_quest/components/molecules/celestial_body_card.dart';
import 'package:cosmo_quest/models/celestial_body.dart';
import 'package:cosmo_quest/services/learning_service.dart';
import 'package:flutter/material.dart';

class SolarSystemSection extends StatelessWidget {
  const SolarSystemSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LearningService learningService = LearningService();
    return FutureBuilder<List<CelestialBody>>(
        future: learningService.fetchCelestialBodies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
                child: Text('Error fetching solar system data!'));
          }
          final List<CelestialBody> celestialBodies = snapshot.data!;
          return Column(
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
                        "Solar System",
                        style: Theme.of(context).textTheme.displaySmall,
                        textAlign: TextAlign.start,
                      ),
                      const SizedBox(height: 8),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "Explore the solar system and learn about the planets around us.",
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
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: celestialBodies.length,
                      itemBuilder: (context, index) => CelestialBodyCard(
                          celestialBody: celestialBodies[index])))
            ],
          );
        });
  }
}
