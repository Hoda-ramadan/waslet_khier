import 'package:equatable/equatable.dart';

class ChangePassModel extends Equatable {
  final String message;
  final String token;

  const ChangePassModel({required this.message, required this.token});

  factory ChangePassModel.fromJson(Map<String, dynamic> json) {
    return ChangePassModel(
      message: json['message'] as String,
      token: json['token'] as String,
    );
  }

  Map<String, dynamic> toJson() => {'message': message, 'token': token};

  @override
  List<Object?> get props => [message, token];
}
