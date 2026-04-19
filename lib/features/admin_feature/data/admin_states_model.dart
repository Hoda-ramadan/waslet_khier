class AdminStatsModel {
  final String charityName;
  final String? charityLogo;
  final int totalDonations;
  final int totalDonors;
  final int activeCases;
  final int completedCases;

  AdminStatsModel({
    required this.charityName,
    this.charityLogo,
    required this.totalDonations,
    required this.totalDonors,
    required this.activeCases,
    required this.completedCases,
  });
}