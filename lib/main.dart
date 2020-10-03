import 'package:flutter/material.dart';
import 'nav-drawer.dart';
import 'data.dart';
import 'animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
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


class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;



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
            SizedBox(
              child: Center(
                child: Text(
                  'Initial Funds',
                ),

              ),
            ),

            TextFormField(
                controller: initialFunds,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
            ),
            
            SizedBox(
              child: Center(
                child: Text(
                  'Annual interest percentage (%)',
                ),
              ),
            ),
            TextFormField(
              controller: annualInterestpercentage,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Target Amount',
                ),
              ),
            ),
            TextFormField(
              controller: targetAmount,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Number of Years',
                ),
              ),
            ),
            TextFormField(
              controller: NumberofYears,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            RaisedButton(
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
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        // When the user presses the button, show an alert dialog containing the
        // text that the user has entered into the text field.
        onPressed: () {
//          save(_MyHomePageState);
        homefields.x = retainValue1(initialFunds.text);
        homefields.y = retainValue1(annualInterestpercentage.text);
        homefields.z = retainValue1(targetAmount.text);
        homefields.years = retainValue1(NumberofYears.text);

        String result = calculate(homefields.x, homefields.y, homefields.z, homefields.years);
        print(result);
        if (homefields.y == '0.00') {
          homefields.y = result;
        }
        else if (homefields.z == '0.00') {
          homefields.z = result;
        }
        else if (homefields.years == '0.00') {
          homefields.years = result;
        }
//        homefields.retainValue1(x, y, z);
        setState(() {

        });
//        retainValue1(x, y, z);

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
        tooltip: 'Show me the value!',
        child: Icon(Icons.text_fields),

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
  int _counter = 0;
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
              child:AnimatedBuilder(
                animation: transitionAnimation,
                builder: (context, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(-1, 0),
                      end: Offset(0, 0),
                    ).animate(CurvedAnimation(
                      parent: transitionAnimation,
                      curve: Interval(0,0.5, curve: Curves.easeInCubic),
                    )),
                    child: child,
                  );
                },

                child: SizedBox(
                  child: Center(
                    child: Text(
                      'Bank account',
                    ),

                  ),
                ),

              ),
            ),


            SizedBox(
              child: Center(
                child: Text(
                  'Pension',
                ),
              ),
            ),
            TextField(
              controller: pension,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Investment',
                ),
              ),
            ),
            TextField(
              controller: investment,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Asset Total',
                ),
              ),
            ),
            TextField(
              enabled: false,
              controller: assetTotal,
              textAlign: TextAlign.center,
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

class LiabilitiesPageState extends State<LiabilitiesPage> {
  int _counter = 0;

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
            SizedBox(
              child: Center(
                child: Text(
                  'Credit Card Loans',
                ),

              ),
            ),
            TextField(
              controller: creditCardLoan,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Mortgage',
                ),
              ),
            ),
            TextField(
              controller: mortgage,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Student Loans',
                ),
              ),
            ),
            TextField(
              controller: studentLoan,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              child: Center(
                child: Text(
                  'Liabilities Total',
                ),
              ),
            ),
            TextField(
              enabled: false,
              controller: liabilitiesTotal,
              textAlign: TextAlign.center,
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
  int _counter = 0;

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