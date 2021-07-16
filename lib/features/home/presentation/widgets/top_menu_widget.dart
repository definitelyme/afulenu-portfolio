import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_bloc/flutter_bloc.dart' hide ReadContext;
import 'package:kt_dart/kt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:portfolio/features/home/domain/entities/index.dart';
import 'package:portfolio/features/home/presentation/widgets/side_menu_widget.dart';
import 'package:portfolio/manager/theme/theme.dart';
import 'package:portfolio/widgets/web/interactive_mouse_region.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/utils/utils.dart';

/// A stateless widget to render TopMenuWidget.
class TopMenuWidget extends StatelessWidget {
  static final items = MenuItem.list;

  const TopMenuWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveWidget(
        builder: (query, config) => Container(
          padding: EdgeInsets.symmetric(
            horizontal: query.fold(
              isMobile: 0.04.sw,
              isTablet: 0.05.sw,
              orElse: 0.04.sw,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Hero(
                    tag: HeroTag.kProfilePhotoHeroTag,
                    child: CircleAvatar(
                      maxRadius: 19.0,
                      minRadius: 17.0,
                      backgroundImage: AssetImage(AppAssets.user),
                      backgroundColor: Colors.transparent,
                      child: SizedBox(
                        height: double.infinity,
                        width: double.infinity,
                        child: Visibility(
                          visible: true,
                          child: Material(
                            shape: CircleBorder(),
                            clipBehavior: Clip.hardEdge,
                            color: AppColors.accentColor,
                            child: Center(
                              child: AutoSizeText(
                                'V',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  //
                  HorizontalSpace(width: 0.008.sw),
                  //
                  const SelectableText.rich(
                    TextSpan(children: [
                      TextSpan(
                        text: 'Vivian',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      TextSpan(
                        text: ' Nwasike',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ]),
                    style: TextStyle(fontSize: 16.0),
                  ),
                ],
              ),
              //
              query.fold(
                isMobile: const Center(child: SideMenuIcon()),
                orElse: Expanded(
                  child: FractionallySizedBox(
                    widthFactor: query.fold(
                      isMobile: 0.65,
                      isTablet: 0.7,
                      orElse: 0.55,
                    ),
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: items
                          .toImmutableList()
                          .mapIndexed((i, e) => _NavItem(menu: e))
                          .asList(),
                    ),
                  ),
                ),
              ),
            ],
          ),
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
    return InteractiveMouseRegion(
      onHover: (_) {
        setState(() => isHovering = true);
        return SystemMouseCursors.click;
      },
      onExit: (_) {
        setState(() => isHovering = false);
        return SystemMouseCursors.none;
      },
      child: GestureDetector(
        onTap: () =>
            innerNavigator(context, const HomeRootRouter())
                ?.replace(widget.menu.route) ??
            navigator.replace(widget.menu.route),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder<ThemeCubit, AppTheme>(
            builder: (context, state) {
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
        ),
      ),
    );
  }
}
