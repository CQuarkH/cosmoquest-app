import 'package:cosmo_quest/components/atoms/nasa_credit_tile.dart';
import 'package:cosmo_quest/components/atoms/section_title.dart';
import 'package:cosmo_quest/components/molecules/photo_w_details.dart';
import 'package:cosmo_quest/components/organisms/celestial_body_data_section.dart';
import 'package:cosmo_quest/components/organisms/sliver_appbar_scaffold.dart';
import 'package:cosmo_quest/models/celestial_body.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CelestialBodyDetailsScreen extends StatelessWidget {
  final CelestialBody celestialBody;
  const CelestialBodyDetailsScreen({super.key, required this.celestialBody});

  @override
  Widget build(BuildContext context) {
    return SliverAppbarScaffold(
        icons: false,
        title: celestialBody.englishName,
        expandedHeight: 400,
        bottomSpace: 0,
        onExpandedBackgroundImage: BackgroundImage(
            image: NetworkImage(celestialBody.gallery[0].url),
            heroTag: '${celestialBody.englishName}-image'),
        onExpandedWidget: ExpandedWidget(
            alignment: MainAxisAlignment.end,
            widget: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 0.6),
                    child: Text(celestialBody.gallery[0].title,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .color!
                                .withOpacity(0.8))),
                  ),
                  const NasaCreditTile()
                ],
              ),
            )),
        child: SliverToBoxAdapter(
            child: Column(children: [
          Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // planet name and description
                  Text(celestialBody.englishName,
                      style: Theme.of(context).textTheme.displayLarge),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16.0, horizontal: 8),
                    child: Text(celestialBody.description,
                        style: Theme.of(context).textTheme.bodyMedium),
                  ),

                  // details section
                  CelestialBodyDataSection(celestialBody: celestialBody),
                  const SizedBox(height: 16),

                  // gallery section

                  const SectionTitle(
                      title: 'Gallery', icon: FontAwesomeIcons.images),
                  ListView.builder(
                      padding: const EdgeInsets.all(0),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: celestialBody.gallery.length,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: PhotoWithDetails(
                              photo: celestialBody.gallery[index],
                              heroTag: celestialBody.gallery[index].date,
                            ),
                          )),

                  // fun fact section
                  const SectionTitle(
                      title: 'Fun Fact', icon: FontAwesomeIcons.lightbulb),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 4),
                    child: Text(
                      celestialBody.funFact,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ))
        ])));
  }
}
