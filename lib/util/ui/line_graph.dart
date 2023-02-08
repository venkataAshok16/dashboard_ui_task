import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/util/constants/font_size_constants.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class UTILLineGraphUI extends StatefulWidget {
  final LineGraphModal modal;
  const UTILLineGraphUI({Key? key, required this.modal}) : super(key: key);

  @override
  State<UTILLineGraphUI> createState() => _UTILLineGraphUIState();
}

class _UTILLineGraphUIState extends State<UTILLineGraphUI> {
  late ZoomPanBehavior zoomPanBehavior;

  @override
  void initState() {
    if (widget.modal.isLandScapeMode) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]); // Please don't add any other orientation here. Bugs the iOS build
    }
    zoomPanBehavior = ZoomPanBehavior(enablePanning: true);
    super.initState();
  }

  @override
  void dispose() {
    if (widget.modal.isLandScapeMode) {
      //Mandatory for iOS
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: SfCartesianChart(
                enableAxisAnimation: true,
                primaryXAxis: CategoryAxis(
                  majorGridLines: MajorGridLines(width: 0),
                  axisLine: AxisLine(width: 0),
                  title: AxisTitle(text: widget.modal.xAxisTitle),
                  labelRotation: -45,
                  autoScrollingMode: AutoScrollingMode.end,
                  visibleMaximum: (widget.modal.isLandScapeMode) ? 10.5 : 5.5,
                  interval: 1,
                ),
                primaryYAxis: NumericAxis(
                  plotBands: (widget.modal.upperLimit != null && widget.modal.lowerLimit != null)
                      ? <PlotBand>[
                          PlotBand(isVisible: true, start: 0, end: widget.modal.lowerLimit, color: Colors.red.shade50),
                          PlotBand(isVisible: true, start: widget.modal.lowerLimit, end: widget.modal.upperLimit, color: Colors.green.shade50),
                          PlotBand(isVisible: true, start: widget.modal.upperLimit, color: Colors.red.shade50),
                          if (widget.modal.upperLimit != null)
                            PlotBand(
                                verticalTextPadding: '5%',
                                horizontalTextPadding: '5%',
                                text: 'High',
                                textAngle: 360,
                                start: widget.modal.upperLimit,
                                end: widget.modal.upperLimit,
                                textStyle: TextStyle(color: Theme.of(context).errorColor),
                                borderColor: Theme.of(context).errorColor,
                                horizontalTextAlignment: TextAnchor.start,
                                verticalTextAlignment: TextAnchor.start,
                                borderWidth: 1),
                          if (widget.modal.lowerLimit != null)
                            PlotBand(
                                verticalTextPadding: '5%',
                                horizontalTextPadding: '5%',
                                text: 'Low',
                                textAngle: 360,
                                start: widget.modal.lowerLimit,
                                end: widget.modal.lowerLimit,
                                textStyle: TextStyle(color: Theme.of(context).errorColor),
                                borderColor: Theme.of(context).errorColor,
                                horizontalTextAlignment: TextAnchor.start,
                                verticalTextAlignment: TextAnchor.start,
                                borderWidth: 1),
                        ]
                      : [],
                  title: AxisTitle(text: widget.modal.yAxisTitle),
                  minimum: widget.modal.yAxisMinValue ?? 0,
                  maximum: widget.modal.yAxisMaxValue,
                ),
                title: ChartTitle(text: widget.modal.mainTitle, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: FontSizeConstants.small)),
                legend: Legend(isVisible: (widget.modal.seriesData.length == 1) ? false : true, toggleSeriesVisibility: false),
                tooltipBehavior: TooltipBehavior(enable: true),
                zoomPanBehavior: zoomPanBehavior,
                series: List.generate(
                  widget.modal.seriesData.length,
                  (index) => LineSeries<XYAxisValues, String>(
                      name: widget.modal.seriesData.elementAt(index).lineToolTip,
                      dataSource: widget.modal.seriesData.elementAt(index).data,
                      xValueMapper: (XYAxisValues xyAxisValues, _) =>
                          xyAxisValues.xAxisValue, // MPDateTimeFormat.get12HrsTimeFromTimeOfDate(context, sales.year),
                      yValueMapper: (XYAxisValues xyAxisValues, _) => xyAxisValues.yAxisValue,
                      markerSettings: const MarkerSettings(isVisible: true),
                      yAxisName: widget.modal.xAxisTitle,
                      xAxisName: widget.modal.yAxisTitle,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: true,
                        opacity: 0.1,
                        angle: 0,
                      ),
                      animationDelay: 10,
                      animationDuration: 10),
                ))));
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

  LineGraphSeries({required this.data, required this.lineToolTip, this.lineColor});
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
