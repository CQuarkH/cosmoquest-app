import 'dart:ui';

import 'package:cosmo_quest/components/organisms/carousel_slider.dart';
import 'package:cosmo_quest/models/photo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PhotoSlider extends HookWidget {
  final List<Photo> photos;
  final bool? autoPlay;
  const PhotoSlider({super.key, required this.photos, this.autoPlay = true});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        itemCount: photos.length,
        builder: (context, index) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Stack(
                children: [
                  Image.network(
                    photos[index].url,
                    fit: BoxFit.cover,
                    height: double.infinity,
                    width: double.infinity,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    top: 0,
                    child: ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                        child: Container(
                          color: Colors.black.withOpacity(0.5),
                          child: Center(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                photos[index].title,
                                style: Theme.of(context).textTheme.displayLarge,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ));
  }
}
