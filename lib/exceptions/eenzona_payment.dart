import 'package:enzona_payments/exceptions/eenzona.dart';

class EEnzonaPayment extends EEnzona {
    static const String error = "Failed processing payment in Enzona API";
    
    EEnzonaPayment (String message) : super(message) {
    }
    
}