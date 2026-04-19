import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String? name;
  final String? iconUrl;

  const CategoryModel({this.id, this.name, this.iconUrl});

  factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
    id: json['id'] as int?,
    name: json['name'] as String?,
    iconUrl: json['iconUrl'] as String?,
  );

  Map<String, dynamic> toJson() => {'id': id, 'name': name, 'iconUrl': iconUrl};

  @override
  List<Object?> get props => [id, name, iconUrl];
}
