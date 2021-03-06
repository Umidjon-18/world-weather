import 'package:hive/hive.dart';
import 'app.dart';
import 'utils.dart';
import 'weather_model.dart';

Utils utils = Utils();

void main(List<String> arguments) async {
  Hive.init("../src");
  Hive.registerAdapter<WeatherModel>(WeatherModelAdapter());
  App().weatherGo();
}
