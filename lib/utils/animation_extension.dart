import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

/// Extension methods for adding animations to widgets.
extension WidgetAnimationExtension on Widget {
  //? Slide Animations
  /// Animates a widget from right to left with a fade effect.
  Widget animateRightToLeft({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    bool isFromStart = true,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeInOutQuart)
        .moveX(
          begin: isFromStart ? 50 : -50,
          end: 0,
          duration: duration,
          curve: Curves.easeInOutQuart,
        );
  }

  /// Animates a widget from bottom to top with a fade effect.
  Widget animateBottomToTop({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    bool isFromBottom = true,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeInOutQuart)
        .moveY(
          begin: isFromBottom ? 50 : -50,
          end: 0,
          duration: duration,
          curve: Curves.easeInOutQuart,
        );
  }

  //? Shimmer and Shine Animations
  /// Adds a shimmer effect to the widget.
  Widget animateShimmer({
    List<Color>? colors,
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 1500),
  }) {
    return animate(
      delay: delay,
      onPlay: (controller) => controller.repeat(reverse: true),
    ).shimmer(duration: duration, colors: colors);
  }

  /// Adds a desaturation effect to the widget, making it appear gray and then normal repeatedly.
  Widget animateDesaturateRepeated({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(
      delay: delay,
      onPlay: (controller) => controller.repeat(reverse: true),
    ).desaturate(
      begin: 0.5,
      end: 1.0,
      duration: duration,
      curve: Curves.easeInOutQuart,
    );
  }

  //? Alarm and Attention Animations
  /// Adds a shake effect to the widget, useful for alarms or errors.
  Widget animateShake({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    double hz = 10,
  }) {
    return animate(
      delay: delay,
      onPlay: (controller) => controller.repeat(),
    ).shake(hz: hz, duration: duration);
  }

  //? Flip and Rotate Animations
  /// Flips the widget vertically.
  Widget animateFlipVertical({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    Alignment alignment = Alignment.center,
  }) {
    return animate(delay: delay).flipV(
      alignment: alignment,
      begin: 0.5,
      end: 0,
      duration: duration,
      curve: Curves.easeInOutQuart,
    );
  }

  /// Flips the widget horizontally.
  Widget animateFlipHorizontal({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    Alignment alignment = Alignment.center,
  }) {
    return animate(delay: delay).flipH(
      alignment: alignment,
      begin: 0.5,
      end: 0,
      duration: duration,
      curve: Curves.easeInOutQuart,
    );
  }

  /// Rotates the widget.
  Widget animateRotate({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(seconds: 1),
    Alignment alignment = Alignment.center,
  }) {
    return animate(delay: delay).rotate(
      alignment: alignment,
      begin: 0.5,
      end: 1,
      duration: duration,
      curve: Curves.easeInOutQuart,
    );
  }

  //? Scale and Fade Animations
  /// Scales and fades the widget vertically.
  Widget animateScaleAndFadeVertical({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 1000),
    Alignment alignment = Alignment.center,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeInOutQuart)
        .scaleY(
          alignment: alignment,
          begin: 0.5,
          end: 1,
          duration: duration,
          curve: Curves.easeInOutQuart,
        );
  }

  /// Scales and fades the widget horizontally.
  Widget animateScaleAndFadeHorizontal({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 1000),
    Alignment alignment = Alignment.center,
  }) {
    return animate(delay: delay)
        .fadeIn(duration: duration, curve: Curves.easeInOutQuart)
        .scaleX(
          alignment: alignment,
          begin: 0.0,
          end: 1,
          duration: duration,
          curve: Curves.easeInOutQuart,
        );
  }

  //? Visibility and Blur Animations
  /// Hides the widget after a delay.
  Widget animateHideAfterDelay({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    bool maintain = false,
  }) {
    return animate(delay: delay).hide(maintain: maintain, duration: duration);
  }

  /// Makes the widget visible after a delay.
  Widget animateShowAfterDelay({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    bool maintain = false,
  }) {
    return animate(
      delay: delay,
    ).visibility(maintain: maintain, duration: duration);
  }

  /// Blurs the widget and then clears the blur.
  Widget animateBlur({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).blur(
      begin: const Offset(2, 2),
      end: const Offset(0, 0),
      duration: duration,
      curve: Curves.easeInOutQuart,
    );
  }

  //? Additional Animations
  /// Adds a fade-in effect to the widget.
  Widget animateFadeIn({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).fadeIn(duration: duration);
  }

  /// Adds a fade-out effect to the widget.
  Widget animateFadeOut({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).fadeOut(duration: duration);
  }

  /// Adds a slide effect to the widget.
  Widget animateSlide({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    Offset begin = const Offset(1, 0),
    Offset end = const Offset(0, 0),
  }) {
    return animate(
      delay: delay,
    ).slide(begin: begin, end: end, duration: duration);
  }

  /// Adds a scale effect to the widget.
  Widget animateScale({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    Offset begin = const Offset(0.5, 0.5),
    Offset end = const Offset(1.0, 1.0),
  }) {
    return animate(
      delay: delay,
    ).scale(begin: begin, end: end, duration: duration);
  }

  /// Adds a flip effect to the widget.
  Widget animateFlip({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
    double begin = 0.5,
    double end = 1.0,
  }) {
    return animate(
      delay: delay,
    ).flip(begin: begin, end: end, duration: duration);
  }

  /// Adds a spin effect to the widget.
  Widget animateSpin({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).rotate(duration: duration);
  }

  /// Adds a bounce effect to the widget.
  Widget animateBounce({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).scale(duration: duration);
  }

  /// Adds a flash effect to the widget.
  Widget animateFlash({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).fadeIn(duration: duration);
  }

  /// Adds a swing effect to the widget.
  Widget animateSwing({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).shake(duration: duration);
  }

  /// Adds a tada effect to the widget.
  Widget animateTada({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).scale(duration: duration);
  }

  /// Adds a jello effect to the widget.
  Widget animateJello({
    Duration delay = const Duration(milliseconds: 500),
    Duration duration = const Duration(milliseconds: 500),
  }) {
    return animate(delay: delay).shake(duration: duration);
  }
}
