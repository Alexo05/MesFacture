class Facture {
  final String id;
  final String clientName;
  final String clientEmail;
  final String invoiceDate;
  final List<Product> products;
  final String totalHT;
  final dynamic totalTTC; 

  Facture({
    required this.id,
    required this.clientName,
    required this.clientEmail,
    required this.invoiceDate,
    required this.products,
    required this.totalHT,
    required this.totalTTC,
  });

  factory Facture.fromJson(Map<String, dynamic> json) {
    return Facture(
      id: json['id'],
      clientName: json['clientName'],
      clientEmail: json['clientEmail'],
      invoiceDate: json['invoiceDate'],
      products: (json['products'] as List<dynamic>)
          .map((item) => Product.fromJson(item))
          .toList(),
      totalHT: json['TotalHT'] ?? '',
      totalTTC: json['TotalTTC'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientName': clientName,
      'clientEmail': clientEmail,
      'invoiceDate': invoiceDate,
      'products': products.map((e) => e.toJson()).toList(),
      'TotalHT': totalHT,
      'TotalTTC': totalTTC,
    };
  }
}

class Product {
  String name;
  String description;
  dynamic qte;
  dynamic price; 

  Product({
    required this.name,
    required this.description,
    required this.qte,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      description: json['description'],
      qte: json['qte'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'qte': qte,
      'price': price,
    };
  }
}
