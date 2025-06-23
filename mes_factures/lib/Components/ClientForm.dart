

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/date_picker.dart';
import 'package:flutter_holo_date_picker/i18n/date_picker_i18n.dart';
import 'package:intl/intl.dart';

class ClientForm extends StatefulWidget {
  const ClientForm({super.key, required this.nameController, required this.emailController, required this.adresseController, required this.dateController});
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController adresseController;
  final TextEditingController dateController;

  @override
  State<ClientForm> createState() => _ClientFormState();
}

class _ClientFormState extends State<ClientForm> {
  var invoiceDate;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Ajouter les informations de votre Client",
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.w700,
                color: Theme.of(context).colorScheme.onSurface
              ),),
        SizedBox(height: 30,),
         Row(
            children: [
              Text("Nom Complet",
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
              controller: widget.nameController,
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: "Nom Complet",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ), 
              ),
              onChanged: (value) {
                setState(() {
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Email",
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
              controller: widget.emailController,
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: "Date de la facture",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ), 
              ),
              onChanged: (value) {
                setState(() {
                });
              },
            ),
          ),
           SizedBox(height: 20,),
          Row(
            children: [
              Text("Adresse",
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
              controller: widget.adresseController,
              decoration: InputDecoration(
                border: InputBorder.none, 
                hintText: "Adresse",
                hintStyle: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 15,
                ), 
              ),
              onChanged: (value) {
                setState(() {
                });
              },
            ),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Text("Date de la facture",
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
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              onPressed: () async {
                    var datePicked = await DatePicker.showSimpleDatePicker(
                        context,
                        // initialDate: DateTime(2020),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2090),
                        dateFormat: "dd-MMMM-yyyy",
                        locale: DateTimePickerLocale.en_us,
                        looping: true,
                      );
                    setState(() {
                      if(datePicked != null) invoiceDate = DateFormat('dd-MM-yyyy').format(datePicked);
                      widget.dateController.text = invoiceDate.toString();
                    });
              },
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.transparent),
                shadowColor: WidgetStateProperty.all(Colors.transparent), 
              ),
              // ignore: prefer_if_null_operators
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.dateController.text ?? "Selectionner une date", 
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    ),
                    ),
                  Icon(CupertinoIcons.time, color: Theme.of(context).colorScheme.tertiary,)
                ],
              ),
            ),
          ),

      ],
    );
  }
}