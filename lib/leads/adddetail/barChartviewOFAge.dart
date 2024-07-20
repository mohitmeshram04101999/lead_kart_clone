import 'package:flutter/material.dart';
import 'package:leadkart/leads/adddetail/add_detail_screen.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../helper/dimention.dart';


class BarChartViewOfAge extends StatelessWidget {
  Map data;
  BarChartViewOfAge({required this.data,super.key});

  @override
  Widget build(BuildContext context) {

     List _d = data["data"];
    return Column(
      children: [

        Padding(
          padding: EdgeInsets.symmetric(horizontal: SC.from_height(15)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Age',
                style: TextStyle(fontSize: SC.from_height(18),color: Colors.grey.shade700,fontWeight: FontWeight.w500),
              ),
              InkWell(
                onTap: (){

                },
                child: Text(
                  'Views',
                  style: TextStyle(
                      fontSize: SC.from_height(18),
                      color: Color.fromRGBO(36, 238, 221, 1)),
                ),
              ),
            ],
          ),
        ),

        SizedBox(
          height: 300,
          child: SfCartesianChart(

            primaryXAxis: const CategoryAxis(
              majorGridLines: MajorGridLines(width: 0),// Remove X-axis gridlines
              axisLine: AxisLine(width: 0),
              majorTickLines: MajorTickLines(size: 0),
            ),
            primaryYAxis:const  NumericAxis(
              isVisible: false, // Hide Y-axis for better visual
              majorGridLines: MajorGridLines(width: 0), // Remove Y-axis gridlines
            ),
            // Hide Y-axis for better visual
            plotAreaBorderWidth: 0,
            // Remove plot area border
            series: [
              ColumnSeries<SalesData, String>(
                dataSource: <SalesData>[

                  for(var i in _d)
                    SalesData('${i["age"]}', double.parse(i["impressions"]??"0")),
                ],
                xValueMapper: (SalesData sales, _) => sales.month,
                yValueMapper: (SalesData sales, _) => sales.sales,
                borderRadius: BorderRadius.circular(0),
                color: Colors.indigo.shade400,
                // Optionally, make bar corners rounded
                // spacing: 0.2,
                // Adjust spacing between bars
                dataLabelSettings: DataLabelSettings(
                  isVisible: true,

                  textStyle: const  TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                  labelPosition: ChartDataLabelPosition.inside,
                  builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                    // Check if data is not null
                    if (data != null) {
                      return Text(
                        "${data.sales.toInt()}", // Access sales property if data is not null
                        style:const  TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      );
                    } else {
                      return const SizedBox(); // Return an empty widget if data is null
                    }
                  },

                  labelAlignment: ChartDataLabelAlignment.top, // Align labels inside the bars
                ),
              ),
            ],
          ),
        ),

        const Center(
          child: Text('Age Group',style: TextStyle(color: Colors.grey),),
        ),
      ],
    );
  }
}
