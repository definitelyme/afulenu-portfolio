// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_analytics/firebase_analytics.dart' as _i3;
import 'package:firebase_auth/firebase_auth.dart' as _i5;
import 'package:firebase_core/firebase_core.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:portfolio/manager/locator/modules/modules.dart' as _i8;
import 'package:portfolio/manager/theme/manager/theme_cubit.dart'
    as _i7; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// an extension to register the provided dependencies inside of [GetIt]
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of provided dependencies inside of [GetIt]
  Future<_i1.GetIt> $initGetIt(
      {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
    final gh = _i2.GetItHelper(this, environment, environmentFilter);
    final modules = _$Modules();
    gh.lazySingleton<_i3.FirebaseAnalytics>(() => modules.firebaseAnalytics);
    await gh.factoryAsync<_i4.FirebaseApp>(() => modules.firebaseApp,
        preResolve: true);
    gh.lazySingleton<_i5.FirebaseAuth>(() => modules.firebaseAuth);
    gh.lazySingleton<_i6.GoogleSignIn>(() => modules.googleSignIn);
    gh.factory<_i7.ThemeCubit>(() => _i7.ThemeCubit());
    return this;
  }
}

class _$Modules extends _i8.Modules {}
