import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/screens/contact_us_screen/contact_us_screen.dart';
import 'package:invoice_builder/screens/hom_screens/blinding.dart';
import 'package:invoice_builder/screens/hom_screens/home_screen.dart';
import 'package:invoice_builder/screens/invoice_screens/blinding.dart';
import 'package:invoice_builder/screens/invoice_screens/invoice_screen.dart';
import 'package:invoice_builder/screens/invoice_screens/screen_composites/business_compos/business_compos.dart';
import 'package:invoice_builder/screens/invoice_screens/screen_composites/customer_compos/customer_compos.dart';
import 'package:invoice_builder/screens/invoice_screens/screen_composites/items_compos/blinding.dart';
import 'package:invoice_builder/screens/invoice_screens/screen_composites/items_compos/item_compos.dart';
import 'package:invoice_builder/screens/invoice_screens/screen_composites/payement_compos/payement_compos.dart';
import 'package:invoice_builder/screens/invoice_screens/screen_composites/sign_usr_compos/sign_usr_compos.dart';
import 'package:invoice_builder/screens/login_screens/login_screen.dart';
import 'package:invoice_builder/screens/notification_screen/notification_screen.dart';
import 'package:invoice_builder/screens/onbording_screens/onbording_screen.dart';
import 'package:invoice_builder/screens/preview_screens/preview_screen.dart';
import 'package:invoice_builder/screens/register_screen/register_screen.dart';
import 'package:invoice_builder/screens/splash_screens/splash_screen.dart';
import 'package:invoice_builder/screens/templates_screens/last_usr_template_screen.dart';
import 'package:invoice_builder/screens/templates_screens/template_screen.dart';

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
        name: AppLinks.loginScreen, page: () => const LoginScreen(), transition: Transition.native),
    GetPage(
        name: AppLinks.registerScreen,
        page: () => const RegisterScreen(),
        transition: Transition.native),
    GetPage(
      name: AppLinks.newInvoiceScreen,
      page: () => const InvoiceScreen(),
      transition: Transition.native,
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: AppLinks.newBuisinessScreen,
      page: () => const BusinessComposScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.newCustomerScreen,
      page: () => const CustomerInformationScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.newPaymentScreen,
      page: () => PaymentInstructionsScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.contactScreen,
      page: () => const ContactUsScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.newItemScreen,
      page: () => ItemCompoScreen(),
      transition: Transition.native,
      binding: ItemsBidning(),
    ),
    GetPage(
      name: AppLinks.signatureScreen,
      page: () => const SignatureScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.previewScreen,
      page: () => const PreviewScreen(),
      transition: Transition.fade,
    ),
    GetPage(
      name: AppLinks.notificationScreen,
      page: () => const NotificationScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppLinks.onbordingScreen,
      page: () => const OnBordingScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppLinks.tempScreen,
      page: () => const TemplateScreen(),
      transition: Transition.native,
    ),
    GetPage(
      name: AppLinks.lastTempScreen,
      page: () => const LastTemplateUsedScreen(),
      transition: Transition.native,
    ),
  ];
}
