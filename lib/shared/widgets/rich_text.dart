// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:invoice_builder/shared/style.dart';

class AppRichText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final double spacing;
  final double height;
  final Color color;
  final TextAlign align;
  final List<TextSpan> children;
  final TextDirection? direction;
  final TextStyle? style;
  const AppRichText(
      {Key? key,
      required this.text,
      this.children = const <TextSpan>[],
      this.fontSize,
      this.direction,
      this.spacing = 0,
      this.height = 1,
      this.color = Colors.black,
      this.align = TextAlign.center,
      this.style})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*
      Google Package Font Is Missing, 
      However, for more style add this package 
    */
    // return RichText(
    //   textAlign: align,
    //   textDirection: direction,
    //   text: TextSpan(
    //     text: text,
    //     style: GoogleFonts.nunito(
    //       color: color,
    //       fontSize: fontSize ?? AutoDimensions.calcH(18),
    //       fontWeight: weight,
    //       letterSpacing: spacing,
    //       height: height,
    //     ),
    //     children: [
    //       ...children.toList()
    //     ],
    //   ),
    // );
    return RichText(
      textAlign: align,
      textDirection: direction,
      text: TextSpan(
        text: text,
        style: style ?? AppTextStyle.textStyle3(),
        children: [...children.toList()],
      ),
    );
    // return Text(
    //   text,
    //   textAlign: TextAlign.center,
    //   style: GoogleFonts.nunito(
    //       color: color,
    //       fontSize: fontSize ?? Dimensions.calcH(18),
    //       fontWeight: weight),
    // );
  }
}
