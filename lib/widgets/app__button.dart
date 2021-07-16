import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/manager/theme/theme.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/utils/extensions/button_type_extension.dart';

class AppButton extends StatefulWidget {
  final Function()? onLongPress;
  final AlignmentGeometry alignment;
  //
  final bool autofocus;

  //
  final Color? backgroundColor;

  final BorderRadius borderRadius;
  final Widget? child;
  final Clip clipBehavior;
  final bool disabled;
  final SystemMouseCursor cursorType;
  final AppButtonStyle Function(AppButtonStyle)? onHover;
  final AppButtonStyle Function(AppButtonStyle)? onHoverExit;
  // Cupertino
  final Color disabledColor;

  final double? elevation;
  final String? fontFamily;
  final double fontSize;
  final FontWeight? fontWeight;
  final double height;
  final double minSize;
  final VoidCallback? onPressed;
  final double opacity;
  final EdgeInsetsGeometry? padding;
  final double pressedOpacity;
  final OutlinedBorder? shape;
  final BorderSide? side;
  final Color? splashColor;
  final MaterialTapTargetSize? tapTargetSize;
  final String? text;
  final Alignment textAlignment;
  final Color? textColor;
  final TextStyle? textStyle;
  final ButtonType type;
  final double? width;
  final double? wordSpacing;

  AppButton({
    Key? key,
    this.text,
    this.fontSize = 16.0,
    this.fontWeight,
    this.fontFamily,
    this.wordSpacing,
    this.textAlignment = Alignment.center,
    this.alignment = Alignment.center,
    this.textColor,
    this.width,
    this.height = 48.0,
    this.autofocus = false,
    this.disabled = false,
    SystemMouseCursor cursor = SystemMouseCursors.click,
    double? opacity,
    this.clipBehavior = Clip.antiAlias,
    this.onLongPress,
    this.backgroundColor,
    this.splashColor,
    this.elevation,
    this.padding,
    BorderRadius? borderRadius,
    this.shape,
    this.side,
    this.tapTargetSize,
    this.textStyle,
    this.child,
    Color? disabledColor,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.4,
    this.onPressed,
    this.onHover,
    this.onHoverExit,
  })  : assert(text != null || child != null),
        cursorType = cursor,
        type = disabled && (Platform.isIOS || Platform.isMacOS)
            ? ButtonType.elevated
            : ButtonType.flat,
        opacity = disabled ? 0.6 : opacity ?? 1.0,
        borderRadius =
            borderRadius ?? BorderRadius.circular(Helpers.buttonRadius),
        disabledColor = disabled
            ? CupertinoColors.inactiveGray
            : CupertinoColors.quaternarySystemFill,
        super(key: key);

  AppButton.filled({
    Key? key,
    this.text,
    this.fontSize = 16.0,
    this.fontWeight,
    this.fontFamily,
    this.wordSpacing,
    this.textAlignment = Alignment.center,
    this.alignment = Alignment.center,
    this.textColor,
    this.width,
    this.height = 48.0,
    this.autofocus = false,
    this.disabled = false,
    SystemMouseCursor cursor = SystemMouseCursors.click,
    double? opacity,
    this.clipBehavior = Clip.antiAlias,
    this.onLongPress,
    this.backgroundColor,
    this.splashColor,
    this.elevation,
    this.padding,
    BorderRadius? borderRadius,
    this.shape,
    this.side,
    this.tapTargetSize,
    this.textStyle,
    this.child,
    Color? disabledColor,
    this.minSize = kMinInteractiveDimensionCupertino,
    this.pressedOpacity = 0.4,
    this.onPressed,
    this.onHover,
    this.onHoverExit,
  })  : assert(text != null || child != null),
        cursorType = cursor,
        type = ButtonType.elevated,
        opacity = disabled ? 0.6 : opacity ?? 1.0,
        borderRadius =
            borderRadius ?? BorderRadius.circular(Helpers.buttonRadius),
        disabledColor = disabled
            ? CupertinoColors.inactiveGray
            : CupertinoColors.quaternarySystemFill,
        super(key: key);

  @override
  _AppButtonState createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  late AppButtonStyle style;
  late AppButtonStyle original;
  String? themeId = '';

  void init() {
    style = original = AppButtonStyle(
      type: widget.type,
      primary: widget.backgroundColor ?? AppColors.accentColor,
      alignment: widget.alignment,
      elevation: widget.elevation,
      padding: widget.padding,
      splashFactory: CustomSplashFactory(splashColor: widget.splashColor),
      shape: widget.shape ??
          RoundedRectangleBorder(borderRadius: widget.borderRadius),
      tapTargetSize: widget.tapTargetSize,
      textStyle: widget.textStyle ??
          TextStyle(
            fontSize: widget.fontSize,
            fontWeight: widget.fontWeight,
            fontFamily: widget.fontFamily,
            wordSpacing: widget.wordSpacing,
            color: widget.textColor,
          ),
      backgroundColor: widget.backgroundColor ?? AppColors.accentColor,
      side: widget.side,
    );
  }

  @override
  void initState() {
    super.initState();

    init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, AppTheme>(
      builder: (_, s) {
        if (themeId != s.id)
          SchedulerBinding.instance!.addPostFrameCallback((_) => init());

        return PlatformBuilder(
          cupertino: (context) => widget.type.fold(
            elevated: () => CupertinoButton.filled(
              key: widget.key,
              alignment: widget.alignment,
              borderRadius: widget.borderRadius,
              pressedOpacity: widget.pressedOpacity,
              minSize: widget.minSize,
              disabledColor: widget.disabledColor,
              padding: widget.padding,
              onPressed: widget.onPressed,
              child: Visibility(
                visible: widget.text != null && !widget.text!.isBlank,
                replacement: widget.child ?? const SizedBox.shrink(),
                child: AutoSizeText(
                  widget.text ?? '',
                  style: widget.textStyle ??
                      TextStyle(
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        fontFamily: widget.fontFamily,
                        wordSpacing: widget.wordSpacing,
                        color: widget.textColor ?? App.theme.accentColor,
                      ),
                ),
              ),
            ),
            flat: () => CupertinoButton(
              key: widget.key,
              alignment: widget.alignment,
              borderRadius: widget.borderRadius,
              pressedOpacity: widget.pressedOpacity,
              minSize: widget.minSize,
              // color: backgroundColor,
              disabledColor: widget.disabledColor,
              padding: widget.padding,
              onPressed: widget.onPressed,
              child: Visibility(
                visible: widget.text != null && !widget.text!.isBlank,
                replacement: widget.child ?? const SizedBox.shrink(),
                child: AutoSizeText(
                  widget.text ?? '',
                  style: widget.textStyle ??
                      TextStyle(
                        fontSize: widget.fontSize,
                        fontWeight: widget.fontWeight,
                        fontFamily: widget.fontFamily,
                        wordSpacing: widget.wordSpacing,
                        color: widget.textColor ?? App.theme.accentColor,
                      ),
                ),
              ),
            ),
          ),
          material: (context) => InteractiveMouseRegion(
            onHover: (_) {
              if (widget.onHover != null)
                setState(() => style = widget.onHover!.call(style));
              return style.cursorType ?? widget.cursorType;
            },
            onExit: (_) {
              if (widget.onHoverExit != null)
                setState(() => style = widget.onHoverExit!.call(original));
              return style.cursorType ?? widget.cursorType;
            },
            child: widget.type.fold(
              flat: () => TextButton(
                key: widget.key,
                onPressed: widget.onPressed,
                autofocus: widget.autofocus,
                clipBehavior: widget.clipBehavior,
                onLongPress: widget.onLongPress,
                style: style.apply(),
                child: Visibility(
                  visible: widget.text != null && !widget.text!.isBlank,
                  replacement: widget.child ?? const SizedBox.shrink(),
                  child: FractionallySizedBox(
                    child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: Align(
                        alignment: widget.textAlignment,
                        child: AutoSizeText(
                          widget.text ?? '',
                          style: style.textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              elevated: () => ElevatedButton(
                key: widget.key,
                onPressed: widget.onPressed,
                autofocus: widget.autofocus,
                clipBehavior: widget.clipBehavior,
                onLongPress: widget.onLongPress,
                style: style.apply(),
                child: Visibility(
                  visible: widget.text != null && !widget.text!.isBlank,
                  replacement: widget.child ?? const SizedBox.shrink(),
                  child: FractionallySizedBox(
                    child: SizedBox(
                      width: widget.width,
                      height: widget.height,
                      child: Align(
                        alignment: widget.textAlignment,
                        child: AutoSizeText(
                          widget.text ?? '',
                          style: style.textStyle,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class AppButtonStyle {
  final Color? onPrimary;
  final Color? onSurface;
  final Color? primary;
  final Color? shadowColor;
  final Color? backgroundColor;
  final double? elevation;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final Size? fixedSize;
  final BorderSide? side;
  final OutlinedBorder? shape;
  final VisualDensity? visualDensity;
  final MaterialTapTargetSize? tapTargetSize;
  final Duration? animationDuration;
  final bool? enableFeedback;
  final AlignmentGeometry? alignment;
  final InteractiveInkFeatureFactory? splashFactory;
  final SystemMouseCursor? cursorType;
  final ButtonType type;

  const AppButtonStyle({
    required this.type,
    this.onPrimary,
    this.onSurface,
    this.primary,
    this.shadowColor,
    this.backgroundColor,
    this.elevation,
    this.textStyle,
    this.padding,
    this.minimumSize,
    this.fixedSize,
    this.side,
    this.shape,
    this.visualDensity,
    this.tapTargetSize,
    this.animationDuration,
    this.enableFeedback,
    this.alignment,
    this.splashFactory,
    SystemMouseCursor? cursor,
  }) : cursorType = cursor;

  AppButtonStyle copyWith({
    Color? onPrimary,
    Color? onSurface,
    Color? primary,
    Color? shadowColor,
    Color? backgroundColor,
    double? elevation,
    TextStyle? textStyle,
    EdgeInsetsGeometry? padding,
    Size? minimumSize,
    Size? fixedSize,
    BorderSide? side,
    OutlinedBorder? shape,
    VisualDensity? visualDensity,
    MaterialTapTargetSize? tapTargetSize,
    Duration? animationDuration,
    bool? enableFeedback,
    AlignmentGeometry? alignment,
    InteractiveInkFeatureFactory? splashFactory,
    SystemMouseCursor? cursorType,
    ButtonType? type,
  }) =>
      AppButtonStyle(
        type: type ?? this.type,
        alignment: alignment ?? this.alignment,
        shadowColor: shadowColor ?? this.shadowColor,
        elevation: elevation ?? this.elevation,
        textStyle: this.textStyle?.merge(textStyle),
        padding: padding ?? this.padding,
        minimumSize: minimumSize ?? this.minimumSize,
        fixedSize: fixedSize ?? this.fixedSize,
        side: side ?? this.side,
        shape: shape ?? this.shape,
        visualDensity: visualDensity ?? this.visualDensity,
        tapTargetSize: tapTargetSize ?? this.tapTargetSize,
        animationDuration: animationDuration ?? this.animationDuration,
        enableFeedback: enableFeedback ?? this.enableFeedback,
        splashFactory: splashFactory ?? this.splashFactory,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        primary: primary ?? this.primary,
        onSurface: onSurface ?? this.onSurface,
        onPrimary: onPrimary ?? this.onPrimary,
        cursor: cursorType ?? this.cursorType,
      );

  ButtonStyle apply() {
    return type.fold(
      flat: () {
        return TextButton.styleFrom(
          alignment: alignment,
          shadowColor: shadowColor,
          elevation: elevation,
          textStyle: textStyle,
          padding: padding,
          minimumSize: minimumSize,
          fixedSize: fixedSize,
          side: side,
          shape: shape,
          visualDensity: visualDensity,
          tapTargetSize: tapTargetSize,
          animationDuration: animationDuration,
          enableFeedback: enableFeedback,
          splashFactory: splashFactory,
          backgroundColor: backgroundColor,
          onSurface: onSurface,
        );
      },
      elevated: () {
        return ElevatedButton.styleFrom(
          alignment: alignment,
          shadowColor: shadowColor,
          elevation: elevation,
          textStyle: textStyle,
          padding: padding,
          minimumSize: minimumSize,
          fixedSize: fixedSize,
          side: side,
          shape: shape,
          visualDensity: visualDensity,
          tapTargetSize: tapTargetSize,
          animationDuration: animationDuration,
          enableFeedback: enableFeedback,
          splashFactory: splashFactory,
          onPrimary: onPrimary,
          onSurface: onSurface,
          primary: primary,
        );
      },
    );
  }
}
