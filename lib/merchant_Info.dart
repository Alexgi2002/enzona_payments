// ignore_for_file: non_constant_identifier_names, file_names

import 'dart:convert';
import 'dart:io';
import 'package:enzona_payments/exceptions/eenzona_settings.dart';
import 'package:enzona_payments/utils/http_overrides.dart';
import 'package:http/http.dart' as http;

import 'package:enzona_payments/utils/constants.dart';

class MerchantInfo {
    final String consumer_key;
    final String consumer_secret;
    
    late http.Client _client;
    String _token = "";
    int _expireTime = 0;
    
    MerchantInfo(this.consumer_key, this.consumer_secret) {
      _init();
    }
    
    void _init(){
      try {
        HttpOverrides.global = MyHttpOverrides();
        _client = http.Client();
        // await authenticate();             
      } catch (ex) {
        EEnzonaSettings(ex.toString());
      }
    }
     
    Future<void> _checkToken() async {
      if(DateTime.now().millisecondsSinceEpoch > _expireTime){
        await authenticate();
      }
    }

    Future<String> getToken() async {
      await _checkToken();
      return _token;
    }

    int getExpireTime() {
      return _expireTime;
    }

    http.Client getClient() {
      return _client;
    }
     
    Future<bool> authenticate() async {
        try {
            String auth = base64.encode(("$consumer_key:$consumer_secret").codeUnits);
            
            final response = await _client.post(Uri.https(Constants.url, "/token"), headers: {"Authorization" : "Basic $auth"}, body: {
              "grant_type" : "client_credentials",
              "scope" : Constants.scope
            });

            final data = jsonDecode(response.body) as Map<String, dynamic>;

            _token = data["access_token"];
            
            _expireTime = DateTime.now().millisecondsSinceEpoch + data["expires_in"] as int;
            
            return _token.isNotEmpty;
            
        } on Exception{
          return false;
        }
    }
}