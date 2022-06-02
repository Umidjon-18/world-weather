import 'dart:convert';
import 'package:hive/hive.dart';
part 'weather_model.g.dart';

@HiveType(typeId: 1)
class WeatherModel extends HiveObject{
  @HiveField(0)
  String? day;
  @HiveField(1)
  String? tempDay;
  @HiveField(2)
  String? tempNight;

  WeatherModel({this.day, this.tempDay, this.tempNight});

  @override
  String toString() {
    return 'WeatherModel(day: $day, tempDay: $tempDay, tempNight: $tempNight)';
  }

  factory WeatherModel.fromMap(Map<String, dynamic> data) => WeatherModel(
        day: data['day'] as String?,
        tempDay: data['tempDay'] as String?,
        tempNight: data['tempNight'] as String?,
      );

  Map<String, dynamic> toMap() => {
        'day': day,
        'tempDay': tempDay,
        'tempNight': tempNight,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [WeatherModel].
  factory WeatherModel.fromJson(String data) {
    return WeatherModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [WeatherModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
