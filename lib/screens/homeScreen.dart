import 'dart:convert';

import 'package:covid_19/screens/covidInfoScreen.dart';
import 'package:covid_19/screens/covidMapScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../bloc/covid_bloc.dart';
import '../constant/constant.dart';
import '../model/covidModel.dart';
import '../widgets/counter.dart';
import '../widgets/myHeader.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CovidBloc _newsBloc = CovidBloc();
  double offset = 0;
  dynamic jsonResult;
  List<Countries> _countries = [];
  String selectedRegion = 'Afghanistan';

  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
    loadJson();
  }

  loadJson() async {
    String data = await rootBundle.loadString('assets/json/country_json.json');
     jsonResult = json.decode(data);
     setState(() {
       _countries = (jsonResult).map<Countries>((item) => Countries.fromJson(item)).toList();
     });
    print(jsonResult);
  }

  @override
  Widget build(BuildContext context) {
    print("selectedRegion:$selectedRegion");
    return Scaffold(
      appBar: AppBar(title: Text('COVID-19 ')),
      body: SingleChildScrollView(
          child: _buildListCovid()),
    );
  }

  Widget _buildListCovid() {
    return Column(
      children: [
        MyHeader(
          image: "assets/icons/Drcorona.svg",
          textTop: "All you need",
          textBottom: "is stay at home.",
          offset: offset,
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          height: 60,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(
              color: Color(0xFFE5E5E5),
            ),
          ),
          child: Row(
            children: <Widget>[
              SvgPicture.asset("assets/icons/maps-and-flags.svg"),
              SizedBox(width: 20),
              Expanded(
                child: DropdownButton(
                  isExpanded: true,
                  underline: SizedBox(),
                  icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                  value: selectedRegion,
                  items: _countries
                      .map((Countries value) {
                    return DropdownMenuItem<String>(
                      value: value.country,
                      child: Text(value.country!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedRegion = value!;
                    });

                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.all(8.0),
          child: BlocProvider(
            create: (_) => _newsBloc,
            child: BlocListener<CovidBloc, CovidState>(
              listener: (context, state) {
                if (state is CovidError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.message!),
                    ),
                  );
                }
              },
              child: BlocBuilder<CovidBloc, CovidState>(
                builder: (context, state) {
                  if (state is CovidInitial) {
                    return _buildLoading();
                  } else if (state is CovidLoading) {
                    return _buildLoading();
                  } else if (state is CovidLoaded) {
                    return _buildbody(context, state.covidModel);
                  } else if (state is CovidError) {
                    return Container();
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildbody(BuildContext context, CovidModel model) {
    int country_confirmed = 0;
    int country_deaths = 0;
    int country_recovered = 0;
    List<RawDatum> country_list = [];
    for(int index=0;index<model.rawData!.length;index++){
      if(model.rawData![index].countryRegion.toString() == selectedRegion)
      {
        country_confirmed += int.parse(model.rawData![index].confirmed!);
        country_deaths += int.parse(model.rawData![index].deaths!);
        country_list.add(model.rawData![index]);
      }else if( selectedRegion == 'United States' && model.rawData![index].countryRegion.toString() == "US"){
        // country_confirmed = model.summaryStats!.global!.confirmed!.toInt();
        // country_deaths = model.summaryStats!.global!.deaths!.toInt();
        // country_list.add(model.rawData![index]);
        country_confirmed += int.parse(model.rawData![index].confirmed!);
        country_deaths += int.parse(model.rawData![index].deaths!);
        country_list.add(model.rawData![index]);
      }else if( selectedRegion == 'South Korea' && model.rawData![index].countryRegion.toString() == "Korea, South"){
        // country_confirmed = model.summaryStats!.global!.confirmed!.toInt();
        // country_deaths = model.summaryStats!.global!.deaths!.toInt();
        // country_list.add(model.rawData![index]);
        country_confirmed += int.parse(model.rawData![index].confirmed!);
        country_deaths += int.parse(model.rawData![index].deaths!);
        country_list.add(model.rawData![index]);
      }
      //  country_recovered += int.parse(model.rawData![index].recovered!);
    }
    print("counytry total confirmed:$country_confirmed");
    print("counytry total deaths:$country_deaths");
    print("counytry total recovered:$country_recovered");


    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Case Update\n",
                      style: kTitleTextstyle,
                    ),
                    TextSpan(
                      text: "Newest update March 28",
                      style: TextStyle(
                        color: kTextLightColor,
                      ),
                    ),
                  ],
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) {
                        return CovidInfoScreen(model:country_list);
                      },
                    ));
                },
                child: Text(
                  "See details",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 4),
                  blurRadius: 30,
                  color: kShadowColor,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Counter(
                  color: kInfectedColor,
                  number: country_confirmed,
                  title: "Infected",
                ),
                Counter(
                  color: kDeathColor,
                  number: country_deaths,
                  title: "Deaths",
                ),
                Counter(
                  color: kRecovercolor,
                  number: country_recovered,
                  title: "Recovered",
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Spread of Virus",
                style: kTitleTextstyle,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context,MaterialPageRoute(builder: (context) {
                  return CovidMapScreen();
                },
                )),
                child: Text(
                  "See details",
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.all(20),
            height: 178,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 30,
                  color: kShadowColor,
                ),
              ],
            ),
            child: Image.asset(
              "assets/images/world_map.png",
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}

class Countries {
   String? country;
  String? currency_code;

  Countries({ this.country,this.currency_code});
  factory Countries.fromJson(Map<String, dynamic> json) {
    return new Countries(
        country: json['country'], currency_code: json['currency_code']);
  }
}
