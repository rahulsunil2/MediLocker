import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class DateTimeChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  double screenHeight;
  var finaldate;

  DateTimeChart(this.seriesList, {this.animate});

  factory DateTimeChart.withSampleData() {
    return new DateTimeChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      
      body: SingleChildScrollView(
              child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Color.fromRGBO(116, 116, 191, 1.0),
              Color.fromRGBO(52, 138, 199, 1.0)
            ]),
           ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
              child: Container(
                height: 550,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(20.0),
                child: new Column(
                  children: [
                    new Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text(
                "DIABETES",
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    Text(
                      "Glucose Level",
                      style: new TextStyle(
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    new Flexible(
                      child: new TextFormField(
                        decoration: new InputDecoration(
                          labelText: "Date",
                          fillColor: Colors.white,
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(15.0),
                            borderSide: new BorderSide(),
                          ),
                        ),
                        validator: (val) {
                          if (val.length == 0) {
                            return "Date";
                          } else {
                            return null;
                          }
                        },
                        keyboardType: TextInputType.datetime,
                        style: new TextStyle(
                          fontFamily: "Poppins",
                          fontSize: 10,
                        ),
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(bottom: 20.0)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        new Flexible(
                          child: new TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Before Fasting",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Value can not be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.datetime,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                               fontSize: 8,
                            ),
                          ),
                        ),
                        new Padding(padding: EdgeInsets.only(left: 10.0)),
                        new Flexible(
                          child: new TextFormField(
                            decoration: new InputDecoration(
                              labelText: "After fasting",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(15.0),
                                borderSide: new BorderSide(),
                              ),
                            ),
                            validator: (val) {
                              if (val.length == 0) {
                                return "Value can not be empty";
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            style: new TextStyle(
                              fontFamily: "Poppins",
                               fontSize: 8,
                            ),
                          ),
                        ),
                      ],
                    ),
                    new Padding(padding: EdgeInsets.only(bottom:10.0)),
                    Card(
                      child: Container(
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                          child:
                              new charts.TimeSeriesChart(
                                seriesList,
                                animate: animate,
                                defaultRenderer:
                                    new charts.LineRendererConfig(),
                                customSeriesRenderers: [
                                  new charts.PointRendererConfig(
                                      customRendererId: 'customPoint')
                                ],
                                dateTimeFactory:
                                    const charts.LocalDateTimeFactory(),
                              ),
                      ),
                    ),
                    new Padding(padding: EdgeInsets.only(bottom:10.0)),
                    Row(
                                children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  color: Colors.green,
                                ),
                                Text(
                                  '  Normal Range ( 125 mg )'
                                ),
                              ],
                              ),
                              Row(
                                children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  color: Colors.blue,
                                ),
                                Text(
                                  '  Before Fasting'
                                ),
                              ],
                              ),
                              Row(
                                children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  color: Colors.red,
                                ),
                                Text(
                                  '  After Fasting'
                                ),
                              ],
                              ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<TimeSeries, DateTime>> _createSampleData() {
    final beforeFasting = [
      new TimeSeries(new DateTime(2020, 1, 19), 70),
      new TimeSeries(new DateTime(2020, 2, 2), 90),
      new TimeSeries(new DateTime(2020, 2, 20), 190),
      new TimeSeries(new DateTime(2020, 3, 10), 175),
    ];

    final afterFasting = [
      new TimeSeries(new DateTime(2020, 1, 19), 80),
      new TimeSeries(new DateTime(2020, 2, 2), 120),
      new TimeSeries(new DateTime(2020, 2, 20), 200),
      new TimeSeries(new DateTime(2020, 3, 10), 190),
    ];
    final normalGlucose = [
      new TimeSeries(new DateTime(2020, 1, 19), 125),
      new TimeSeries(new DateTime(2020, 2, 26), 125),
      new TimeSeries(new DateTime(2020, 2, 3), 125),
      new TimeSeries(new DateTime(2020, 3, 10), 125),
    ];

    return [
      new charts.Series<TimeSeries, DateTime>(
        id: 'Glucose',
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        domainFn: (TimeSeries value, _) => value.time,
        measureFn: (TimeSeries value, _) => value.glucose,
        data: normalGlucose,
      ),
      new charts.Series<TimeSeries, DateTime>(
        id: 'Before Fasting',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (TimeSeries value, _) => value.time,
        measureFn: (TimeSeries value, _) => value.glucose,
        data: beforeFasting,
      ),
      new charts.Series<TimeSeries, DateTime>(
        id: 'After Fasting',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (TimeSeries value, _) => value.time,
        measureFn: (TimeSeries value, _) => value.glucose,
        data: afterFasting,
      ),
    ];
  }
}

/// Sample time series data type.
class TimeSeries {
  final DateTime time;
  final int glucose;

  TimeSeries(this.time, this.glucose);
}
