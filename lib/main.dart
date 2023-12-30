import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Language Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.black,
      ),
      home: QuizSelection(),
    );
  }
}

class QuizSelection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Choose a Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen(
                    title: 'Java Quiz',
                    questions: javaQuestions,
                    options: javaOptions,
                    answers: javaAnswers,
                  )),
                );
              },
              child: Text('Java Quiz'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen(
                    title: 'C++ Quiz',
                    questions: cppQuestions,
                    options: cppOptions,
                    answers: cppAnswers,
                  )),
                );
              },
              child: Text('C++ Quiz'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String title;
  final List<String> questions;
  final List<List<String>> options;
  final List<int> answers;

  QuizScreen({
    required this.title,
    required this.questions,
    required this.options,
    required this.answers,
  });

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _questionIndex = 0;
  int _score = 0;

  void _answerQuestion(int selectedIndex) {
    if (selectedIndex == widget.answers[_questionIndex]) {
      setState(() {
        _score++;
      });
    }
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _questionIndex < widget.questions.length
            ? QuizBody(
          question: widget.questions[_questionIndex],
          options: widget.options[_questionIndex],
          answerQuestion: _answerQuestion,
        )
            : Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Quiz Completed!',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Your Score: $_score / ${widget.questions.length}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: _resetQuiz,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue,
                ),
                child: Text('Restart Quiz'),
              ),
              SizedBox(height: 20),
              Text(
                'Correct Answers:',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(
                  widget.questions.length,
                      (index) => Text(
                    '${index + 1}. ${widget.questions[index]} - ${widget.options[index][widget.answers[index]]}',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuizBody extends StatelessWidget {
  final String question;
  final List<String> options;
  final Function(int) answerQuestion;

  QuizBody({
    required this.question,
    required this.options,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          question,
          style: TextStyle(fontSize: 22, color: Colors.white),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 20),
        ...options.asMap().entries.map(
              (entry) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0),
            child: ElevatedButton(
              onPressed: () => answerQuestion(entry.key),
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
              ),
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  entry.value,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// Java Questions
List<String> javaQuestions = [
  'What is Java?',
  'Which keyword is used to define a constant in Java?',
  'What does JVM stand for in Java?',
  'Which access modifier restricts access the most in Java?',
  'What is the Java compiler called?',
  'What is the output of 9 + 3 / 4 in Java?',
  'What is the purpose of the keyword "this" in Java?',
  'Which collection class allows null values in Java?',
  'What is the purpose of the keyword "static" in Java?',
  'What is the superclass of all classes in Java?'
];

List<List<String>> javaOptions = [
  ['Programming language', 'Scripting language', 'Markup language', 'Database language'],
  ['final', 'const', 'static', 'define'],
  ['Java Virtual Machine', 'Java Visual Model', 'Java Variable Model', 'Just Virtual Machine'],
  ['private', 'public', 'protected', 'default'],
  ['javac', 'java', 'JVM', 'JRE'],
  ['9', '3.75', '12', 'Error'],
  ['To refer to the current object', 'To declare methods', 'For method overloading', 'For exception handling'],
  ['ArrayList', 'HashSet', 'TreeMap', 'LinkedHashMap'],
  ['To create constants', 'To declare global variables', 'To allocate memory', 'To make a method or variable belong to the class rather than a specific instance'],
  ['Object', 'Class', 'Super', 'Main']
];

List<int> javaAnswers = [0, 0, 0, 0, 0, 1, 0, 1, 3, 0];

// C++ Questions
List<String> cppQuestions = [
  'What is C++?',
  'What is the output of cout << (5 | 3); in C++?',
  'What is the purpose of the "virtual" keyword in C++?',
  'Which type of inheritance is not supported in C++?',
  'What is a reference variable in C++?',
  'What is the correct way to dynamically allocate memory in C++?',
  'Which operator is used to dereference a pointer in C++?',
  'What does the keyword "const" signify in C++?',
  'What is the purpose of using namespaces in C++?',
  'What is the output of the code: int x = 10; int y = x++; cout << y; in C++?'
];

List<List<String>> cppOptions = [
  ['Programming language', 'Scripting language', 'Markup language', 'Database language'],
  ['7', '5', '3', '8'],
  ['To create templates', 'For multiple inheritance', 'For achieving polymorphism', 'For file handling'],
  ['Single inheritance', 'Multiple inheritance', 'Hybrid inheritance', 'Hierarchical inheritance'],
  ['A variable that stores memory address', 'A variable that cannot be modified', 'A variable that refers to another variable', 'A variable that stores constant values'],
  ['new()', 'alloc()', 'malloc()', 'create()'],
  ['*', '&', '#', '@'],
  ['Variable cannot be modified', 'Variable can be modified', 'Variable is a constant', 'Variable is a function'],
  ['To avoid naming conflicts', 'To reduce code size', 'To increase code readability', 'To create macros'],
  ['10', '11', '9', 'Error']
];

List<int> cppAnswers = [0, 0, 2, 2, 2, 0, 1, 2, 0, 2];
