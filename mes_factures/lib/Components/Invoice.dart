import 'package:flutter/material.dart';
import 'package:mes_factures/models/invoiceModel.dart';

class Invoice extends StatefulWidget {
  const Invoice({super.key, required this.facture});
  final Facture facture;
  @override
  State<Invoice> createState() => _InvoiceState();
}

class _InvoiceState extends State<Invoice> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      decoration: BoxDecoration(
        color: Colors.white
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text('Facture: ${widget.facture.id}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text('Date: ${widget.facture.invoiceDate}'),
            SizedBox(height: 16),
          
            // Client Info
            Text('Client: ${widget.facture.clientName}'),
            Text('Email: ${widget.facture.clientEmail}'),
            Text('Adresse: ${widget.facture.clientAdress}'),
            Divider(),
          
            // Product Table
            Table(
              border: TableBorder.all(),
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(3),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(1),
              },
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[300]),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Produit', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Description', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Prix', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('Qté', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                ...widget.facture.products.map((p) => TableRow(
                  children: [
                    Padding(padding: EdgeInsets.all(4), child: Text(p.name)),
                    Padding(padding: EdgeInsets.all(4), child: Text(p.description)),
                    Padding(padding: EdgeInsets.all(4), child: Text('${p.price.toStringAsFixed(2)}')),
                    Padding(padding: EdgeInsets.all(4), child: Text('${p.qte}')),
                  ],
                )),
              ],
            ),
          
            SizedBox(height: 16),
            Divider(),
          
            // Totals
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("Total HT: ${widget.facture.totalHT.toStringAsFixed(2)} \€", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("TVA(20%): ${(widget.facture.totalHT*0.2).toStringAsFixed(2)} \€", style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Total TTC: ${widget.facture.totalTTC.toStringAsFixed(2)} \€", style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    )
;
  }
}