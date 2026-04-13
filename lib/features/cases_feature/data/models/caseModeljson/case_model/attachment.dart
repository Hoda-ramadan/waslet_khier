import 'package:collection/collection.dart';

class Attachment {
  int? id;
  String? fileUrl;

  Attachment({this.id, this.fileUrl});

  factory Attachment.fromJson(Map<String, dynamic> json) =>
      Attachment(id: json['id'] as int?, fileUrl: json['fileUrl'] as String?);

  Map<String, dynamic> toJson() => {'id': id, 'fileUrl': fileUrl};

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Attachment) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toJson(), toJson());
  }

  @override
  int get hashCode => id.hashCode ^ fileUrl.hashCode;
}
