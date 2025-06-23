import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mes_factures/Components/ProductForm.dart';
import 'package:mes_factures/models/invoiceModel.dart';
import 'package:popup_card/popup_card.dart';

class ProductsForm extends StatefulWidget {
  const ProductsForm({super.key});

  @override
  State<ProductsForm> createState() => _ProductsFormState();
}

class _ProductsFormState extends State<ProductsForm> {

  List<Product> produits = [];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
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
                child: ProductForm(),
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
        )
      ],
    );
  }
}