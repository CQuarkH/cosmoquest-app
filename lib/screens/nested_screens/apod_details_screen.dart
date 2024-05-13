import 'package:cosmo_quest/components/atoms/app_logo_tile.dart';
import 'package:cosmo_quest/components/atoms/icon_label_tile.dart';
import 'package:cosmo_quest/components/organisms/sliver_appbar_scaffold.dart';
import 'package:cosmo_quest/models/photo.dart';
import 'package:cosmo_quest/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:palette_generator/palette_generator.dart';

class APODDetailsScreen extends HookWidget {
  final Photo photo;
  const APODDetailsScreen({super.key, required this.photo});

  @override
  Widget build(BuildContext context) {
    final paletteFuture =
        useMemoized(() => _generatePalette(photo.url), [photo.url]);

    return FutureBuilder<PaletteGenerator>(
      future: paletteFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Center(
              child: Text('Error loading image palette'),
            ),
          );
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const Scaffold(
            body: Center(
              child: Text('No data available'),
            ),
          );
        } else {
          final dominantColor = snapshot.data!.dominantColor!.color;
          final vibrantColor = snapshot.data!.vibrantColor?.color;
          return SliverAppbarScaffold(
            icons: false,
            bottomSpace: 0,
            topSpace: 0,
            physics: const AlwaysScrollableScrollPhysics(),
            expandedHeight: 500,
            onExpandedBackgroundImage: BackgroundImage(
                image: NetworkImage(photo.url), heroTag: photo.url),
            title: photo.title,
            child: SliverToBoxAdapter(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    tileMode: TileMode.decal,
                    colors: isColorTooLight(dominantColor)
                        ? [
                            Colors.black.withOpacity(0.7),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0)
                          ]
                        : [
                            dominantColor,
                            dominantColor.withOpacity(0.7),
                            dominantColor.withOpacity(0.5),
                            dominantColor.withOpacity(0.3),
                            dominantColor.withOpacity(0.1),
                            dominantColor.withOpacity(0)
                          ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: ClipRect(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // photo title and description
                        Text(photo.title,
                            style: Theme.of(context).textTheme.displayLarge),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconLabelTile(
                                  iconColor: vibrantColor,
                                  iconSize: 22,
                                  label: photo.date,
                                  icon: FontAwesomeIcons.calendarDay),
                              if (photo.copyright != null &&
                                  photo.copyright != '')
                                IconLabelTile(
                                    iconColor:
                                        snapshot.data!.vibrantColor?.color,
                                    iconSize: 22,
                                    label: photo.copyright!,
                                    icon: FontAwesomeIcons.camera)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Text(photo.description,
                              style: Theme.of(context).textTheme.bodyMedium),
                        ),
                        //
                        const SizedBox(height: 40),
                        const AppLogoTile(opacity: 0.2)
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<PaletteGenerator> _generatePalette(String imagePath) async {
    final ImageProvider imageProvider = NetworkImage(imagePath);
    return await PaletteGenerator.fromImageProvider(
      imageProvider,
      size: const Size(500, 500),
      maximumColorCount: 20,
    );
  }
}
