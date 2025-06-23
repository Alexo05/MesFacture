import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mes_factures/Components/ProductCard.dart';
import 'package:mes_factures/Components/ProductForm.dart';
import 'package:mes_factures/models/invoiceModel.dart';
import 'package:popup_card/popup_card.dart';

class ProductsForm extends StatefulWidget {
  const ProductsForm({super.key, required this.onProductInsert, required this.totalPrice, required this.produits, required this.onProductDelete});
  final Function( Product produit) onProductInsert;
  final Function(int index) onProductDelete;
  final List<Product> produits;
  final double totalPrice;

  @override
  State<ProductsForm> createState() => _ProductsFormState();
}

class _ProductsFormState extends State<ProductsForm> {


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Ajouter vos Produits",
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.onSurface
            ),
            ),
            PopupItemLauncher(
              tag: "addPrduct",
              popUp: PopUpItem(
                padding: EdgeInsets.all(16), 
                color: Theme.of(context).colorScheme.surface, 
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                elevation: 1, 
                tag: "addPrduct", 
                child: ProductForm(onProductInsert: widget.onProductInsert,),
            ),
            child:  Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(CupertinoIcons.add, color: Theme.of(context).colorScheme.tertiary, size: 20, weight: 700,),
            ),
          ),
          ],
        ),
        if(widget.produits.isNotEmpty)
        Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child:  Expanded(
                    child: ListView.builder(
                      itemCount: widget.produits.length,
                      itemBuilder: (context, int i) {
                        return ProductCard(produit: widget.produits[i], index: i, onProductDelete: widget.onProductDelete,);
                      },
                    ),
              ),
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Total HT", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),),
                              Text(" ${widget.totalPrice} \€", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.tertiary),)
                            ],
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("TVA", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),),
                              Text("20%", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.tertiary),)
                            ],
                          ),
                           Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text("Total TTC", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.onSurface),),
                              Text("${((widget.totalPrice * 0.2)+ widget.totalPrice ).toStringAsFixed(2)} \€", style: TextStyle(fontSize: 14, color: Theme.of(context).colorScheme.tertiary),)
                            ],
                          )
                        ],
                      ),
                    ),
                )
              ],
            )
          ],
        )
        
      ],
    );
  }
}