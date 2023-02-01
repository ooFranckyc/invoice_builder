import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/screens/hom_screens/fragments/home_fragment/widgets/invoice_card.dart';
import 'package:invoice_builder/screens/templates_screens/template_screen.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/firestore_key.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/searchbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeFragment extends StatefulWidget {
  const HomeFragment({super.key});

  @override
  State<HomeFragment> createState() => _HomeFragmentState();
}

class _HomeFragmentState extends State<HomeFragment> {
  final defaultDuration = const Duration(milliseconds: 180);
  final preferences = SharedPreferences.getInstance();
  String username = 'Random User', profile = 'assets/google.png';

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
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _headerUserInformation(),
        const InvoiceSearchBar(),
        _tipsForFastBuildInvoiceStepByStep(),
        _usingTemplateInvoice()
      ],
    );
  }

  Widget _headerUserInformation() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, ${username.split(' ')[0]}',
            style: AppTextStyle.textStyle1(),
          ),
          Text(
            'Let\'s build new invoice',
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
          color: AppColors.cGreyLow,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 50, left: 20, top: 15),
                child: Text(
                  'Generate Invoice By Following Just Few Steps !',
                  style: AppTextStyle.textStyle1(),
                ),
              ),
              const SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10),
                child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll<Color>(AppColors.cPrimary),
                        elevation: const MaterialStatePropertyAll<double?>(.5),
                        padding: const MaterialStatePropertyAll<EdgeInsets>(
                            EdgeInsets.symmetric(vertical: 8, horizontal: 15)),
                        splashFactory: NoSplash.splashFactory),
                    onPressed: () {
                      Get.toNamed("/new_invoice");
                    },
                    child: Text(
                      'Generate News',
                      style: AppTextStyle.textStyle3(color: AppColors.cWhite),
                    )),
              )
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

  final listAvaiblesLocalInvoices = [
    [
      'Abstract Black',
      'assets/invoices-local-preview/abstract-black.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
    [
      'Geometric Business',
      'assets/invoices-local-preview/abstract-geometric-business.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
    [
      'Corporative Business',
      'assets/invoices-local-preview/corporative-business.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
    [
      'Elegant Blue',
      'assets/invoices-local-preview/elegant-blue-gray.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
    [
      'Driving School',
      'assets/invoices-local-preview/flat-design-driving-school.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
    [
      'Geometric Architecure',
      'assets/invoices-local-preview/geometric-architecture.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
    [
      'Indoo Potted Plants',
      'assets/invoices-local-preview/indoor-potted-plants.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
    [
      'Minimal Yellow',
      'assets/invoices-local-preview/minimal-yellow.jpg',
      'Lorem ipsum dolor sit amet consectetur adipisicing elit. Omnis enim illum esse voluptatum, ad perspiciatis placeat totam nesciunt iusto cum! Quia neque dolor commodi molestiae eius ipsam dicta id cupiditate?',
      'false'
    ],
  ];

  Widget _usingPopularInvoice() {
    return Column(
      children: [
        _templateUI(title: 'Popular Templates', action: 'View All', onPress: () {}),
        const SizedBox(height: 10.0),
        SizedBox(
            height: 230,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                itemCount: listAvaiblesLocalInvoices.length,
                itemBuilder: (context, index) => OpenContainer(
                      closedBuilder: (BuildContext context, void Function() action) {
                        return InvoiceCard(
                            title: listAvaiblesLocalInvoices[index][0],
                            heroPreview: listAvaiblesLocalInvoices[index][1]);
                      },
                      openBuilder:
                          (BuildContext context, void Function({Object? returnValue}) action) {
                        return TemplateScreenDetails(
                            templateName: listAvaiblesLocalInvoices[index][0],
                            templateImage: listAvaiblesLocalInvoices[index][1],
                            templateDesc: listAvaiblesLocalInvoices[index][2],
                            isFavorite: listAvaiblesLocalInvoices[index][3]);
                      },
                    )))
      ],
    );
  }

  Widget _lastTemplateUsed() {
    return Column(
      children: [
        _templateUI(title: 'Last used Templates', action: 'View All', onPress: () {}),
        const SizedBox(
          height: 30.0,
        ),
        noTemplateYet()
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
            'No Template Yet',
            style: AppTextStyle.textStyle4(),
          ),
          Text(
            'Please create invoice using one template, there showing here',
            style: AppTextStyle.textStyle6(color: AppColors.cPrimary.withOpacity(.70)),
            textAlign: TextAlign.center,
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
          style: AppTextStyle.textStyle4(),
        ),
        Bounce(
          duration: defaultDuration,
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
