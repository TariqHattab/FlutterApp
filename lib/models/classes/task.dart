class Task {
  List<Task> tasks;
  String notes;
  DateTime timeToComplete;
  bool completed;
  String requests;
  DateTime deadline;
  List<DateTime> reminders;
  String taskId;
  String title;

  Task(this.title, this.completed, this.taskId);
}
