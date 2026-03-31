import 'package:flutter/material.dart';
import 'task_repository.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      title: "krakflow",
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskState();
  }
}

class TaskState extends State<HomeScreen> {

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
                  Text("Masz dzisiaj ${TaskRepository.tasks.length} zadania do zrobienia"),
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
                    itemCount: TaskRepository.tasks.length,
                    itemBuilder: (context, index) {
                      return TaskCard(
                        title: TaskRepository.tasks[index].title,
                        subtitle: "termin: ${TaskRepository.tasks[index].deadline} | priorytet: ${TaskRepository.tasks[index].priority}",
                        icon: TaskRepository.tasks[index].done ? Icons.check_circle : Icons.radio_button_checked,
                      );
                    },
                  )
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            final Task? newTask = await Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => AddTaskScreen(),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  final offsetAnimation = Tween<Offset>(
                    begin: Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );

            if (newTask != null) {
              setState(() {
                TaskRepository.tasks.add(newTask);
              });
            }
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final TextEditingController priorityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text("Nowe zadanie"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: "Tytuł zadania",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: deadlineController,
              decoration: InputDecoration(
                labelText: "Termin zadania",
                border: OutlineInputBorder(),
              ),
            ),
            TextField(
              controller: priorityController,
              decoration: InputDecoration(
                labelText: "Priorytet zadania",
                border: OutlineInputBorder(),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  final newTask = Task(
                    title: titleController.text,
                    deadline: deadlineController.text,
                    priority: priorityController.text,
                    done: false,
                  );

                  Navigator.pop(context, newTask);
                },
                child: Text("Zapisz"),
            )
          ],
        )
      ),
    );
  }
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
