class CreatorPremium {
  final String creatorId;
  final String creatorName;
  final DateTime createDate;
  final String email;
  final String card;
  final double payment;
  final String paymentStatus;

  CreatorPremium({
    required this.creatorId,
    required this.creatorName,
    required this.createDate,
    required this.email,
    required this.card,
    required this.payment,
    required this.paymentStatus,
  });

  factory CreatorPremium.fromJson(Map<String, dynamic> json) {
    return CreatorPremium(
      creatorId: json['creatorId'] ?? '',
      creatorName: json['creatorName'] ?? '',
      createDate: json['createDate'] ?? '',
      email: json['email'] ?? '',
      card: json['card'] ?? '',
      payment: json['payment'] ?? '',
      paymentStatus: json['paymentStatus'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'creatorId': creatorId,
      'creatorName': creatorName,
      'createDate': createDate,
      'email': email,
      'card': card,
      'payment': payment,
      'paymentStatus': paymentStatus,
    };
  }
}
