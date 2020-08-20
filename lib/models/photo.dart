import 'package:flutter/cupertino.dart';

class Urls {
  final String small;
  final String raw;
  final String regular;

  Urls({this.small, this.raw, this.regular});

  factory Urls.fromJson(Map json) {
    return Urls(
      small: json['small'] as String,
      raw: json['raw'] as String,
      regular: json['regular'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'small': small,
        'raw': raw,
        'regular': regular,
      };

}

class User {
  final String id;
  final String name;
  final String username;

  User({this.id, this.name, this.username});

  factory User.fromJson(Map json) {
    return User(
      id: json['id'] as String,
      name: json['name'] as String,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'name': name,
        'username': username,
      };

  @override
  String toString() {
    return 'name: $name' ;
  }

}

class Photo {
  final String id;
  final String description;
  final User user;
  final Urls urls;

  Photo({this.id, this.description, this.user, this.urls});

  Photo copyWith({
    @required String id,
    @required String description,
    @required User user,
    @required Urls urls
  }) {
    return Photo(
      id: id ?? this.id,
      description: description ?? this.description,
    );
  }
  factory Photo.fromJson(Map json) {
    return Photo(
      id: json['id'] as String,
      description: json['description'] as String,
      user: User.fromJson(json['user']),
      urls: Urls.fromJson(json['urls'])
    );
  }

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'description': description,
        'user': user,
        'urls': urls
      };

  @override
  String toString() {
    return 'id: $id' ;
  }

}
