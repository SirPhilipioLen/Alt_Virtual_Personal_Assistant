import 'package:flutter/material.dart';

class Task {
  String name;
  bool isCompleted;
  bool isTopPriority;

  Task({required this.name, required this.isCompleted, required this.isTopPriority});
}

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  List<Task> tasks = [];
  List<Task> completedTasks = [];
  bool topPriorityChecked = false;

  void addTask(String taskName, bool isTopPriority) {
    setState(() {
      if (isTopPriority) {
        tasks.insert(0, Task(name: taskName, isCompleted: false, isTopPriority: true));
      } else {
        tasks.add(Task(name: taskName, isCompleted: false, isTopPriority: false));
      }
    });
  }

  void completeTask(int index) {
    setState(() {
      Task completedTask = tasks.removeAt(index);
      completedTask.isCompleted = true;
      completedTasks.add(completedTask);
    });
  }

  void uncompleteTask(int index) {
    setState(() {
      Task uncompletedTask = completedTasks.removeAt(index);
      uncompletedTask.isCompleted = false;
      tasks.add(uncompletedTask);
    });
  }

  void deleteTask(int index, bool isCompleted) {
    setState(() {
      if (isCompleted) {
        completedTasks.removeAt(index);
      } else {
        tasks.removeAt(index);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _addDefaultTasks();
  }

  void _addDefaultTasks() {
    addTask('Complete project report', false);
    addTask('Buy groceries', false);
    addTask('Pay bills', true);
    addTask('Call mom', false);
    addTask('Go for a run', false);
    completeTask(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () {
              _showInformationDialog(context);
            },
            padding: EdgeInsets.only(right: 16.0),
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildTaskCategory('Tasks', tasks, false),
          _buildTaskCategory('Completed', completedTasks, true),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

 Widget _buildTaskCategory(String title, List<Task> categoryTasks, bool isCompleted) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: categoryTasks.length,
        itemBuilder: (context, index) {
          Task task = categoryTasks[index];

          return ListTile(
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (value) {
                setState(() {
                  task.isCompleted = value!;
                  if (isCompleted && !task.isCompleted) {
                    uncompleteTask(index);
                  } else if (!isCompleted && task.isCompleted) {
                    completeTask(index);
                  }
                });
              },
            ),
            title: Text(
              task.name,
              style: TextStyle(
                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteTask(index, isCompleted);
              },
            ),
            onTap: () {
              _editTask(context, task, isCompleted);
            },
          );
        },
      ),
    ],
  );
}


  void _showAddTaskDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      String newTask = '';
      bool isTopPriority = false;

      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: Text('Add Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  onChanged: (value) {
                    newTask = value;
                  },
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textInputAction: TextInputAction.newline,
                  onSubmitted: (_) {
                    newTask += '\n';
                  },
                ),
                Row(
                  children: [
                    Checkbox(
                      value: isTopPriority,
                      onChanged: (value) {
                        setState(() {
                          isTopPriority = value!;
                        });
                      },
                    ),
                    Text('Top Priority'),
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (newTask.isNotEmpty) {
                    addTask(newTask, isTopPriority);
                  }
                  Navigator.of(context).pop();
                },
                child: Text('Add'),
              ),
            ],
          );
        },
      );
    },
  );
}


  void _editTask(BuildContext context, Task task, bool isCompleted) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String updatedTaskName = task.name;
        bool updatedTopPriority = task.isTopPriority;

        return AlertDialog(
          title: Text('Edit Task'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  updatedTaskName = value;
                },
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                onSubmitted: (_) {
                  updatedTaskName += '\n';
                },
                controller: TextEditingController(text: task.name),
              ),
              Row(
                children: [
                  Checkbox(
                    value: updatedTopPriority,
                    onChanged: (value) {
                      setState(() {
                        updatedTopPriority = value!;
                      });
                    },
                  ),
                  Text('Top Priority'),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (updatedTaskName.isNotEmpty) {
                  task.name = updatedTaskName;
                  task.isTopPriority = updatedTopPriority;
                }
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

void _showInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Page Information'),
        content: SingleChildScrollView(
          child: Container(
            width: 400.0, // Adjust the width as needed
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to the Tasks Page!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
        ],
      );
    },
  );
}