import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import 'util/constants/asset_constants.dart';
import 'util/ui/avatar.dart';
import 'util/ui/image.dart';
import 'util/ui/line_graph.dart';
import 'util/ui/text.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> carouselImg = [
    "assets/images/carosual_banner.jpg",
    "assets/images/carosual_banner.jpg",
    "assets/images/carosual_banner.jpg",
    "assets/images/carosual_banner.jpg"
  ];

  int carouselIndex = 0;

  late LineGraphModal graph;

  @override
  void initState() {
    graph = LineGraphModal(
        lowerLimit: 25,
        upperLimit: 10,
        seriesData: [
          LineGraphSeries(data: [
            XYAxisValues("1900", 21),
            XYAxisValues("1901", 29),
            XYAxisValues("1902", 18),
            XYAxisValues("1903", 30),
            XYAxisValues("1904", 8),
            XYAxisValues("1905", 25),
            XYAxisValues("1906", 12),
            XYAxisValues("1907", 14),
            XYAxisValues("1908", 26),
            XYAxisValues("1909", 28),
            XYAxisValues("1910", 10),
            XYAxisValues("1911", 40),
          ], lineToolTip: "")
        ],
        mainTitle: "Working hours to by the SAP 500 (1860-2020)");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: UTILAvatar(
            avtrType: AvatarTypes.imageAvatar,
            radius: 25,
            avtrImg: AssetConstants.defaultProfileLogo,
            avtrBrdrColor: Colors.blue.shade200,
          ),
          actions: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.blue,
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
              child: const CircleAvatar(
                radius: 25,
                backgroundColor: Colors.blue,
                foregroundColor: Colors.blue,
                child: Icon(
                  Icons.alarm,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              decoration: const BoxDecoration(shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10)]),
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.yellow.shade300,
                child: const CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.yellow,
                  child: Icon(
                    Icons.currency_rupee,
                    color: Colors.white,
                    size: 25,
                  ),
                ),
              ),
            ),
          ],
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        ),
        body: body(),
      ),
    );
  }

  Widget body() {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            carouselSlider(),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              width: double.infinity,
              color: Colors.blue,
            ),
            const SizedBox(
              height: 10,
            ),
            card1(),
            const SizedBox(
              height: 5,
            ),
            card2(),
            const SizedBox(
              height: 5,
            ),
            card3(),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 230,
              child: Center(
                  child: SfCartesianChart(
                      enableAxisAnimation: true,
                      primaryXAxis: CategoryAxis(
                        majorGridLines: MajorGridLines(width: 0),
                        axisLine: AxisLine(width: 0),
                        title: AxisTitle(text: graph.xAxisTitle, textStyle: TextStyle(color: Colors.black)),
                        labelRotation: -45,
                        autoScrollingMode: AutoScrollingMode.end,
                        visibleMaximum: (graph.isLandScapeMode) ? 10.5 : 5.5,
                        interval: 1,
                      ),
                      primaryYAxis: NumericAxis(
                        plotBands: <PlotBand>[
                          PlotBand(
                              verticalTextPadding: '5%',
                              horizontalTextPadding: '5%',
                              text: '                                          Average 25',
                              textAngle: 360,
                              start: 25,
                              end: 25,
                              textStyle: TextStyle(color: Colors.purple),
                              borderColor: Colors.purple,
                              horizontalTextAlignment: TextAnchor.start,
                              verticalTextAlignment: TextAnchor.start,
                              borderWidth: 1),
                        ],
                        // title: AxisTitle(text: graph.yAxisTitle, textStyle: TextStyle(color: Colors.black)),
                        minimum: graph.yAxisMinValue ?? 0,
                        maximum: graph.yAxisMaxValue,
                      ),
                      title: ChartTitle(text: graph.mainTitle, textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 10, color: Colors.white54)),
                      legend: Legend(isVisible: (graph.seriesData.length == 1) ? false : true, toggleSeriesVisibility: false),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      series: List.generate(
                        graph.seriesData.length,
                        (index) => FastLineSeries<XYAxisValues, String>(
                            name: graph.seriesData.elementAt(index).lineToolTip,
                            dataSource: graph.seriesData.elementAt(index).data,
                            xValueMapper: (XYAxisValues xyAxisValues, _) =>
                                xyAxisValues.xAxisValue, // MPDateTimeFormat.get12HrsTimeFromTimeOfDate(context, sales.year),
                            yValueMapper: (XYAxisValues xyAxisValues, _) => xyAxisValues.yAxisValue,
                            // markerSettings: const MarkerSettings(isVisible: true),
                            yAxisName: graph.xAxisTitle,
                            xAxisName: graph.yAxisTitle,
                            dataLabelSettings: const DataLabelSettings(
                              isVisible: true,
                              opacity: 0.1,
                              angle: 0,
                            ),
                            animationDelay: 10,
                            animationDuration: 10),
                      ))),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget carouselSlider() {
    return Column(
      children: [
        Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey.shade400,
            borderRadius: BorderRadius.circular(10),
          ),
          child: CarouselSlider(
              options: CarouselOptions(
                onPageChanged: (index, _) {
                  carouselIndex = index;
                  setState(() {});
                },
              ),
              items: carouselImg.map((item) => Center(child: UTILImage(image: item))).toList()),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
                carouselImg.length,
                (index) => Container(
                      width: 35.0,
                      height: 3.0,
                      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                      decoration: BoxDecoration(
                        // shape: BoxShape.circle,
                        borderRadius: BorderRadius.circular(15),
                        color: carouselIndex == index ? Colors.white : Colors.blue,
                      ),
                    ))),
      ],
    );
  }

  Widget card1() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          reuseableAwatar(Icons.inventory_sharp, "Coin Invest"),
          reuseableAwatar(Icons.transfer_within_a_station, "Transaction"),
          reuseableAwatar(Icons.balance, "My Team"),
          reuseableAwatar(Icons.balance, "My Tree"),
        ],
      ),
    );
  }

  Widget card2() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          reuseableAwatar(Icons.build_outlined, "L-ROI"),
          reuseableAwatar(Icons.balance, "W-Income"),
          reuseableAwatar(Icons.reviews, "Reward"),
          reuseableAwatar(Icons.pin_drop, "Air Drop"),
        ],
      ),
    );
  }

  Widget card3() {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 5, 10, 5),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          reuseableAwatar(Icons.card_travel, "Bye Coin"),
          reuseableAwatar(Icons.repeat, "Transaction"),
          reuseableAwatar(Icons.request_page, "Request"),
          reuseableAwatar(Icons.payment, "Quick Pay"),
        ],
      ),
    );
  }

  Widget reuseableAwatar(IconData icon, String title) {
    return Column(
      children: [
        UTILAvatar(
          avtrType: AvatarTypes.iconAvatar,
          radius: 20,
          icon: icon,
          avtrBrdrColor: Colors.white,
          iconColor: Colors.blue,
        ),
        UTILText(
          title,
          color: Colors.white,
        )
      ],
    );
  }
}
