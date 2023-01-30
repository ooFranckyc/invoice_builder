import 'dart:typed_data';
import 'package:invoice_builder/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfInvoiceGenApi {
  static Future<Uint8List> generate(Invoice invoice) async {
    final headers = ['Item Description', 'Qty', 'Price', 'Total'];
    final invoicesData = [...invoice.items.map((e) => e.toList()).toList()];
    final pdf = Document(pageMode: PdfPageMode.fullscreen);
    pdf.addPage(MultiPage(
        pageTheme: const PageTheme(margin: EdgeInsets.zero),
        //pageFormat: PdfPageFormat.a4,
        maxPages: 2,
        header: (context) =>
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Padding(
                  padding: const EdgeInsets.all(50),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    Transform.rotate(
                        angle: 120,
                        child: Container(
                            width: 30,
                            height: 30,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(width: 2, color: PdfColors.green900),
                                borderRadius: BorderRadius.circular(5)))),
                    SizedBox(width: 10),
                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                      Text('FG-Open Source',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      Text('You are welcome developer'.toUpperCase(),
                          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    ]),
                  ])),
              Container(
                  decoration: BoxDecoration(
                      color: PdfColors.grey800, borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  child: Text("INVOICE",
                      style: TextStyle(
                          fontSize: 50, fontWeight: FontWeight.bold, color: PdfColors.white)))
            ]),
        build: (context) => [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: .1 * PdfPageFormat.cm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // (invoice.from.logo != null)
                            //     ? Image(
                            //         MemoryImage(invoice.from.logo!),
                            //         height: 80,
                            //         width: 80,
                            //       )
                            //     : Text(""),
                            // SizedBox(height: 1 * PdfPageFormat.cm),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Invoice to:',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 23,
                                        color: PdfColors.grey800)),
                                SizedBox(height: .1 * PdfPageFormat.cm),
                                Text(invoice.to.name,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: PdfColors.grey800)),
                                Text(invoice.from.address!,
                                    style: const TextStyle(color: PdfColors.grey700, fontSize: 14)),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                            width: 210,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text('Invoice# ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 22)),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(invoice.id,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: PdfColors.grey500,
                                                    fontWeight: FontWeight.bold)))
                                      ]),
                                  Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Text('Date ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold, fontSize: 22)),
                                        Align(
                                            alignment: Alignment.centerRight,
                                            child: Text(invoice.date,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    color: PdfColors.grey500,
                                                    fontWeight: FontWeight.bold)))
                                      ]),
                                ]))
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 1 * PdfPageFormat.cm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 35),
                child: Table.fromTextArray(
                  headers: headers,
                  headerHeight: 25,
                  data: invoicesData,
                  border: TableBorder.all(width: 1, color: PdfColors.grey200),
                  headerPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  cellStyle: const TextStyle(
                    fontSize: 17,
                    color: PdfColors.grey800,
                  ),
                  rowDecoration: const BoxDecoration(
                      border: Border.symmetric(
                          horizontal: BorderSide(color: PdfColors.grey600, width: 1),
                          vertical: BorderSide(color: PdfColors.grey600, width: 1))),
                  cellPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 10),
                  headerStyle:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PdfColors.white),
                  headerDecoration: const BoxDecoration(color: PdfColors.grey700),
                  cellHeight: 30,
                  cellAlignments: {
                    0: Alignment.centerLeft,
                    1: Alignment.centerRight,
                    2: Alignment.centerRight,
                    3: Alignment.centerRight,
                    4: Alignment.centerRight,
                    5: Alignment.centerRight,
                  },
                ),
              ),
              SizedBox(height: 1.55 * PdfPageFormat.cm),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(children: [
                  Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                            width: 230,
                            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                              Text('Payment Infos:',
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: .5 * PdfPageFormat.cm),
                              buildText(
                                title: 'Account #: ',
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: PdfColors.grey900),
                                subtitleStyle: const TextStyle(
                                  fontSize: 13,
                                  color: PdfColors.grey700,
                                ),
                                value: invoice.id,
                                unite: true,
                              ),
                              SizedBox(height: .1 * PdfPageFormat.cm),
                              buildText(
                                title: 'A/C Name:'.toUpperCase(),
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: PdfColors.grey900),
                                subtitleStyle: const TextStyle(
                                  fontSize: 13,
                                  color: PdfColors.grey700,
                                ),
                                value: 'Lorem Ipsum',
                                unite: true,
                              ),
                              SizedBox(height: .1 * PdfPageFormat.cm),
                              buildText(
                                title: 'Bank Details: ',
                                titleStyle: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: PdfColors.grey900),
                                subtitleStyle: const TextStyle(
                                  fontSize: 13,
                                  color: PdfColors.grey700,
                                ),
                                value: 'Add you bank details',
                                unite: true,
                              ),
                              SizedBox(height: 1 * PdfPageFormat.cm),
                              Text('Terms & Conditions:',
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 23.0,
                                      fontWeight: FontWeight.bold)),
                              SizedBox(height: .2 * PdfPageFormat.cm),
                              Text('Lorem, ipsum dolor sit amet consectetur adipisicing',
                                  style: TextStyle(
                                      color: PdfColors.black,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.normal)),
                            ])),
                        SizedBox(height: .7 * PdfPageFormat.cm),
                        Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: SizedBox(
                                width: 230,
                                child:
                                    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                                  buildText(
                                    title: 'Sub Total: ',
                                    titleStyle: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    subtitleStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: PdfColors.grey700),
                                    value: "\$220.00",
                                    unite: true,
                                  ),
                                  SizedBox(height: .5 * PdfPageFormat.cm),
                                  buildText(
                                    title: 'Tax: ',
                                    titleStyle: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    subtitleStyle: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: PdfColors.grey700),
                                    value: "0.00%",
                                    unite: true,
                                  ),
                                  SizedBox(height: .5 * PdfPageFormat.cm),
                                  Divider(thickness: 1, height: 2, color: PdfColors.grey900),
                                  SizedBox(height: .5 * PdfPageFormat.cm),
                                  buildText(
                                    title: 'Total: ',
                                    titleStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: PdfColors.grey900),
                                    subtitleStyle: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: PdfColors.grey800),
                                    value: '\$${invoice.total.toString()}',
                                    unite: true,
                                  ),
                                ])))
                      ])
                ]),
              )
            ],
        footer: (context) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 230,
                    child: Text(
                      invoice.paymentInstructions,
                      maxLines: 2,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold, color: PdfColors.grey800),
                    ),
                  ),
                  SizedBox(height: 5 * PdfPageFormat.mm),
                  SizedBox(
                      width: 200,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.centerRight,
                              child: Container(width: 300, height: 3, color: PdfColors.grey900),
                            ),
                            SizedBox(height: 5 * PdfPageFormat.mm),
                            Text(
                              "Authorised Sign",
                              maxLines: 1,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: PdfColors.grey800),
                            ),
                          ])),
                  SizedBox(height: 10 * PdfPageFormat.mm),
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
    final style = TextStyle(fontWeight: FontWeight.bold);

    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(title, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value),
      ],
    );
  }

  static buildText({
    required String title,
    required String value,
    double width = double.infinity,
    TextStyle? titleStyle,
    TextStyle? subtitleStyle,
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: subtitleStyle),
        ],
      ),
    );
  }
}
