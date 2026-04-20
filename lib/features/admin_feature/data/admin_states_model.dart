class AdminStatsModel {
  final int id;
  final String charityName;
  final String? charityLogo;
  final String? charityEmail;
  final String? charityPhone;
  final String? charityAddress;
  final int totalDonations;   // totalRaisedAmount
  final int totalDonors;      // totalDonorsCount
  final int activeCases;      // totalProjectsCount
  final int completedCases;
  final bool isActive;

  AdminStatsModel({
    required this.id,
    required this.charityName,
    this.charityLogo,
    this.charityEmail,
    this.charityPhone,
    this.charityAddress,
    required this.totalDonations,
    required this.totalDonors,
    required this.activeCases,
    required this.completedCases,
    required this.isActive,
  });

  factory AdminStatsModel.fromJson(Map<String, dynamic> json) {
    return AdminStatsModel(
      id: json['id'] ?? 0,
      charityName: json['name'] ?? '',
      charityLogo: json['logoUrl'],
      charityEmail: json['email'],
      charityPhone: json['phoneNumber'],
      charityAddress: json['address'],
      totalDonations: (json['totalRaisedAmount'] ?? 0).toInt(),
      totalDonors: (json['totalDonorsCount'] ?? 0).toInt(),
      activeCases: (json['totalProjectsCount'] ?? 0).toInt(),
      completedCases: 0, // not in API, keep 0 or remove the card
      isActive: json['isActive'] ?? false,
    );
  }
}