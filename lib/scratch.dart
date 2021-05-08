import 'dart:io';

void main() {
  performTasks();
}

void performTasks() async {
  task1();
  String task2Res = await task2();
  task3(task2Res);
  task4();
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  String result;
  Duration pause=Duration(seconds: 3);
  await Future.delayed(pause,(){
    result = 'task 2 data';
    print('Task 2 complete');
  });
  return result;
}

void task3(String task2Data) {
  String result = 'task 3 data';
  print('Task 3 complete - $task2Data');
}

void task4() {
  String result = 'task 4 data';
  print('Task 4 complete');
}