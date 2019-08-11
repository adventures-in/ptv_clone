# ptv_clone

A clone of the PTV app in Flutter.

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