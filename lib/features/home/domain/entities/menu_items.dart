import 'package:auto_route/auto_route.dart';
import 'package:portfolio/utils/utils.dart';

class MenuItem {
  final String name;
  final PageRouteInfo route;

  const MenuItem(this.name, {required this.route});

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is MenuItem && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;

  @override
  String toString() => 'MenuItem($name)';

  static List<MenuItem> get list => [
        const MenuItem('Home', route: HomeRoute()),
        const MenuItem('About Me', route: AboutMeRoute()),
        const MenuItem('Resume', route: ResumeRoute()),
        const MenuItem('Portfolio', route: PortfolioRoute()),
        const MenuItem('Contact', route: ContactMeRoute()),
      ];
}
