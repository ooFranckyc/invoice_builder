import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';

/*
  file name: template_screen.dart
  ?params: name, imageUrl, description, favorite : Strings
  
*/

// ignore: must_be_immutable
class TemplateScreenDetails extends StatefulWidget {
  String? templateName;
  String? templateImage;
  String? templateDesc;
  String? isFavorite;
  TemplateScreenDetails(
      {super.key, this.templateName, this.templateImage, this.templateDesc, this.isFavorite});

  @override
  State<TemplateScreenDetails> createState() => _TemplateScreenDetailsState();
}

class _TemplateScreenDetailsState extends State<TemplateScreenDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cWhite,
          elevation: .0,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.dark,
              statusBarColor: AppColors.cWhite),
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: IconThemeData(color: AppColors.cPrimary),
          title: Text(
            widget.templateName!,
            style: AppTextStyle.textStyle3(color: AppColors.cPrimary),
          ),
        ),
        backgroundColor: AppColors.cWhite,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: const [],
          ),
        ));
  }
}
