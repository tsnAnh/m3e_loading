part of 'loading_indicator.dart';

class _LoadingIndicatorPainter extends CustomPainter {
  const _LoadingIndicatorPainter({
    required this.color,
    required this.morphProgress,
    required this.globalRotation,
    required this.morphRotationTargetAngle,
    required this.currentMorphIndex,
  });

  static const _shapesScaleFactor = 0.6852541768130451;

  final Color color;
  final double morphProgress;
  final double globalRotation;
  final double morphRotationTargetAngle;
  final int currentMorphIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final rotationDegrees =
        morphProgress * 90.0 + morphRotationTargetAngle + globalRotation;
    final rotation = _degreesToRadians(rotationDegrees);

    final morph = _ShapeFactory.morphs[currentMorphIndex];
    final path = morph.toPath(progress: morphProgress);

    final scaleMatrix = Matrix4.identity()
      ..scale(
        size.width * _shapesScaleFactor,
        size.height * _shapesScaleFactor,
      );

    final scaledPath = path.transform(scaleMatrix.storage);
    final bounds = scaledPath.getBounds();
    final centerOffset = Offset(
      size.width / 2 - bounds.center.dx,
      size.height / 2 - bounds.center.dy,
    );
    final finalPath = scaledPath.shift(centerOffset);

    canvas
      ..save()
      ..translate(size.width / 2, size.height / 2)
      ..rotate(rotation)
      ..translate(-size.width / 2, -size.height / 2)
      ..drawPath(
        finalPath,
        Paint()
          ..color = color
          ..style = PaintingStyle.fill
          ..isAntiAlias = true,
      )
      ..restore();
  }

  double _degreesToRadians(double degrees) => degrees * math.pi / 180;

  @override
  bool shouldRepaint(covariant _LoadingIndicatorPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.morphProgress != morphProgress ||
        oldDelegate.globalRotation != globalRotation ||
        oldDelegate.morphRotationTargetAngle != morphRotationTargetAngle ||
        oldDelegate.currentMorphIndex != currentMorphIndex;
  }
}
