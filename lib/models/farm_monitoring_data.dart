class FarmMonitoringData {
  FarmMonitoringData({
    this.status = '',
    this.soilHumidity = 0,
    this.temperature = 0,
    this.airHumidity = 0,
    this.soilPh = 0,
  });

  String status;
  int soilHumidity;
  int temperature;
  int airHumidity;
  int soilPh;

  factory FarmMonitoringData.fromJson(Map<String, dynamic> json) {
    return FarmMonitoringData(
      status: json["status"],
      airHumidity: json["air_humidity"],
      soilHumidity: json["soil_humidity"],
      soilPh: json["soil_ph"],
      temperature: json["temperature"],
    );
  }

  Map<String, dynamic> toJson() => {
        "status": status,
        "air_humidity": airHumidity,
        "soil_humidity": soilHumidity,
        "soil_ph": soilPh,
        "temperature": temperature,
      };
}
