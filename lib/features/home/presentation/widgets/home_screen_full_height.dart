import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/manager/theme/theme.dart';
import 'package:portfolio/widgets/widgets.dart';
import 'package:portfolio/utils/utils.dart';

/// A stateless widget to render HomeScreenFullHeight.
class HomeScreenFullHeight extends StatelessWidget {
  const HomeScreenFullHeight({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget(
      builder: (query, _) => SizedBox(
        height: query.fold(orElse: 0.9.sh, isDesktop: 0.8.sh),
        width: double.infinity,
        child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceAround,
          runAlignment: WrapAlignment.center,
          runSpacing: 40,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: query.fold(
                  isMobile: 0.8.sw,
                  isTablet: 0.4.sw,
                  orElse: 0.35.sw,
                ),
              ),
              child: Align(
                alignment: query.fold(
                  isMobile: Alignment.center,
                  orElse: Alignment.centerRight,
                ),
                child: Hero(
                  tag: HeroTag.kProfilePhotoHeroTag,
                  child: Material(
                    elevation: 6,
                    borderRadius:
                        const BorderRadius.all(Radius.circular(5000.0)),
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: CircleAvatar(
                        maxRadius: query.fold(
                            isMobile: 145, isTablet: 140, orElse: 180),
                        minRadius: query.fold(
                            isMobile: 130, isTablet: 120, orElse: 160),
                        backgroundImage: const ExactAssetImage(AppAssets.cesar),
                        backgroundColor: Colors.transparent,
                        child: const SizedBox(
                          height: double.infinity,
                          width: double.infinity,
                          child: Visibility(
                            visible: false,
                            child: Material(
                              shape: CircleBorder(),
                              clipBehavior: Clip.hardEdge,
                              color: AppColors.accentColor,
                              child: Center(
                                child: AutoSizeText.selectable('VN'),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //
            ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: query.fold(isMobile: 1.sw, orElse: 0.45.sw),
                minWidth: query.fold(isMobile: 0.5.sw, orElse: 0.1.sw),
              ),
              child: Align(
                alignment: query.fold(
                  isMobile: Alignment.center,
                  orElse: Alignment.centerLeft,
                ),
                child: Column(
                  crossAxisAlignment: query.fold(
                    isMobile: CrossAxisAlignment.center,
                    orElse: CrossAxisAlignment.start,
                  ),
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const AutoSizeText.selectable(
                      'Frontend developer',
                      style: TextStyle(color: Colors.grey),
                    ),
                    //
                    VerticalSpace(height: 0.008.sh),
                    //
                    AutoSizeText.selectable(
                      'Vivian Nwasike',
                      maxLines: 1,
                      style: Theme.of(context).textTheme.headline3!.copyWith(
                            color: Helpers.foldTheme(
                              context: context,
                              light: () => const Color(0xff333333),
                              dark: () => Colors.white,
                            ),
                            fontWeight: FontWeight.bold,
                            // fontStyle: FontStyle.normal,
                          ),
                    ),
                    //
                    VerticalSpace(height: 0.02.sh),
                    //
                    ResponsiveWidget(
                      builder: (q, config) => ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: q.fold(
                            isTablet: double.infinity,
                            isDesktop: config.constraints!.maxWidth * 0.82,
                            orElse: double.infinity,
                          ),
                        ),
                        child: Padding(
                          padding: query.fold(
                            isMobile:
                                EdgeInsets.symmetric(horizontal: 0.035.sw),
                            orElse: EdgeInsets.zero,
                          ),
                          child: const AutoSizeText.selectable(
                            'Fusce tempor magna mi, non egestas velit ultricies nec. '
                            'Aenean convallis, risus non condimentum gravida, odio mauris ullamcorper '
                            'felis, ut venenatis purus ex eu mi. Quisque imperdiet '
                            'lacinia urna, a placerat sapien pretium eu.',
                            maxLines: 4,
                            textAlign: TextAlign.justify,
                            style: TextStyle(
                              fontSize: 15,
                              fontStyle: FontStyle.normal,
                              height: 1.3,
                            ),
                          ),
                        ),
                      ),
                    ),
                    //
                    VerticalSpace(height: 0.025.sh),
                    //
                    BlocBuilder<ThemeCubit, AppTheme>(
                      builder: (context, state) => Wrap(
                        spacing: 10,
                        children: [
                          AppButton(
                            onPressed: () {},
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            textColor: Helpers.computeLuminance(
                              Theme.of(context).scaffoldBackgroundColor,
                            ),
                            shape: const RoundedRectangleBorder(
                              side: BorderSide(
                                color: AppColors.accentColor,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                            onHover: (prev) => prev.copyWith(
                              backgroundColor: AppColors.accentColor,
                              textStyle: const TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                              ),
                            ),
                            onHoverExit: (prev) => prev,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 3.0,
                            height: 40,
                            width: 150,
                            fontSize: 14.0,
                            text: 'Download CV',
                          ),
                          //
                          AppButton(
                            onPressed: () {},
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            textColor: Helpers.foldTheme(
                              light: () => Colors.black,
                              dark: () => Colors.white,
                            ),
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: Helpers.foldTheme(
                                  light: () => Colors.grey.shade300,
                                  dark: () => Colors.grey.shade700,
                                )!,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(100.0),
                              ),
                            ),
                            onHover: (prev) => prev.copyWith(
                              backgroundColor: Helpers.foldTheme(
                                light: () => Colors.grey.shade300,
                                dark: () => Colors.grey.shade700,
                              )!,
                            ),
                            onHoverExit: (prev) => prev,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            elevation: 3.0,
                            height: 40,
                            width: 120,
                            fontSize: 14.0,
                            text: 'Contact',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
