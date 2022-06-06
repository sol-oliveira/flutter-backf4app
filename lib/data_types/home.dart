import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String objectId = 'Fgl5vxO3KX';

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Parse Data Types"),
          backgroundColor: Colors.blueAccent,
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 200,
                  child: Image.asset(
                      "assets/images/logo.png"),
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(onPressed: doSaveData, child: const Text('Save Data')),
                 const SizedBox(
                  height: 16,
                ),
                ElevatedButton(onPressed: doReadData, child: const Text('Read Data')),
                 const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: doUpdateData, child: const Text('Update Data'))
              ],
            ),
          ),
        ));
  }

  void doSaveData() async {

     var parseObject = ParseObject("DataTypes")
      ..set("stringField", "String")
      ..set("doubleField", 1.5)
      ..set("intField", 2)
      ..set("boolField", true)
      ..set("dateField", DateTime.now())
      ..set("jsonField", {"field1": "value1", "field2": "value2"})
      ..set("listStringField", ["a", "b", "c", "d"])
      ..set("listIntField", [0, 1, 2, 3, 4])
      ..set("listBoolField", [false, true, false])
      ..set("listJsonField", [
        {"field1": "value1", "field2": "value2"},
        {"field1": "value1", "field2": "value2"}
      ]);
      
    final ParseResponse parseResponse = await parseObject.save();

    if (parseResponse.success) {
      objectId = (parseResponse.results!.first as ParseObject).objectId!;
      showMessage('Object created: $objectId');
    } else {
      showMessage('Object created with failed: ${parseResponse.error.toString()}');
    }
    
  }

  void doReadData() async {
    print('dddd');
     if (objectId.isEmpty) {
      showMessage('None objectId. Click button Save Date before.');
      return;
    }

    QueryBuilder<ParseObject> queryUsers =
        QueryBuilder<ParseObject>(ParseObject('DataTypes'))
          ..whereEqualTo('objectId', objectId);
    final ParseResponse parseResponse = await queryUsers.query();
    if (parseResponse.success && parseResponse.results != null) {
      final object = (parseResponse.results!.first) as ParseObject;
      debugPrint('stringField: ${object.get<String>('stringField')}');
      debugPrint('stringField: ${object.get<String>('stringField')}');
      debugPrint('doubleField: ${object.get<double>('doubleField')}');
      debugPrint('intField: ${object.get<int>('intField')}');
      debugPrint('boolField: ${object.get<bool>('boolField')}');
      debugPrint('dateField: ${object.get<DateTime>('dateField')}');
      debugPrint('jsonField: ${object.get<Map<String, dynamic>>('jsonField')}');
      debugPrint('listStringField: ${object.get<List>('listStringField')}');
      debugPrint('listNumberField: ${object.get<List>('listNumberField')}');
      debugPrint('listIntField: ${object.get<List>('listIntField')}');
      debugPrint('listBoolField: ${object.get<List>('listBoolField')}');
      debugPrint('listJsonField: ${object.get<List>('listJsonField')}');
    }
    
  }

  void doUpdateData() async {

      if (objectId.isEmpty) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
            const SnackBar(content: Text('None objectId. Click Save before.')));
      return;
    }

    final parseObject = ParseObject("DataTypes")
      ..objectId = objectId
      ..set("intField", 3)
      ..set("listStringField", ["a", "b", "c", "d", "e"]);

    final ParseResponse parseResponse = await parseObject.save();

    if (parseResponse.success) {
      showMessage('Object updated: $objectId');
    } else {
      showMessage('Object updated with failed: ${parseResponse.error.toString()}');
    }
    
  }
}