import 'package:auto_route/annotations.dart';
import 'package:portfolio/features/home/presentation/pages/export.dart';
import 'package:portfolio/features/home/presentation/roots/home_root_router.dart';
import 'package:portfolio/features/home/presentation/screens/export.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Screen,Route',
  preferRelativeImports: false,
  routes: <AutoRoute<dynamic>>[
    AutoRoute(
      initial: true,
      path: '/',
      maintainState: true,
      page: HomeRootRouter,
      children: [
        AutoRoute(
          path: '',
          fullMatch: true,
          page: HomeScreen,
          maintainState: true,
        ),
        //
        AutoRoute(
          path: 'portfolio',
          fullMatch: true,
          page: PortfolioScreen,
          maintainState: true,
        ),
        //
        AutoRoute(
          path: 'my-resume',
          fullMatch: true,
          page: ResumeScreen,
          maintainState: true,
        ),
        //
        AutoRoute(
          path: 'talk-to-me',
          fullMatch: true,
          page: ContactMeScreen,
          maintainState: true,
        ),
        //
        AutoRoute(
          path: 'summary',
          fullMatch: true,
          page: AboutMeScreen,
          maintainState: true,
        ),
        //
        RedirectRoute(path: '*', redirectTo: ''),
      ],
    ),
    //
    RedirectRoute(path: '*', redirectTo: '/')
  ],
)
class $AppRouter {}
