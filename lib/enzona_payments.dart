library enzona_payments;

import 'package:enzona_payments/exceptions/eenzona_payment.dart';
import 'package:enzona_payments/interfaces/ienzona.dart';
import 'package:enzona_payments/merchant_Info.dart';
import 'package:enzona_payments/models/payment.dart';
import 'package:enzona_payments/models/payment_request.dart';
import 'package:enzona_payments/utils/constants.dart';
/*
 *
 * @author alexgi
 */
class Enzona implements IEnzona{
    
    final MerchantInfo merchantInfo;

    Enzona(this.merchantInfo);
    
    @override
    Future<Payment> createPayment(PaymentRequest paymentRequest) async {
        try {
            String data = paymentRequest.toJson();
            
            final response = await merchantInfo.getClient().post(
              Uri.https(Constants.url , Constants.api_payment),
              body: data,
              headers: {
                "Authorization":"Bearer ${await merchantInfo.getToken()}",
                "Content-Type": "application/json"
              }
            );
            return Payment.fromJson(response.body);
            
        } catch (ex) {
          throw EEnzonaPayment(ex.toString());
        }
    }

    @override
    Future<bool> completePayment(String transactionUuid) async {
        try {
            final response = await merchantInfo.getClient().post(
              Uri.https(Constants.url, "${Constants.api_payment}/$transactionUuid/complete",),
              headers: {
                "Authorization":"Bearer ${await merchantInfo.getToken()}",
                "Content-Type": "application/json"
              }
            );
                        
            if(response.statusCode == 403){
                throw EEnzonaPayment("Transacción no confirmada");
            }
            
            return response.statusCode == 200;
            
        } catch (ex) {
            throw EEnzonaPayment(ex.toString());
        }
    }

    @override
    Future<bool> cancelPayment(String transactionUuid) async {
        try {
            final response = await merchantInfo.getClient().post(
              Uri.https(Constants.url, "${Constants.api_payment}/$transactionUuid/cancel"),
              headers: {
                "Authorization":"Bearer ${await merchantInfo.getToken()}",
                "Content-Type": "application/json"
              }
            );
                        
            return response.statusCode == 200;
            
        } catch (ex) {
          throw EEnzonaPayment(ex.toString());
        }
    }

    @override
    Future<Payment> getPayment(String transactionUuid) async {
        try {

            final response = await merchantInfo.getClient().get(
              Uri.https(Constants.url,"${Constants.api_payment}/$transactionUuid"),
              headers: {
                "Authorization" : "Bearer ${await merchantInfo.getToken()}",
                "Content-Type": "application/json"
              }
            );
            
            return Payment.fromJson(response.body);
            
        } catch (ex) {
          throw EEnzonaPayment(ex.toString());
        }        
    }
    
}

