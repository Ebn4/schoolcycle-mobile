import 'package:schoolcycle_mobile/business/models/category/category.dart';
import 'package:schoolcycle_mobile/business/models/photo/photo.dart';
import 'package:schoolcycle_mobile/business/models/user/user.dart';

class Announcement {
  final int id;
  final String? title;
  final String? description;
  final String? operation_type;
  final int? price;
  final bool? isComplete;
  final bool? isCanceled;
  final String? exchangeLocationAddress;
  final double? exchangeLocationLng;
  final double? exchangeLocationLat;
  final Category? category;
  final List<Photo>? photos;
  final User? created_by;

  Announcement({
    required this.id,
    this.title,
    this.description,
    this.operation_type,
    this.price,
    this.isComplete,
    this.isCanceled,
    this.exchangeLocationAddress,
    this.exchangeLocationLng,
    this.exchangeLocationLat,
    this.category,
    this.photos,
    this.created_by,
  });

  factory Announcement.fromJson(json) => Announcement(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    operation_type: json['operation_type'],
    price: json['price'],
    isComplete: json['isComplete'],
    isCanceled: json['isCanceled'],
    exchangeLocationAddress: json['exchangeLocationAddress'],
    exchangeLocationLng: json['exchangeLocationLng'],
    exchangeLocationLat: json['exchangeLocationLat'],
    category: json['category'] != null ? Category.fromJson(json['category'] as Map<String, dynamic>) : null,
    photos: json['photos'] != null ? List<Photo>.from(json['photos'].map((p) => Photo.fromJson(p)))
      : null,
    created_by: json['created_by'] != null
        ? User.fromJson(json['created_by'] as Map<String, dynamic>)
        : null,
  );

  Map toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'operation_type': operation_type,
    'price': price,
    'isComplete': isComplete,
    'isCanceled': isCanceled,
    'exchangeLocationAddress': exchangeLocationAddress,
    'exchangeLocationLng': exchangeLocationLng,
    'exchangeLocationLat': exchangeLocationLat,
    'category': category,
    'photos': photos,
    'created_by': created_by,
  };
}
