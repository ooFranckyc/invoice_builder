import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';

class InvoiceCard extends StatefulWidget {
  final String title;
  final String heroPreview;
  const InvoiceCard({super.key, required this.title, required this.heroPreview});

  @override
  State<InvoiceCard> createState() => _InvoiceCardState();
}

class _InvoiceCardState extends State<InvoiceCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 210,
      color: AppColors.cWhite,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 190,
            height: 200,
            color: AppColors.cWhite,
            child: CachedNetworkImage(
              imageUrl: widget.heroPreview,
              progressIndicatorBuilder: (context, url, downloadProgress) => SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: CircularProgressIndicator(value: downloadProgress.progress)),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: 30.0,
                color: AppColors.cPrimary,
              ),
            ),
          ),
          const SizedBox(height: 5.0),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: AppTextStyle.textStyle5(weight: FontWeight.w700),
                ),
                Container(
                  width: 25.0,
                  height: 5,
                  color: AppColors.cPrimary,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
