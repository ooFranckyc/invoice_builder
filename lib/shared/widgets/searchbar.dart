import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';

class InvoiceSearchBar extends StatefulWidget {
  const InvoiceSearchBar({super.key});

  @override
  State<InvoiceSearchBar> createState() => _InvoiceSearchBarState();
}

class _InvoiceSearchBarState extends State<InvoiceSearchBar> {
  final defaultDuration = const Duration(milliseconds: 180);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Material(
            elevation: .5,
            borderRadius: BorderRadius.circular(12),
            shadowColor: AppColors.cGreyLow,
            child: Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    color: AppColors.cWhite, borderRadius: BorderRadius.circular(12.0)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(CupertinoIcons.search_circle, color: AppColors.cPrimary, size: 30),
                    const SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        decoration: InputDecoration(
                            hintText: 'Search templates here',
                            hintStyle:
                                AppTextStyle.textStyle6(color: AppColors.cPrimary.withOpacity(.50)),
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none),
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.search,
                        scrollPhysics: const BouncingScrollPhysics(),
                      ),
                    )
                  ],
                )),
          )),
          Bounce(
            duration: defaultDuration,
            onPressed: () {},
            child: Container(
              width: 40.0,
              height: 40.0,
              margin: const EdgeInsets.only(left: 8.0),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(color: AppColors.cPrimary, shape: BoxShape.circle),
              child: Icon(CupertinoIcons.slider_horizontal_3, color: AppColors.cWhite),
            ),
          )
        ],
      ),
    );
  }
}
