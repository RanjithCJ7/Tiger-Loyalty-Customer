import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tl_customer/src/pages/bottom_tab.dart';
import 'styles.dart';

class RewardTableModel {
  String min, max, percentage;
  RewardTableModel(
      {required this.min, required this.max, required this.percentage});
}

class CreateReward extends StatefulWidget {
  @override
  _CreateRewardState createState() => _CreateRewardState();
}

class _CreateRewardState extends State<CreateReward> {
  TextEditingController minController = TextEditingController();
  TextEditingController maxController = TextEditingController();
  TextEditingController percentageController = TextEditingController();
  List<RewardTableModel> rewardData = [];

  List<DataRow> generateRows(List<List<String>> data) {
    return data.asMap().entries.map((entry) {
      int index = entry.key;
      List<String> rowData = entry.value;

      Color backgroundColor = index.isOdd ? Colors.white : Color(0xFFD9D9D9);

      return DataRow(
        color: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.selected)) {
            return Theme.of(context).colorScheme.primary.withOpacity(0.08);
          }
          return backgroundColor;
        }),
        cells: [
          DataCell(Text(rowData[0])),
          DataCell(Text(rowData[1])),
          DataCell(
            Row(
              children: [
                Text(rowData[2]),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Image.asset('assets/remove.png'),
                ),
              ],
            ),
          ),
        ],
      );
    }).toList();
  }

  List<String> rowData = [];

  String selectedMinValue = '';
  String selectedMaxValue = '';

  bool showCreateReward = true;

  @override
  void dispose() {
    minController.dispose();
    maxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<List<String>> tableData = [
      ['10,000', '100,000', '1%', ''],
      ['100,001', '1,000,000', '2%', ''],
      ['1,000,001', '5,000,000', '3%', ''],
      ['5,000,001', '10,000,000', '4%', ''],
    ];

    List data = [
      {'min': '10,000', 'max': "100,000"},
      {'min': '100,001', 'max': "100,000"},
      {'min': '1,000,001', 'max': "5,000,000"},
      {'min': '5,000,001', 'max': "10,000,000"},
    ];

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(vertical: 15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get started',
                            style: label,
                          ),
                          SizedBox(
                            height: 35.0,
                          ),
                          if (showCreateReward)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Container(
                                    width: 176,
                                    child: Text(
                                      'Define your reward points value to get started',
                                      style: desc,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 15.0),
                                  child: Text(
                                    'Create reward table',
                                    style: labelSm,
                                    textAlign: TextAlign.start,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      child: TextField(
                                        controller: minController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: 'Min. spending',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                        ),
                                        style: textFieldStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '-',
                                      style: label,
                                    ),
                                    Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        controller: maxController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: 'Max. Spending',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                        ),
                                        style: textFieldStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: TextField(
                                          controller: percentageController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            hintText: '%',
                                            hintStyle: TextStyle(
                                                color: Color(0xFF000000)),
                                            border: InputBorder.none,
                                          ),
                                          style: textFieldStyle,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          setState(() {
                                            showCreateReward = false;
                                          });
                                        },
                                        style: btnGold2,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            'Save',
                                            style: btnGoldText2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 75.0,
                                ),
                              ],
                            )
                          else
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Define your reward points value to get started',
                                    style: desc,
                                  ),
                                ),
                                SizedBox(
                                  height: 35.0,
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: Text(
                                    'Reward table',
                                    style: labelSm,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.29,
                                          child: const Text(
                                            "Min",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.25,
                                          child: const Text(
                                            "Max",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          )),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.19,
                                          child: const Text(
                                            "Reward%",
                                            style: TextStyle(
                                              fontFamily: 'Inter',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ))
                                    ],
                                  ),
                                ),
                                ListView.builder(
                                  padding: EdgeInsets.zero,
                                  shrinkWrap: true,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.055,
                                      decoration: BoxDecoration(
                                          color: index.isEven
                                              ? const Color(0XFFD9D9D9)
                                              : Colors.white),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(data[index]["min"])),
                                          SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.25,
                                              child: Text(data[index]["max"])),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.15,
                                            child: Row(
                                              children: [
                                                Text("${index + 1}%"),
                                                const SizedBox(width: 5),
                                                Image.asset(
                                                    'assets/remove.png'),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                                // SingleChildScrollView(
                                //   child: DataTable(
                                //     horizontalMargin: 5,
                                //     columns: [
                                //       DataColumn(label: Text('Min')),
                                //       DataColumn(label: Text('Max')),
                                //       DataColumn(label: Text('Reward%')),
                                //     ],
                                //     rows: generateRows(tableData),
                                //   ),
                                // ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 15.0),
                                  child: Text(
                                    'Add field',
                                    style: labelSm,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        controller: minController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: 'Min. spending',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                        ),
                                        style: textFieldStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    // Spacer(),
                                    Text(
                                      '-',
                                      style: label,
                                    ),
                                    // Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextField(
                                        controller: maxController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: <TextInputFormatter>[
                                          FilteringTextInputFormatter.digitsOnly
                                        ],
                                        decoration: const InputDecoration(
                                          hintText: 'Max. Spending',
                                          hintStyle: TextStyle(
                                              color: Color(0xFF808080)),
                                          border: InputBorder.none,
                                        ),
                                        style: textFieldStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 20),
                                        child: TextField(
                                          controller: percentageController,
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          decoration: const InputDecoration(
                                            hintText: '%',
                                            hintStyle: TextStyle(
                                                color: Color(0xFF000000)),
                                            border: InputBorder.none,
                                          ),
                                          style: textFieldStyle,
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.35,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.07,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: TextButton(
                                        onPressed: () {
                                          addrewardPoints();
                                        },
                                        style: btnGold2,
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Text(
                                            'Save',
                                            style: btnGoldText2,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          const SizedBox(
                            height: 80.0,
                          ),
                          SizedBox(
                            width: 180,
                            child: Text(
                              'You can change this configurations on setting page',
                              style: desc,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const BottomTab(),
                                  ),
                                  (route) => false);
                            },
                            style: btnGold2,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Proceed',
                                  style: btnGoldText2,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void addrewardPoints() {
    if (minController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter min value");
    } else if (maxController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter max value");
    } else if (percentageController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Please enter percentage value");
    } else {
      int min = int.parse(minController.text.trim().toString());
      int max = int.parse(maxController.text.trim().toString());
      print("min ==> ${minController.text}");
      if (min > max) {
        Fluttertoast.showToast(msg: "Please enter valid max value");
      } else {
        rewardData.add(RewardTableModel(
            min: min.toString(),
            max: max.toString(),
            percentage: percentageController.text.trim()));
      }
    }
  }
}
