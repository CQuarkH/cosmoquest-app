import 'package:flutter/material.dart';

class NasaCreditTile extends StatelessWidget {
  final TextStyle? textStyle;
  final double? iconHeight;
  final double? iconWidth;
  const NasaCreditTile(
      {super.key, this.iconHeight, this.iconWidth, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('By', style: textStyle ?? Theme.of(context).textTheme.bodyMedium),
        const SizedBox(width: 4),
        Image.asset('assets/icons/nasa.png',
            height: iconHeight ?? 36, width: iconWidth ?? 36),
      ],
    );
  }
}
