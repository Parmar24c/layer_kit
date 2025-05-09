//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:easy_localization/easy_localization.dart";
import 'package:flutter/material.dart';
import 'package:layer_kit/layer_kit.dart';
import "package:layer_kit_example/config/lang/lang.dart";
import 'package:layer_kit_example/config/theme/app_colors.dart';
import "package:layer_kit_example/di_container.dart";
import 'package:layer_kit_example/src/demo/screens/demo_screen.dart';
import 'package:layer_kit_example/src/home/screens/home_screen.dart';
import 'package:layer_kit_example/src/profile/screens/profile_screen.dart';

import '../config/routes/routes.dart';

class MainScreen extends StatefulWidget with BaseRoute {
  final int? initialIndex;

  const MainScreen({super.key, this.initialIndex});

  @override
  State<MainScreen> createState() => _MainScreenState();

  @override
  Widget get screen => this;

  @override
  Routes get routeName => Routes.appScaffold;
}

enum BottomNavItem {
  home(Icons.home),
  activity(Icons.message),
  profile(Icons.person);

  final IconData icon;

  const BottomNavItem(this.icon);

  BaseRoute get route => switch (this) {
        BottomNavItem.home => HomeScreen() as BaseRoute,
        BottomNavItem.activity => DemoScreen() as BaseRoute,
        BottomNavItem.profile => ProfileScreen() as BaseRoute,
      };

  String get title => switch (this) {
        BottomNavItem.home => "home".tr(),
        BottomNavItem.activity => "demo".tr(),
        BottomNavItem.profile => "profile".tr(),
      };
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  late final PageController pctr;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex ?? 0;
    pctr = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Txt.appbar(
            "${BottomNavItem.values[currentIndex].title} ${"screen".tr()}"),
        actions: [
          IconButton(
              onPressed: () {
                if (context.locale == Locl.en.locale) {
                  context.setLocale(Locl.de.locale);
                } else {
                  context.setLocale(Locl.en.locale);
                }
              },
              icon: Icon(Icons.language)),
          IconButton(
              onPressed: () {
                context.themeProvider.toggleTheme();
              },
              icon: Icon(Icons.brightness_4_outlined))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: BottomNavItem.values
            .map((e) => BottomNavigationBarItem(
                  icon: Icon(
                    e.icon,
                    color: currentIndex == e.index
                        ? context.colors.primary
                        : context.colors.black,
                  ),
                  label: e.title,
                ))
            .toList(),
        unselectedItemColor: context.colors.black.withOpacity(0.5),
        selectedItemColor: context.colors.primary,
        currentIndex: currentIndex,
        selectedFontSize: 1.8.h,
        onTap: (index) => setState(() {
          currentIndex = index;
          pctr.jumpToPage(index);
        }),
      ),
      body: Center(
        child: PageView(
          controller: pctr,

          ///UNCOMMENT THIS LINE TO DISABLE HORIZONTAL SCROLL
          // physics: NeverScrollableScrollPhysics(),
          onPageChanged: (index) => setState(() => currentIndex = index),
          children: BottomNavItem.values.map((e) => e.route.screen).toList(),
        ),
      ),
    );
  }
}

//  IndexedStack(
//     index: currentIndex,
//     children: BottomNavItem.values.map((e) => e.route.screen).toList(),
//   )
