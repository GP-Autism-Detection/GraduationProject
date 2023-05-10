import 'dart:convert';

class centers {
  final String Name;
  final String Address;
  final String Area;
  final String ContactNum;
  final String Image;
  final num Rating;

  centers(
      {required this.Name,
      required this.Address,
      required this.Area,
      required this.ContactNum,
      required this.Image,
      required this.Rating});

  Map<String, dynamic> get data => {
        'Name': Name,
        'Area': Area,
        'Contact Num': ContactNum,
        'Image': Image,
        'Address': Address,
      };

  factory centers.fromMap(Map<String, dynamic> map) {
    return centers(
      Name: map['Name'] ?? '',
      Area: map['Area'] ?? '',
      Image: map['Image'] ?? '',
      ContactNum: map['Contact Num'] ?? '',
      Address: map['Address'] ?? '',
      Rating: map['Rating'] ?? '',
    );
  }

  factory centers.fromJson(String source) =>
      centers.fromMap(json.decode(source) as Map<String, dynamic>);
}
