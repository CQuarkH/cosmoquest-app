import 'package:flutter/material.dart';

class IconLabelTile extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color? iconColor;
  final TextStyle? textStyle;
  final double? iconSize;
  final double? spacing;
  final EdgeInsets? padding;
  const IconLabelTile(
      {super.key,
      required this.label,
      required this.icon,
      this.iconSize = 24,
      this.textStyle,
      this.spacing = 8,
      this.padding,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.all(8),
      child: Row(
        children: [
          Icon(
            icon,
            color: iconColor ?? Theme.of(context).colorScheme.secondary,
            size: iconSize,
          ),
          SizedBox(width: spacing!),
          Text(label,
              style: textStyle ?? Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
