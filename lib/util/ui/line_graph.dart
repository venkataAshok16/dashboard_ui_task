import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UTILLineGraphUI extends StatefulWidget {
  final LineGraphModal modal;
  const UTILLineGraphUI({Key? key, required this.modal}) : super(key: key);

  @override
  State<UTILLineGraphUI> createState() => _UTILLineGraphUIState();
}

class _UTILLineGraphUIState extends State<UTILLineGraphUI> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: SfCartesianChart(
              enableAxisAnimation: true,
              primaryXAxis: CategoryAxis(
                majorGridLines: const MajorGridLines(width: 0),
                axisLine: const AxisLine(width: 0),
                title: AxisTitle(
                    text: widget.modal.xAxisTitle,
                    textStyle: const TextStyle(color: Colors.black)),
                labelRotation: -45,
                autoScrollingMode: AutoScrollingMode.end,
                // visibleMaximum: (widget.modal.isLandScapeMode) ? 10.5 : 5.5,
                // interval: 1,
              ),
              primaryYAxis: NumericAxis(
                plotBands: <PlotBand>[
                  PlotBand(
                      verticalTextPadding: '5%',
                      horizontalTextPadding: '5%',
                      text:
                          '                                          Average 25',
                      textAngle: 360,
                      start: 25,
                      end: 25,
                      textStyle: const TextStyle(color: Colors.purple),
                      borderColor: Colors.purple,
                      horizontalTextAlignment: TextAnchor.start,
                      verticalTextAlignment: TextAnchor.start,
                      borderWidth: 1),
                ],
                // title: AxisTitle(text: widget.modal.yAxisTitle, textStyle: TextStyle(color: Colors.black)),
                minimum: widget.modal.yAxisMinValue ?? 0,
                maximum: widget.modal.yAxisMaxValue,
              ),
              title: ChartTitle(
                  text: widget.modal.mainTitle,
                  textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 10,
                      color: Colors.white54)),
              legend: Legend(
                  isVisible:
                      (widget.modal.seriesData.length == 1) ? false : true,
                  toggleSeriesVisibility: false),
              tooltipBehavior: TooltipBehavior(enable: true),
              series: List.generate(
                widget.modal.seriesData.length,
                (index) => FastLineSeries<XYAxisValues, String>(
                    name: widget.modal.seriesData.elementAt(index).lineToolTip,
                    dataSource: widget.modal.seriesData.elementAt(index).data,
                    xValueMapper: (XYAxisValues xyAxisValues, _) => xyAxisValues
                        .xAxisValue, // MPDateTimeFormat.get12HrsTimeFromTimeOfDate(context, sales.year),
                    yValueMapper: (XYAxisValues xyAxisValues, _) =>
                        xyAxisValues.yAxisValue,
                    // markerSettings: const MarkerSettings(isVisible: true),
                    yAxisName: widget.modal.xAxisTitle,
                    xAxisName: widget.modal.yAxisTitle,
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                      opacity: 0.1,
                      angle: 0,
                    ),
                    animationDelay: 10,
                    animationDuration: 10),
              ))),
    );
  }
}

class LineGraphModal {
  List<LineGraphSeries> seriesData;
  String? xAxisTitle;
  String? yAxisTitle;
  String mainTitle;
  bool isLandScapeMode;
  double? yAxisMinValue;
  double? yAxisMaxValue;
  bool isAppBarVisible;
  double? lowerLimit;
  double? upperLimit;

  LineGraphModal(
      {required this.seriesData,
      this.xAxisTitle,
      this.yAxisTitle,
      required this.mainTitle,
      this.isLandScapeMode = true,
      this.yAxisMinValue,
      this.yAxisMaxValue,
      this.lowerLimit,
      this.upperLimit,
      this.isAppBarVisible = false});
}

class LineGraphSeries {
  List<XYAxisValues> data;
  Color? lineColor;
  String lineToolTip;

  LineGraphSeries(
      {required this.data, required this.lineToolTip, this.lineColor});
}

class XYAxisValues {
  String xAxisValue;
  double yAxisValue;
  ElementWiseTooltip? toolTip;
  XYAxisValues(this.xAxisValue, this.yAxisValue, {this.toolTip});

  factory XYAxisValues.addData(dynamic x, dynamic y, {dynamic toolTip}) {
    return XYAxisValues(x, y, toolTip: toolTip);
  }
}

class ElementWiseTooltip {
  final String elementName;
  final String sampleName;
  final String date;
  final String time;
  final double conc;
  final double lowerConc;
  final double upperConc;
  final String range;

  ElementWiseTooltip(
      {required this.elementName,
      required this.sampleName,
      required this.date,
      required this.time,
      required this.conc,
      required this.lowerConc,
      required this.upperConc,
      required this.range});
}
