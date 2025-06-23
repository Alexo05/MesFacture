import 'package:flutter/material.dart';
import 'package:mes_factures/Components/Invoice.dart';
import 'package:mes_factures/models/invoiceModel.dart';

class InvoiceView extends StatefulWidget {
  const InvoiceView({super.key, required this.facture});
  final Facture facture;

  @override
  State<InvoiceView> createState() => _InvoiceViewState();
}

class _InvoiceViewState extends State<InvoiceView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Column(
              children: [
                Row(
                   children: [
                      GestureDetector(
                         onTap: () => {
                           Navigator.pop(context)
                         },
                          child: Stack(
                           alignment: Alignment.center,
                           children: [
                             Container(
                               width: 40,
                               height: 40,
                               decoration: BoxDecoration(
                                 borderRadius: BorderRadius.circular(15),
                                 color: Theme.of(context).colorScheme.secondary,
                               ),
                               child: Icon(Icons.arrow_back_ios_new, color: Theme.of(context).colorScheme.tertiary, size: 20,),
                             ),
                           ],
                        ),
                        ),
                        SizedBox(width: 10,),
                         Text(widget.facture.id, style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),),
                   ],
                 ),
              ],
            ),
            SizedBox(height: 30,),
            Invoice(facture: widget.facture)
          ],
        ),
      ),
    );
  }
}