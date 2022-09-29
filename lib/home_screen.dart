// import 'package:demo_app/models/person.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_geocoder/geocoder.dart';
// import 'package:geocoding/geocoding.dart';
//
// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   // PhoneContact? _pickedContact;
//   String? address;
//   Address? address2;
//
//   final personjson = {
//     "name": 'Ritesh',
//     "Age": "22"
//   };
//
//   var json = <String, dynamic>{
//     'root': 'value',
//     'root2': <String, dynamic>{'leaf': 'fruit'}
//   };
//
//   bool checkIfNotEmpty(String? value) {
//     return value != null && value.isNotEmpty && value != "null";
//   }
//
//   _getFromGeoCoding() async {
//     final placemark = await placemarkFromCoordinates(
//         26.1498592, 85.3645463
//     );
//     if (placemark.isNotEmpty) {
//       final list = <String?>[];
//       if (checkIfNotEmpty(placemark[0].name)) {
//         list.add(placemark[0].name);
//       }
//       if (checkIfNotEmpty(placemark[0].subLocality)) {
//         list.add(placemark[0].subLocality);
//       }
//       if (checkIfNotEmpty(placemark[0].locality)) {
//         list.add(placemark[0].locality);
//       }
//       if (checkIfNotEmpty(placemark[0].subAdministrativeArea)) {
//         list.add(placemark[0].subAdministrativeArea);
//       }
//       if (checkIfNotEmpty(placemark[0].administrativeArea)) {
//         list.add(placemark[0].administrativeArea);
//       }
//       if (checkIfNotEmpty(placemark[0].postalCode)) {
//         list.add(placemark[0].postalCode);
//       }
//       if (checkIfNotEmpty(placemark[0].country)) {
//         list.add(placemark[0].country);
//       }
//
//       print(placemark.first.toJson());
//
//       return list.join(', ');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     final p = Person.fromjson(personjson);
//
//     return Scaffold(
//       appBar: AppBar(),
//       body: SafeArea(
//         child: Column(
//           children: [
//
//             // Text(JSONUtils().get(json, 'root', 'defaultValue')),
//
//             if (address != null)
//               Text(address!)
//             else
//               Text('please pick contact'),
//
//
//             ElevatedButton(
//               onPressed: () async {
//
//                 address = await _getFromGeoCoding();
//                 setState(() {});
//               },
//               child: Text('pick contact'),
//             ),
//
//             if (address2 != null)
//               Text(address2!.addressLine!)
//             else
//               Text('please pick contact'),
//             ElevatedButton(
//               onPressed: () async {
//                 final ad = await Geocoder.local.findAddressesFromCoordinates(Coordinates(
//                     26.1498592,85.3645463
//                 ));
//                 if(ad.isNotEmpty) {
//                   address2 = ad.first;
//                 }else{
//                   print('empty result');
//                 }
//                 setState(() {});
//               },
//               child: Text('pick contact'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
