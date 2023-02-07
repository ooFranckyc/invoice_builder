import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:get/get.dart';
import 'package:invoice_builder/env/linker_route.dart';
import 'package:invoice_builder/screens/templates_screens/invoice_viewer_screen.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/time.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:invoice_builder/shared/widgets/snackbar.dart';
import 'package:invoice_builder/shared/widgets/text.dart';
import 'package:cached_network_image/cached_network_image.dart';

/*
  file name: template_screen.dart
  ?params: name, imageUrl, description, favorite : Strings
  
*/

// ignore: must_be_immutable
class TemplateScreenDetails extends StatefulWidget {
  String? templateName;
  String? templateImage;
  String? templateDomain;
  String? templateDesc;
  int? templateLike;
  TemplateScreenDetails(
      {super.key,
      this.templateName,
      this.templateImage,
      this.templateDomain,
      this.templateDesc,
      this.templateLike});

  @override
  State<TemplateScreenDetails> createState() => _TemplateScreenDetailsState();
}

class _TemplateScreenDetailsState extends State<TemplateScreenDetails> {
  bool isLike = false;
  final invoiceHeroTag = 'invoice_view_model';
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
          actions: [
            Bounce(
                duration: AppTimePlaner.defaultDuration,
                onPressed: () {
                  setState(() {
                    isLike = !isLike;
                    messageWithSnackbar(
                        context: context, message: 'Invoice template marked has favorite');
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(isLike ? Icons.favorite : Icons.favorite_border, size: 30),
                )),
          ],
          title: Text(
            widget.templateName!,
            style: AppTextStyle.textStyle3(color: AppColors.cPrimary),
          ),
        ),
        backgroundColor: AppColors.cWhite,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            fullscreenDialog: true,
                            builder: (context) => InvoiceModelViewHeroScreen(
                                tag: invoiceHeroTag, imageView: widget.templateImage!)));
                  },
                  child: SizedBox(
                    width: 400,
                    height: 280,
                    child: Hero(
                      tag: invoiceHeroTag,
                      child: CachedNetworkImage(
                        imageUrl: widget.templateImage!,
                        progressIndicatorBuilder: (context, url, downloadProgress) =>
                            CircularProgressIndicator(value: downloadProgress.progress),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                Divider(color: AppColors.cGreyConcentric, height: 2, thickness: 1),
                const SizedBox(height: 10.0),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(
                        text: widget.templateName!,
                        style: AppTextStyle.textStyle1(),
                      ),
                      const SizedBox(height: 5),
                      AppText(
                        text: widget.templateDomain!,
                        style: AppTextStyle.textStyle6(color: AppColors.cPrimary.withOpacity(.60)),
                        maxline: 2,
                        align: TextAlign.left,
                      ),
                      const SizedBox(height: 15),
                      const AppText(text: 'Description'),
                      AppText(
                        text: widget.templateDesc!,
                        style: AppTextStyle.textStyle6(color: AppColors.cPrimary.withOpacity(.60)),
                        maxline: 4,
                        align: TextAlign.left,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RatingBarIndicator(
                              rating: 2.75,
                              itemBuilder: (context, index) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              itemCount: 5,
                              itemSize: 30.0,
                              direction: Axis.horizontal,
                            ),
                            Bounce(
                              duration: AppTimePlaner.defaultDuration,
                              onPressed: () {
                                Get.toNamed(AppLinks.newInvoiceScreen);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: AppColors.cPrimary,
                                    borderRadius: BorderRadius.circular(50)),
                                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                child: AppText(
                                  text: 'Use Template',
                                  style: AppTextStyle.textStyle4(color: AppColors.cWhite),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      const AppText(text: 'About'),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppText(
                              text:
                                  'This invoice template is built free of charge for you, you can use it as you wish.',
                              style: AppTextStyle.textStyle5(),
                              maxline: 2,
                              align: TextAlign.left,
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Row(
                                  children: [
                                    AppText(
                                      text: 'Model designed by ',
                                      style: AppTextStyle.textStyle5(),
                                      maxline: 3,
                                      align: TextAlign.left,
                                    ),
                                    AppText(
                                      text: 'open-source#invoice',
                                      style: AppTextStyle.textStyle5(weight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // open browser to freepick website
                                  },
                                  child: Row(
                                    children: [
                                      AppText(
                                        text: 'Inspirred by ',
                                        style: AppTextStyle.textStyle5(),
                                        maxline: 2,
                                        align: TextAlign.left,
                                      ),
                                      AppText(
                                        text: 'Freepik',
                                        style: AppTextStyle.textStyle5(weight: FontWeight.bold),
                                        maxline: 2,
                                        align: TextAlign.left,
                                        decoration: TextDecoration.underline,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 30.0),
                            Bounce(
                              duration: AppTimePlaner.defaultDuration,
                              onPressed: () {},
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.cPrimary,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                  child: AppText(
                                    text: 'Download this template',
                                    style: AppTextStyle.textStyle4(),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 15.0),
                            Bounce(
                              duration: AppTimePlaner.defaultDuration,
                              onPressed: () {},
                              child: Align(
                                alignment: Alignment.center,
                                child: Container(
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2,
                                        color: AppColors.cPrimary,
                                      ),
                                      borderRadius: BorderRadius.circular(50)),
                                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                                  child: AppText(
                                    text: 'Share template',
                                    style: AppTextStyle.textStyle4(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
