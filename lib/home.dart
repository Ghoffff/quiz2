import 'package:flutter/material.dart';
import 'package:flutter_mentor_quiz_app_tut/answer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Icon> _scoreTracker = [];
  int _questionIndex = 0;
  int _totalScore = 0;
  bool answerWasSelected = false;
  bool endOfQuiz = false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore) {
    setState(() {
      // answer was selected
      answerWasSelected = true;
      // check if answer was correct
      if (answerScore) {
        _totalScore++;
        correctAnswerSelected = true;
      }
      // adding to the score tracker on top
      _scoreTracker.add(
        answerScore
            ? Icon(
                Icons.check_circle,
                color: Color(0xFFAB47BC),
              )
            : Icon(
                Icons.clear,
                color: Color(0xFFAB47BC),
              ),
      );
      //when the quiz ends
      if (_questionIndex + 1 == _questions.length) {
        endOfQuiz = true;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      _questionIndex++;
      answerWasSelected = false;
      correctAnswerSelected = false;
    });
    // what happens at the end of the quiz
    //******//
    if (_questionIndex >= _questions.length) {
      _resetQuiz();
    }
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
      _scoreTracker = [];
      endOfQuiz = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz',
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,
              fontSize: 20,),

        ),
        centerTitle: true,
        backgroundColor: Color(0xFF6F35A5),
    ),
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            Row(
              children: [
                if (_scoreTracker.length == 0)
                  SizedBox(
                    height: 25.0,
                  ),
                if (_scoreTracker.length > 0) ..._scoreTracker
              ],
            ),
            (_questions[_questionIndex]['question']=='What chord is this ?')?
            Container(
              width: double.infinity,
              height: 280.0,
              margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
              child:Column(
                children: [Text(
                  _questions[_questionIndex]['question'],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                  SizedBox(height: 10,),

                  SizedBox(height:200,width: 200,child: Image.asset("assets/images/EM.png"),)
                ],
              )

                  ),
                  ):Container(
                width: double.infinity,
                height: 130.0,
                margin: EdgeInsets.only(bottom: 10.0, left: 30.0, right: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                    child:Column(
                      children: [Text(
                        _questions[_questionIndex]['question'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 19.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      ],
                    ))

                ),



                  ...(_questions[_questionIndex]['answers']
                    as List<Map<String, dynamic>>)
                .map(
              (answer) => Answer(
                answer['answerText'],
                answerWasSelected
                    ? answer['score']
                        ? Color(0xFFE1BEE7)
                        : Color(0xFFAB47BC)
                    : Colors.white,
                () {
                  // if answer was already selected then nothing happens onTap
                  if (answerWasSelected) {
                    return;
                  }
                  //answer is being selected
                  _questionAnswered(answer['score']);
                },
              ),
            ),
            SizedBox(height: 40.0),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 40.0),
                primary: Color(0xFFF3E5F5),

              ),
              onPressed: () {
                if (!answerWasSelected) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Please select an answer before going to the next question'),
                  ));
                  return;
                }
                _nextQuestion();
              },

              child: Text(endOfQuiz ? 'Restart Quiz' : 'Next Question',

                style: TextStyle(

                  fontSize: 14.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,

                ),
              ),
            ),

            if (endOfQuiz)
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.transparent,
                child: Center(
                  child: Text(
                    _totalScore > 3
                        ? 'Congratulations! You just unlocked the next course '
                        : 'Your final score is: $_totalScore.  '
                        'Better luck next time!',

                    style: TextStyle(

                      fontSize: 14.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> _questions = const [
  {
    'question': 'How many strings are on a guitar ?',
    'answers': [
      {'answerText': '6', 'score': true},
      {'answerText': '8', 'score': false},
      {'answerText': '5', 'score': false},
    ],
  },
  {
    'question':
        'What are the names of the guitar strings in standard tuning ?',
        'answers': [
      {'answerText': 'DADGAD', 'score': false},
      {'answerText': 'EGDABE', 'score': false},
      {'answerText': 'EADGBE', 'score': true},
    ],
  },
  {
    'question': 'What is the position of the A string ?',
    'answers': [
      {'answerText': '2', 'score': false},
      {'answerText': '4', 'score': false},
      {'answerText': '5', 'score': true},
    ],
  },
  {
    'question': 'What chord is this ?',
    'answers': [
      {'answerText': 'A major chord', 'score': false},
      {'answerText': 'E minor chord ', 'score': true},
      {'answerText': 'E major chord', 'score': false},
    ],
  },

  {
    'question':
    'What does the X mean above a string?',
    'answers': [
      {'answerText': 'The string should not be played ', 'score': true},
      {'answerText': 'You play this string open', 'score': false},
      {'answerText': 'You should press this string', 'score': false},
    ],
  },
];
