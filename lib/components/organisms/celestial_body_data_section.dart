import 'package:cosmo_quest/components/atoms/section_title.dart';
import 'package:cosmo_quest/components/molecules/kpi_card.dart';
import 'package:cosmo_quest/models/celestial_body.dart';
import 'package:flutter/material.dart';

class CelestialBodyDataSection extends StatelessWidget {
  final CelestialBody celestialBody;
  const CelestialBodyDataSection({super.key, required this.celestialBody});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
            width: double.infinity,
            child: SectionTitle(title: 'Details', icon: Icons.info)),
        GridView.count(
          padding: const EdgeInsets.all(0),
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            KPICard(
                label: 'Mass', value: celestialBody.mass.massValue.toString()),
            KPICard(
              label: 'Gravity',
              value: celestialBody.gravity.toString(),
              suffix: 'm/s²',
            ),
            KPICard(
              label: 'Radius',
              value: celestialBody.meanRadius.toString(),
              suffix: 'km',
            ),
            KPICard(
              label: 'Avg Temp',
              value: celestialBody.avgTemp.toString(),
              suffix: '°C',
            ),
            KPICard(
              label: 'Orbit Period',
              value: celestialBody.sideralOrbit.toString(),
              suffix: 'days',
            ),
            KPICard(
              label: 'Rotation Period',
              value: celestialBody.sideralRotation.toString(),
              suffix: 'hours',
            ),
          ],
        )
      ],
    );
  }
}
