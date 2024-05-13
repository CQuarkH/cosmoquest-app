import 'package:cosmo_quest/components/atoms/icon_label_tile.dart';
import 'package:flutter/material.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData icon;
  const SectionTitle({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconLabelTile(
      label: title,
      icon: icon,
      textStyle: Theme.of(context).textTheme.displayMedium,
      padding: const EdgeInsets.symmetric(vertical: 8),
      spacing: 12,
      iconSize: 22,
    );
  }
}
