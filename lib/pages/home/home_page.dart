import 'dart:io' show Platform;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:mobile_app_skeleton/pages/home/page_navigator.dart';
import 'package:mobile_app_skeleton/pages/home/widgets/page_navigation_animation.dart';
import 'package:mobile_app_skeleton/pages/home/widgets/bottom_nav_bar.dart';
import 'package:mobile_app_skeleton/pages/home/widgets/side_nav_bar.dart';

/// The [HomePage] displays all general UI elements like the bottom nav-menu and
/// handles the switching between the different pages.
class HomePage extends StatefulWidget {
  final GlobalKey<NavigatorState> mainNavigatorKey;

  const HomePage({super.key, required this.mainNavigatorKey});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  /// Creates a [GlobalKey] for each page that should be accessable within the bottom nav-menu
  Map<PageItem, GlobalKey<NavigatorState>> navigatorKeys = {
    PageItem.page1: GlobalKey<NavigatorState>(),
    PageItem.page2: GlobalKey<NavigatorState>(),
    PageItem.page3: GlobalKey<NavigatorState>(),
    PageItem.page4: GlobalKey<NavigatorState>(),
    PageItem.page5: GlobalKey<NavigatorState>(),
    PageItem.page6: GlobalKey<NavigatorState>(),
  };

  /// Creates two [GlobalKey] for each page in order to control the exit- and
  /// entry-animation from outside the page
  Map<PageItem, GlobalKey<AnimatedExitState>> exitAnimationKeys = {
    PageItem.page1: GlobalKey<AnimatedExitState>(),
    PageItem.page2: GlobalKey<AnimatedExitState>(),
    PageItem.page3: GlobalKey<AnimatedExitState>(),
    PageItem.page4: GlobalKey<AnimatedExitState>(),
    PageItem.page5: GlobalKey<AnimatedExitState>(),
    PageItem.page6: GlobalKey<AnimatedExitState>(),
  };
  Map<PageItem, GlobalKey<AnimatedEntryState>> entryAnimationKeys = {
    PageItem.page1: GlobalKey<AnimatedEntryState>(),
    PageItem.page2: GlobalKey<AnimatedEntryState>(),
    PageItem.page3: GlobalKey<AnimatedEntryState>(),
    PageItem.page4: GlobalKey<AnimatedEntryState>(),
    PageItem.page5: GlobalKey<AnimatedEntryState>(),
    PageItem.page6: GlobalKey<AnimatedEntryState>(),
  };

  final SystemUiOverlayStyle lightSystemUiStyle = const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light, // iOS
    statusBarColor: Colors.white, // Android
    statusBarIconBrightness: Brightness.dark, // Android
    systemNavigationBarColor: Colors.white, // Android
    systemNavigationBarIconBrightness: Brightness.dark, // Android
  );
  final SystemUiOverlayStyle darkSystemUiStyle = const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark, // iOS
    statusBarColor: Color.fromRGBO(14, 20, 32, 1), // Android
    statusBarIconBrightness: Brightness.light, // Android
    systemNavigationBarColor: Color.fromRGBO(17, 25, 38, 1), // Android
    systemNavigationBarIconBrightness: Brightness.light, // Android
  );
  final SystemUiOverlayStyle lightTabletSystemUiStyle =
      const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.light, // iOS
    statusBarColor: Color.fromRGBO(245, 246, 250, 1), // Android
    statusBarIconBrightness: Brightness.dark, // Android
    systemNavigationBarColor: Color.fromRGBO(245, 246, 250, 1), // Android
    systemNavigationBarIconBrightness: Brightness.dark, // Android
  );
  final SystemUiOverlayStyle darkTabletSystemUiStyle =
      const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark, // iOS
    statusBarColor: Color.fromRGBO(17, 25, 38, 1), // Android
    statusBarIconBrightness: Brightness.light, // Android
    systemNavigationBarColor: Color.fromRGBO(17, 25, 38, 1), // Android
    systemNavigationBarIconBrightness: Brightness.light, // Android
  );

  /// Holds the currently active page.
  PageItem currentPage = PageItem.page1;

  /// Controls the Page View
  final PageController pageController = PageController();
  double pagePosition = 0;

  /// Indicates whether swiping is disabled
  bool swipeDisabled = false;

  /// Temporarily disable swiping for certain pages e.g. in app web view
  void setSwipeDisabled({bool disableSwipe = false}) {
    setState(() {
      swipeDisabled = disableSwipe;
    });
  }

  /// Switches to another page when selected in the nav-menu on phones
  Future<bool> selectedPage(PageItem selectedPageItem) async {
    if (selectedPageItem == currentPage) return true;

    // Phone Layout
    if (MediaQuery.of(context).size.shortestSide < 600) {
      // Get all pages as list and find the corresponding element
      final List<PageItem> pages = navigatorKeys.keys.toList();
      final int indexNewPage =
          pages.indexWhere((element) => element == selectedPageItem);

      // Switch to the selected page
      await pageController.animateToPage(
        indexNewPage,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );

      // Tablet Layout
    } else {
      // Reset the exit animation of the new page to make the content visible again
      exitAnimationKeys[selectedPageItem]?.currentState?.resetExitAnimation();
      // Start the exit animation of the old page
      await exitAnimationKeys[currentPage]?.currentState?.startExitAnimation();
      // Switch to the new page
      setState(() => currentPage = selectedPageItem);
      // Start the entry animation of the new page
      await entryAnimationKeys[selectedPageItem]
          ?.currentState
          ?.startEntryAnimation();
    }

    // Enable swiping upon navigation
    setSwipeDisabled();

    return true;
  }

  /// Returns the [NavBarNavigator] for the specified PageItem on phones
  Widget buildNavigator(PageItem tabItem) {
    return NavBarNavigator(
      mainNavigatorKey: widget.mainNavigatorKey,
      navigatorKey: navigatorKeys[tabItem]!,
      pageItem: tabItem,
      pageEntryAnimationKey: entryAnimationKeys[tabItem]!,
      pageExitAnimationKey: exitAnimationKeys[tabItem]!,
    );
  }

  /// Wraps the [NavBarNavigator] that holds the displayed page in an [Offstage] widget
  /// in order to stack them and show only the active page.
  /// Only used for tablets.
  Widget buildOffstateNavigator(PageItem tabItem) {
    return Offstage(
      offstage: currentPage != tabItem,
      child: NavBarNavigator(
        mainNavigatorKey: widget.mainNavigatorKey,
        navigatorKey: navigatorKeys[tabItem]!,
        pageItem: tabItem,
        pageEntryAnimationKey: entryAnimationKeys[tabItem]!,
        pageExitAnimationKey: exitAnimationKeys[tabItem]!,
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    pageController.addListener(() {
      setState(() => pagePosition = pageController.page ?? 0);
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPhone = MediaQuery.of(context).size.shortestSide < 600;
    final isLight = theme.brightness == Brightness.light;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isPhone
          ? (isLight ? lightSystemUiStyle : darkSystemUiStyle)
          : (isLight ? lightTabletSystemUiStyle : darkTabletSystemUiStyle),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, _) {
          if (didPop) return;
          final nav = navigatorKeys[currentPage]?.currentState;
          if (nav == null) return;
          unawaited(nav.maybePop());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: theme.colorScheme.surface,
          body: isPhone
              // Phone layout
              ? SafeArea(
                  bottom: false,
                  child: Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: Platform.isIOS ? 80 : 60),
                        child: PageView.builder(
                          physics: swipeDisabled
                              ? const NeverScrollableScrollPhysics()
                              : const ScrollPhysics(),
                          controller: pageController,
                          itemCount: navigatorKeys.length,
                          onPageChanged: (page) {
                            final List<PageItem> pages =
                                navigatorKeys.keys.toList();

                            // Find new PageItem and assign newPage the old value in case no element is found
                            final PageItem newPage = pages[page];

                            // Set newPage as the currentPage
                            if (newPage != currentPage) {
                              setState(() => currentPage = newPage);
                            }
                          },
                          itemBuilder: (context, index) {
                            return AnimatedOpacity(
                              opacity: pagePosition - index < 0
                                  // Navigate left -> blend out the right page
                                  ? pagePosition - index + 1 >= 0.9
                                      ? 1
                                      : pagePosition - index + 1 <= 0.1
                                          ? 0
                                          : pagePosition - index + 1
                                  // Navigate right -> blend out the left page
                                  : (1 - (pagePosition - index)) >= 0.9
                                      ? 1
                                      : 1 - (pagePosition - index) <= 0.1
                                          ? 0
                                          : 1 - (pagePosition - index),
                              duration: const Duration(milliseconds: 100),
                              child: buildNavigator(
                                navigatorKeys.keys.toList()[index],
                              ),
                            );
                          },
                        ),
                      ),
                      // BottomNavigationBar
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BottomNavBar(
                          currentPage: currentPage,
                          onSelectedPage: selectedPage,
                        ),
                      ),
                    ],
                  ),
                )
              // Tablet layout
              : SafeArea(
                  child: Container(
                    color: isLight
                        ? const Color.fromRGBO(245, 246, 250, 1)
                        : theme.cardColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          height: 20,
                          color: isLight
                              ? const Color.fromRGBO(245, 246, 250, 1)
                              : theme.cardColor,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              SideNavBar(
                                currentPage: currentPage,
                                onSelectedPage: selectedPage,
                              ),
                              // Pages
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: theme.colorScheme.surface,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Center(
                                    child: SizedBox(
                                      width: currentPage != PageItem.page3
                                          ? 550
                                          : null,
                                      child: Stack(
                                        children: [
                                          buildOffstateNavigator(
                                            PageItem.page1,
                                          ),
                                          buildOffstateNavigator(
                                            PageItem.page2,
                                          ),
                                          buildOffstateNavigator(
                                            PageItem.page3,
                                          ),
                                          buildOffstateNavigator(
                                            PageItem.page4,
                                          ),
                                          buildOffstateNavigator(
                                            PageItem.page5,
                                          ),
                                          buildOffstateNavigator(
                                            PageItem.page6,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              // Detail space
                              Container(
                                width: 20,
                                color: isLight
                                    ? const Color.fromRGBO(245, 246, 250, 1)
                                    : theme.cardColor,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 20,
                          color: isLight
                              ? const Color.fromRGBO(245, 246, 250, 1)
                              : theme.cardColor,
                        ),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
