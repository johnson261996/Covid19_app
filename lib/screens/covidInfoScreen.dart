

import 'package:covid_19/model/covidModel.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';

class CovidInfoScreen extends StatefulWidget {
  List<RawDatum> model;
   CovidInfoScreen({Key? key,required this.model}) : super(key: key);

  @override
  State<CovidInfoScreen> createState() => _CovidInfoScreenState();
}

class _CovidInfoScreenState extends State<CovidInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: Text("Covid Details"),
    ),
    body:ListView.builder(
        itemCount: widget.model.length,
        itemBuilder: (context, index) {
          int total = int.parse(widget.model[index].confirmed!) + int.parse(widget.model[index].deaths!) + int.parse(widget.model[index].recovered!.isEmpty ? 0.toString() : widget.model[index].recovered!);
          return Container(
            margin: EdgeInsets.all(8.0),
            child: Card(
              child: Container(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.model[index].admin2!.isEmpty ? Text(widget.model[index].provinceState!,style:kSubTextStyle ,) :  Text(widget.model[index].admin2! + "," + widget.model[index].provinceState!,style:kSubTextStyle ,),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Total",style: TextStyle(fontSize: 14,color:kPrimaryColor,fontWeight: FontWeight.bold ),
                        ),
                        Text(
                            "Active" ,style: TextStyle(fontSize: 14,color:kInfectedColor,fontWeight: FontWeight.bold ),
                        ),
                        Text(
                          "Recovered" ,style: TextStyle(fontSize: 14,color:kRecovercolor,fontWeight: FontWeight.bold ),
                        ),
                        Text(
                          "Deaths" ,style: TextStyle(fontSize: 14,color:kDeathColor,fontWeight: FontWeight.bold ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(  total.toString(),style: TextStyle(fontSize: 14,color:kPrimaryColor,fontWeight: FontWeight.bold)),
                    Text(
                            widget.model[index].confirmed!,style: TextStyle(fontSize: 14,color:kInfectedColor,fontWeight: FontWeight.bold)),
                        Text(
                            widget.model[index].recovered!.isEmpty ? 0.toString() : widget.model[index].recovered!,style: TextStyle(fontSize: 14,color:kPrimaryColor,fontWeight: FontWeight.bold)),
                        Text( widget.model[index].deaths!,style: TextStyle(fontSize: 14,color:kPrimaryColor,fontWeight: FontWeight.bold)),

                      ],
                    ),

                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }
}
