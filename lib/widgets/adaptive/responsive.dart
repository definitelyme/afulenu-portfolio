part of './platform_builder.dart';

typedef _ResponsiveWidget = Widget Function(
    QueryContext, WidgetRenderConfiguration);

enum BreakpointDirection { asc, desc }

/// A stateless widget to render Responsive.
class ResponsiveWidget extends StatelessWidget {
  final _ResponsiveWidget? builder;
  final Widget? desktop;
  final Widget? mobile;
  final Widget? small;
  final Widget? tablet;
  final bool? useStrict;

  const ResponsiveWidget({
    Key? key,
    Widget? smallMobile,
    this.mobile,
    this.tablet,
    this.desktop,
    this.builder,
    this.useStrict,
  })  : small = smallMobile ?? mobile,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final config = WidgetRenderConfiguration(MediaQuery.of(context));
    final responsive = QueryContext(
      context: context,
      boxConfig: config,
      desktop: desktop != null,
      tablet: tablet != null,
      mobile: mobile != null,
      isStrict: useStrict,
    );

    return responsive.fold(
      isSmallMobile: small ?? layoutBuilder(builder, responsive, config),
      isMobile: mobile ?? layoutBuilder(builder, responsive, config),
      isTablet: tablet ?? layoutBuilder(builder, responsive, config),
      isDesktop: desktop ?? layoutBuilder(builder, responsive, config),
      orElse: layoutBuilder(builder, responsive, config),
    );
  }

  Widget layoutBuilder(
    _ResponsiveWidget? builder,
    QueryContext responsive,
    WidgetRenderConfiguration config,
  ) {
    if (builder != null)
      return LayoutBuilder(
        builder: (context, constraints) => builder.call(
          responsive,
          config.copyWith(constraints: constraints),
        ),
      );
    else
      return const SizedBox.shrink();
  }
}

class QueryContext {
  static const double _kDefaultHeight = 850;
  static const double _kMobileBreakPoint = 850;
  // static const Widget _kReplacement = SizedBox.shrink();
  static const double _kSmallMobileBreakPoint = 450;
  static const double _kTabletBreakPoint = 1100;

  final BuildContext __context;
  final WidgetRenderConfiguration? _config;
  // final bool _desktop;
  // final bool? _isStrict;
  // final bool _mobile;
  // final bool _smallMobile;

  // final bool _tablet;

  const QueryContext({
    required BuildContext context,
    WidgetRenderConfiguration? boxConfig,
    bool smallMobile = true,
    bool mobile = true,
    bool tablet = false,
    bool desktop = false,
    bool? isStrict,
  })  : __context = context,
        _config = boxConfig;
  // _smallMobile = smallMobile,
  // _mobile = mobile,
  // _tablet = tablet,
  // _desktop = desktop,
  // _isStrict = isStrict ?? true;

  BuildContext get context => __context;

  Size breakpoint(BuildContext context) {
    return fold(
      isSmallMobile: const Size(_kSmallMobileBreakPoint, _kDefaultHeight),
      isMobile: const Size(_kMobileBreakPoint, _kDefaultHeight),
      isTablet: const Size(_kMobileBreakPoint + 300, _kDefaultHeight),
      isDesktop: const Size(_kTabletBreakPoint + 300, _kDefaultHeight),
      orElse: const Size(_kMobileBreakPoint, _kDefaultHeight),
    );
  }
}

class WidgetRenderConfiguration {
  final MediaQueryData _mediaQuery;

  final BoxConstraints? constraints;

  WidgetRenderConfiguration(
    this._mediaQuery, {
    this.constraints,
  });

  double get aspectRatio => _mediaQuery.size.aspectRatio;
  Size get flipped => _mediaQuery.size.flipped;
  double get height => _mediaQuery.size.height;
  double get longest => _mediaQuery.size.longestSide;
  double get shortest => _mediaQuery.size.shortestSide;
  double get width => _mediaQuery.size.width;

  WidgetRenderConfiguration copyWith({
    BoxConstraints? constraints,
  }) =>
      WidgetRenderConfiguration(
        _mediaQuery,
        constraints: constraints ?? this.constraints,
      );
}

extension XQueryContext on QueryContext {
  /// Small mobile breadkpoint [_kSmallMobileBreakPoint = 450]
  ///
  /// Mobile breadkpoint [_kMobileBreakPoint = 850]
  ///
  /// Tablet breakpoint [_kTabletBreakPoint = 1100]
  T fold<T>({
    T? isSmallMobile,
    T? isMobile,
    T? isTablet,
    T? isDesktop,
    required T orElse,
  }) {
    if (_isDesktop(context))
      return isDesktop ?? orElse;
    //
    else if (_isTablet(context))
      return isTablet ?? isDesktop ?? orElse;
    //
    else if (_isMobile(context))
      return isMobile ?? isTablet ?? orElse;
    //
    else
      return isSmallMobile ?? isMobile ?? orElse;
  }

  T rangeOf<T>({
    T? s320,
    T? s320e450,
    T? s451e550,
    T? s551e650,
    T? s651e750,
    T? s751e850,
    T? s851e950,
    T? s951e1100,
    T? s1101e1300,
    T? e1300,
    required T orElse,
  }) {
    if (_config == null) return orElse;

    if (_config!.width < 320) {
      if (s320 != null) return s320;
      return s320e450 ?? orElse;
    }
    if (_config!.width >= 320 && _config!.width <= 450) {
      if (s320e450 != null) return s320e450;
      return s451e550 ?? orElse;
    }
    if (_config!.width >= 451 && _config!.width <= 550) {
      if (s451e550 != null) return s451e550;
      return s551e650 ?? orElse;
    }
    if (_config!.width >= 551 && _config!.width <= 650) {
      if (s551e650 != null) return s551e650;
      return s651e750 ?? orElse;
    }
    if (_config!.width >= 651 && _config!.width <= 750) {
      if (s651e750 != null) return s651e750;
      return s751e850 ?? orElse;
    }
    if (_config!.width >= 751 && _config!.width <= 850) {
      if (s751e850 != null) return s751e850;
      return s851e950 ?? orElse;
    }
    if (_config!.width >= 851 && _config!.width <= 950) {
      if (s851e950 != null) return s851e950;
      return s951e1100 ?? orElse;
    }
    if (_config!.width >= 951 && _config!.width <= 1100) {
      if (s951e1100 != null) return s951e1100;
      return s1101e1300 ?? orElse;
    }
    if (_config!.width >= 1101 && _config!.width <= 1300) {
      if (s1101e1300 != null) return s1101e1300;
      return e1300 ?? orElse;
    }

    if (_config!.width >= 1300) return e1300 ?? orElse;

    return orElse;
  }

  T computeOnEach<T extends num>(
    T Function() callback, {
    required num kconst,
    BreakpointDirection direction = BreakpointDirection.desc,
  }) {
    switch (direction) {
      case BreakpointDirection.asc:
        return rangeOf(
          s320: kconst,
          orElse: 0,
        ) as T;
      case BreakpointDirection.desc:
      default:
        break;
    }

    return 0 as T;
  }

  static bool _isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < QueryContext._kMobileBreakPoint &&
      MediaQuery.of(context).size.width > QueryContext._kSmallMobileBreakPoint;

  static bool _isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= QueryContext._kMobileBreakPoint &&
      MediaQuery.of(context).size.width < QueryContext._kTabletBreakPoint;

  static bool _isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= QueryContext._kTabletBreakPoint;
}
