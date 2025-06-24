import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String cpf;
  final String? avatarUrl;

  const UserEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.cpf,
    this.avatarUrl,
  });

  factory UserEntity.fromMap(Map<String, dynamic> map) {
    return UserEntity(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      cpf: map['cpf'] ?? '',
      avatarUrl: map['avatarUrl'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'cpf': cpf,
      'avatarUrl': avatarUrl,
    };
  }

  UserEntity copyWith({
    String? id,
    String? name,
    String? email,
    String? cpf,
    String? avatarUrl,
    DateTime? createdAt,
    DateTime? lastLoginAt,
  }) {
    return UserEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      cpf: cpf ?? this.cpf,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        cpf,
        avatarUrl,
      ];
}