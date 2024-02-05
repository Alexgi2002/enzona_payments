// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:enzona_payments/models/details.dart';

class Amount {
    String total;
    Details details;

    Amount(this.total, this.details);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'details': details.toMap(),
    };
  }

  factory Amount.fromMap(Map<String, dynamic> map) {
    return Amount(
      map['total'] as String,
      Details.fromMap(map['details'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Amount.fromJson(String source) => Amount.fromMap(json.decode(source) as Map<String, dynamic>);
}
