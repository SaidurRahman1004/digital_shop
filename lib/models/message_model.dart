class MessageModel {
  final String id;
  final String productName;
  final String validity;
  final String activationId;
  final String activationKey;
  final String sentAt;
  final String adminMessage;
  bool isRead;

  MessageModel({
    required this.id,
    required this.productName,
    required this.validity,
    required this.activationId,
    required this.activationKey,
    required this.sentAt,
    this.adminMessage = '',
    this.isRead = false,
  });
}