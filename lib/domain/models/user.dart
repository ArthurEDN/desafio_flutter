import 'package:equatable/equatable.dart';

class User implements Equatable {
  const User({
    required this.id,
    required this.name,
    required this.cpf,
    this.avatarUrl,
  });

  final int id;
  final String name;
  final String cpf;
  final String? avatarUrl;

  @override
  List<Object?> get props {
    return [id, name, cpf, avatarUrl];
  }

  @override
  bool? get stringify => true;
}
