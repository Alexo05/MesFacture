import 'package:alert_info/alert_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mes_factures/models/invoiceModel.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.produit, required this.index, required this.onProductDelete});
  final Product produit;
  final int index;
  final Function(int index) onProductDelete;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {

  late double totalPrice;

  @override
  void initState() {
    super.initState(); 
    totalPrice = widget.produit.price * widget.produit.qte;
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 12.0,
              horizontal: 20,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.produit.name, style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ), ),
                    Text(widget.produit.description, style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        print(widget.index);
                        widget.onProductDelete(widget.index);
                        AlertInfo.show(
                          context: context,
                          text: 'Produit supprimé.',
                          typeInfo: TypeInfo.success,
                          backgroundColor: Colors.white,
                          textColor: Colors.grey.shade800,
                      );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        width: 25,
                        height: 25,
                        child: Icon(CupertinoIcons.delete, size: 12, color: Colors.white,),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Text(widget.produit.qte.toString(), style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),),
                    Text(widget.produit.price.toString(), style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontWeight: FontWeight.w500,
                      fontSize: 14
                    ),),
                    Text(totalPrice.toString(), style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurface,
                      fontWeight: FontWeight.w600,
                      fontSize: 16
                    ),),
                  ],
                ),
              ],
            ),
            ),
        ),
       SizedBox(height: 10,),
      ],
    );
  }
}