import 'package:flutter/material.dart';

import 'package:mobile_app_skeleton/pages/home/page_navigator.dart';
import 'package:mobile_app_skeleton/pages/home/widgets/side_nav_bar_item.dart';
import 'package:mobile_app_skeleton/l10n/l10n_x.dart';

class SideNavBar extends StatefulWidget {
  /// Needs the currently active page in order to highlight it
  final PageItem currentPage;

  /// Calls this function when an item of the navigation bar is selected.
  final Function(PageItem) onSelectedPage;

  const SideNavBar({
    super.key,
    required this.currentPage,
    required this.onSelectedPage,
  });

  @override
  State<SideNavBar> createState() => _SideNavBarState();
}

class _SideNavBarState extends State<SideNavBar> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;

    return Container(
      width: 80,
      padding: const EdgeInsets.only(top: 40, bottom: 10, left: 15, right: 15),
      decoration: BoxDecoration(
        color:
            isLight ? const Color.fromRGBO(245, 246, 250, 1) : theme.cardColor,
      ),
      child: Column(
        children: [
          // Page 1
          SideNavBarItem(
            title: context.l10n.page1Title,
            activeIcon: Icons.home,
            inactiveIcon: Icons.home_outlined,
            onTap: () => widget.onSelectedPage(PageItem.page1),
            isActive: widget.currentPage == PageItem.page1,
          ),
          // Page 2
          SideNavBarItem(
            title: context.l10n.page2Title,
            activeIcon: Icons.calendar_month,
            inactiveIcon: Icons.calendar_month_outlined,
            onTap: () => widget.onSelectedPage(PageItem.page2),
            isActive: widget.currentPage == PageItem.page2,
          ),
          // Page 3
          SideNavBarItem(
            title: context.l10n.page3Title,
            activeIcon: Icons.map,
            inactiveIcon: Icons.map_outlined,
            onTap: () => widget.onSelectedPage(PageItem.page3),
            isActive: widget.currentPage == PageItem.page3,
          ),
          // Page 4
          SideNavBarItem(
            title: context.l10n.page4Title,
            activeIcon: Icons.restaurant,
            inactiveIcon: Icons.restaurant_outlined,
            onTap: () => widget.onSelectedPage(PageItem.page4),
            isActive: widget.currentPage == PageItem.page4,
          ),
          // Page 5
          SideNavBarItem(
            title: context.l10n.page5Title,
            activeIcon: Icons.account_balance_wallet,
            inactiveIcon: Icons.account_balance_wallet_outlined,
            onTap: () => widget.onSelectedPage(PageItem.page5),
            isActive: widget.currentPage == PageItem.page5,
          ),
          const Expanded(child: SizedBox()),
          // Page 6
          SideNavBarItem(
            title: context.l10n.page6Title,
            activeIcon: Icons.more_horiz,
            inactiveIcon: Icons.more_horiz,
            onTap: () => widget.onSelectedPage(PageItem.page6),
            isActive: widget.currentPage == PageItem.page6,
          ),
        ],
      ),
    );
  }
}
