import 'package:dashboard_screen_task/util/ui/text.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

import 'util/ui/tree/GraphView.dart';

class MyTreeView extends StatefulWidget {
  const MyTreeView({super.key});

  @override
  MyTreeViewState createState() => MyTreeViewState();
}

class MyTreeViewState extends State<MyTreeView> {
  Node? selectedNode;
  NodeData? selectedNodeData;

  List<NodeData> nodeList = [];
  List<NodeData> actualNodeList = [];

  Graph graph = Graph()..isTree = true;
  @override
  void initState() {
    super.initState();

    actualNodeList.addAll([
      NodeData(0, 1, details: NodeDetails('VT 345', 'user 1', '12/12/2002')),
      NodeData(0, 2, details: NodeDetails('VT 345', 'user 2', '12/12/2002')),
      NodeData(1, 11, details: NodeDetails('VT 345', 'user 3', '12/12/2002')),
      NodeData(1, 12, details: NodeDetails('VT 345', 'user 4', '12/12/2002')),
      NodeData(2, 21, details: NodeDetails('VT 345', 'user 5', '12/12/2002')),
      NodeData(2, 22, details: NodeDetails('VT 345', 'user 6', '12/12/2002')),
      NodeData(11, 111, details: NodeDetails('VT 345', 'user 7', '12/12/2002')),
      NodeData(11, 112, details: NodeDetails('VT 345', 'user 8', '12/12/2002')),
      NodeData(12, 121, details: NodeDetails('VT 345', 'user 9', '12/12/2002')),
      NodeData(12, 122,
          details: NodeDetails('VT 345', 'user 10', '12/12/2002')),
      NodeData(21, 211,
          details: NodeDetails('VT 345', 'user 11', '12/12/2002')),
      NodeData(21, 212,
          details: NodeDetails('VT 345', 'user 12', '12/12/2002')),
      NodeData(22, 221,
          details: NodeDetails('VT 345', 'user 13', '12/12/2002')),
      NodeData(22, 222,
          details: NodeDetails('VT 345', 'user 14', '12/12/2002')),
      NodeData(111, 1111),
      NodeData(111, 1112),
    ]);

    setNodeData();
  }

  void setNodeData() {
    graph = Graph();

    graph..isTree = true;

    nodeList.forEach((element) {
      graph.addEdge(Node.Id(element.startVal.toString()),
          Node.Id(element.endVal.toString()));
    });

    builder
      ..nodeSeparation = (30)
      ..levelSeparation = (30)
      ..orientation = SugiyamaConfiguration.ORIENTATION_TOP_BOTTOM;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const UTILText("My Tree"),
          backgroundColor: const Color.fromARGB(255, 15, 38, 58),
          centerTitle: true,
        ),
        backgroundColor: const Color.fromARGB(255, 31, 87, 101),
        body: Stack(
          children: [
            if (selectedNodeData != null && selectedNodeData?.details != null)
              detailsCard(),
            Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                (nodeList.isNotEmpty)
                    ? graphView()
                    : Center(child: emptyRectangleWidget()),
              ],
            ),
          ],
        ));
  }

  Widget detailsCard() {
    return Positioned(
        right: 2,
        child: Container(
            // width: 100,
            padding: EdgeInsets.all(5),
            margin: EdgeInsets.all(2.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    UTILText(
                      'Id: ${selectedNodeData!.details?.id}',
                      color: Colors.black,
                    ),
                  ],
                ),
                Row(
                  children: [
                    UTILText(
                      'Name:  ${selectedNodeData!.details?.name}',
                      color: Colors.black,
                    ),
                  ],
                ),
                Row(
                  children: [
                    UTILText(
                      'Joining: ${selectedNodeData!.details?.joiningDate} ',
                      color: Colors.black,
                    ),
                  ],
                ),
              ],
            )));
  }

  Widget graphView() {
    return Expanded(
        child: Center(
      child: InteractiveViewer(
        constrained: false,
        boundaryMargin: EdgeInsets.all(100),
        minScale: 0.0001,
        maxScale: 10.6,
        child: GraphView(
          graph: graph,
          algorithm: SugiyamaAlgorithm(builder),
          paint: Paint()
            ..color = Colors.white38
            ..strokeWidth = 1
            ..style = PaintingStyle.stroke,
          builder: (Node node) {
            var a = node.key!.value;
            return rectangleWidget(a, node);
          },
        ),
      ),
    ));
  }

  Widget rectangleWidget(String a, Node node) {
    return GestureDetector(
      onTap: () => nodeOnTapEvent(a, node),
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color:
                      (selectedNode != node) ? Colors.blue[100]! : Colors.green,
                  spreadRadius: 1),
            ],
          ),
          child: Text('')),
    );
  }

  Widget emptyRectangleWidget() {
    return InkWell(
      onTap: () {
        selectedNodeData = nodeList.isEmpty
            ? null
            : ((nodeList.elementAt(0).startVal.toString() == '0')
                ? nodeList.elementAt(0)
                : nodeList.firstWhereOrNull(
                    (element) => element.endVal.toString() == '0'));

        addNode('0');
        setState(() {});
      },
      child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.blue[100]!, spreadRadius: 1),
            ],
          ),
          child: Text('')),
    );
  }

  void nodeOnTapEvent(String a, Node node) {
    selectedNode = node;
    selectedNodeData = nodeList.isEmpty
        ? null
        : ((nodeList.elementAt(0).startVal.toString() == a)
            ? nodeList.elementAt(0)
            : nodeList.firstWhereOrNull((element) =>
                element.endVal.toString() == node.key?.value.toString()));

    addNode(a);

    if (selectedNodeData != null) {
      if (selectedNodeData?.details == null) {
        addEntryDetails();
      }
    }
    setState(() {});
  }

  void addNode(String val) {
    nodeList.addAll(actualNodeList
        .where((element) => element.startVal.toString() == val)
        .toList());

    setNodeData();
  }

  Future<bool?> addEntryDetails() async {
    return (await showGeneralDialog(
            context: context,
            pageBuilder: (BuildContext buildContext,
                Animation<double> animation,
                Animation<double> secondaryAnimation) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                title: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Add Info",
                            style: TextStyle(fontSize: 16),
                          ),
                          IconButton(
                              icon: Icon(Icons.cancel,
                                  color: Colors.black,
                                  size:
                                      (MediaQuery.of(context).size.width >= 600)
                                          ? 30
                                          : null),
                              onPressed: () {
                                Navigator.of(context).pop(true);
                              })
                        ],
                      ),
                    ),
                    Container(height: 2, color: Colors.black)
                  ],
                ),
                titlePadding: EdgeInsets.zero,
                contentPadding: EdgeInsets.all(10),
                content: StatefulBuilder(builder:
                    (BuildContext context, StateSetter dialogSetState) {
                  return SingleChildScrollView(
                    child: SizedBox(
                        width: 400,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Row(
                              children: [
                                Text(
                                    'Id: ${selectedNodeData!.details?.id ?? 'Id'}'),
                              ],
                            ),
                            Row(
                              children: [
                                Text('Name: '),
                                Container(
                                  width: 100,
                                  height: 30,
                                  child: TextField(
                                    decoration: new InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0),
                                      ),
                                      fillColor: Colors.blue.shade50,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Text('Joining: '),
                                Container(
                                  width: 100,
                                  height: 30,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.blue, width: 1.0),
                                      ),
                                      fillColor: Colors.blue.shade50,
                                      filled: true,
                                      contentPadding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 0),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: Text('Save'),
                            )
                          ],
                        )),
                  );
                }),
              );
            },
            barrierDismissible: false,
            barrierLabel:
                MaterialLocalizations.of(context).modalBarrierDismissLabel,
            transitionDuration: const Duration(milliseconds: 500))) ??
        false;
  }
}

var builder = SugiyamaConfiguration();

class NodeData {
  int startVal;
  int endVal;
  NodeDetails? details;

  NodeData(this.startVal, this.endVal, {this.details});

  Map<String, dynamic> printData() => {'start': startVal, 'end': endVal};
}

class NodeDetails {
  String id;
  String name;
  String joiningDate;

  NodeDetails(this.id, this.name, this.joiningDate);
}
