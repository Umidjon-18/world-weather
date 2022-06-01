import 'dart:io';
import 'package:colorize/colorize.dart';

class Utils {
  void printModel(Colorize text) {
    print(greenColor(
        '''-----------------------------------------------------------------------------------------------------------------
|                                                                                                               |'''));
    print("  $text");
    print(greenColor(
        '''|                                                                                                               |
-----------------------------------------------------------------------------------------------------------------'''));
  }

  void printModel2(Colorize text) {
    print(greenColor(
        '''-----------------------------------------------------------------------------------------------------------------'''));
    print("  $text");
    print(greenColor(
        '''-----------------------------------------------------------------------------------------------------------------'''));
  }

  Colorize greenColor(String text) {
    return Colorize(text).green();
  }

  Colorize redColor(String text) {
    return Colorize(text).red();
  }

  waiting(bool cycle) async {
    var str1 = 'Malumot yuklanmoqda .';
    var str2 = 'Malumot yuklanmoqda ..';
    var str3 = 'Malumot yuklanmoqda ...';
    var str4 = 'Malumot yuklanmoqda ....';
    while (true) {
      clear();
      print(str1);
      await Future.delayed(Duration(milliseconds: 100));
      clear();
      print(str2);
      await Future.delayed(Duration(milliseconds: 100));
      clear();
      print(str3);
      await Future.delayed(Duration(milliseconds: 100));
      clear();
      print(str4);
      await Future.delayed(Duration(milliseconds: 100));
    }
  }

  clear() {
    print(Process.runSync("clear", [], runInShell: true).stdout);
  }
}
