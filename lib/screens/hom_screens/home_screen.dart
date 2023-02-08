// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:invoice_builder/screens/hom_screens/fragments/history_fragment/history_fragment.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/home_fragment/home_fragment.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/profile_fragment/profile_fragment.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/template_fragment/template_fragment.dart';
import 'package:invoice_builder/services/authentification.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/firestore_key.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/time.dart';
import 'package:invoice_builder/shared/widgets/invoice_appbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> connectivitySubscription;

  @override
  void initState() {
    initializeConntection();
    connectivitySubscription = connectivity.onConnectivityChanged.listen(updateConnectionStatus);
    super.initState();
  }

  Future<void> initializeConntection() async {
    late ConnectivityResult result;
    try {
      result = await connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return updateConnectionStatus(result);
  }

  Future<void> updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
    });
  }

  @override
  void dispose() {
    connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      menuScreen: MenuScreen(connectionStatus: connectionStatus),
      mainScreen: const MainScreen(),
      androidCloseOnBackTap: true,
      disableDragGesture: true,
      angle: -1,
      slideWidth: MediaQuery.of(context).size.width * 0.65,
      borderRadius: 24.0,
      showShadow: true,
      drawerShadowsBackgroundColor: Colors.grey.shade50,
      menuBackgroundColor: AppColors.cPrimary,
    );
  }
}

class MenuScreen extends StatefulWidget {
  final ConnectivityResult connectionStatus;
  const MenuScreen({
    Key? key,
    required this.connectionStatus,
  }) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int currentIndex = 0;
  final preferences = SharedPreferences.getInstance();
  String username = AppStrings.defaultUsername, profile = AppStrings.defaultProfileImage;

  getInfo() async {
    final SharedPreferences pref = await preferences;
    final sharedName = (pref.getString(FirestoreConstantsKey.nickname));
    final sharedProfile = (pref.getString(FirestoreConstantsKey.photoUrl));
    setState(() {
      username = sharedName!;
      profile = sharedProfile!;
    });
  }

  @override
  void initState() {
    currentIndex = 0;
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AuthentificationProvider authProvider = Provider.of<AuthentificationProvider>(context);

    return Scaffold(
      backgroundColor: AppColors.cPrimary,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light,
            statusBarColor: AppColors.cPrimary,
            systemNavigationBarColor: AppColors.cPrimary,
            systemNavigationBarIconBrightness: Brightness.light),
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
                    duration: AppTimePlaner.defaultDuration,
                    onPressed: () {
                      setState(() {
                        currentIndex = 0;
                      });
                      ZoomDrawer.of(context)!.toggle();
                    },
                    child: optionMenuTitle(
                        title: AppStrings.homePageOption,
                        icon: CupertinoIcons.home,
                        isCurrent: currentIndex == 0 ? true : false)),
                Bounce(
                  duration: AppTimePlaner.defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 0; // A 0 parce que l'on revient toujours en page principal
                    });
                    ZoomDrawer.of(context)!.toggle();
                    Get.toNamed(AppLinks.tempScreen);
                  },
                  child: optionMenuTitle(
                      title: AppStrings.templateHomePageOption,
                      icon: CupertinoIcons.photo,
                      isCurrent: currentIndex == 1 ? true : false),
                ),
                Bounce(
                  duration: AppTimePlaner.defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 0; // A 0 parce que l'on revient toujours en page principal
                    });
                    ZoomDrawer.of(context)!.toggle();
                    Get.toNamed(AppLinks.notificationScreen);
                  },
                  child: optionMenuTitle(
                      title: AppStrings.notificationHomePageOption,
                      icon: CupertinoIcons.bell,
                      isCurrent: currentIndex == 2 ? true : false),
                ),
                Bounce(
                  duration: AppTimePlaner.defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 0; // A 0 parce que l'on revient toujours en page principal
                    });
                    ZoomDrawer.of(context)!.toggle();
                  },
                  child: optionMenuTitle(
                      title: AppStrings.rateUSHomePageOption,
                      icon: CupertinoIcons.wand_stars_inverse,
                      isCurrent: currentIndex == 3 ? true : false),
                ),
                Bounce(
                  duration: AppTimePlaner.defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 0; // A 0 parce que l'on revient toujours en page principal
                    });
                    ZoomDrawer.of(context)!.toggle();
                    Get.toNamed(AppLinks.contactScreen);
                  },
                  child: optionMenuTitle(
                      title: AppStrings.helpCenterHomePageOption,
                      icon: Icons.help_outline,
                      isCurrent: currentIndex == 4 ? true : false),
                ),
                Bounce(
                  duration: AppTimePlaner.defaultDuration,
                  onPressed: () {
                    setState(() {
                      currentIndex = 5;
                    });
                    ZoomDrawer.of(context)!.toggle();
                    Get.defaultDialog(
                        title: 'Are sure?',
                        titleStyle: AppTextStyle.textStyle4(),
                        contentPadding: const EdgeInsets.symmetric(vertical: 20),
                        content: AppText(
                          text: 'Cofirm you sign out action',
                          style: AppTextStyle.textStyle6(),
                        ),
                        actions: [
                          GestureDetector(
                            onTap: () async {
                              await authProvider.handleSignOut();
                              Get.offNamed(AppLinks.loginScreen);
                            },
                            child: AppText(
                              text: 'Sign Out',
                              style: AppTextStyle.textStyle5(weight: FontWeight.w700),
                            ),
                          )
                        ]);
                  },
                  child: optionMenuTitle(
                      title: AppStrings.signOutHomePageOption,
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
          const SizedBox(width: 10.0),
          Text(
            title,
            style: AppTextStyle.textStyle5(color: AppColors.cWhite.withOpacity(.80)),
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
          const SizedBox(width: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${AppStrings.hiMsgHomePageOption}${username.split(' ')[0]}', // return the first name of username -> "Hi, Franck" for example
                style: AppTextStyle.textStyle2(color: AppColors.cWhite),
              ),
              Text(AppStrings.welcomeTextHomePageOption,
                  style: AppTextStyle.textStyle4(color: AppColors.cWhite)),
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
                  activeColorPrimary: AppColors.cPrimary,
                  title: AppStrings.homeTextNavigation,
                  textStyle: AppTextStyle.textStyle6(weight: FontWeight.w600),
                  icon: const Icon(
                    CupertinoIcons.home,
                  )),
              PersistentBottomNavBarItem(
                  activeColorPrimary: AppColors.cPrimary,
                  title: AppStrings.templatesTextNavigation,
                  textStyle: AppTextStyle.textStyle6(weight: FontWeight.w600),
                  icon: const Icon(
                    CupertinoIcons.doc_text_search,
                  )),
              PersistentBottomNavBarItem(
                  activeColorPrimary: AppColors.cPrimary,
                  title: AppStrings.historyTextNavigation,
                  textStyle: AppTextStyle.textStyle6(weight: FontWeight.w600),
                  icon: const Icon(
                    Icons.history,
                  )),
              PersistentBottomNavBarItem(
                  activeColorPrimary: AppColors.cPrimary,
                  title: AppStrings.profileTextNavigation,
                  textStyle: AppTextStyle.textStyle6(weight: FontWeight.w600),
                  icon: const Icon(
                    CupertinoIcons.profile_circled,
                  )),
            ]),
        margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      ),
    );
  }
}
