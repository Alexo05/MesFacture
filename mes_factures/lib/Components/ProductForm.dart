import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mes_factures/models/invoiceModel.dart';

class ProductForm extends StatefulWidget {
  const ProductForm({super.key});

  @override
  State<ProductForm> createState() => _ProductFormState();
}

class _ProductFormState extends State<ProductForm> {

  Product produit = Product(name: "", description: "", qte: 0, price: 0);
  double totalPrice = 0;

  void calculateTotalPrice(){
    if(produit.price != 0 && produit.qte != 0) {
      setState(() {
        totalPrice = produit.price * produit.qte;
      });
      print(totalPrice);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(CupertinoIcons.xmark, color: Theme.of(context).colorScheme.onSurface, size: 18,),
              ),
          ],
        ),
        SizedBox(height: 10,),
        Text("Ajouter un Produit",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Theme.of(context).colorScheme.onSurface
          ),
        ),
        SizedBox(height: 20,),
        Row(
            children: [
              Text("Nom du Produit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
              ),),
              Text(" *",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red
              ),),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: "Nom  du Produit",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ), 
              ),
              onChanged: (value) {
                setState(() {
                  produit.name = value;
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Description du Produit",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
              ),),
              Text(" *",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red
              ),),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: "Description  du Produit",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ), 
              ),
              onChanged: (value) {
                setState(() {
                  produit.description = value;
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Quantité",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
              ),),
              Text(" *",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red
              ),),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: "QTE",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ), 
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: (value) {
                setState(() {
                  produit.qte = double.parse(value);
                  calculateTotalPrice();
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Prix Unitaire",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
              ),),
              Text(" *",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red
              ),),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: "Prix U",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ), 
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
              onChanged: (value) {
                setState(() {
                  produit.price = double.parse(value);
                  calculateTotalPrice();
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Prix Total",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSurface
              ),),
              Text(" *",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.red
              ),),
            ],
          ),
          SizedBox(height: 5,),
          Container(
            padding: EdgeInsets.only(left: 8, right: 8),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: totalPrice.toString(),
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 15,
                ), 
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(10),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton(
                onPressed: ()  {
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("Ajouter un Produit", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),)
                  ],
                ),
              ),
            ),
      ],
    );
  }
}