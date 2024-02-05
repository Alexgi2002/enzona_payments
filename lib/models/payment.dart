// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:enzona_payments/models/currency.dart';
import 'package:enzona_payments/models/link.dart';
import 'package:enzona_payments/models/product.dart';
import 'package:enzona_payments/models/status_denom.dart';

class Payment {
    final String transaction_uuid;
    final String created_at;
    final String updated_at;
    final int status_code;
    Currency currency = Currency.CUP;
    final String status_denom;
    StatusDenom status = StatusDenom.Desactivada;
    final String description;
    final String merchant_op_id;
    final double price_total;
    final List<Product> items;
    final List<Link> links;

    Payment(this.transaction_uuid, this.created_at,
      this.updated_at, this.status_code, String currency,
      this.status_denom, this.description, this.merchant_op_id,
      this.price_total, this.items, this.links) {

        for (var element in Currency.values) {
          if(element.name == currency){
            this.currency = element;
          }
        }
        for (var element in StatusDenom.values) {
          if(element.name == status_denom){
            status = element;
          }
        }
      }

    String getTransaction_uuid() {
        return transaction_uuid;
    }

    String getCreated_at() {
        return created_at;
    }

    String getUpdated_at() {
        return updated_at;
    }

    int getStatus_code() {
        return status_code;
    }

    Currency getCurrency() {
        return currency;
    }

    StatusDenom getStatus() {
        StatusDenom status = StatusDenom.Cancelada; 
        for (var element in StatusDenom.values) { 
          if(element.name == status_denom){
            status = element;
          }
        }
        return status;
    }

    String getDescription() {
        return description;
    }

    String getMerchant_op_id() {
        return merchant_op_id;
    }

    double getPrice_total() {
        return price_total;
    }

    List<Product> getItems() {
        return items;
    }

    List<Link> getLinks() {
        return links;
    }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'transaction_uuid': transaction_uuid,
      'created_at': created_at,
      'updated_at': updated_at,
      'status_code': status_code,
      'currency': currency.name,
      'status_denom': status_denom,
      'description': description,
      'merchant_op_id': merchant_op_id,
      'price_total': price_total,
      'items': items.map((x) => x.toMap()).toList(),
      'links': links.map((x) => x.toMap()).toList(),
    };
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(
      map['transaction_uuid'] as String,
      map['created_at'] as String,
      map['updated_at'] as String,
      map['status_code'] as int,
      map['currency'] as String,
      map['status_denom'] as String,
      map['description'] as String,
      map['merchant_op_id'] as String,
      double.parse(map['amount']["total"]),
      List<Product>.from((map['items'] as List<dynamic>).map<Product>((x) => Product.fromMap(x as Map<String,dynamic>),),),
      List<Link>.from((map['links'] as List<dynamic>).map<Link>((x) => Link.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) => Payment.fromMap(json.decode(source) as Map<String, dynamic>);
}
