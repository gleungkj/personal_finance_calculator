import 'dart:math';

class calculatedStatus{
  bool uncalculatedinterest = true;
  bool uncalculatedtarget = true;
  bool uncalculatedyears = true;
}


class homeValue {
  String x;
  String y;
  String z;
  String sum;
  String years;


  void sum_of_fields(input1,input2,input3) {
    input1 = retainValue1(input1);
    input2 = retainValue1(input2);
    input3 = retainValue1(input3);
    num total = double.parse(input1) + double.parse(input2) + double.parse(input3);
//    print(total);
    sum = total.toStringAsFixed(2);
  }
}

String retainValue1(input1) {
  if (input1 == ''){
    input1 = '0.00';
  };
  input1 = (double.parse(input1)).toStringAsFixed(2);
  return input1;
}

String convertToPercentage(input1) {
  return input1 = (double.parse(input1) / 100).toStringAsFixed(2);
}

String calculate(initial_balance, interest_rate, target_amount, year_elapsed) {
//  final amount = initial principal balance(1+interest rate/number of times interest applied per time period)^   cont...
//    (number of times interest applied per time period * number of time periods elapsed)
//  A = P(1+r/n)^nt
  initial_balance = double.parse(initial_balance);
  interest_rate = double.parse(interest_rate);
  target_amount = double.parse(target_amount);
  year_elapsed = double.parse(year_elapsed);

  if (initial_balance == 0) {
      print('You need to input an initial balance!');
      return null;
  }
  else if (interest_rate == 0) {
//    r = n[(A/P)^1/nt - 1]
    interest_rate = 100 * (pow((target_amount/initial_balance),(1/year_elapsed)) - 1);
    return interest_rate.toStringAsFixed(2);
  }
  else if (target_amount == 0) {
//    A = P(1 + r/n) ^ nt
    target_amount = initial_balance * pow((1+(interest_rate / 100)), year_elapsed);
    return target_amount.toStringAsFixed(2);
  }
  else if (year_elapsed == 0) {
//    t = ln(A/P) / n[ln(1 + r/n)] = [ ln(A) - ln(P) ] / n[ln(1 + r/n)]
    year_elapsed = log(target_amount/initial_balance)/log(1+(interest_rate / 100));
    return year_elapsed.toStringAsFixed(2);
  }

}

var homefields = new homeValue();

var assetfields = new homeValue();

var liabilityfields = new homeValue();

var calculatedStatuses = new calculatedStatus();