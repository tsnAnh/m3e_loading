import 'dart:math' as math;

import 'package:androidx_graphics_shapes/material_shapes.dart';
import 'package:androidx_graphics_shapes/shapes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

part 'loading_indicator_painter.dart';
part 'loading_shapes.dart';

/// Material 3 Expressive loading indicator with animated morphing shapes.
///
/// This widget displays a smooth morphing animation between different
/// geometric shapes, following Material 3 Expressive design language.
///
/// Example:
/// ```dart
/// M3ELoadingIndicator(size: M3ELoadingIndicator.sizeMD)
/// ```
///
/// The color can be customized via [ProgressIndicatorTheme]:
/// ```dart
/// ProgressIndicatorTheme(
///   data: ProgressIndicatorThemeData(color: Colors.blue),
///   child: M3ELoadingIndicator(),
/// )
/// ```
class M3ELoadingIndicator extends StatefulWidget {
  const M3ELoadingIndicator({
    super.key,
    this.size,
    this.color,
    this.backgroundColor,
  });

  final double? size;
  final Color? color;
  final Color? backgroundColor;

  /// Extra small size: 28.0 logical pixels
  static const double sizeXS = 28.0;

  /// Small size: 32.0 logical pixels
  static const double sizeSM = 32.0;

  /// Medium size: 40.0 logical pixels (default)
  static const double sizeMD = 40.0;

  /// Large size: 48.0 logical pixels
  static const double sizeLG = 48.0;

  /// Extra large size: 56.0 logical pixels
  static const double sizeXL = 56.0;

  @override
  State<M3ELoadingIndicator> createState() => _M3ELoadingIndicatorState();
}

class _M3ELoadingIndicatorState extends State<M3ELoadingIndicator>
    with TickerProviderStateMixin {
  late final AnimationController _globalRotationController;
  late final AnimationController _loopController;
  int _currentMorphIndex = 0;
  double _morphRotationTargetAngle = 90;

  late final SpringSimulation _springSimulation;

  @override
  void initState() {
    super.initState();
    _globalRotationController = AnimationController(
      duration: const Duration(milliseconds: 4666),
      vsync: this,
    );

    _loopController = AnimationController(
      duration: const Duration(milliseconds: 650),
      vsync: this,
    );

    _loopController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _currentMorphIndex =
              (_currentMorphIndex + 1) % _ShapeFactory.morphs.length;
          _morphRotationTargetAngle =
              (_morphRotationTargetAngle + 90.0) % 360.0;
        });
        _loopController.forward(from: 0);
      }
    });

    final spring = SpringDescription(
      mass: 1,
      stiffness: 200,
      damping: 0.6 * 2 * math.sqrt(200.0),
    );
    _springSimulation = SpringSimulation(
      spring,
      0,
      1,
      0,
      tolerance: const Tolerance(
        distance: 0.1,
        velocity: 0.1,
      ),
    );

    _startAnimations();
  }

  void _startAnimations() {
    _globalRotationController.repeat();
    _loopController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _globalRotationController.stop();
      _loopController.stop();
    } else if (!_globalRotationController.isAnimating) {
      _startAnimations();
    }
  }

  @override
  void dispose() {
    _globalRotationController.dispose();
    _loopController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final color = widget.color ??
        ProgressIndicatorTheme.of(context).color ??
        Theme.of(context).colorScheme.primary;
    final disableAnimations = MediaQuery.disableAnimationsOf(context);

    return Semantics(
      label: 'Loading',
      child: RepaintBoundary(
        child: SizedBox.square(
          dimension: widget.size ?? M3ELoadingIndicator.sizeMD,
          child: AnimatedBuilder(
            animation: Listenable.merge([
              _globalRotationController,
              _loopController,
            ]),
            builder: (context, _) {
              double morphProgress = 0;
              if (!disableAnimations) {
                final time = _loopController.value * 0.650;
                morphProgress = _springSimulation.isDone(time)
                    ? 1.0
                    : _springSimulation.x(time);
              }

              final globalRotation = disableAnimations
                  ? 0.0
                  : _globalRotationController.value * 360.0;

              return CustomPaint(
                painter: _LoadingIndicatorPainter(
                  color: color,
                  morphProgress: morphProgress,
                  globalRotation: globalRotation,
                  morphRotationTargetAngle: _morphRotationTargetAngle,
                  currentMorphIndex: _currentMorphIndex,
                  backgroundColor: widget.backgroundColor,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
