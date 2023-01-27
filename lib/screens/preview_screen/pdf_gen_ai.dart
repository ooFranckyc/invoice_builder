import 'dart:typed_data';
import 'package:invoice_builder/models/invoice.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';

class PdfInvoiceGenApi {
  static Future<Uint8List> generate(Invoice invoice) async {
    //const paymentTerms = '${15} days';
    //final titles = <String>['Invoice Number:', 'Invoice Date:', 'Due Date:'];
    // final data = <String>[
    //   "100",
    //   "15",
    //   paymentTerms,
    //   "266",
    // ];
    final headers = ['Description', 'Quantity', 'Price per item', 'Total'];
    final invoicesData = [...invoice.items.map((e) => e.toList()).toList()];
    final pdf = Document(pageMode: PdfPageMode.fullscreen);
    pdf.addPage(MultiPage(
      pageTheme: const PageTheme(margin: EdgeInsets.zero),
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
                Text('FG-Open Source', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('You are welcome developper'.toUpperCase(),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              ]),
            ])),
        Container(
            decoration:
                BoxDecoration(color: PdfColors.black, borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Text("INVOICE",
                style:
                    TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: PdfColors.white)))
      ]),
      build: (context) => [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: .3 * PdfPageFormat.cm),
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
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                          Text(invoice.to.name,
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17)),
                          Text(invoice.from.address!,
                              style: TextStyle(color: PdfColors.black.shade(.70), fontSize: 14)),
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
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
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
                                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
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
        SizedBox(height: 2.55 * PdfPageFormat.cm),
        Container(
          width: double.infinity,
          decoration:
              BoxDecoration(color: PdfColors.green100, borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Invoice details',
                style: TextStyle(fontSize: 20, color: PdfColors.black, fontWeight: FontWeight.bold),
              ),
              Text(
                'All items price has ',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
        ),
        SizedBox(height: 0.5 * PdfPageFormat.cm),
        Table.fromTextArray(
          headers: headers,
          data: invoicesData,
          border: null,
          headerStyle: TextStyle(fontWeight: FontWeight.bold),
          headerDecoration: const BoxDecoration(color: PdfColors.amber300),
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
        Divider(),
        Container(
          alignment: Alignment.centerRight,
          child: Row(
            children: [
              Spacer(flex: 6),
              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildText(
                      title: 'Total amount due',
                      titleStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      value: "\$${invoice.total}",
                      unite: true,
                    ),
                    SizedBox(height: 2 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                    SizedBox(height: 0.5 * PdfPageFormat.mm),
                    Container(height: 1, color: PdfColors.grey400),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 3 * PdfPageFormat.mm),
        Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Payment Instructions",
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    invoice.paymentInstructions,
                  ),
                ],
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Image(
                  MemoryImage(
                    invoice.signature.buffer.asUint8List(),
                  ),
                  height: 80,
                ),
              )
            ]),
      ],
      footer: (context) => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Divider(),
          SizedBox(height: 8 * PdfPageFormat.mm),
          buildSimpleText(title: 'Address', value: invoice.from.address!),
          SizedBox(height: 5 * PdfPageFormat.mm),
          buildSimpleText(
              title: '', value: "email: ${invoice.from.email!} / tel: ${invoice.from.phone!}"),
        ],
      ),
    ));
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
    bool unite = false,
  }) {
    final style = titleStyle ?? TextStyle(fontWeight: FontWeight.bold);

    return Container(
      width: width,
      child: Row(
        children: [
          Expanded(child: Text(title, style: style)),
          Text(value, style: unite ? style : null),
        ],
      ),
    );
  }
}
