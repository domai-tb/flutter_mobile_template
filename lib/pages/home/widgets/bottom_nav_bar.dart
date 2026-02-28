import 'dart:io' show Platform;

import 'package:flutter/material.dart';

import 'package:mobile_app_skeleton/pages/home/page_navigator.dart';
import 'package:mobile_app_skeleton/pages/home/widgets/bottom_nav_bar_item.dart';
import 'package:mobile_app_skeleton/l10n/l10n_x.dart';

/// Creates the bottom navigation bar that lets the user switch between different pages.
class BottomNavBar extends StatefulWidget {
  /// Needs the currently active page in order to highlight it
  final PageItem currentPage;

  /// Calls this function when an item of the navigation bar is selected.
  final Function(PageItem) onSelectedPage;

  const BottomNavBar({
    super.key,
    required this.currentPage,
    required this.onSelectedPage,
  });

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: Platform.isIOS ? 88 : 98,
      padding: Platform.isIOS
          ? const EdgeInsets.only(bottom: 20, left: 5)
          : const EdgeInsets.only(left: 7),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(15),
          topRight: Radius.circular(15),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            offset: Offset(0, -1),
          ),
        ],
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Page 1
              BottomNavBarItem(
                title: context.l10n.page1Title,
                activeIcon: Icons.home,
                inactiveIcon: Icons.home_outlined,
                onTap: () => widget.onSelectedPage(PageItem.page1),
                isActive: widget.currentPage == PageItem.page1,
                iconPaddingLeft: 0,
              ),
              // Page 2
              BottomNavBarItem(
                title: context.l10n.page2Title,
                activeIcon: Icons.calendar_month,
                inactiveIcon: Icons.calendar_month_outlined,
                onTap: () => widget.onSelectedPage(PageItem.page2),
                isActive: widget.currentPage == PageItem.page2,
                iconPaddingLeft: 14,
              ),
              BottomNavBarItem(
                title: context.l10n.page3Title,
                activeIcon: Icons.map,
                inactiveIcon: Icons.map_outlined,
                onTap: () => widget.onSelectedPage(PageItem.page3),
                isActive: widget.currentPage == PageItem.page3,
              ),
              // Page 4
              BottomNavBarItem(
                title: context.l10n.page4Title,
                activeIcon: Icons.restaurant,
                inactiveIcon: Icons.restaurant_outlined,
                onTap: () => widget.onSelectedPage(PageItem.page4),
                isActive: widget.currentPage == PageItem.page4,
              ),
              // Page 5
              BottomNavBarItem(
                title: context.l10n.page5Title,
                activeIcon: Icons.account_balance_wallet,
                inactiveIcon: Icons.account_balance_wallet_outlined,
                onTap: () => widget.onSelectedPage(PageItem.page5),
                isActive: widget.currentPage == PageItem.page5,
              ),
              // Page 6
              BottomNavBarItem(
                title: context.l10n.page6Title,
                activeIcon: Icons.more_horiz,
                inactiveIcon: Icons.more_horiz,
                onTap: () => widget.onSelectedPage(PageItem.page6),
                isActive: widget.currentPage == PageItem.page6,
                iconPaddingLeft: 5,
                iconPaddingRight: 0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
