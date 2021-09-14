import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'self.dart';

class Links extends Equatable {
  final Self self;
  Links({
    required this.self,
  });

  Map<String, dynamic> toMap() {
    return {
      'self': self.toMap(),
    };
  }

  factory Links.fromMap(Map<String, dynamic>? map) {
    if (map == null) return Links(self: Self());
    return Links(
      self: Self.fromMap(map['self']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Links.fromJson(String source) => Links.fromMap(json.decode(source));

  @override
  List<Object?> get props => [self];
}
