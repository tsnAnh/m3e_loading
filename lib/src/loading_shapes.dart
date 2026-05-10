part of 'loading_indicator.dart';

abstract final class _ShapeFactory {
  static final shapes = <RoundedPolygon>[
    MaterialShapes.softBurst,
    MaterialShapes.cookie9Sided,
    MaterialShapes.pentagon,
    MaterialShapes.pill,
    MaterialShapes.sunny,
    MaterialShapes.cookie4Sided,
    MaterialShapes.oval,
  ];

  static final morphs = List.generate(
    shapes.length,
    (i) => Morph(
      shapes[i],
      shapes[(i + 1) % shapes.length],
    ),
  );
}
