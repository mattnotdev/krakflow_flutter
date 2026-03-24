import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  List<Task> tasks = [
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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("KrakFlow")),
        body: Center(
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Masz dzisiaj ${tasks.length} zadania do zrobienia"),
                ],
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "Dzisiejsze zadania",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  )
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      title: tasks[index].title,
                      subtitle: "termin: ${tasks[index].deadline} | priorytet: ${tasks[index].priority}",
                      icon: tasks[index].done ? Icons.check_circle : Icons.radio_button_checked,
                    );
                  },
                )
              ),
            ],
          ),
        ),
      ),
    );
  }
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

class TaskCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const TaskCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:6, horizontal:20),
      child: Card(
        child: ListTile(
          leading: Icon(icon),
          title: Text(title),
          subtitle: Text(subtitle),
        ),
      )
    );
  }
}
