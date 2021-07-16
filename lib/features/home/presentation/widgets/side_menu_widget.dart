import 'package:auto_route/auto_route.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/features/home/domain/entities/index.dart';
import 'package:portfolio/features/home/presentation/managers/index.dart';
import 'package:portfolio/manager/theme/theme.dart';
import 'package:portfolio/utils/utils.dart';
import 'package:portfolio/widgets/widgets.dart';

/// A stateless widget to render SideMenuWidget.
class SideMenuWidget extends StatelessWidget with AutoRouteWrapper {
  static final items = MenuItem.list;

  const SideMenuWidget({Key? key}) : super(key: key);

  @override
  Widget wrappedRoute(BuildContext context) {
    return this;
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        controller: ScrollController(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DrawerHeader(
              child: ResponsiveWidget(
                builder: (res, screen) => Image.asset(
                  AppAssets.female,
                  fit: res.fold(
                    isMobile: BoxFit.contain,
                    isTablet: BoxFit.contain,
                    orElse: null,
                  ),
                  width: res.fold(
                    isSmallMobile: screen.width * 0.3,
                    isMobile: res.rangeOf(
                      s751e850: screen.width * 0.15,
                      orElse: screen.width * 0.2,
                    ),
                    isTablet: screen.width * 0.13,
                    orElse: null,
                  ),
                ),
              ),
            ),
            //
            ListView.builder(
              shrinkWrap: true,
              controller: ScrollController(),
              itemCount: items.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (_, i) => _NavItem(menu: items.elementAt(i)),
            ),
            //
            BlocBuilder<ThemeCubit, AppTheme>(
              builder: (c, s) => SwitchListTile.adaptive(
                value: BlocProvider.of<ThemeCubit>(c).isDarkMode,
                dense: true,
                title: AutoSizeText.selectable("${Helpers.foldTheme(
                  light: () => 'Turn on Dark',
                  dark: () => 'Activate Light',
                )} Mode"),
                subtitle: const AutoSizeText.selectable('Toggle appearance'),
                selected: BlocProvider.of<ThemeCubit>(c).isPlatformDarkMode
                    ? !BlocProvider.of<ThemeCubit>(c).isPlatformDarkMode
                    : !BlocProvider.of<ThemeCubit>(c).isDarkMode,
                onChanged: (_) =>
                    BlocProvider.of<ThemeCubit>(context).toggleTheme(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final MenuItem menu;

  const _NavItem({Key? key, required this.menu}) : super(key: key);

  @override
  __NavItemState createState() => __NavItemState();
}

class __NavItemState extends State<_NavItem> {
  bool isHovering = false;

  final kDefaultFontWeight = FontWeight.w600;

  bool get isActiveRoute =>
      App.router.isRouteActive(widget.menu.route.routeName) ||
      (innerNavigator(context, const HomeRootRouter()) != null &&
          innerNavigator(context, const HomeRootRouter())!
              .isRouteActive(widget.menu.route.routeName));

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        innerNavigator(context, const HomeRootRouter())
                ?.replace(widget.menu.route) ??
            navigator.replace(widget.menu.route);

        context.read(drawerProvider.notifier).close(context);
      },
      horizontalTitleGap: 0.0,
      // leading: SvgPicture.asset(
      //   svg,
      //   color: Colors.white54,
      //   height: 16.0,
      // ),
      title: BlocBuilder<ThemeCubit, AppTheme>(
        builder: (c, s) {
          final kDefaultColor = Helpers.foldTheme(
            light: () => Colors.black87,
            dark: () => Colors.grey.shade200,
          );

          return AutoSizeText(
            widget.menu.name,
            style: TextStyle(
              fontSize: isHovering ? 14.5 : 14.0,
              fontWeight: isActiveRoute
                  ? kDefaultFontWeight
                  : isHovering
                      ? kDefaultFontWeight
                      : FontWeight.w500,
              color: isActiveRoute
                  ? kDefaultColor
                  : isHovering
                      ? kDefaultColor
                      : Helpers.foldTheme(
                          light: () => Colors.black54,
                          dark: () => Colors.grey.shade400,
                        ),
            ),
          );
        },
      ),
    );
  }
}

class SideMenuIcon extends StatelessWidget {
  const SideMenuIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(100.0)),
      child: InkWell(
        onTap: context.read(drawerProvider.notifier).open,
        borderRadius: const BorderRadius.all(Radius.circular(100.0)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            Theme.of(context).platform.fold(
                  material: () => Icons.menu,
                  cupertino: () => CupertinoIcons.money_pound,
                ),
          ),
        ),
      ),
    );
  }
}
