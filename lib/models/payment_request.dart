// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:enzona_payments/models/amount.dart';
import 'package:enzona_payments/models/currency.dart';
import 'package:enzona_payments/models/details.dart';
import 'package:enzona_payments/models/product.dart';

class PaymentRequest {
    String merchant_uuid;
    String merchant_op_id;
    late Amount amount;
    String description;
    String return_url;
    late String currency;
    List<Product> items;
    String invoice_number;
    String cancel_url;
    final String buyer_identity_code = "";
    String terminal_id;
    

    PaymentRequest(this.merchant_uuid, this.merchant_op_id, this.description, Details details,
            this.return_url, this.cancel_url, Currency currency, this.items, this.invoice_number, this.terminal_id) {
        this.currency = currency.name;
        
        double productPriceTotal = 0;
        double productTaxTotal = 0;
        double productCount = items.length.toDouble();
        for(int i=0 ; i<productCount ; i++){
            productTaxTotal += items[i].getTax();
            productPriceTotal += items[i].getPrice() * items[i].getQuantity();
        }
        
        details.setTax(productTaxTotal);
        amount = Amount("${productPriceTotal + details.getAmount()}0", details);
    }    

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'merchant_uuid': merchant_uuid,
      'merchant_op_id': merchant_op_id,
      'amount': amount.toMap(),
      'description': description,
      'return_url': return_url,
      'currency': currency,
      'items': items.map((x) => x.toMap()).toList(),
      'invoice_number': invoice_number,
      'cancel_url': cancel_url,
      'buyer_identity_code': buyer_identity_code,
      'terminal_id': terminal_id,
    };
  }

  factory PaymentRequest.fromMap(Map<String, dynamic> map) {
    return PaymentRequest(
      map['merchant_uuid'] as String,
      map['merchant_op_id'] as String,
      map['description'] as String,
      Details.fromMap(map['details'] as Map<String,dynamic>),
      map['return_url'] as String,
      map['cancel_url'] as String,
      map['currency'] as Currency,
      List<Product>.from((map['items'] as List<int>).map<Product>((x) => Product.fromMap(x as Map<String,dynamic>),),),
      map['invoice_number'] as String,
      map['terminal_id'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentRequest.fromJson(String source) => PaymentRequest.fromMap(json.decode(source) as Map<String, dynamic>);
}
