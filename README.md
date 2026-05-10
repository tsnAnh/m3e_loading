# M3E Loading

A Flutter package providing Material 3 Expressive loading indicators with smooth morphing shape animations.

## Features

- 🎨 **Material 3 Expressive Design** - Follows Google's latest design system
- ⚡ **Smooth Animations** - Spring-based morphing between 7 different shapes
- 📐 **5 Size Variants** - From XS (28px) to XL (56px)
- 🎯 **Themeable** - Respects `ProgressIndicatorTheme` or accepts custom colors
- ♿ **Accessible** - Semantic labels and respects `disableAnimations`
- 🚀 **Zero Config** - Works out of the box with Material theme

## Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  m3e_loading:
    git:
      url: https://github.com/tsnAnh/m3e_loading.git
      ref: main
```

Or run:

```bash
flutter pub add m3e_loading --git-url=https://github.com/tsnAnh/m3e_loading.git
```

## Usage

### Basic Usage

```dart
import 'package:m3e_loading/m3e_loading.dart';

M3ELoadingIndicator(size: M3ELoadingSize.md)
```

### Size Variants

```dart
M3ELoadingIndicator(size: M3ELoadingSize.xs)  // 28px
M3ELoadingIndicator(size: M3ELoadingSize.sm)  // 32px
M3ELoadingIndicator(size: M3ELoadingSize.md)  // 40px (default)
M3ELoadingIndicator(size: M3ELoadingSize.lg)  // 48px
M3ELoadingIndicator(size: M3ELoadingSize.xl)  // 56px
```

### Custom Color

```dart
M3ELoadingIndicator(
  size: M3ELoadingSize.md,
  color: Colors.blue,
)
```

### Using ProgressIndicatorTheme

```dart
ProgressIndicatorTheme(
  data: ProgressIndicatorThemeData(
    color: Theme.of(context).colorScheme.secondary,
  ),
  child: M3ELoadingIndicator(),
)
```

### Centered in Screen

```dart
Center(
  child: M3ELoadingIndicator(),
)
```

## Shape Morphing Sequence

The indicator morphs through 7 Material shapes in sequence:
1. Soft Burst
2. Cookie (9-sided)
3. Pentagon
4. Pill
5. Sunny
6. Cookie (4-sided)
7. Oval

Then loops back to Soft Burst.

## API Reference

### M3ELoadingIndicator

Main widget displaying the animated loading indicator.

**Properties:**
- `size` (M3ELoadingSize) - Size of the indicator. Default: `M3ELoadingSize.md`
- `color` (Color?) - Optional color override. If null, uses `ProgressIndicatorTheme.color` or `ColorScheme.primary`

### M3ELoadingSize

Enum defining size variants.

**Values:**
- `xs` - 28x28 pixels
- `sm` - 32x32 pixels
- `md` - 40x40 pixels (default)
- `lg` - 48x48 pixels
- `xl` - 56x56 pixels

## Performance

- Uses `RepaintBoundary` for optimized repaints
- Respects `MediaQuery.disableAnimationsOf()` for accessibility
- Efficient `shouldRepaint` logic in custom painter
- Smooth 60fps animations with spring physics

## Platform Support

| Platform | Supported |
|----------|-----------|
| Android  | ✅ |
| iOS      | ✅ |
| Web      | ✅ |
| macOS    | ✅ |
| Linux    | ✅ |
| Windows  | ✅ |

## Example

See the [example](example/) directory for a complete demo app.

To run the example:

```bash
cd example
flutter run
```

## Dependencies

- `androidx_graphics_shapes` ^1.5.0 - Material shape morphing library

## Credits

Inspired by Android's Material 3 Expressive loading indicators.

## License

MIT License - see [LICENSE](LICENSE) file for details.

## Contributing

Contributions welcome! Please open an issue or PR on GitHub.
