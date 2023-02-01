import 'package:flutter/material.dart';
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
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: SizedBox(
        width: 190,
        height: 200,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 190,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(fit: BoxFit.cover, image: AssetImage(widget.heroPreview)),
                  borderRadius: BorderRadius.circular(8.0)),
            ),
            const SizedBox(height: 5.0),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.title,
                style: AppTextStyle.textStyle6(weight: FontWeight.w700),
              ),
            )
          ],
        ),
      ),
    );
  }
}
