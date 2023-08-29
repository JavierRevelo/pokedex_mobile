import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User {
  final String? email;
  final String id;
  final String? name;
  final String? photo;

  const User({
    required this.email,
    required this.id,
    required this.name,
    required this.photo
  });

  static const empty = User(email: '', id: '', name: null, photo: null);
}