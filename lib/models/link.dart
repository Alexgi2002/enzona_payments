// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Link {
    final String rel;
    final String method;
    final String href;

    Link(this.rel, this.method, this.href);

    String getRel() {
        return rel;
    }

    String getMethod() {
        return method;
    }

    String getHref() {
        return href;
    }
    
    

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'rel': rel,
      'method': method,
      'href': href,
    };
  }


// "links":[{"rel":"confirm","method":"REDIRECT","href":"https://www.enzona.net/checkout/01b967077916154b2e941c35fc561d5672/login"},{"rel":"complete","method":"POST","href":"https://api.enzona.net/payment/v1.0.0/payments/3bf233e54c17470f8e2df862afa3ad09/complete"},{"rel":"cancel","method":"POST","href":"https://api.enzona.net/payment/v1.0.0/payments/3bf233e54c17470f8e2df862afa3ad09/cancel"},{"rel":"refund","method":"POST","href":"https://api.enzona.net/payment/v1.0.0/payments/3bf233e54c17470f8e2df862afa3ad09/refund"},{"rel":"self","method":"GET","href":"https://api.enzona.net/payment/v1.0.0/payments/3bf233e54c17470f8e2df862afa3ad09"}]
  factory Link.fromMap(Map<String, dynamic> map) {
    return Link(
      map['rel'] as String,
      map['method'] as String,
      map['href'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Link.fromJson(String source) => Link.fromMap(json.decode(source) as Map<String, dynamic>);
}
