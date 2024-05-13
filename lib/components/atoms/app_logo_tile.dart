import 'package:flutter/material.dart';

class AppLogoTile extends StatelessWidget {
  final double? opacity;
  final Color? color;
  const AppLogoTile({super.key, this.opacity = 1, this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('COSMOQUEST',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: color?.withOpacity(opacity!) ??
                    Theme.of(context)
                        .colorScheme
                        .onBackground
                        .withOpacity(opacity!),
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}
