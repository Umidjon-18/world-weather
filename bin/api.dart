import 'dart:io';
import 'package:hive/hive.dart';

import 'utils.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;

import 'weather_model.dart';

class API {
  
  Utils utils = Utils();
  connectAPI(String country, String region, String month, weatherBox) async {
    var response = await http.get(Uri.parse(
        'https://world-weather.ru/pogoda/$country/$region/$month-2022/'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var weatherTemDay = document
          .getElementsByClassName("ww-month")[0]
          .getElementsByTagName("span")
          .map((e) => e.text)
          .toList();
      var weatherTemNight = document
          .getElementsByClassName("ww-month")[0]
          .getElementsByTagName("p")
          .map((e) => e.text)
          .toList();
      List<WeatherModel> list = [];
      for (int i = 1; i <= weatherTemDay.length; i++) {
        list.add(WeatherModel(
            day: i.toString(),
            tempDay: weatherTemDay[i - 1],
            tempNight: weatherTemNight[i - 1]));
      }
      weatherBox.addAll(list);
    } else {
      utils.printModel2(utils.redColor(
          "Bog'lanishda xatolik yuz berdi ❌\n  Status code : ${response.statusCode}"));
      exit(0);
    }
  }

 Future<List<WeatherModel>> getResult(String country, String region, String month) async {
  var weatherBoxName = "$country-$region-$month";
    if(Hive.isBoxOpen(weatherBoxName)){
      var weatherBox = Hive.box<WeatherModel>(weatherBoxName);
      return weatherBox.values.toList();
    } else {
      var weatherBox = await Hive.openBox<WeatherModel>(weatherBoxName);
      await connectAPI(country, region, month, weatherBox);
      return weatherBox.values.toList();
    }
  }

  boxClose(String boxName) async {
    var selectedBox = await Hive.openBox(boxName);
    await selectedBox.close();
  }

  connectByHour(String country, String region) async {
    var response = await http.get(
        Uri.parse('https://world-weather.ru/pogoda/$country/$region/24hours/'));
    if (response.statusCode == 200) {
      var document = parse(response.body);
      var soatlar = [];
      var havoBosimi = [];
      var temperatura = [];
      var shamolTezligi = [];
      var yoginEhtimoli = [];
      document.getElementsByClassName("weather-day").forEach((element) {
        soatlar.add(element.text);
      });
      document.getElementsByClassName("weather-feeling").forEach((element) {
        temperatura.add(element.text);
      });
      document.getElementsByClassName("weather-probability").forEach((element) {
        yoginEhtimoli.add(element.text);
      });
      document.getElementsByClassName("weather-pressure").forEach((element) {
        havoBosimi.add(element.text);
        document.getElementsByClassName("weather-wind").forEach((element) {
          shamolTezligi
              .add(element.getElementsByTagName("span")[1].attributes["title"]);
        });
      });
      return {
        "status": 200,
        "soat": soatlar,
        "havoBosimi": havoBosimi,
        "temperatura": temperatura,
        "shamolTezligi": shamolTezligi,
        "yoginEhtimoli": yoginEhtimoli
      };
    } else {
      return {"status": response.statusCode};
    }
  }
}
