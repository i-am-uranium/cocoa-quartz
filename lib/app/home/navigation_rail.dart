import 'package:flutter/material.dart';

import '../../constants/constant.dart';
import '../common/common.dart';
import '../common/logo.dart';

class MainNavigationRail extends StatelessWidget {
  const MainNavigationRail({
    this.selectedIndex = 0,
    this.onDestinationClick,
    Key key,
  }) : super(key: key);
  final int selectedIndex;
  final ValueChanged<int> onDestinationClick;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 88,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: AppColors.mainBG,
        boxShadow: [
          BoxShadow(
            offset: const Offset(10, 0),
            color: AppColors.navigationRailShadow,
            blurRadius: 50,
          ),
        ],
      ),
      child: Column(
        children: [
          const VerticalSpacer(),
          Padding(
            padding: const EdgeInsets.all(8),
            child: AppLogo(
              width: 40,
              height: 40,
              shadowColor: AppColors.navigationRailShadow,
              bgColor: AppColors.navigationRailShadow,
            ),
          ),
          const VerticalSpacer(
            space: 64,
          ),
          Expanded(
            child: NavigationRail(
              backgroundColor: AppColors.mainBG,
              minWidth: 64,
              selectedIndex: selectedIndex,
              onDestinationSelected: onDestinationClick,
              destinations: const [
                NavigationRailDestination(
                  label: Text(Strings.home),
                  icon: NavigationItem(
                    asset: Assets.homePng,
                  ),
                  selectedIcon: NavigationItem(
                    asset: Assets.homePng,
                    selected: true,
                  ),
                ),
                NavigationRailDestination(
                  label: Text(Strings.explore),
                  icon: NavigationItem(
                    asset: Assets.explorePng,
                  ),
                  selectedIcon: NavigationItem(
                    asset: Assets.explorePng,
                    selected: true,
                  ),
                ),
                NavigationRailDestination(
                  label: Text(Strings.timeline),
                  icon: NavigationItem(
                    asset: Assets.timelinePng,
                  ),
                  selectedIcon: NavigationItem(
                    asset: Assets.timelinePng,
                    selected: true,
                  ),
                ),
                NavigationRailDestination(
                  label: Text(Strings.preference),
                  icon: NavigationItem(
                    asset: Assets.preferencesPng,
                  ),
                  selectedIcon: NavigationItem(
                    asset: Assets.preferencesPng,
                    selected: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem extends StatelessWidget {
  const NavigationItem({
    @required this.asset,
    this.width = 32,
    this.height = 32,
    this.selected = false,
    Key key,
  }) : super(key: key);
  final double width;
  final double height;
  final bool selected;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      color: selected ? AppColors.black : AppColors.navigationRailButton,
    );
  }
}
