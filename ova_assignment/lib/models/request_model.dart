import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class friendRequests {
  friendRequests({
    required this.senderId,
    required this.sentAt,
  });
  final String senderId;
  final String sentAt;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'sentAt': sentAt,
    };
  }

  factory friendRequests.fromMap(Map<String, dynamic> map) {
    return friendRequests(
      senderId: map['senderId'] ?? '',
      sentAt: map['sentAt'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory friendRequests.fromJson(String source) =>
      friendRequests.fromMap(json.decode(source) as Map<String, dynamic>);
}

class sendRequests {
  final String requestedUserId;
  final String sentAt;
  sendRequests({
    required this.requestedUserId,
    required this.sentAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'requestedUserId': requestedUserId,
      'sentAt': sentAt,
    };
  }

  factory sendRequests.fromMap(Map<String, dynamic> map) {
    return sendRequests(
      requestedUserId: map['requestedUserId'] ?? "",
      sentAt: map['sentAt'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory sendRequests.fromJson(String source) =>
      sendRequests.fromMap(json.decode(source) as Map<String, dynamic>);
}
