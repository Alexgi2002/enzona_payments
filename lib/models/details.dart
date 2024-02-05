// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';


class Details {
    late String shipping;
    late String discount;
    late String tip;
    String tax;

    Details(double shipping, double discount, double tip,{this.tax="0.0"}){
      this.shipping = "${shipping}0";
      this.discount = "${discount}0";
      this.tip = "${tip}0";
    }

    void setTax(double tax) {
        this.tax = "${tax}0";
    }
    
    double getAmount(){
        double shipping = double.parse(this.shipping);
        double discount = double.parse(this.discount);
        double tax = double.parse(this.tax);
        double tip = double.parse(this.tip);
        
        return shipping - discount + tax + tip;
    }
    

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'shipping': shipping,
      'discount': discount,
      'tax': tax,
      'tip': tip,
    };
  }

  factory Details.fromMap(Map<String, dynamic> map) {
    return Details(
      map['shipping'] as double,
      map['discount'] as double,
      map['tip'] as double,
    );
  }

  String toJson() => json.encode(toMap());

  factory Details.fromJson(String source) => Details.fromMap(json.decode(source) as Map<String, dynamic>);
}
