import 'package:cosmo_quest/components/atoms/nasa_credit_tile.dart';
import 'package:cosmo_quest/models/photo.dart';
import 'package:flutter/material.dart';

class PhotoWithDetailsBottomWidget {
  final double? height;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final MainAxisSize? mainAxisSize;
  final List<Widget> children;

  const PhotoWithDetailsBottomWidget(
      {this.height = 100,
      this.mainAxisAlignment = MainAxisAlignment.spaceBetween,
      this.crossAxisAlignment = CrossAxisAlignment.end,
      this.mainAxisSize = MainAxisSize.min,
      required this.children});
}

class PhotoWithDetails extends StatelessWidget {
  final Photo photo;
  final String? heroTag;
  final double? height;
  final double? width;
  final double? borderRadius;
  final bool nasaCredits;
  final PhotoWithDetailsBottomWidget? bottomWidget;
  const PhotoWithDetails(
      {super.key,
      required this.photo,
      this.heroTag,
      this.height = 400,
      this.width = double.infinity,
      this.nasaCredits = true,
      this.borderRadius = 10,
      this.bottomWidget});

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: heroTag ?? '',
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius!),
        child: Stack(
          children: [
            Image.network(
              photo.url,
              fit: BoxFit.cover,
              width: width!,
              height: height,
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 100,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Theme.of(context).scaffoldBackgroundColor,
                        Colors.transparent,
                      ],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                        mainAxisAlignment: bottomWidget?.mainAxisAlignment ??
                            MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: bottomWidget?.crossAxisAlignment ??
                            CrossAxisAlignment.end,
                        mainAxisSize:
                            bottomWidget?.mainAxisSize ?? MainAxisSize.min,
                        children: bottomWidget?.children ??
                            [
                              Expanded(
                                child: Text(
                                  photo.title,
                                  style: Theme.of(context).textTheme.bodySmall!,
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(width: 8),
                              if (nasaCredits)
                                NasaCreditTile(
                                  textStyle:
                                      Theme.of(context).textTheme.bodySmall!,
                                  iconHeight: 26,
                                  iconWidth: 26,
                                ),
                              if (!nasaCredits)
                                Text(photo.date,
                                    style:
                                        Theme.of(context).textTheme.bodySmall!),
                            ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
