import 'package:flutter/material.dart';
import 'package:universal_platform/universal_platform.dart';

part 'responsive.dart';

typedef _PlatformBuilder = Widget Function(BuildContext context);

typedef _ResponsivePlatformBuilder = Widget Function(
  QueryContext context,
  WidgetRenderConfiguration configuration,
);

class PlatformBuilder extends StatelessWidget {
  static const Widget _kDefault = SizedBox.shrink();
  final _PlatformBuilder? _cupertino;
  final _PlatformBuilder? _web;
  final _PlatformBuilder? _material;
  //
  final _ResponsivePlatformBuilder? _rCupertino;
  final _ResponsivePlatformBuilder? _rWeb;
  final _ResponsivePlatformBuilder? _rMaterial;
  final bool _responsive;

  const PlatformBuilder({
    Key? key,
    required _PlatformBuilder material,
    _PlatformBuilder? cupertino,
    _PlatformBuilder? web,
  })  : _cupertino = cupertino,
        _web = web,
        _material = material,
        _rCupertino = null,
        _rMaterial = null,
        _rWeb = null,
        _responsive = false,
        super(key: key);

  const PlatformBuilder.responsive({
    Key? key,
    required _ResponsivePlatformBuilder material,
    _ResponsivePlatformBuilder? cupertino,
    _ResponsivePlatformBuilder? web,
  })  : _cupertino = null,
        _web = null,
        _material = null,
        _rCupertino = cupertino,
        _rMaterial = material,
        _rWeb = web,
        _responsive = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (UniversalPlatform.isWeb)
      return !_responsive
          ? _web?.call(context) ?? _material?.call(context) ?? _kDefault
          : ResponsiveWidget(
              builder: (q, c) =>
                  _rWeb?.call(q, c) ?? _rMaterial?.call(q, c) ?? _kDefault,
            );

    if (UniversalPlatform.isIOS || UniversalPlatform.isMacOS)
      return !_responsive
          ? _cupertino?.call(context) ?? _material?.call(context) ?? _kDefault
          : ResponsiveWidget(
              builder: (q, c) =>
                  _rCupertino?.call(q, c) ??
                  _rMaterial?.call(q, c) ??
                  _kDefault,
            );

    return !_responsive
        ? _material?.call(context) ?? _kDefault
        : ResponsiveWidget(
            builder: (q, c) => _rMaterial?.call(q, c) ?? _kDefault,
          );
  }
}
