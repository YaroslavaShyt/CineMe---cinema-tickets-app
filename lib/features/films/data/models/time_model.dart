class HourMinute{
  final int time;
  HourMinute({required this.time});

  get hourMinute{
    return '${time ~/60}h ${time % 60}min';
  }
}