# ptv_clone

A clone of the PTV app in Flutter.

## API Key 

Follow the instructions at https://www.ptv.vic.gov.au/footer/data-and-reporting/datasets/ptv-timetable-api/ to obtain your credentials, then add the file `lib/utilities/credentials.dart` with contents: 

```Dart
const Map<String, String> credentials = <String, String>{
  'uid': 'your user id',
  'key': 'your api key'
};
```

the file is already in `.gitignore` so there's no danger of adding your credentials to version control

## Swagger 

Swagger docs for the PTV API: https://timetableapi.ptv.vic.gov.au/swagger/ui/index 

Swagger codegen info: https://github.com/swagger-api/swagger-codegen

