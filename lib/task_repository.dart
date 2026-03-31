class TaskRepository {
  static List<Task> tasks = [
    Task(
        title: "odrobić zadanie na metodologie",
        deadline: "dzisiaj",
        done:false,
        priority: "wysokie"
    ),
    Task(
      title: "wyrobić certyfikat Cisco",
      deadline: "koniec semestru",
      done: false,
      priority: "średnie",
    ),
    Task(
      title: "napisać stronę w html",
      deadline: "następny tydzień",
      done: false,
      priority: "niskie",
    ),
    Task(
      title: "napisać program w C na systemy",
      deadline: "następny tydzień",
      done: true,
      priority: "niskie",
    ),
  ];
}


class Task {
  final String title;
  final String deadline;
  final bool done;
  final String priority;

  Task({
    required this.title,
    required this.deadline,
    required this.done,
    required this.priority,
  });
}