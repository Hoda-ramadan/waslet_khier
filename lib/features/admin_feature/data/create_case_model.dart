// ─── 1. Updated AdminCaseModel ────────────────────────────────────────────────
// Replace your existing AdminCaseModel with this one.
// Added: age, location, isFeatured, endDate — needed by the edit screen.

class AdminCaseModel {
  final int id;
  final String title;
  final String description;
  final double targetAmount;
  final double collectedAmount;
  final String? coverImageUrl;
  final String beneficiaryName;
  final String categoryName;
  final int? categoryId; // needed to pre-select dropdown
  final String priority;
  final String status;
  final int? age;
  final String? location;
  final bool? isFeatured;
  final DateTime? endDate;

  AdminCaseModel({
    required this.id,
    required this.title,
    required this.description,
    required this.targetAmount,
    required this.collectedAmount,
    this.coverImageUrl,
    required this.beneficiaryName,
    required this.categoryName,
    this.categoryId,
    required this.priority,
    required this.status,
    this.age,
    this.location,
    this.isFeatured,
    this.endDate,
  });

  factory AdminCaseModel.fromJson(Map<String, dynamic> json) {
    return AdminCaseModel(
      id: json['id'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      targetAmount: (json['targetAmount'] as num).toDouble(),
      collectedAmount: (json['collectedAmount'] as num).toDouble(),
      coverImageUrl: json['coverImageUrl'],
      beneficiaryName: json['beneficiaryName'] ?? '',
      categoryName: json['categoryName'] ?? '',
      categoryId: json['categoryId'] as int?,
      priority: json['priority'] ?? '',
      status: json['status'] ?? '',
      age: json['age'] as int?,
      location: json['location'] as String?,
      isFeatured: json['isFeatured'] as bool?,
      endDate: json['endDate'] == null
          ? null
          : DateTime.tryParse(json['endDate'] as String),
    );
  }

  double get progress =>
      targetAmount > 0 ? (collectedAmount / targetAmount).clamp(0.0, 1.0) : 0.0;

  bool get isActive => status == 'Active';
}

// ─── 2. Router snippet — add inside /admin/:charityId routes list ─────────────
// In your app_router.dart, inside the existing GoRoute for /admin/:charityId,
// add this new child route alongside the existing case_details route:

/*
GoRoute(
  path: 'edit_case',
  parentNavigatorKey: _rootNavigatorKey,
  builder: (context, state) {
    final charityId =
        int.tryParse(state.pathParameters['charityId'] ?? '0') ?? 0;
    final extra = state.extra as Map<String, dynamic>;
    final caseData = extra['caseData'] as AdminCaseModel;
    final adminId = extra['adminId'] as int;
    return AdminEditCaseView(
      caseData: caseData,
      charityId: charityId,
      adminId: adminId,
    );
  },
),
*/

// ─── 3. Navigation call — in _CaseCard "تعديل الحالة" button onPressed ────────
// Replace the empty onPressed: () {} with:

/*
onPressed: () async {
  final result = await context.push<bool>(
    '/admin/$charityId/edit_case',
    extra: {
      'caseData': data,
      'adminId': 7, // TODO: replace with real adminId from your auth provider
    },
  );
  // If edit was saved, refresh the list
  if (result == true && context.mounted) {
    context.read<AdminCubit>().loadCases(charityId);
  }
},
*/
