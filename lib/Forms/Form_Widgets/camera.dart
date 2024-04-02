// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_image_compress/flutter_image_compress.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart' as path_provider;
// import 'package:intl/intl.dart';
// import 'dart:io';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:lottie/lottie.dart';
//
// import '../../../Values/values.dart';
// import '../Support/location_permission.dart';
//
// class CameraField extends StatefulWidget {
//   final String fieldName;
//   final Function(String) onImageCaptured;
//   final Map<String, dynamic> formValues;
//
//   CameraField({
//     required this.fieldName,
//     required this.onImageCaptured,
//     required this.formValues,
//   });
//
//   @override
//   _CameraFieldState createState() => _CameraFieldState();
// }
//
// class _CameraFieldState extends State<CameraField> {
//   XFile? image;
//   late File _selectedImage;
//   late String capturedLocation;
//   late String capturedDate;
//
//   @override
//   void initState() {
//     super.initState();
//     _selectedImage = File('');
//     image = _getCapturedImageFromState(widget.fieldName);
//     if (image != null && image!.path.isNotEmpty) {
//       _selectedImage = File(image!.path);
//     }
//     _captureLocation(widget.fieldName);
//     _captureDate(widget.fieldName);
//   }
//
//   Future<void> _captureLocation(fieldName) async {
//     if (!widget.formValues.containsKey('${fieldName}_location')) {
//       Position? position = await checkLocationPermission();
//       if (position != null) {
//         try {
//           List<Placemark> placemarks = await placemarkFromCoordinates(
//               position.latitude, position.longitude);
//           Placemark placemark = placemarks[0];
//           capturedLocation =
//               "${placemark.street}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.subAdministrativeArea}, ${placemark.postalCode}, ${placemark.country}";
//           widget.formValues['${fieldName}_location'] = capturedLocation;
//         } catch (e) {
//           capturedLocation = "Error: $e";
//         }
//       }
//     }
//     setState(() {});
//   }
//
//   void _captureDate(fieldName) {
//     if (!widget.formValues.containsKey('${fieldName}_date')) {
//       capturedDate = DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.now());
//       widget.formValues['${fieldName}_date'] = capturedDate;
//     }
//     setState(() {});
//   }
//
//   Future<void> _imagePickerFromGallery(fieldName) async {
//     final picker = ImagePicker();
//     image = (await picker.pickImage(source: ImageSource.camera))!;
//     final result = await FlutterImageCompress.compressAndGetFile(
//       image!.path,
//       '${(await path_provider.getTemporaryDirectory()).path}/$fieldName.jpg',
//       minHeight: 1080,
//       minWidth: 1080,
//       quality: 90,
//     );
//
//     _selectedImage = File(result!.path);
//     final imageBytes = await _selectedImage.readAsBytes();
//     String photobase64File1 = base64Encode(imageBytes);
//
//     setState(() {
//       widget.formValues[fieldName] = photobase64File1;
//     });
//     widget.onImageCaptured(_selectedImage.path);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           InkWell(
//             onTap: () => _imagePickerFromGallery(widget.fieldName),
//             child: image != null && image!.path.isNotEmpty
//                 ? Center(
//                     child: Image.file(
//                       _selectedImage,
//                       height: 200,
//                       fit: BoxFit.cover,
//                     ),
//                   )
//                 : SizedBox(
//                     height: 50,
//                     width: double.infinity,
//                     child: ColorFiltered(
//                       colorFilter: ColorFilter.mode(
//                         HexColor.fromHex("#bf3a4a"),
//                         BlendMode.modulate,
//                       ),
//                       child: Lottie.asset('assets/lottie/camera.json'),
//                     ),
//                   ),
//           ),
//           if (_selectedImage.path.isNotEmpty)
//             Card(
//               color: Colors.white,
//               elevation: 0,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Text(
//                   "Location: ${widget.formValues['${widget.fieldName}_location']}\n"
//                   "Date: ${widget.formValues['${widget.fieldName}_date']}",
//                   style: TextStyle(color: Colors.black),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   _getCapturedImageFromState(fieldName) {
//     if (widget.formValues.containsKey(fieldName)) {
//       final imagePath = widget.formValues[fieldName];
//       if (imagePath is String && imagePath.isNotEmpty) {
//         final file = File(imagePath);
//         if (file.existsSync()) {
//           return XFile(imagePath);
//         } else {
//           print("File does not exist at path: $imagePath");
//         }
//       } else {
//         print("Invalid image path: $imagePath");
//       }
//     } else {
//       print("Field '$fieldName' not found in formValues");
//     }
//     return null;
//   }
// }
