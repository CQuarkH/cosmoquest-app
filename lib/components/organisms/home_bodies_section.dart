import 'package:cosmo_quest/components/organisms/photo_slider.dart';
import 'package:cosmo_quest/models/celestial_body.dart';
import 'package:cosmo_quest/models/photo.dart';
import 'package:cosmo_quest/services/learning_service.dart';
import 'package:flutter/material.dart';

class HomeBodiesSection extends StatelessWidget {
  const HomeBodiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final LearningService learningService = LearningService();
    return FutureBuilder(
        future: learningService.fetchCelestialBodies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SizedBox(
              height: 300,
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return SizedBox(
              height: 500,
              child: Center(
                child:
                    Text("Error fetching celestial bodies: ${snapshot.error}"),
              ),
            );
          } else if (snapshot.hasData) {
            final List<CelestialBody> celestialBodies = snapshot.data!;
            final List<Photo> mainPhotos = celestialBodies
                .map((celestialBody) => Photo(
                    url: celestialBody.gallery[0].url,
                    title: celestialBody.englishName,
                    description: '',
                    date: ''))
                .toList();

            return SizedBox(
              height: 400,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            "Celestial Bodies",
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: SizedBox(
                      height: 300,
                      child: PhotoSlider(photos: mainPhotos),
                    ),
                  )
                ],
              ),
            );
          }
          return const SizedBox();
        });
  }
}
