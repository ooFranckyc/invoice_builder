import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/history_fragment/history_fragment.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/home_fragment/home_fragment.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/profile_fragment/profile_fragment.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/template_fragment/template_fragment.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/invoice_appbar.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: const MenuScreen(),
      mainScreen: const MainScreen(),
      androidCloseOnBackTap: true,
      angle: 0.0,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      borderRadius: 24.0,
      showShadow: true,
      drawerShadowsBackgroundColor: Colors.white60,
      menuBackgroundColor: AppColors.cPrimary,
    );
  }
}

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final defaultDuration = const Duration(milliseconds: 180);
  int currentIndex = 0;

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cPrimary,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: AppColors.cPrimary),
        backgroundColor: AppColors.cPrimary,
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _profile(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Bounce(
                    duration: defaultDuration,
                    onPressed: () {
                      setState(() {
                        currentIndex = 0;
                      });
                    },
                    child: optionMenuTitle(
                        title: 'Home Page',
                        icon: CupertinoIcons.home,
                        isCurrent: currentIndex == 0 ? true : false)),
                Bounce(
                  duration: defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 1;
                    });
                  },
                  child: optionMenuTitle(
                      title: 'Templates',
                      icon: CupertinoIcons.photo,
                      isCurrent: currentIndex == 1 ? true : false),
                ),
                Bounce(
                  duration: defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 2;
                    });
                  },
                  child: optionMenuTitle(
                      title: 'Notifications',
                      icon: CupertinoIcons.bell,
                      isCurrent: currentIndex == 2 ? true : false),
                ),
                Bounce(
                  duration: defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 3;
                    });
                  },
                  child: optionMenuTitle(
                      title: 'Rate US',
                      icon: CupertinoIcons.wand_stars_inverse,
                      isCurrent: currentIndex == 3 ? true : false),
                ),
                Bounce(
                  duration: defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 4;
                    });
                  },
                  child: optionMenuTitle(
                      title: 'Help Center',
                      icon: Icons.help_outline,
                      isCurrent: currentIndex == 4 ? true : false),
                ),
                Bounce(
                  duration: defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 5;
                    });
                  },
                  child: optionMenuTitle(
                      title: 'Sign Out',
                      icon: Icons.logout,
                      isCurrent: currentIndex == 5 ? true : false),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Container optionMenuTitle(
      {required String title, required IconData icon, required bool isCurrent}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 25),
      margin: const EdgeInsets.symmetric(vertical: 12),
      decoration: isCurrent
          ? BoxDecoration(
              color: AppColors.cGreyLow.withOpacity(.13), borderRadius: BorderRadius.circular(12.0))
          : const BoxDecoration(),
      alignment: Alignment.center,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 25.0, color: AppColors.cWhite.withOpacity(.80)),
          const SizedBox(width: 20.0),
          Text(
            title,
            style: TextStyle(
                color: AppColors.cWhite.withOpacity(.80),
                fontSize: 16.3,
                fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }

  Widget _profile() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
                color: Colors.blue,
                border: Border.all(width: 2, color: Colors.white),
                shape: BoxShape.circle),
          ),
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hi, Franck',
                style: AppTextStyle.textStyle2(),
              ),
              Text('Welcome.', style: AppTextStyle.textStyle4()),
            ],
          )
        ],
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  final fragments = const [
    HomeFragment(),
    TemplateFragment(),
    HistoryFragment(),
    ProfileFragment()
  ];

  @override
  void initState() {
    currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context: context, index: currentIndex),
      backgroundColor: AppColors.cWhite,
      body: fragments[currentIndex],
      bottomNavigationBar: PersistentBottomNavBar(
        navBarStyle: NavBarStyle.style9,
        navBarDecoration: NavBarDecoration(
            borderRadius: BorderRadius.circular(1), adjustScreenBottomPaddingOnCurve: true),
        navBarEssentials: NavBarEssentials(
            backgroundColor: AppColors.cWhite,
            navBarHeight: 80,
            selectedIndex: currentIndex,
            itemAnimationProperties: const ItemAnimationProperties(
                duration: Duration(milliseconds: 1), curve: Curves.bounceInOut),
            onItemSelected: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: [
              PersistentBottomNavBarItem(
                  activeColorPrimary: Colors.black,
                  title: 'Home',
                  icon: const Icon(
                    CupertinoIcons.home,
                  )),
              PersistentBottomNavBarItem(
                  activeColorPrimary: Colors.black,
                  title: 'Templates',
                  icon: const Icon(
                    CupertinoIcons.doc_text_search,
                  )),
              PersistentBottomNavBarItem(
                  activeColorPrimary: Colors.black,
                  title: 'History',
                  icon: const Icon(
                    Icons.history,
                  )),
              PersistentBottomNavBarItem(
                  activeColorPrimary: Colors.black,
                  title: 'Profile',
                  icon: const Icon(
                    CupertinoIcons.profile_circled,
                  )),
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
    );
  }
}