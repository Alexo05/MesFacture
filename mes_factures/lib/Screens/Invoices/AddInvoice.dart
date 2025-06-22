import 'package:flutter/material.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({super.key});

  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
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
                     Text("Ajouter une Facture", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),),
               ],
             ),
          ],
        ),
      ),
    );
  }
}