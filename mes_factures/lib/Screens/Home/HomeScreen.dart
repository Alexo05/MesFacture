import 'dart:convert';
import 'dart:io';

import 'package:alert_info/alert_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:mes_factures/Screens/Invoices/AddInvoice.dart';
import 'package:mes_factures/models/invoiceModel.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int totalSells = 100000;
  int totalInvoices = 20;
  int totalClients = 15;
  late final controller = SlidableController(this as TickerProvider);
  List<Facture> factures = [];

  //  String jsonData = '''
  // [
  //   {
  //     "id": "inv-001",
  //     "clientName": "Zakariae",
  //     "clientEmail": "Zakariaeamrani6@gmail.com",
  //     "invoiceDate": "22-06-2025",
  //     "products": [
  //       {"name": "Iphone", "description": "Iphone", "price": 200},
  //       {"name": "Iphone", "description": "Iphone", "price": 200},
  //       {"name": "Iphone", "description": "Iphone", "price": 200},
  //       {"name": "Iphone", "description": "Iphone", "price": 200}
  //     ],
  //     "TotalHT": "5321",
  //     "TotalTTC": 5321
  //   },
  //   {
  //     "id": "inv-002",
  //     "clientName": "Zakariae",
  //     "clientEmail": "Zakariaeamrani6@gmail.com",
  //     "invoiceDate": "22-06-2025",
  //     "products": [
  //       {"name": "Iphone", "description": "Iphone", "price": 200},
  //       {"name": "Iphone", "description": "Iphone", "price": 200},
  //       {"name": "Iphone", "description": "Iphone", "price": 200},
  //       {"name": "Iphone", "description": "Iphone", "price": 200}
  //     ],
  //     "TotalHT": "5321",
  //     "TotalTTC": 5321
  //   }
  // ]
  // ''';


  void loadFactures() async {
    // final String jsonString = await rootBundle.loadString('assets/data/Factures.json');
    // final List<dynamic> jsonData = json.decode(jsonString);
    List<dynamic> jsonData =await loadJson();
    setState(() {
      factures = jsonData.map((f) => Facture.fromJson(f)).toList();
      
    });
  }
  
  Future<File> getInvoiceFile() async {
      final dir = await getApplicationDocumentsDirectory();
      final assetsDir = Directory('${dir.path}/assets/data');
       if (!await assetsDir.exists()) {
          await assetsDir.create(recursive: true); 
        }
      return File('${dir.path}/assets/data/MesFactures.json');
    }

  Future<List<dynamic>> loadJson() async {
    final file = await getInvoiceFile();
    if (!(await file.exists())) return [];

    final content = await file.readAsString();
    return json.decode(content);
  }

  Future<void> removeInvoice(int index) async {
    final file = await getInvoiceFile();
    List<dynamic> data = await loadJson();
    if (index >= 0 && index < data.length) {
      data.removeAt(index);
      await file.writeAsString(json.encode(data));
    } 
  }

  Future<void> saveJsonData(jsonData) async {
    final file = await getInvoiceFile();
    await file.writeAsString(jsonData);
    print('JSON data saved to: ${file.path}');
  }
  @override
  void initState() {
    super.initState(); 
    loadFactures();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
        backgroundColor: Theme.of(context).colorScheme.surface,
      ),
      floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              heroTag: "fab1",
              onPressed: () async {
                  Navigator.push(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) =>
                        AddInvoice(),
                  ),
                  );
              },
              shape: const CircleBorder(),
              child: Container(
                width: 60,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                  color: Theme.of(context).colorScheme.primary,
                ),
                child: Icon(CupertinoIcons.add)
              ),
            ),
      body: 
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primary,
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Colors.grey.shade300,
                          offset: const Offset(5, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Totale des Ventes",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        Text(
                          "${totalSells.toStringAsFixed(2)} \€ ",
                          style: const TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Colors.white30,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.arrow_down,
                                      size: 13,
                                      color: Colors.greenAccent,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Nombre de Factures",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        "${totalInvoices.toStringAsFixed(0)} ",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Container(
                                    width: 25,
                                    height: 25,
                                    decoration: const BoxDecoration(
                                      color: Colors.white30,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      CupertinoIcons.arrow_up,
                                      size: 13,
                                      color: Colors.red,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 12,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text(
                                        "Nombre des Clients",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w400,
                                          fontSize: 12,
                                        ),
                                      ),
                                      Text(
                                        " ${totalClients.toStringAsFixed(0)} ",
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Vos Factures",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                        },
                        child: const Text(
                          "Tous",
                          style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Expanded(
                  child: ListView.builder(
                    itemCount: factures.length > 8
                        ? 8
                        : factures.length,
                    itemBuilder: (context, int i) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Slidable(
                              key: const ValueKey(0),
                              endActionPane: ActionPane(
                                extentRatio: 0.2,
                                motion: const ScrollMotion(),
                                children: [
                                SizedBox(width: 10,),
                                SlidableAction(
                                    onPressed: (context) async {
                                      setState(() {
                                        removeInvoice(i);
                                        factures.removeAt(i);
                                      });
                                      AlertInfo.show(
                                          context: context,
                                          text: 'Facture Supprimée.',
                                          typeInfo: TypeInfo.success,
                                          backgroundColor: Colors.white,
                                          textColor: Colors.grey.shade800,
                                      );
                                    },
                                    backgroundColor: Color(0xFFFE4A49),
                                    foregroundColor: Colors.white,
                                    icon: Icons.delete,
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                    padding: EdgeInsets.all(4),
                                  ),
                                ],
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child:   Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                                horizontal: 20,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image(
                                       image: AssetImage('assets/images/invoice.png'),
                                       width: 40,
                                       ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        factures[i].id,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${factures[i].totalTTC.toStringAsFixed(2)} \€",
                                        style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Theme.of(context).colorScheme.onSurface,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      Text(
                                        factures[i].invoiceDate,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            ),
                          ),
                      );
                      
                      
                       
                    },
                  ),
                ),
                ],
              ),
              
            ),
    );
  }
}