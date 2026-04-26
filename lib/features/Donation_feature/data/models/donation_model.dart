class DonationModel {
  final int? id;
  final int? donorId;
  final int? caseId;
  final double? amount;
  final String? caseTitle;
  final String? paymentMethod;
  final DateTime? createdAt;

  const DonationModel({
    this.id,
    this.donorId,
    this.caseId,
    this.amount,
    this.caseTitle,
    this.paymentMethod,
    this.createdAt,
  });

  factory DonationModel.fromJson(Map<String, dynamic> json) => DonationModel(
    id: json['id'] as int?,
    donorId: json['donorId'] as int?,
    caseId: json['caseId'] as int?,
    amount: (json['amount'] as num?)?.toDouble(),
    caseTitle: json['caseTitle'] as String?,
    paymentMethod: json['paymentMethod'] as String?,
    createdAt: json['createdAt'] == null
        ? null
        : DateTime.parse(json['createdAt'] as String),
  );

  Map<String, dynamic> toJson() => {
    'donorId': donorId,
    'caseId': caseId,
    'amount': amount,
    'paymentMethod': paymentMethod,
  };
}
