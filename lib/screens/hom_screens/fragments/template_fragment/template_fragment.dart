import 'package:flutter/material.dart';
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
        // you can user listview widget for show result search invoice in this screen
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
            'Search Templates',
            style: AppTextStyle.textStyle1(),
          ),
          Text(
            'You can use a free template for you invoice.',
            style: AppTextStyle.textStyle5(),
          ),
        ],
      ),
    );
  }
}
