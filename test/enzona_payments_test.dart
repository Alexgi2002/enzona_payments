import 'package:enzona_payments/exceptions/eenzona.dart';
import 'package:enzona_payments/merchant_Info.dart';

import 'package:enzona_payments/enzona_payments.dart';
import 'package:enzona_payments/models/currency.dart';
import 'package:enzona_payments/models/details.dart';
import 'package:enzona_payments/models/payment.dart';
import 'package:enzona_payments/models/payment_request.dart';
import 'package:enzona_payments/models/product.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test("Test Enzona lib", () async {
    try {
             //Create an instance of an Enzona object by passing the consumer_key and consumer_secret of your merchant
             final Enzona e = Enzona(MerchantInfo("consumer_key", "consumer_secret"));
             
             //Create the list of products to send
            List<Product> items = [];
            items.add(Product(1, "Product1", "description1", 100.0 , 0.0));
            items.add(Product(2, "Product2", "description2", 100.0 , 5.0));
             
             //Create a new payment with the createPayment method
             Payment payment = await e.createPayment(PaymentRequest(
                     "merchant_uuid",
                     "000000000001",
                     "description",
                     Details(0, 0, 0),
                     "https://www.enzona.net/ok",
                     "https://www.enzona.net/cancel",
                     Currency.CUP,
                     items,
                     "1",
                     "1"
             ));
              print("CreatePayment");
              print(payment.toMap());

             //Check the details and status of your payment request
             Payment paymentCheck = await e.getPayment("c7f11e8359024f03882c8e4a0a513407");
            print("GetPayment");
            print(paymentCheck.toMap());

         } on EEnzona catch(ex){
             print(ex.toString());
         }
  });
}
