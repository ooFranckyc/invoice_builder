import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/screens/hom_screens/blinding.dart';
import 'package:invoice_builder/screens/hom_screens/home_screen.dart';
import 'package:invoice_builder/screens/invoice_screen/blinding.dart';
import 'package:invoice_builder/screens/invoice_screen/invoice_screen.dart';
import 'package:invoice_builder/screens/invoice_screen/screen_composite/business_compos/business_compos.dart';
import 'package:invoice_builder/screens/invoice_screen/screen_composite/client_compos/client_compos.dart';
import 'package:invoice_builder/screens/invoice_screen/screen_composite/items_compos/blinding.dart';
import 'package:invoice_builder/screens/invoice_screen/screen_composite/items_compos/item_compos.dart';
import 'package:invoice_builder/screens/invoice_screen/screen_composite/sign_usr_compos/sign_usr_compos.dart';
import 'package:invoice_builder/screens/login_screen/login_screen.dart';
import 'package:invoice_builder/screens/preview_screen/preview_screen.dart';
import 'package:invoice_builder/screens/splash_screen/splash_screen.dart';

class AppRouting {
  static final routing = [
    GetPage(
      name: AppLinks.splashScreen,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: AppLinks.homeScreen,
        page: () => const HomeScreen(),
        binding: HomeBinding(),
        transition: Transition.circularReveal),
    GetPage(
        name: AppLinks.loginScreen,
        page: () => const LoginScreen(),
        transition: Transition.rightToLeft),
    GetPage(
      name: AppLinks.newInvoice,
      page: () => const InvoiceScreen(),
      transition: Transition.rightToLeft,
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: AppLinks.newBuisiness,
      page: () => const BusinessComposScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.newClient,
      page: () => const ClientInformationScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.newItem,
      page: () => ItemCompoScreen(),
      transition: Transition.native,
      binding: ItemsBidning(),
    ),
    GetPage(
      name: AppLinks.signature,
      page: () => const SignatureScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.preview,
      page: () => const PreviewScreen(),
      transition: Transition.fade,
    ),
  ];
}

// class HomeBinding extends Bindings {
//   @override
//   void dependencies() {
//     Get.put(AllInvoiceController(), permanent: true);
//   }
// }