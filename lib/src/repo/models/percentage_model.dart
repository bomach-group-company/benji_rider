class Percentage {
  final String id;
  final double riderPercentage;
  final double agentPercentage;
  final double stateCoordinatorPercentage;

  Percentage({
    required this.id,
    required this.riderPercentage,
    required this.agentPercentage,
    required this.stateCoordinatorPercentage,
  });

  factory Percentage.fromJson(Map<String, dynamic> json) {
    return Percentage(
      id: json['id'] ?? '0',
      riderPercentage: (json['rider_percentage'] ?? 0.0) as double,
      agentPercentage: (json['agent_percentage'] ?? 0.0) as double,
      stateCoordinatorPercentage:
          (json['stateCoordinator_percentage'] ?? 0.0) as double,
    );
  }
}
