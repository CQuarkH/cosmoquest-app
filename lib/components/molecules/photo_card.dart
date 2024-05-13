import 'package:cosmo_quest/screens/nested_screens/apod_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:cosmo_quest/models/photo.dart';

class PhotoCard extends StatelessWidget {
  final Photo photo;
  final Widget bottomWidget;
  final double? height;
  final double? width;
  final String? heroTag;

  const PhotoCard({
    Key? key,
    required this.photo,
    required this.bottomWidget,
    required this.heroTag,
    this.height = 250,
    this.width = 200,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => APODDetailsScreen(photo: photo))),
      child: Hero(
        tag: heroTag ?? '',
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Stack(
            children: [
              Image.network(
                photo.url,
                fit: BoxFit.cover,
                width: width!,
                height: height,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey,
                    width: width!,
                    height: height!,
                    child: const Center(
                      child: Icon(
                        Icons.error,
                        color: Colors.white,
                        size: 48,
                      ),
                    ),
                  );
                },
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
                      child: bottomWidget,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
