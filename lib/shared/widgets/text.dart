import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/style.dart';

class AppText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double spacing;
  final double height;
  final Color color;
  final TextAlign align;
  final FontWeight weight;
  final TextDirection? textdirection;
  final TextOverflow? overflow;
  const AppText({
    required this.text,
    this.fontSize,
    this.spacing = 0,
    this.height = 1,
    this.color = Colors.black,
    this.align = TextAlign.center,
    this.weight = FontWeight.normal,
    this.overflow,
    this.textdirection,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
      Google Package Font Is Missing, 
      However, for more style add this package 
    */
    // return Text(
    //   text,
    //   maxLines: 1,
    //   overflow: overflow ?? TextOverflow.ellipsis,
    //   textDirection: textdirection ?? TextDirection.ltr,
    //   textAlign: align,
    //   style: GoogleFonts.nunito(
    //     color: color,
    //     fontSize: fontSize ?? Dimensions.calcH(18),
    //     fontWeight: weight,
    //     letterSpacing: spacing,
    //     height: height,
    //   ),
    // );
    return Text(
      text,
      maxLines: 1,
      overflow: overflow ?? TextOverflow.ellipsis,
      textDirection: textdirection ?? TextDirection.ltr,
      textAlign: align,
      style: AppTextStyle.textStyle3(color: color),
    );
  }
}
