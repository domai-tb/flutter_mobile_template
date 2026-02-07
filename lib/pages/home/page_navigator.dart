import 'package:flutter/material.dart';

import 'package:mobile_app_skeleton/pages/home/widgets/page_navigation_animation.dart';
import 'package:mobile_app_skeleton/pages/page1/page1_page.dart';
import 'package:mobile_app_skeleton/pages/page2/page2_page.dart';
import 'package:mobile_app_skeleton/pages/page3/page3_page.dart';
import 'package:mobile_app_skeleton/pages/page4/page4_page.dart';
import 'package:mobile_app_skeleton/pages/page5/page5_page.dart';
import 'package:mobile_app_skeleton/pages/page6/page6_page.dart';

enum PageItem { page1, page2, page3, page4, page5, page6 }

class PageNavigatorRoutes {
  /// The root-page is shown initially when this navbar-tab is the active one.
  static const String root = '/';

  /// The detail-page is pushed onto the navigator-stack of this specific tab when,
  /// for example, a news-article is opened.
  static const String detail = '/detail';
}

/// Wraps the displayed page into a seperate [Navigator] in order to push new detail-pages
/// (like opening a news-article) to a specific navigator-stack instead of the app-wide navigator-stack.
///
/// This also allows to constantly show the bottom navigation bar across multiple pages, even during transitions.
class NavBarNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState> mainNavigatorKey;

  final GlobalKey<NavigatorState> navigatorKey;

  /// Determines the type of the page in order to set the navigator correctly.
  final PageItem pageItem;

  /// Passes the animation key for the entry animation to the referenced page
  /// to control the animation from outside the page.
  final GlobalKey<AnimatedEntryState> pageEntryAnimationKey;

  /// Passes the animation key for the exit animation to the referenced page
  /// to control the animation from outside the page.
  final GlobalKey<AnimatedExitState> pageExitAnimationKey;

  const NavBarNavigator({
    super.key,
    required this.mainNavigatorKey,
    required this.navigatorKey,
    required this.pageItem,
    required this.pageEntryAnimationKey,
    required this.pageExitAnimationKey,
  });

  /// Creates a map of the root and detail page of the specific page.
  Map<String, WidgetBuilder> _routeBuilders(BuildContext context) {
    Widget rootPage;
    switch (pageItem) {
      case PageItem.page1:
        rootPage = Page1Page(
          mainNavigatorKey: mainNavigatorKey,
          pageEntryAnimationKey: pageEntryAnimationKey,
          pageExitAnimationKey: pageExitAnimationKey,
        );
        break;
      case PageItem.page2:
        rootPage = Page2Page(
          mainNavigatorKey: mainNavigatorKey,
          pageEntryAnimationKey: pageEntryAnimationKey,
          pageExitAnimationKey: pageExitAnimationKey,
        );
        break;
      case PageItem.page4:
        rootPage = Page4Page(
          mainNavigatorKey: mainNavigatorKey,
          pageEntryAnimationKey: pageEntryAnimationKey,
          pageExitAnimationKey: pageExitAnimationKey,
        );
        break;
      case PageItem.page3:
        rootPage = Page3Page(
          pageEntryAnimationKey: pageEntryAnimationKey,
          pageExitAnimationKey: pageExitAnimationKey,
        );
        break;
      case PageItem.page5:
        rootPage = Page5Page(
          pageEntryAnimationKey: pageEntryAnimationKey,
          pageExitAnimationKey: pageExitAnimationKey,
        );
        break;
      case PageItem.page6:
        rootPage = Page6Page(
          mainNavigatorKey: mainNavigatorKey,
          pageEntryAnimationKey: pageEntryAnimationKey,
          pageExitAnimationKey: pageExitAnimationKey,
        );
        break;
    }
    return {
      PageNavigatorRoutes.root: (context) => rootPage,
      //TabNavigatorRoutes.detail: (context) => ,
    };
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, WidgetBuilder> routeBuilders = _routeBuilders(context);

    return Navigator(
      key: navigatorKey,
      initialRoute: PageNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }
}
