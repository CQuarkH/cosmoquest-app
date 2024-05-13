import 'package:cosmo_quest/components/molecules/photo_w_details.dart';
import 'package:cosmo_quest/models/photo.dart';
import 'package:cosmo_quest/components/organisms/sliver_appbar_scaffold.dart';
import 'package:cosmo_quest/screens/nested_screens/apod_details_screen.dart';
import 'package:cosmo_quest/services/apod_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class APODScreen extends HookWidget {
  const APODScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final APODService imageService = APODService();

    return SliverAppbarScaffold(
      title: 'APOD',
      topSpace: 1,
      onExpandedBackgroundImage: const BackgroundImage(
          image: AssetImage('assets/images/apod_background.jpg')),
      onExpandedWidget: ExpandedWidget(
          widget: Column(
        children: [
          SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Astronomy Picture of the Day',
                    style: Theme.of(context).textTheme.displayLarge,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('By', style: Theme.of(context).textTheme.bodyMedium),
                      const SizedBox(width: 4),
                      Image.asset('assets/icons/nasa.png',
                          height: 36, width: 36)
                    ],
                  )
                ],
              )),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Photographs are selected from NASA's vast archive of images. Each day a different image or photograph of our universe is featured, along with a brief explanation written by a professional astronomer.",
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Colors.white.withOpacity(0.8)),
              textAlign: TextAlign.center,
            ),
          )
        ],
      )),
      child: FutureBuilder<List<Photo>>(
        future: imageService.fetchAPODPhotos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SliverFillRemaining(
              child: Center(child: CircularProgressIndicator()),
            );
          } else if (snapshot.hasError) {
            return SliverFillRemaining(
              child: Center(
                child: Text("Error fetching images: ${snapshot.error}"),
              ),
            );
          } else if (snapshot.hasData) {
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final Photo photo = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GestureDetector(
                        onTap: () =>
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => APODDetailsScreen(
                                      photo: photo,
                                    ))),
                        child: PhotoWithDetails(
                          nasaCredits: false,
                          heroTag: photo.url,
                          photo: photo,
                          height: 500,
                        ),
                      ),
                    ),
                  );
                },
                childCount: snapshot.data!.length,
              ),
            );
          } else {
            return SliverToBoxAdapter(
              child: Container(),
            );
          }
        },
      ),
    );
  }
}
