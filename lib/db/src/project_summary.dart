/// project summary used in the project list
class ProjectSummary {
  ProjectSummary({
    required this.projectId,
    required this.projectName,
    required this.createdAt,
    required this.updatedAt,
  });
  String projectId;
  String projectName;
  DateTime createdAt;
  DateTime updatedAt;
}
