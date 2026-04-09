import 'package:equatable/equatable.dart';

import 'errors.dart';

class DonorRegister extends Equatable {
  final String? type;
  final String? title;
  final int? status;
  final Errors? errors;
  final String? traceId;

  const DonorRegister({
    this.type,
    this.title,
    this.status,
    this.errors,
    this.traceId,
  });

  factory DonorRegister.fromJson(Map<String, dynamic> json) => DonorRegister(
    type: json['type'] as String?,
    title: json['title'] as String?,
    status: json['status'] as int?,
    errors: json['errors'] == null
        ? null
        : Errors.fromJson(json['errors'] as Map<String, dynamic>),
    traceId: json['traceId'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'type': type,
    'title': title,
    'status': status,
    'errors': errors?.toJson(),
    'traceId': traceId,
  };

  @override
  List<Object?> get props => [type, title, status, errors, traceId];
}
