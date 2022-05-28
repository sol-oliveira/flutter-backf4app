import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final keyApplicationId = '';
  final keyClientKey = '';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, autoSendSessionId: true);

       var firstObject = ParseObject('FirstClass')
    ..set(
        'message', 'Hey ! Gouvea First message from Flutter. Parse is now connected');
  await firstObject.save();
  
  print('done');

}