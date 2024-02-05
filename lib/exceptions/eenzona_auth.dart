import 'package:enzona_payments/exceptions/eenzona.dart';

class EEnzonaAuth extends EEnzona {
    String emsg  ="";
    static const String error = "Authentication failed in the Enzona API";
    
    EEnzonaAuth(String message) : super(message) {
        emsg = error;
    }
}