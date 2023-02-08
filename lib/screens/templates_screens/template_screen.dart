import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bounce/flutter_bounce.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:invoice_builder/env/auto_dimens.dart';
import 'package:invoice_builder/screens/templates_screens/template_details_screen.dart';
import 'package:invoice_builder/shared/colors.dart';
import 'package:invoice_builder/shared/style.dart';
import 'package:invoice_builder/shared/time.dart';
import 'package:invoice_builder/shared/widgets/text.dart';

class TemplateScreen extends StatefulWidget {
  const TemplateScreen({super.key});

  @override
  State<TemplateScreen> createState() => _TemplateScreenState();
}

class _TemplateScreenState extends State<TemplateScreen> {
  final Stream<QuerySnapshot> invoiceTempStream =
      FirebaseFirestore.instance.collection('Populars').snapshots();
  final invoiceTempHeroTag = 'invoice_temp_model';
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
            duration: const Duration(milliseconds: 180),
            onPressed: () {},
            child: Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(right: 10),
              alignment: Alignment.center,
              decoration: BoxDecoration(color: AppColors.cGreyLow, shape: BoxShape.circle),
              child: Icon(CupertinoIcons.search, color: AppColors.cPrimary),
            ),
          )
        ],
        title: AppText(
          text: 'Find template',
          style: AppTextStyle.textStyle3(color: AppColors.cPrimary),
        ),
      ),
      backgroundColor: AppColors.cWhite,
      body: StreamBuilder<QuerySnapshot>(
          stream: invoiceTempStream,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_dissatisfied,
                    color: AppColors.cPrimary,
                    size: 25,
                  ),
                  AppText(
                    text: 'Something went wrong',
                    style: AppTextStyle.textStyle5(),
                  ),
                ],
              );
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: AppColors.cPrimary,
                  ),
                  AppText(
                    text: 'Loading...',
                    style: AppTextStyle.textStyle5(),
                  ),
                ],
              );
            }
            return ListView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                    Map<String, dynamic> invoice = document.data()! as Map<String, dynamic>;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 170,
                            height: 170,
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
                            child: CachedNetworkImage(
                              imageUrl: invoice['image'],
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  SizedBox(
                                      width: 30.0,
                                      height: 30.0,
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress)),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 30.0,
                                color: AppColors.cPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AppText(
                                text: invoice['name'],
                                style: AppTextStyle.textStyle4(weight: FontWeight.w700),
                              ),
                              RatingBar(
                                onRatingUpdate: (value) {
                                  setState(() {
                                    value++;
                                  });
                                },
                                glowRadius: 8,
                                glowColor: Colors.amber,
                                initialRating: 4.3,
                                unratedColor: Colors.grey.shade300,
                                ratingWidget: RatingWidget(
                                    full: const Icon(
                                      Icons.star,
                                      //color: Colors.amber,
                                    ),
                                    half: const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    empty: Icon(
                                      Icons.star,
                                      color: Colors.grey.shade300,
                                    )),
                                direction: Axis.horizontal,
                                maxRating: 5,
                                itemSize: 23,
                              ),
                              const SizedBox(height: 10),
                              SizedBox(
                                width:
                                    AutoDimensions.calcW(MediaQuery.of(context).size.width - 200),
                                child: AppText(
                                    text: invoice['domain'],
                                    style: AppTextStyle.textStyle7(weight: FontWeight.w700),
                                    align: TextAlign.left,
                                    maxline: 4),
                              ),
                              const SizedBox(height: 10),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Bounce(
                                  duration: AppTimePlaner.defaultDuration,
                                  onPressed: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (context) => TemplateScreenDetails(
                                              templateName: invoice['name'],
                                              templateDesc: invoice['desc'],
                                              templateDomain: invoice['domain'],
                                              templateImage: invoice['image'],
                                              templateLike: invoice['like'],
                                            )));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: AppColors.cPrimary,
                                        borderRadius: BorderRadius.circular(50)),
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                                    child: AppText(
                                      text: 'See more',
                                      style: AppTextStyle.textStyle4(color: AppColors.cWhite),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  })
                  .toList()
                  .cast(),
            );
          }),
    );
  }
}
