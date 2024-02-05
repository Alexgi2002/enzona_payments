// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:enzona_payments/exceptions/eenzona_payment.dart';

class Product {
    final int quantity;
    late String price;
    late String name;
    late String description;
    late String tax;

    Product(this.quantity, this.name, this.description, double price, double tax){
        if(quantity<1){
            throw EEnzonaPayment("Quantity must be greater than zero");
        }
        if(price<=0){
            throw EEnzonaPayment("Price must be greater than zero");
        }
        
        this.price = "${price}0";
        this.tax = "${tax}0";
    }

    double getPrice() {
        return double.parse(price);
    }

    int getQuantity() {
        return quantity;
    }

    double getTax() {
        return double.parse(tax);
    }
    
    

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'quantity': quantity,
      'price': price,
      'name': name,
      'description': description,
      'tax': tax,
    };
  }

  // "items":[{"description":"description1","quantity":"1","price":"100.00","tax":"0.00","name":"Product1"},{"description":"description2","quantity":"2","price":"100.00","tax":"5.00","name":"Product2"}]

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      int.parse(map['quantity']),
      map['name'] as String,
      map['description'] as String,
      double.parse(map['price']),
      double.parse(map['tax']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
