import 'dart:io';
import 'api.dart';
import 'utils.dart';

class App {
  Utils utils = Utils();
  API api = API();

  weatherGo() async {
    utils.printModel(utils.greenColor(
        "Assalomu alaykum.\n\n  Select country. Example: Uzbekistan"));
    var country = stdin.readLineSync()!.trim().toLowerCase();
    if (country == "0") {
      utils.clear();
      exit(0);
    }
    utils.printModel(utils.greenColor("Select region. Example: Tashkent"));
    var region = stdin.readLineSync()!.trim().toLowerCase();
    utils.printModel(utils.greenColor('''
    1) Oy bo'yicha ko'rish
      2) Kun bo'yicha ko'rish
      3) Soat bo'yicha ko'rish
'''));
    var select = stdin.readLineSync()!.trim();
    if (select == "1") {
      utils.printModel(utils.greenColor("Select month. Example: may"));
      var month = stdin.readLineSync()!.trim().toLowerCase();
      var result = await api.getResult(country, region, month);
      utils.printModel(utils
          .greenColor("✅ Country: $country. Region: $region. Month: $month ✅"));
      result.forEach((item) => {
            utils.printModel2(utils.greenColor(
                "${item.day} - $month  🌕 Kunduzi : ${item.tempDay}  🌙 Kechasi: ${item.tempNight} ✅"))
          });
    } else if (select == "2") {
      utils.printModel(utils.greenColor("Select month. Example: may"));
      var month = stdin.readLineSync()!.trim().toLowerCase();
      var result = await api.getResult(country, region, month);
      utils.printModel(utils.greenColor("Select day. Example: 1"));
      var day = int.parse(stdin.readLineSync()!.trim());
      utils.printModel2(utils.greenColor(
          "${result[day - 1].day} - $month. 🌕 Kunduzi: ${result[day - 1].tempDay}. 🌙 Kechasi : ${result[day - 1].tempNight} ✅"));
    } else if (select == "3") {
      var result = await API().connectByHour(country, region);
      if (result["status"] == 200) {
        for (int i = 0; i < 24; i++) {
          utils.printModel2(utils.greenColor(
              "🕑 Soat: ${result["soat"][i]} | Havo bosimi: ${result["havoBosimi"][i]} | 🌡 Temp: ${result["temperatura"][i]} | 🌧 Yog'ingarchilik: ${result["yoginEhtimoli"][i]} | Shamol tezligi: ${result["shamolTezligi"][i]}  ✅"));
        }
      } else {
        utils.printModel2(utils.redColor(
            "Bog'lanishda xatolik yuz berdi ❌\n  Status code : ${result["status"]}"));
        exit(0);
      }
    } else {
      utils.printModel2(utils.redColor("Noto'g'ri buyruq kiritildi ❌"));
      exit(0);
    }

    utils.printModel2(utils.redColor(
        "| Davom etish uchun Enter | Chiqish uchun istalgan boshqa tugmani bosing |"));
    var check = stdin.readLineSync()!;
    if (check.isEmpty) {
      weatherGo();
    } else {
      api.boxClose("weather-box");
      exit(0);
    }
  }
}
