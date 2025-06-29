import 'package:alert_info/alert_info.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:mes_factures/Components/ClientForm.dart';
import 'package:mes_factures/Components/Invoice.dart';
import 'package:mes_factures/Components/ProductsForm.dart';
import 'package:mes_factures/models/invoiceModel.dart';

class AddInvoice extends StatefulWidget {
  const AddInvoice({super.key, required this.onInvoiceInsert, required this.factureLenght});
  final Function( Facture facture) onInvoiceInsert;
  final int factureLenght;
  @override
  State<AddInvoice> createState() => _AddInvoiceState();
}

class _AddInvoiceState extends State<AddInvoice> {

  int activeStep = 0;
  bool isForward = true; 
  final _formKey = GlobalKey<FormState>(); 
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController adressController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  Facture facture = Facture(id: "", clientName: "", clientEmail: "", clientAdress: "", invoiceDate: "", products: [], totalHT: 0, totalTTC: 0);
  List<Product> produits = [];
  double totalPrice = 0;

  void onProductInsert(Product produit){
    setState(() {
      produits.add(produit);
    });
    totalPrice = 0;
    for(var p in produits){
      setState(() {
        totalPrice += p.price * p.qte;
      });
    }
  }
  
  void onProductDelete(int index){
    print(index);
      setState(() {
        produits.removeAt(index);
       });
      totalPrice = 0;
      for(var p in produits){
      setState(() {
        totalPrice += p.price * p.qte;
        });
      }
  }


  void nextStep() {
      setState(() {
        if(activeStep == 0 ){
            if(nameController.text.isNotEmpty && emailController.text.isNotEmpty && adressController.text.isNotEmpty && dateController.text.isNotEmpty){
              activeStep++;
              isForward = true;
            }
            else{
               AlertInfo.show(
                    context: context,
                    text: 'Veuillez d\'abord remplir tous les champs.',
                    typeInfo: TypeInfo.error,
                    backgroundColor: Colors.white,
                    textColor: Colors.grey.shade800,
                );
            }
        }
        else if (activeStep < 2) {
          if(produits.isEmpty){
             AlertInfo.show(
                    context: context,
                    text: 'Veuillez d\'abord ajouter un/des produits.',
                    typeInfo: TypeInfo.error,
                    backgroundColor: Colors.white,
                    textColor: Colors.grey.shade800,
                );
          }else{
            facture.id = "inv-${widget.factureLenght + 1}";
            facture.clientName = nameController.text;
            facture.clientEmail = emailController.text;
            facture.clientAdress = adressController.text;
            facture.invoiceDate = dateController.text;
            facture.products = produits;
            facture.totalHT = totalPrice;
            facture.totalTTC = ((totalPrice*0.2)+totalPrice);
            activeStep++;
            isForward = true;
          }
        }
        else{
          widget.onInvoiceInsert(facture);
          Navigator.pop(context);
        }
        
      });
  }

  void previousStep() {
    if (activeStep > 0) {
      setState(() {
        activeStep--;
        isForward = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                         Text("Ajouter une Facture", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.onSurface),),
                   ],
                 ),
                 SizedBox(height: 10,),
                 SizedBox(
                      height: 100,
                      child: EasyStepper(
                      activeStep: activeStep,
                      activeStepTextColor: Colors.black87,
                      finishedStepTextColor: Colors.black87,
                      internalPadding: 0,
                      showLoadingAnimation: false,
                      stepRadius: 8,
                      showStepBorder: false,
                      lineStyle: LineStyle(  
                        lineType: LineType.normal,
                        defaultLineColor: Colors.white,
                        finishedLineColor: Theme.of(context).colorScheme.primary,
                        lineLength: 130,
                        lineSpace: 0,
                        lineThickness: 2,
                      ),
                      steps: [
                        EasyStep(
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor:
                                  activeStep >= 0 ? Theme.of(context).colorScheme.primary: Colors.white,
                            ),
                          ),
                          title: 'Client',
                        ),
                        EasyStep(
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor:
                                  activeStep >= 1 ? Theme.of(context).colorScheme.primary: Colors.white,
                            ),
                          ),
                          title: 'Produits',
                          topTitle: true,
                        ),
                        EasyStep(
                          customStep: CircleAvatar(
                            radius: 8,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 7,
                              backgroundColor:
                                  activeStep >= 2 ? Theme.of(context).colorScheme.primary: Colors.white,
                            ),
                          ),
                          title: 'Facture',
                        ),
                       
                      ],
                      onStepReached: (index) =>
                          setState(() => activeStep = index),
                                 ),
                    ),
                    SizedBox(height: 20,),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16, right: 16),
                    child: Form(
                      key: _formKey,
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 500),
                        child: Column(
                          key: ValueKey<int>(activeStep), 
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (activeStep == 0)
                              ClientForm(nameController: nameController, emailController: emailController, adresseController: adressController, dateController: dateController,)
                            else if (activeStep == 1)
                              ProductsForm(onProductInsert: onProductInsert, totalPrice: totalPrice, produits: produits, onProductDelete: onProductDelete,)
                            else
                              Invoice(facture: facture)
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
             Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ElevatedButton(
                    onPressed: previousStep,
                    style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all(Colors.white),
                      shadowColor: WidgetStateProperty.all(Colors.transparent), 
                    ),
                    child: Text("Retour" , style: TextStyle(color: Theme.of(context).colorScheme.onSurface),),
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      onPressed: nextStep,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.transparent),
                        shadowColor: WidgetStateProperty.all(Colors.transparent), 
                      ),
                      child: Text(activeStep < 2 ? "Suivant" : "Enregistrer", 
                      style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w600,
                        ),
                        ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
      ),
    );
  }
}