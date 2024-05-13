import 'package:cosmo_quest/models/photo.dart';

class CelestialBody {
  final String englishName;
  final bool isPlanet;
  final String bodyType;
  final List<Moon> moons;
  final int semimajorAxis;
  final int perihelion;
  final int aphelion;
  final double eccentricity;
  final double inclination;
  final Mass mass;
  final Vol vol;
  final double density;
  final double gravity;
  final int escape;
  final double meanRadius;
  final double equaRadius;
  final double polarRadius;
  final double flattening;
  final double sideralOrbit;
  final double sideralRotation;
  final double axialTilt;
  final double avgTemp;
  final List<Photo> gallery;
  final String description;
  final String funFact;

  CelestialBody({
    required this.englishName,
    required this.isPlanet,
    required this.bodyType,
    required this.moons,
    required this.semimajorAxis,
    required this.perihelion,
    required this.aphelion,
    required this.eccentricity,
    required this.inclination,
    required this.mass,
    required this.vol,
    required this.density,
    required this.gravity,
    required this.escape,
    required this.meanRadius,
    required this.equaRadius,
    required this.polarRadius,
    required this.flattening,
    required this.sideralOrbit,
    required this.sideralRotation,
    required this.axialTilt,
    required this.avgTemp,
    required this.gallery,
    required this.description,
    required this.funFact,
  });

  factory CelestialBody.fromJson(Map<String, dynamic> json) => CelestialBody(
        englishName: json['englishName'],
        isPlanet: json['isPlanet'],
        bodyType: json['bodyType'],
        moons: json['moons'] != null
            ? List<Moon>.from(json['moons'].map((x) => Moon.fromJson(x)))
            : [],
        semimajorAxis: json['semimajorAxis'],
        perihelion: json['perihelion'],
        aphelion: json['aphelion'],
        eccentricity: json['eccentricity'],
        inclination: (json['inclination'] as num).toDouble(),
        mass: Mass.fromJson(json['mass']),
        vol: Vol.fromJson(json['vol']),
        density: json['density'],
        gravity: json['gravity'],
        escape: json['escape'],
        meanRadius: (json['meanRadius'] as num).toDouble(),
        equaRadius: (json['equaRadius'] as num).toDouble(),
        polarRadius: (json['polarRadius'] as num).toDouble(),
        flattening: (json['flattening'] as num).toDouble(),
        sideralOrbit: (json['sideralOrbit'] as num).toDouble(),
        sideralRotation: (json['sideralRotation'] as num).toDouble(),
        axialTilt: (json['axialTilt'] as num).toDouble(),
        avgTemp: (json['avgTemp'] as num).toDouble(),
        gallery:
            List<Photo>.from(json['gallery'].map((x) => Photo.fromJson(x))),
        description: json['description'],
        funFact: json['funFact'],
      );
}

class Moon {
  final String moon;
  final String rel;

  Moon({required this.moon, required this.rel});

  factory Moon.fromJson(Map<String, dynamic> json) => Moon(
        moon: json['moon'],
        rel: json['rel'],
      );
}

class Mass {
  final double massValue;
  final int massExponent;

  Mass({required this.massValue, required this.massExponent});

  factory Mass.fromJson(Map<String, dynamic> json) => Mass(
        massValue: json['massValue'],
        massExponent: json['massExponent'],
      );
}

class Vol {
  final double volValue;
  final int volExponent;

  Vol({required this.volValue, required this.volExponent});

  factory Vol.fromJson(Map<String, dynamic> json) => Vol(
        volValue: json['volValue'],
        volExponent: json['volExponent'],
      );
}
