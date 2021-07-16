import 'package:flutter/foundation.dart';
import 'package:universal_platform/universal_platform.dart';

extension PlatformX on TargetPlatform {
  T fold<T>({
    T Function()? cupertino,
    required T Function() material,
  }) {
    if (UniversalPlatform.isIOS || UniversalPlatform.isMacOS)
      return cupertino?.call() ?? material.call();
    else
      return material.call();
  }
}
