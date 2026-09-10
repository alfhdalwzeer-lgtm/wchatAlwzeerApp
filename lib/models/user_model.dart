class UserModel {
  final String uid;
  final String name;
  final bool isOnline;
  final DateTime lastSeen;
  final bool isTyping;

  UserModel({
    required this.uid,
    required this.name,
    this.isOnline = false,
    required this.lastSeen,
    this.isTyping = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'name': name,
      'isOnline': isOnline,
      'lastSeen': lastSeen.millisecondsSinceEpoch,
      'isTyping': isTyping,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      name: map['name'] ?? '',
      isOnline: map['isOnline'] ?? false,
      lastSeen: DateTime.fromMillisecondsSinceEpoch(map['lastSeen'] ?? 0),
      isTyping: map['isTyping'] ?? false,
    );
  }
}
