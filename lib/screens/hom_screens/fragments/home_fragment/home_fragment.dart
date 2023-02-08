import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/home_fragment/widgets/invoice_card.dart';
import 'package:invoice_builder/screens/templates_screens/template_details_screen.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/firestore_key.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/time.dart';
import 'package:invoice_builder/shared/widgets/searchbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final preferences = SharedPreferences.getInstance();
  String username = AppStrings.defaultUsername, profile = AppStrings.defaultProfileImage;
  final Stream<QuerySnapshot> popularInvoiceStream =
      FirebaseFirestore.instance.collection('Populars').snapshots();

  getInfo() async {
    final SharedPreferences pref = await preferences;
    final sharedName = (pref.getString(FirestoreConstantsKey.nickname));
    setState(() {
      username = sharedName!;
    });
  }

  @override
  void initState() {
    getInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cWhite,
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          _headerUserInformation(),
          const InvoiceSearchBar(),
          _tipsForFastBuildInvoiceStepByStep(),
          _usingTemplateInvoice()
        ],
      ),
    );
  }

  Widget _headerUserInformation() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${AppStrings.hiMsgHomePageOption}${username.split(' ')[0]}',
            style: AppTextStyle.textStyle1(),
          ),
          Text(
            AppStrings.belowTextWl,
            style: AppTextStyle.textStyle5(),
          ),
        ],
      ),
    );
  }

  Widget _tipsForFastBuildInvoiceStepByStep() {
    return Stack(
      children: [
        Container(
          decoration:
              BoxDecoration(color: AppColors.cGreyLow, borderRadius: BorderRadius.circular(12)),
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 20, top: 15),
                child: Text(
                  AppStrings.tipsTextHomeFragment,
                  style: AppTextStyle.textStyle1(),
                ),
              ),
              const SizedBox(height: 15.0),
              Padding(
                  padding: const EdgeInsets.only(left: 15.0, bottom: 10),
                  child: Bounce(
                    duration: AppTimePlaner.defaultDuration,
                    onPressed: () {
                      Get.toNamed(AppLinks.newInvoiceScreen);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 13),
                      decoration: BoxDecoration(
                          color: AppColors.cPrimary, borderRadius: BorderRadius.circular(50)),
                      child: AppText(
                        text: 'Generate New',
                        style: AppTextStyle.textStyle3(color: AppColors.cWhite),
                      ),
                    ),
                  ))
            ],
          ),
        )
      ],
    );
  }

  Widget _usingTemplateInvoice() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Column(
        children: [
          _lastTemplateUsed(),
          const SizedBox(height: 20.0),
          _usingPopularInvoice(),
        ],
      ),
    );
  }

  final popularInvoiceLength = 6;
  Widget _usingPopularInvoice() {
    return Column(
      children: [
        _templateUI(
            title: AppStrings.popularTempHomeFragment,
            action: AppStrings.viewAllHomeFragment,
            onPress: () => Get.toNamed(AppLinks.tempScreen)),
        const SizedBox(height: 15.0),
        /*
          A ce niveau, lorsque le service de reception & de modelisation de facture venant 
          de firebase sera operationel, l'utilisation d'un ListView.builder(args), ne sera pas utilse,
          car nous serrions en situation d'ou du code asynchrone serait un moyen d'eviter les bugs d'attente vis a vis,
          des processus de notre app, ou du systeme.
          Le widget recommande est FutureBuilder(args) -> a venir 
        */
        SizedBox(
          height: 235,
          child: StreamBuilder<QuerySnapshot>(
              stream: popularInvoiceStream,
              builder: (cuildContext, snapshot) {
                if (snapshot.hasError) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.sentiment_dissatisfied,
                        color: AppColors.cPrimary,
                        size: 25,
                      ),
                      AppText(
                        text: 'Something went wrong',
                        style: AppTextStyle.textStyle5(),
                      ),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors.cPrimary,
                      ),
                      AppText(
                        text: 'Loading...',
                        style: AppTextStyle.textStyle5(),
                      ),
                    ],
                  );
                }

                return ListView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  children: snapshot.data!.docs
                      .map((DocumentSnapshot document) {
                        Map<String, dynamic> invoice = document.data()! as Map<String, dynamic>;
                        for (int i = 0; i <= popularInvoiceLength;) {
                          return OpenContainer(
                            openColor: AppColors.cWhite,
                            closedColor: AppColors.cWhite,
                            closedBuilder: (BuildContext context, void Function() action) {
                              return InvoiceCard(
                                  title: invoice['name'], heroPreview: invoice['image']);
                            },
                            openBuilder: (BuildContext context,
                                void Function({Object? returnValue}) action) {
                              return TemplateScreenDetails(
                                templateName: invoice['name'],
                                templateImage: invoice['image'],
                                templateDomain: invoice['domain'],
                                templateDesc: invoice['desc'],
                                templateLike: invoice['like'],
                              );
                            },
                          );
                        }
                      })
                      .toList()
                      .cast(),
                );
              }),
        )
      ],
    );
  }

  Widget _lastTemplateUsed() {
    return Column(
      children: [
        _templateUI(
            title: AppStrings.lastTempUsedHomeFragment,
            action: AppStrings.viewAllHomeFragment,
            onPress: () => Get.toNamed(AppLinks.lastTempScreen)),
        const SizedBox(
          height: 50.0,
        ),
        noTemplateYet(),
        const SizedBox(
          height: 10.0,
        ),
      ],
    );
  }

  Center noTemplateYet() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            AppStrings.nothinTempUsedTitleHomeFragment,
            style: AppTextStyle.textStyle4(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Text(
              AppStrings.nothinTempUsedDescriptionHomeFragment,
              style: AppTextStyle.textStyle6(color: AppColors.cPrimary.withOpacity(.70)),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _templateUI(
      {required String title, required String action, required VoidCallback onPress}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyle.textStyle3(),
        ),
        Bounce(
          duration: AppTimePlaner.defaultDuration,
          onPressed: onPress,
          child: Text(
            action,
            style: AppTextStyle.textStyleDefaultSystemValue(),
          ),
        ),
      ],
    );
  }
}
