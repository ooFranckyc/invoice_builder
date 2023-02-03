import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/widgets/searchbar.dart';

class TemplateFragment extends StatefulWidget {
  const TemplateFragment({super.key});

  @override
  State<TemplateFragment> createState() => _TemplateFragmentState();
}

class _TemplateFragmentState extends State<TemplateFragment> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _headerUserInformation(),
        const InvoiceSearchBar(),
        const SizedBox(height: 30),
        /*
          L'affichage des resultas de recherche de fature doit etre asynchrone,
          pour ce faire nous utiliserons un FutureBuilder(args), qui aura comme methodes future "findInvoiceByTag(String tag) async",
          nous construirons ensuite une liste de widgets avec un modeliseurs pour avoir un rendu graphique a l'ecran.
          La methodes retournera donc des informations concernant la fature actuel (currentInvoice),
          qui sera afficher dans un ecran dedier a la consultations d'information, cet ecran permettra de directement utiliser le models
          voir: lib/templates_screens/template_screen.dart
        */
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
            AppStrings.searchInvoiceTextTemplateFragment,
            style: AppTextStyle.textStyle1(),
          ),
          Text(
            AppStrings.searchInvoiceTextDescTemplateFragment,
            style: AppTextStyle.textStyle5(),
          ),
        ],
      ),
    );
  }
}
