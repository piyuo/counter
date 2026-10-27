class ObservationTimeFilter {
  int hour;
  int minute;
  ObservationTimeFilter({required this.hour, required this.minute});
}

class ObservationTimeQuery {
  ObservationTimeFilter from;
  ObservationTimeFilter to;
  ObservationTimeQuery({required this.from, required this.to});
}
