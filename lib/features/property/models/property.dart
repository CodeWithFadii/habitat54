import 'dart:convert';

import 'package:intl/intl.dart';

class Property {
  int id;
  String userId;
  String name;
  String? number;
  String title;
  String? description;
  String price;
  String propertyType;
  String? otherType;
  String? uploadImage;
  String city;
  String? nieghborhood;
  String? bedrooms;
  String? bathrooms;
  String? propertySize;
  List<String>? features;
  String? vedio;
  String? uploadDocument;
  String createdAt;
  DateTime updatedAt;
  List<Additional>? additional;

  Property({
    required this.id,
    required this.userId,
    required this.name,
    this.number,
    required this.title,
    required this.description,
    required this.price,
    required this.propertyType,
    required this.otherType,
    this.uploadImage,
    required this.city,
    this.nieghborhood,
    this.bedrooms,
    this.bathrooms,
    this.propertySize,
    List<String>? features,
    required this.vedio,
    this.uploadDocument,
    required this.createdAt,
    required this.updatedAt,
    List<Additional>? additional,
  })  : features = features ?? [],
        additional = additional ?? [];

  factory Property.fromJson(Map<String, dynamic> json) {
    String formatDate() {
      DateTime dateTime = DateTime.parse(json['created_at']);
      DateFormat formatter = DateFormat('MMMM d, yyyy');
      return formatter.format(dateTime);
    }

    return Property(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'] ?? '',
      number: json['number'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? '',
      propertyType: json['property_type'] ?? '',
      otherType: json['Other_type'] ?? '',
      uploadImage: json['upload_image'] ?? '',
      city: json['city'] ?? '',
      nieghborhood: json['nieghborhood'] ?? '',
      bedrooms: json['bedrooms'] ?? '',
      bathrooms: json['bathrooms'] ?? '',
      propertySize: json['property_size'] ?? '',
      features: json['features'] != []
          ? [jsonDecode(json['features']).toString()]
          : [],
      vedio: json['vedio'] ?? '',
      uploadDocument: json['upload_document'] ?? '',
      createdAt: formatDate(),
      updatedAt: DateTime.parse(json['updated_at']),
      additional: json['additional'] != null
          ? (json['additional'] as List<dynamic>)
              .map((item) => Additional.fromJson(item))
              .toList()
          : [],
    );
  }
}

class Additional {
  int id;
  String productId;
  String name;
  String value;
  DateTime createdAt;
  DateTime updatedAt;

  Additional({
    required this.id,
    required this.productId,
    required this.name,
    required this.value,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Additional.fromJson(Map<String, dynamic> json) {
    return Additional(
      id: json['id'],
      productId: json['product_id'],
      name: json['name'],
      value: json['value'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
