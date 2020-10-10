import 'dart:ui';

import 'package:flutter/material.dart';
import 'nav-drawer.dart';
import 'data.dart';
import 'animation.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {
  runApp(MyApp());
}

class entryFonts extends TextStyle{

  String get fontFamily => 'Ubuntu Light';


  Widget build(BuildContext context) {
    return TextField(

      style: TextStyle(
        fontFamily: 'Ubuntu Light',
      ),

    );
  }
}

class displayFonts extends TextStyle{

  // TODO: implement fontFamily
  String get fontFamily => 'Ubuntu';
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Finance Calculator',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Personal Finance Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

}


class _MyHomePageState extends State<MyHomePage>
  with SingleTickerProviderStateMixin{
  AnimationController transitionAnimation;

  String storedvalue = '0';

  TextEditingController initialFunds = TextEditingController();
  TextEditingController annualInterestpercentage = TextEditingController();
  TextEditingController targetAmount = TextEditingController();
  TextEditingController NumberofYears = TextEditingController();


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    initialFunds.dispose();
    annualInterestpercentage.dispose();
    targetAmount.dispose();
    NumberofYears.dispose();
    super.dispose();
  }

  double result;




  @override
  void initState() {
    super.initState();
    transitionAnimation = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    transitionAnimation.forward();
    _loadCounter();
  }

  _loadCounter() async {
//    loads counter from increment counter where input is tied to the particular key ('initialFunds', 'targetAmount' etc.), and ASSIGN
//    to the original variable (e.g. store variable x into storedvalue => assign to key 'initialfunds' => assign variable x to getstring of 'initialfunds'

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      homefields.x = prefs.getString('initialFunds') ?? 0;
      homefields.y = prefs.getString('annualInterestpercentage') ?? 0;
      homefields.z = prefs.getString('targetAmount') ?? 0;
      homefields.years = prefs.getString('NumberofYears') ?? 0;
    });
  }

  _incrementCounter(counter_name, input) async {
//    saves a particular input by assigning it to a defined key

    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      storedvalue = input;
      prefs.setString(counter_name, storedvalue);
    });
  }

  @override
  Widget build(BuildContext context) {



    initialFunds.text = homefields.x;
    annualInterestpercentage.text = homefields.y;
    targetAmount.text = homefields.z;
    NumberofYears.text = homefields.years;

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: AnimationPage(
                  start: 0.0,
                  finish: 0.5,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Initial Funds',
                        style:displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextField(
                style: entryFonts(),
                controller: initialFunds,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
            ),

            Expanded(
                child: AnimationPage(
                  start: 0.125,
                  finish: 0.675,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Annual Interest percentage (%)',
                        style:displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextFormField(
              style: calculatedStatuses.uncalculatedinterest
                  ? entryFonts():
              TextStyle(color: Colors.red, fontWeight: FontWeight.w900),
              controller: annualInterestpercentage,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: AnimationPage(
                  start: 0.25,
                  finish: 0.75,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Target Amount',
                        style:displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextFormField(
              style: calculatedStatuses.uncalculatedtarget
                  ? entryFonts():
              TextStyle(color: Colors.red,fontWeight: FontWeight.w900),
              controller: targetAmount,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: AnimationPage(
                  start: 0.375,
                  finish: 0.875,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Number of Years',
                        style:displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextFormField(
              style: calculatedStatuses.uncalculatedyears
                  ? entryFonts():
              TextStyle(color: Colors.red,fontWeight: FontWeight.w900),
              controller: NumberofYears,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            Expanded(

              child: Row(
                children: <Widget>[
                    Expanded(

                      child: RaisedButton(

                        child: Center(
                            child: Text(
                              'Import values from Assets and Liabilities',
                            )
                        ),
                        onPressed: () {
                          double totalmoney = double.parse(assetfields.sum) - double.parse(liabilityfields.sum);
                          homefields.x = totalmoney.toStringAsFixed(2);

                          setState(() {

                          });
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the user has entered by using the
                                // TextEditingController.
                                content: Text('Loaded.'),

                              );
                            },
                          );
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Center(                            
                            child: Text(
                              'Clear all data fields',
                            )
                        ),
                        onPressed: () {

                          homefields.x = '';
                          homefields.y = '';
                          homefields.z = '';
                          homefields.years = '';

                          setState(() {

                          });
                          return showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the user has entered by using the
                                // TextEditingController.
                                content: Text('Details cleared.'),

                              );
                            },
                          );
                        },
                      ),
                    ),
                  Expanded(
                    child: RaisedButton(
                      child: Center(
                          child: Text(
                            'Calculate',
                          )
                      ),
                      onPressed: () {

                        calculatedStatuses.uncalculatedinterest = true;
                        calculatedStatuses.uncalculatedtarget = true;
                        calculatedStatuses.uncalculatedyears = true;

                        homefields.x = retainValue1(initialFunds.text);
                        homefields.y = retainValue1(annualInterestpercentage.text);
                        homefields.z = retainValue1(targetAmount.text);
                        homefields.years = retainValue1(NumberofYears.text);

                        String result = calculate(homefields.x, homefields.y, homefields.z, homefields.years);
                        if (homefields.y == '0.00') {
                          homefields.y = result;
                          calculatedStatuses.uncalculatedinterest = false;
                          print(calculatedStatuses.uncalculatedinterest);
                        }
                        else if (homefields.z == '0.00') {
                          homefields.z = result;
                          calculatedStatuses.uncalculatedtarget = false;
                          print(calculatedStatuses.uncalculatedtarget);
                        }
                        else if (homefields.years == '0.00') {
                          homefields.years = result;
                          calculatedStatuses.uncalculatedyears = false;
                          print(calculatedStatuses.uncalculatedyears);
                        }

                        _incrementCounter('initialFunds',homefields.x);
                        _incrementCounter('annualInterestpercentage',homefields.y);
                        _incrementCounter('targetAmount',homefields.z);
                        _incrementCounter('NumberofYears',homefields.years);


                        setState(() {


                        });


                        return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              // Retrieve the text the user has entered by using the
                              // TextEditingController.
                              content: Text('Calculated.'),

                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),



          ],

        ),
      ),

    );
  }
  
}

class AssetPage extends StatefulWidget {
  AssetPage({Key key, this.title, Animation<double> transitionAnimation}) : super(key: key);

  final String title;

  @override
  AssetPageState createState() => AssetPageState();

}

class AssetPageState extends State<AssetPage>
  with SingleTickerProviderStateMixin{
  AnimationController transitionAnimation;

  double result;

  final bankAccount = TextEditingController();
  final pension = TextEditingController();
  final investment = TextEditingController();
  final assetTotal = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    bankAccount.dispose();
    pension.dispose();
    investment.dispose();
    transitionAnimation.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    transitionAnimation = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    transitionAnimation.forward();
  }


  @override
  Widget build(BuildContext context) {

    bankAccount.text = assetfields.x;
    pension.text = assetfields.y;
    investment.text = assetfields.z;
    assetTotal.text = assetfields.sum;

    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Assets'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: AnimationPage(
                  start: 0.0,
                  finish: 0.5,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Bank Account',
                        style:displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
//            TextField(
//              style: entryFonts(),
//              controller: bankAccount,
//              keyboardType: TextInputType.number,
//              textAlign: TextAlign.center,
//            ),
            TextField(
              style: entryFonts(),
              controller: bankAccount,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),


            Expanded(
              child: AnimationPage(
                start: 0.125,
                finish: 0.675,
                child: SizedBox(
                  child: Center(
                    child: Text(
                      'Pension',
                      style:displayFonts(),
                    ),
                  ),
                ),
                animation: transitionAnimation,
              )
            ),

            TextField(
              style: entryFonts(),
              controller: pension,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),

            Expanded(
                child: AnimationPage(
                  start: 0.25,
                  finish: 0.75,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Investment',
                        style: displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,

                )
            ),

            TextField(
              style: entryFonts(),
              controller: investment,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: AnimationPage(
                  start: 0.375,
                  finish: 0.875,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Asset Total',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextField(
              enabled: false,
              controller: assetTotal,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Ubuntu',
                color: Colors.red,
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the
        // text that the user has entered into the text field.

        onPressed: () {


          assetfields.x = retainValue1(bankAccount.text);
          assetfields.y = retainValue1(pension.text);
          assetfields.z = retainValue1(investment.text);

          assetfields.sum_of_fields(assetfields.x, assetfields.y, assetfields.z);
          setState(() {});

          return showDialog(

            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has entered by using the
                // TextEditingController.

                content: Text('Saved.'),

              );
            },
          );

        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),

      ),
    );
  }
}

class LiabilitiesPage extends StatefulWidget {
  LiabilitiesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  LiabilitiesPageState createState() => LiabilitiesPageState();

}

class LiabilitiesPageState extends State<LiabilitiesPage>
    with SingleTickerProviderStateMixin{
  AnimationController transitionAnimation;


  final creditCardLoan = TextEditingController();
  final mortgage = TextEditingController();
  final studentLoan = TextEditingController();
  final liabilitiesTotal = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    creditCardLoan.dispose();
    mortgage.dispose();
    studentLoan.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    transitionAnimation = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
    );
    transitionAnimation.forward();
  }

  @override
  Widget build(BuildContext context) {

    creditCardLoan.text = liabilityfields.x;
    mortgage.text = liabilityfields.y;
    studentLoan.text = liabilityfields.z;
    liabilitiesTotal.text = liabilityfields.sum;

    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Liabilities'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: AnimationPage(
                  start: 0.0,
                  finish: 0.5,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Credit Card Loans',
                        style: displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextField(
              style: entryFonts(),
              controller: creditCardLoan,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: AnimationPage(
                  start: 0.125,
                  finish: 0.675,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Mortgage',
                        style: displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextField(
              style: entryFonts(),
              controller: mortgage,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: AnimationPage(
                  start: 0.25,
                  finish: 0.75,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Student Loans',
                        style: displayFonts(),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextField(
              style: entryFonts(),
              controller: studentLoan,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            Expanded(
                child: AnimationPage(
                  start: 0.375,
                  finish: 0.875,
                  child: SizedBox(
                    child: Center(
                      child: Text(
                        'Liabilities Total',
                        style: TextStyle(
                          fontFamily: 'Ubuntu',
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  animation: transitionAnimation,
                )
            ),
            TextField(
              enabled: false,
              controller: liabilitiesTotal,
              textAlign: TextAlign.center,
              style: TextStyle(
              fontFamily: 'Ubuntu',
              color: Colors.red,
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the
        // text that the user has entered into the text field.
        onPressed: () {

          liabilityfields.x = retainValue1(creditCardLoan.text);
          liabilityfields.y = retainValue1(mortgage.text);
          liabilityfields.z = retainValue1(studentLoan.text);

//          liabilityfields.retainValue1(x, y, z);
          liabilityfields.sum_of_fields(liabilityfields.x, liabilityfields.y, liabilityfields.z);
          setState(() {});
          
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has entered by using the
                // TextEditingController.

                content: Text('saved'),

              );
            },
          );

        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}

class ExpensesPage extends StatefulWidget {
  ExpensesPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  ExpensesPageState createState() => ExpensesPageState();

}

class ExpensesPageState extends State<ExpensesPage> {


  final houseBills = TextEditingController();
  final creditCardBills = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    houseBills.dispose();
    creditCardBills.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Expenses'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              child: Center(
                child: Text(
                  'House Bills',
                ),

              ),
            ),
            TextField(
              controller: houseBills,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Credit Card Bills',
                ),
              ),
            ),
            TextField(
              controller: creditCardBills,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the
        // text that the user has entered into the text field.
        onPressed: () {
          return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                // Retrieve the text the user has entered by using the
                // TextEditingController.

                content: Text(creditCardBills.text),

              );
            },
          );

        },
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),
      ),
    );
  }
}