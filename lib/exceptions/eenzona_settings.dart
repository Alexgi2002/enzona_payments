import 'package:enzona_payments/exceptions/eenzona.dart';

class EEnzonaSettings extends EEnzona {
    static const String error = "Failed to set Enzona parameters";    
    
    EEnzonaSettings (String message) : super(message);
}