# ptv_clone

A clone of the PTV app in Flutter.

## built_value 

Models are built_value types. You will need to run codegen with:

`flutter pub run build_runner build`

## Icons and Launch Screen 

I used [ApeTools](https://apetools.webprofusion.com/#/tools/imagegorilla) to quickly generate some crappy icons. I will come back and create something better at a later time. 

### API Credentials 

A signature is automatically calculated for each API call, using the API key and developer ID.

Follow the instructions at https://www.ptv.vic.gov.au/footer/data-and-reporting/datasets/ptv-timetable-api/ to obtain your credentials, then create a file

```Dart
lib/utilities/credentials.dart
```

with contents:

```Dart
const Map<String, String> credentials = <String, String>{
  'uid': 'your user id',
  'key': 'your api key'
};
```

If you put `credentials.dart` in the `lib/utilities/` folder it is already in `.gitignore` so will not be added to version control.

## Debugging with RemoteDevTools 

see https://github.com/MichaelMarner/dart-redux-remote-devtools

Get the local ip from Network Preferences and update main_rdt.dart
`remotedev --port 8000`
Run Debug Mobile configuration from launch.json 
open `http://localhost:8000`

## Generated Code 

Models use [built_value](https://pub.dev/packages/built_value).

Run codegen with: 
`flutter packages pub run build_runner build`

### Snippet for boilerplate 

Generating serializable built models with [built_value](https://pub.dev/packages/built_value) requires a fair bit of boilerplate in order to connect the model to its generated code. 

We can automate writing the boilerplate using code snippets.  For example in VSCode, the following snippet will use the file name to create all the boilerplate for a model.  
```Json
{
  "built_value class": {
	  "prefix": "blt_val",
	    "body": [
          "library ${TM_FILENAME_BASE};",
          "",
          "import 'dart:convert';",
          "",
          "import 'package:built_collection/built_collection.dart';",
          "import 'package:built_value/built_value.dart';",
          "import 'package:built_value/serializer.dart';",
          "",
          "part '${TM_FILENAME_BASE}.g.dart';",
          "",
          "abstract class ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g} implements Built<${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}, ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}Builder> {",
          "  ${1}",
          "",
          "\t${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}._();",
          "",
          "\tfactory ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}([updates(${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}Builder b)]) = _$${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g};",
          "",
          "\tString toJson() {",
          "\t\treturn json.encode(serializers.serializeWith(${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}.serializer, this));",
          "\t}",
          "",
          "",
          "\tstatic ${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g} fromJson(String jsonString) {",
          "\t\treturn serializers.deserializeWith(${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}.serializer, json.decode(jsonString));",
          "\t}",
          "",
          "\tstatic Serializer<${TM_FILENAME_BASE/(.*)/${1:/pascalcase}/g}> get serializer => _$${TM_FILENAME_BASE/([a-z]*)_+([a-z]*)/${1:/lower}${2:/capitalize}/g}Serializer;",
          "}"
	  ],
	  "description": "dart built_value class"
	},	
}
```
