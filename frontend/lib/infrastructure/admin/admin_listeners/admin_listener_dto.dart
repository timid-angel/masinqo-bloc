class AdminListener {
  final String email;
  final String id;
  final String name;

  AdminListener({required this.id, required this.email, required this.name});

  factory AdminListener.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'email': String email,
        'name': String name,
        '_id': String id,
      } =>
        AdminListener(
          id: id,
          email: email,
          name: name,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}

class ListenerID {
  final String id;

  ListenerID({required this.id});
}
