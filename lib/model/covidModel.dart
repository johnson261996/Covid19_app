// To parse this JSON data, do
//
//     final covidModel = covidModelFromJson(jsonString);

import 'dart:convert';

CovidModel covidModelFromJson(String str) => CovidModel.fromJson(json.decode(str));

String covidModelToJson(CovidModel data) => json.encode(data.toJson());

class CovidModel {
  SummaryStats? summaryStats;
  Cache? cache;
  DataSource? dataSource;
  String? apiSourceCode;
  List<RawDatum>? rawData;
  String? error;

  CovidModel({
    this.summaryStats,
    this.cache,
    this.dataSource,
    this.apiSourceCode,
    this.rawData,
  });

  CovidModel.withError(String errorMessage) {
    error = errorMessage;
  }

  factory CovidModel.fromJson(Map<String, dynamic> json) => CovidModel(
    summaryStats: json["summaryStats"] == null ? null : SummaryStats.fromJson(json["summaryStats"]),
    cache: json["cache"] == null ? null : Cache.fromJson(json["cache"]),
    dataSource: json["dataSource"] == null ? null : DataSource.fromJson(json["dataSource"]),
    apiSourceCode: json["apiSourceCode"],
    rawData: json["rawData"] == null ? [] : List<RawDatum>.from(json["rawData"]!.map((x) => RawDatum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "summaryStats": summaryStats?.toJson(),
    "cache": cache?.toJson(),
    "dataSource": dataSource?.toJson(),
    "apiSourceCode": apiSourceCode,
    "rawData": rawData == null ? [] : List<dynamic>.from(rawData!.map((x) => x.toJson())),
  };
}

class Cache {
  String? lastUpdated;
  String? expires;
  int? lastUpdatedTimestamp;
  int? expiresTimestamp;

  Cache({
    this.lastUpdated,
    this.expires,
    this.lastUpdatedTimestamp,
    this.expiresTimestamp,
  });

  factory Cache.fromJson(Map<String, dynamic> json) => Cache(
    lastUpdated: json["lastUpdated"],
    expires: json["expires"],
    lastUpdatedTimestamp: json["lastUpdatedTimestamp"],
    expiresTimestamp: json["expiresTimestamp"],
  );

  Map<String, dynamic> toJson() => {
    "lastUpdated": lastUpdated,
    "expires": expires,
    "lastUpdatedTimestamp": lastUpdatedTimestamp,
    "expiresTimestamp": expiresTimestamp,
  };
}

class DataSource {
  String? url;
  DateTime? lastGithubCommit;
  String? publishedBy;
  String? ref;

  DataSource({
    this.url,
    this.lastGithubCommit,
    this.publishedBy,
    this.ref,
  });

  factory DataSource.fromJson(Map<String, dynamic> json) => DataSource(
    url: json["url"],
    lastGithubCommit: json["lastGithubCommit"] == null ? null : DateTime.parse(json["lastGithubCommit"]),
    publishedBy: json["publishedBy"],
    ref: json["ref"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "lastGithubCommit": lastGithubCommit?.toIso8601String(),
    "publishedBy": publishedBy,
    "ref": ref,
  };
}

class RawDatum {
  String? fips;
  String? admin2;
  String? provinceState;
  String? countryRegion;
  DateTime? lastUpdate;
  String? lat;
  String? long;
  String? confirmed;
  String? deaths;
  String? recovered;
  String? active;
  String? combinedKey;
  String? incidentRate;
  String? caseFatalityRatio;

  RawDatum({
    this.fips,
    this.admin2,
    this.provinceState,
    this.countryRegion,
    this.lastUpdate,
    this.lat,
    this.long,
    this.confirmed,
    this.deaths,
    this.recovered,
    this.active,
    this.combinedKey,
    this.incidentRate,
    this.caseFatalityRatio,
  });

  factory RawDatum.fromJson(Map<String, dynamic> json) => RawDatum(
    fips: json["FIPS"],
    admin2: json["Admin2"],
    provinceState: json["Province_State"],
    countryRegion: json["Country_Region"],
    lastUpdate: json["Last_Update"] == null ? null : DateTime.parse(json["Last_Update"]),
    lat: json["Lat"],
    long: json["Long_"],
    confirmed: json["Confirmed"],
    deaths: json["Deaths"],
    recovered: json["Recovered"],
    active: json["Active"],
    combinedKey: json["Combined_Key"],
    incidentRate: json["Incident_Rate"],
    caseFatalityRatio: json["Case_Fatality_Ratio"],
  );

  Map<String, dynamic> toJson() => {
    "FIPS": fips,
    "Admin2": admin2,
    "Province_State": provinceState,
    "Country_Region": countryRegion,
    "Last_Update": lastUpdate?.toIso8601String(),
    "Lat": lat,
    "Long_": long,
    "Confirmed": confirmed,
    "Deaths": deaths,
    "Recovered": recovered,
    "Active": active,
    "Combined_Key": combinedKey,
    "Incident_Rate": incidentRate,
    "Case_Fatality_Ratio": caseFatalityRatio,
  };
}

class SummaryStats {
  China? global;
  China? china;
  China? nonChina;

  SummaryStats({
    this.global,
    this.china,
    this.nonChina,
  });

  factory SummaryStats.fromJson(Map<String, dynamic> json) => SummaryStats(
    global: json["global"] == null ? null : China.fromJson(json["global"]),
    china: json["china"] == null ? null : China.fromJson(json["china"]),
    nonChina: json["nonChina"] == null ? null : China.fromJson(json["nonChina"]),
  );

  Map<String, dynamic> toJson() => {
    "global": global?.toJson(),
    "china": china?.toJson(),
    "nonChina": nonChina?.toJson(),
  };
}

class China {
  int? confirmed;
  int? recovered;
  int? deaths;

  China({
    this.confirmed,
    this.recovered,
    this.deaths,
  });

  factory China.fromJson(Map<String, dynamic> json) => China(
    confirmed: json["confirmed"],
    recovered: json["recovered"],
    deaths: json["deaths"],
  );

  Map<String, dynamic> toJson() => {
    "confirmed": confirmed,
    "recovered": recovered,
    "deaths": deaths,
  };
}
