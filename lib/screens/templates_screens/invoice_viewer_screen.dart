import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_builder/shared/colors.dart';

class InvoiceModelViewHeroScreen extends StatefulWidget {
  final String tag;
  final String imageView;
  const InvoiceModelViewHeroScreen({super.key, required this.tag, required this.imageView});

  @override
  State<InvoiceModelViewHeroScreen> createState() => _InvoiceModelViewHeroScreenState();
}

class _InvoiceModelViewHeroScreenState extends State<InvoiceModelViewHeroScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.grey.shade800,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Colors.grey.shade800,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Colors.grey.shade800),
        iconTheme: IconThemeData(color: AppColors.cWhite),
      ),
      backgroundColor: Colors.grey.shade800,
      body: Center(
        child: SizedBox(
          width: double.infinity,
          height: 360,
          child: Hero(tag: widget.tag, child: Image.network(widget.imageView, fit: BoxFit.cover)),
        ),
      ),
    );
  }
}
