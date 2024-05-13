import 'package:cosmo_quest/components/molecules/photo_w_details.dart';
import 'package:cosmo_quest/models/photo.dart';
import 'package:cosmo_quest/screens/nested_screens/apod_details_screen.dart';
import 'package:cosmo_quest/services/apod_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomeAPODSection extends HookWidget {
  const HomeAPODSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final APODService imageService = APODService();

    return FutureBuilder<List<Photo>>(
      future: imageService.fetchAPODPhotos(limit: 1),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 300,
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return SizedBox(
            height: 300,
            child: Center(
              child:
                  Text("Error fetching apod section images: ${snapshot.error}"),
            ),
          );
        } else if (snapshot.hasData) {
          final Photo photo = snapshot.data![0];
          return SizedBox(
            height: 600,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => APODDetailsScreen(photo: photo))),
                    child: PhotoWithDetails(
                      heroTag: photo.url,
                      photo: photo,
                      height: 550,
                      borderRadius: 0,
                      nasaCredits: false,
                      bottomWidget: PhotoWithDetailsBottomWidget(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  'ASTRONOMY PICTURE OF THE DAY',
                                  style:
                                      Theme.of(context).textTheme.displaySmall!,
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  children: [
                                    Text(
                                      photo.title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!,
                                    ),
                                    const SizedBox(width: 30),
                                    if (photo.copyright != null)
                                      Text('By ${photo.copyright}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall!)
                                  ],
                                )
                              ],
                            )
                          ]),
                    ),
                  ),
                )
              ],
            ),
          );
        } else {
          return const SizedBox(height: 300);
        }
      },
    );
  }
}
