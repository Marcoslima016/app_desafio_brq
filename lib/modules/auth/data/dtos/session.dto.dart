import 'package:app_desafio_brq/lib.exports.dart';

class SessionDto {
  const SessionDto({required this.uid, required this.email});

  final String uid;
  final String email;

  factory SessionDto.fromJson(Map<String, dynamic> json) {
    return SessionDto(uid: json['uid'] as String, email: json['email'] as String);
  }

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};

  Session toEntity() => Session(uid: uid, email: email);
}
