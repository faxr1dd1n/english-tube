import 'package:en_tube/src/ui/menu/home/home_screen.dart';
import 'package:en_tube/src/ui/menu/learn/learn_screen.dart';
import 'package:en_tube/src/ui/menu/mentors/mentors_screen.dart';
import 'package:en_tube/src/ui/menu/profile/profile_screen.dart';
import 'package:en_tube/src/ui/menu/progress/progress_screen.dart';
import 'package:flutter/material.dart';

enum NavItemEnum {
  home,
  category,
  basket,
  favorite,
  profile;

  bool get isHome => this == NavItemEnum.home;
  bool get isCategory => this == NavItemEnum.category;
  bool get isBasket => this == NavItemEnum.basket;
  bool get isFavorite => this == NavItemEnum.favorite;
  bool get isProfile => this == NavItemEnum.profile;
}

class TabNavigator extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  final NavItemEnum tabItem;

  const TabNavigator({
    required this.tabItem,
    required this.navigatorKey,
    super.key,
  });

  @override
  State<TabNavigator> createState() => _TabNavigatorState();
}

class _TabNavigatorState extends State<TabNavigator>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Navigator(
      key: widget.navigatorKey,
      initialRoute: '/',
      onGenerateRoute: (routeSettings) {
        final routeBuilders = _routeBuilders(
          context: context,
          routeSettings: routeSettings,
        );
        return MaterialPageRoute(
          builder: (context) => routeBuilders[routeSettings.name]!(context),
        );
      },
    );
  }

  Map<String, WidgetBuilder> _routeBuilders({
    required BuildContext context,
    required RouteSettings routeSettings,
  }) {
    final tabItem = widget.tabItem;
    if (tabItem.isHome) {
      return {'/': (context) => const HomeScreen()};
    }
    if (tabItem.isCategory) {
      return {'/': (context) => const MentorsScreen()};
    }
    if (tabItem.isBasket) {
      return {'/': (context) => const LearnScreen()};
    }
    if (tabItem.isFavorite) {
      return {'/': (context) => const ProgressScreen()};
    }
    if (tabItem.isProfile) {
      return {'/': (context) => const ProfileScreen()};
    }
    return {};
  }

  @override
  bool get wantKeepAlive => true;
}
