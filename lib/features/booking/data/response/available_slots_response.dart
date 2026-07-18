class AvailableSlotsResponse {
  final List<String> dates;
  final List<String> times;

  AvailableSlotsResponse({required this.dates, required this.times});

  factory AvailableSlotsResponse.fromJson(Map<String, dynamic> json) {
    return AvailableSlotsResponse(
      dates: List<String>.from(json['dates'] ?? []),
      times: List<String>.from(json['times'] ?? []),
    );
  }

  Map<String, dynamic> toJson() => {
        'dates': dates,
        'times': times,
      };
}
