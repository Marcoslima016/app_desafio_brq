class Session {
  const Session({required this.uid, required this.email});

  final String uid;
  final String email;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Session && other.uid == uid && other.email == email;

  @override
  int get hashCode => Object.hash(uid, email);
}
