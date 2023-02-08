import 'dart:io';
import 'package:flutter/services.dart';
import 'package:invoice_builder/models/invoice.dart';
import 'package:invoice_builder/shared/strings.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfInvoiceGenApi {
  static Future<Uint8List> generate(Invoice invoice) async {
    final headers = [
      AppStrings.headers[0],
      AppStrings.headers[1],
      AppStrings.headers[2],
      AppStrings.headers[3]
    ];
    final invoicesData = [...invoice.items.map((e) => e.toList()).toList()];
    final pdf = pw.Document(pageMode: PdfPageMode.fullscreen);
    final fontAssetPath = await rootBundle.load('assets/fonts/PTSerif-Regular.ttf');
    final pTSerifFontTtf = pw.Font.ttf(fontAssetPath);
    pdf.addPage(pw.MultiPage(
        pageTheme: const pw.PageTheme(margin: pw.EdgeInsets.zero, pageFormat: PdfPageFormat.a4),
        maxPages: 2, // definissez le nombre de page des facture generer ici
        header: (context) =>
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.all(50),
                  child: pw.Row(mainAxisSize: pw.MainAxisSize.min, children: [
                    pw.Transform.rotate(
                        angle: 120,
                        child: pw.Container(
                            width: 30,
                            height: 30,
                            alignment: pw.Alignment.center,
                            decoration: pw.BoxDecoration(
                                border: pw.Border.all(width: 2, color: PdfColors.green900),
                                borderRadius: pw.BorderRadius.circular(5)))),
                    pw.SizedBox(width: 10),
                    pw.Column(crossAxisAlignment: pw.CrossAxisAlignment.start, children: [
                      pw.Text('FG-Open Source',
                          style: pw.TextStyle(
                              fontSize: 20, font: pTSerifFontTtf, fontWeight: pw.FontWeight.bold)),
                      pw.Text('You are welcome developer'.toUpperCase(),
                          style: pw.TextStyle(
                              fontSize: 12, font: pTSerifFontTtf, fontWeight: pw.FontWeight.bold)),
                    ]),
                  ])),
              pw.Container(
                  decoration: pw.BoxDecoration(
                      color: PdfColors.grey800, borderRadius: pw.BorderRadius.circular(5)),
                  padding: const pw.EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: pw.Text("INVOICE",
                      style: pw.TextStyle(
                          font: pTSerifFontTtf,
                          fontSize: 50,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.white)))
            ]),
        build: (context) => [
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 45),
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.SizedBox(height: .1 * PdfPageFormat.cm),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: [
                        pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.start,
                          crossAxisAlignment: pw.CrossAxisAlignment.start,
                          children: [
                            // (invoice.from.logo != null)
                            //     ? Image(
                            //         MemoryImage(invoice.from.logo!),
                            //         height: 80,
                            //         width: 80,
                            //       )
                            //     : Text(""),
                            // SizedBox(height: 1 * PdfPageFormat.cm),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('Invoice to:',
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 23,
                                        font: pTSerifFontTtf,
                                        color: PdfColors.grey800)),
                                pw.SizedBox(height: .1 * PdfPageFormat.cm),
                                pw.Text(invoice.to.name,
                                    style: pw.TextStyle(
                                        fontWeight: pw.FontWeight.bold,
                                        fontSize: 17,
                                        font: pTSerifFontTtf,
                                        color: PdfColors.grey800)),
                                pw.Text(invoice.from.address!,
                                    style: pw.TextStyle(
                                        font: pTSerifFontTtf,
                                        color: PdfColors.grey700,
                                        fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                        pw.SizedBox(
                            width: 210,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.end,
                                mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
                                children: [
                                  pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      mainAxisSize: pw.MainAxisSize.max,
                                      children: [
                                        pw.Text('Invoice# ',
                                            style: pw.TextStyle(
                                                font: pTSerifFontTtf,
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 22)),
                                        pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.Text(invoice.id,
                                                style: pw.TextStyle(
                                                    fontSize: 14,
                                                    font: pTSerifFontTtf,
                                                    color: PdfColors.grey500,
                                                    fontWeight: pw.FontWeight.bold)))
                                      ]),
                                  pw.Row(
                                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                                      mainAxisSize: pw.MainAxisSize.max,
                                      children: [
                                        pw.Text('Date ',
                                            style: pw.TextStyle(
                                                font: pTSerifFontTtf,
                                                fontWeight: pw.FontWeight.bold,
                                                fontSize: 22)),
                                        pw.Align(
                                            alignment: pw.Alignment.centerRight,
                                            child: pw.Text(invoice.date,
                                                style: pw.TextStyle(
                                                    fontSize: 14,
                                                    font: pTSerifFontTtf,
                                                    color: PdfColors.grey500,
                                                    fontWeight: pw.FontWeight.bold)))
                                      ]),
                                ]))
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 35),
                child: pw.Table.fromTextArray(
                  headers: headers,
                  headerHeight: 25,
                  data: invoicesData,
                  border: pw.TableBorder.all(width: 1, color: PdfColors.grey200),
                  headerPadding: const pw.EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  cellStyle: pw.TextStyle(
                    fontSize: 17,
                    font: pTSerifFontTtf,
                    color: PdfColors.grey800,
                  ),
                  rowDecoration: const pw.BoxDecoration(
                      border: pw.Border.symmetric(
                          horizontal: pw.BorderSide(color: PdfColors.grey600, width: 1),
                          vertical: pw.BorderSide(color: PdfColors.grey600, width: 1))),
                  cellPadding: const pw.EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  headerStyle: pw.TextStyle(
                      font: pTSerifFontTtf,
                      fontWeight: pw.FontWeight.bold,
                      fontSize: 18,
                      color: PdfColors.white),
                  headerDecoration: const pw.BoxDecoration(color: PdfColors.grey700),
                  cellHeight: 30,
                  cellAlignments: {
                    0: pw.Alignment.centerLeft,
                    1: pw.Alignment.centerRight,
                    2: pw.Alignment.centerRight,
                    3: pw.Alignment.centerRight,
                    4: pw.Alignment.centerRight,
                    5: pw.Alignment.centerRight,
                  },
                ),
              ),
              pw.SizedBox(height: 1 * PdfPageFormat.cm),
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 30),
                child: pw.Column(children: [
                  pw.Row(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: [
                        pw.SizedBox(
                            width: 230,
                            child: pw.Column(
                                crossAxisAlignment: pw.CrossAxisAlignment.start,
                                children: [
                                  pw.Text('Payment Infos:',
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 23.0,
                                          font: pTSerifFontTtf,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.SizedBox(height: .5 * PdfPageFormat.cm),
                                  buildText(
                                    title: 'Account #: ',
                                    titleStyle: pw.TextStyle(
                                        fontSize: 16,
                                        font: pTSerifFontTtf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.grey900),
                                    subtitleStyle: pw.TextStyle(
                                      fontSize: 13,
                                      font: pTSerifFontTtf,
                                      color: PdfColors.grey700,
                                    ),
                                    value: invoice.id,
                                    unite: true,
                                  ),
                                  pw.SizedBox(height: .1 * PdfPageFormat.cm),
                                  buildText(
                                    title: 'A/C Name:'.toUpperCase(),
                                    titleStyle: pw.TextStyle(
                                        fontSize: 16,
                                        font: pTSerifFontTtf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.grey900),
                                    subtitleStyle: pw.TextStyle(
                                      fontSize: 13,
                                      font: pTSerifFontTtf,
                                      color: PdfColors.grey700,
                                    ),
                                    value: 'Lorem Ipsum',
                                    unite: true,
                                  ),
                                  pw.SizedBox(height: .1 * PdfPageFormat.cm),
                                  buildText(
                                    title: 'Bank Details: ',
                                    titleStyle: pw.TextStyle(
                                        fontSize: 16,
                                        font: pTSerifFontTtf,
                                        fontWeight: pw.FontWeight.bold,
                                        color: PdfColors.grey900),
                                    subtitleStyle: pw.TextStyle(
                                      fontSize: 13,
                                      font: pTSerifFontTtf,
                                      color: PdfColors.grey700,
                                    ),
                                    value: 'Add you bank details',
                                    unite: true,
                                  ),
                                  pw.SizedBox(height: 1 * PdfPageFormat.cm),
                                  pw.Text('Terms & Conditions:',
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 23.0,
                                          font: pTSerifFontTtf,
                                          fontWeight: pw.FontWeight.bold)),
                                  pw.SizedBox(height: .2 * PdfPageFormat.cm),
                                  pw.Text('Lorem, ipsum dolor sit amet consectetur adipisicing',
                                      style: pw.TextStyle(
                                          color: PdfColors.black,
                                          fontSize: 16.0,
                                          font: pTSerifFontTtf,
                                          fontWeight: pw.FontWeight.normal)),
                                ])),
                        pw.SizedBox(height: .7 * PdfPageFormat.cm),
                        pw.Padding(
                            padding: const pw.EdgeInsets.only(top: 10.0),
                            child: pw.SizedBox(
                                width: 230,
                                child: pw.Column(
                                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                                    children: [
                                      buildText(
                                        title: 'Sub Total: ',
                                        titleStyle: pw.TextStyle(
                                          fontSize: 16,
                                          font: pTSerifFontTtf,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                        subtitleStyle: pw.TextStyle(
                                            fontSize: 17,
                                            font: pTSerifFontTtf,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColors.grey700),
                                        value: "\$220.00",
                                        unite: true,
                                      ),
                                      pw.SizedBox(height: .5 * PdfPageFormat.cm),
                                      buildText(
                                        title: 'Tax: ',
                                        titleStyle: pw.TextStyle(
                                          fontSize: 17,
                                          font: pTSerifFontTtf,
                                          fontWeight: pw.FontWeight.bold,
                                        ),
                                        subtitleStyle: pw.TextStyle(
                                            fontSize: 17,
                                            font: pTSerifFontTtf,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColors.grey700),
                                        value: "0.00%",
                                        unite: true,
                                      ),
                                      pw.SizedBox(height: .5 * PdfPageFormat.cm),
                                      pw.Divider(thickness: 1, height: 2, color: PdfColors.grey900),
                                      pw.SizedBox(height: .5 * PdfPageFormat.cm),
                                      buildText(
                                        title: 'Total: ',
                                        titleStyle: pw.TextStyle(
                                            fontSize: 18,
                                            font: pTSerifFontTtf,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColors.grey900),
                                        subtitleStyle: pw.TextStyle(
                                            fontSize: 18,
                                            font: pTSerifFontTtf,
                                            fontWeight: pw.FontWeight.bold,
                                            color: PdfColors.grey800),
                                        value: '\$${invoice.total.toString()}',
                                        unite: true,
                                      ),
                                    ])))
                      ])
                ]),
              )
            ],
        footer: (context) => pw.Padding(
              padding: const pw.EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: pw.Row(
                crossAxisAlignment: pw.CrossAxisAlignment.center,
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
                  pw.SizedBox(
                    width: 230,
                    child: pw.Text(
                      invoice.paymentInstructions,
                      maxLines: 2,
                      overflow: pw.TextOverflow.clip,
                      style: pw.TextStyle(
                          font: pTSerifFontTtf,
                          fontSize: 14,
                          fontWeight: pw.FontWeight.bold,
                          color: PdfColors.grey800),
                    ),
                  ),
                  pw.SizedBox(height: 5 * PdfPageFormat.mm),
                  pw.SizedBox(
                      width: 200,
                      child: pw.Column(
                          mainAxisAlignment: pw.MainAxisAlignment.center,
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Align(
                              alignment: pw.Alignment.centerRight,
                              child: pw.Container(width: 300, height: 3, color: PdfColors.grey900),
                            ),
                            pw.SizedBox(height: 5 * PdfPageFormat.mm),
                            pw.Text(
                              "Authorised Sign",
                              maxLines: 1,
                              overflow: pw.TextOverflow.clip,
                              style: pw.TextStyle(
                                  fontSize: 14,
                                  font: pTSerifFontTtf,
                                  fontWeight: pw.FontWeight.bold,
                                  color: PdfColors.grey800),
                            ),
                          ])),
                  pw.SizedBox(height: 10 * PdfPageFormat.mm),
                ],
              ),
            )));
    Uint8List bytes = await pdf.save();
    return bytes;
  }

  static buildSimpleText({
    required String title,
    required String value,
  }) {
    final Uint8List pTSerifFontData = File('assets/fonts/PTSerif-Regular.ttf').readAsBytesSync();
    final pTSerifFontTtf = pw.Font.ttf(pTSerifFontData.buffer.asByteData());
    final style = pw.TextStyle(fontWeight: pw.FontWeight.bold, font: pTSerifFontTtf);

    return pw.Row(
      mainAxisSize: pw.MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Text(title, style: style),
        pw.SizedBox(width: 2 * PdfPageFormat.mm),
        pw.Text(value,
            style: pw.TextStyle(
              font: pTSerifFontTtf,
            )),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    pw.TextStyle? titleStyle,
    pw.TextStyle? subtitleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? pw.TextStyle(fontWeight: pw.FontWeight.bold);

    return pw.Container(
      width: width,
      child: pw.Row(
        children: [
          pw.Expanded(child: pw.Text(title, style: style)),
          pw.Text(value, style: subtitleStyle),
        ],
      ),
    );
  }
}
