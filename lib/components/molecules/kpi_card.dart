import 'package:flutter/material.dart';

class KPICard extends StatelessWidget {
  final String label;
  final String value;
  final String? suffix;

  const KPICard(
      {super.key, required this.label, required this.value, this.suffix});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: 8),
            Text(suffix != null ? '$value $suffix' : value,
                style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ),
    );
  }
}
