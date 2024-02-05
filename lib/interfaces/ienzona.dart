import 'package:enzona_payments/models/payment.dart';
import 'package:enzona_payments/models/payment_request.dart';

abstract class IEnzona{
    Future<Payment> createPayment(PaymentRequest paymentRequest);
    Future<bool> completePayment(String transactionUuid);
    Future<bool> cancelPayment(String transactionUuid);
    Future<Payment> getPayment(String transactionUuid);
}