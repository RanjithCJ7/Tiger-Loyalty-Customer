import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tl_customer/const/my_appbar.dart';
import 'package:tl_customer/src/pages/brands.dart';
import 'package:tl_customer/src/pages/home_newuser.dart';
import 'package:tl_customer/src/pages/profile.dart';
import 'package:tl_customer/src/pages/rewards.dart';
import 'styles.dart';

class Deals extends StatefulWidget {
  @override
  _Deals_State createState() => _Deals_State();
}

class My_Deal_Data {
  String title;
  String image;
  String name;
  int count;
  bool like;

  My_Deal_Data({
    required this.title,
    required this.image,
    required this.name,
    required this.count,
    required this.like,
  });
}

class _Deals_State extends State<Deals> {
  List<String> categories = [
    'Categories',
    'Shopping',
    'Supermarket',
    'Restaurant',
    'Spa',
    'Salon',
  ];

  String selectedCategory = 'Categories';

  List<My_Deal_Data> deal_Data = [
    My_Deal_Data(
        title: 'Bonge la mchongo 3% off today',
        image: 'assets/d_waikiki.png',
        name: 'LC Waikiki',
        count: 400,
        like: true),
    My_Deal_Data(
        title: '5% off from you next order',
        image: 'assets/d_samaki.png',
        name: 'Samaki Samaki',
        count: 182,
        like: false),
    My_Deal_Data(
        title: 'Kuku Tuesday',
        image: 'assets/d_pizza.png',
        name: 'Pizza Hut',
        count: 40,
        like: true),
    My_Deal_Data(
        title: 'Flash Sale',
        image: 'assets/d_gsm.png',
        name: 'GSM Home',
        count: 37,
        like: false)
  ];
  Map<String, bool> dealExpansionMap = {
    'Bonge la mchongo 3% off today': true,
    '5% off from you next order': false,
    'Kuku Tuesday': false,
    'Flash Sale': false
  };

  DateTime? fromDate;
  DateTime? toDate;

  Future<void> _selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: fromDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != fromDate) {
      setState(() {
        fromDate = picked;
      });
    }
  }

  Future<void> _selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: toDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != toDate) {
      setState(() {
        toDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: My_AppBar(
        context,
        title: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('My Deals', style: label.copyWith(color: Colors.black)),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F5),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0XFFD9D9D9))),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/search.png'),
                                    const SizedBox(width: 10),
                                    SizedBox(
                                      width: size.width * 0.3,
                                      height: 24,
                                      child: TextField(
                                        decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 11),
                                          hintText: 'Search brand',
                                          border: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                        ),
                                        style: dialogTextSm,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 15.0),
                          Container(
                            decoration: BoxDecoration(
                                color: const Color(0xFFF5F5F5),
                                borderRadius: BorderRadius.circular(5),
                                border:
                                    Border.all(color: const Color(0XFFD9D9D9))),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: size.width * 0.2,
                                    height: 24,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: selectedCategory,
                                        onChanged: (newValue) {
                                          setState(() {
                                            selectedCategory = newValue ?? '';
                                          });
                                        },
                                        items: categories.map((category) {
                                          return DropdownMenuItem<String>(
                                              value: category,
                                              child: Text(category,
                                                  style: selectBtnBold));
                                        }).toList(),
                                        icon: Image.asset(
                                            'assets/dropdown_right.png'),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15.0),
                      SingleChildScrollView(
                        child: ExpansionPanelList(
                          expandedHeaderPadding: EdgeInsets.zero,
                          children: deal_Data
                              .map<ExpansionPanel>((My_Deal_Data data) {
                            return ExpansionPanel(
                              headerBuilder:
                                  (BuildContext context, bool isExpanded) {
                                return ListTile(
                                  title: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        dealExpansionMap[data.title] =
                                            !(dealExpansionMap[data.title] ??
                                                false);
                                      });
                                    },
                                    child: Text(data.title, style: transBold),
                                  ),
                                );
                              },
                              body: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        'Lorem ipsum dolor sit amet consectetur. Feugiat libero in nisi luctus nunc tincidunt tempor.',
                                        style: label_sm3,
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFFFFF)
                                                    .withOpacity(0.3),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _selectFromDate(
                                                              context),
                                                      child: Text(
                                                          'From ${fromDate != null ? fromDate!.toLocal().toString().split(' ')[0] : ""}',
                                                          style: welcomeDesc),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Color(0xFFFFFFFF)
                                                    .withOpacity(0.3),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () =>
                                                          _selectToDate(
                                                              context),
                                                      child: Text(
                                                          'To ${toDate != null ? toDate!.toLocal().toString().split(' ')[0] : ""}',
                                                          style: welcomeDesc),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Image.asset(data.image),
                                                  const SizedBox(width: 15),
                                                  Container(
                                                    child: TextButton(
                                                      onPressed: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (BuildContext
                                                              context) {
                                                            return Container(
                                                              width: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width *
                                                                  1.0,
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height -
                                                                  125.0,
                                                              child: Dialog(
                                                                child: Column(
                                                                  children: [
                                                                    Container(
                                                                      margin: EdgeInsets
                                                                          .all(
                                                                              5),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          const Spacer(),
                                                                          const SizedBox(
                                                                              width: 40),
                                                                          Text(
                                                                            'Scan to',
                                                                            style:
                                                                                alertTitle,
                                                                          ),
                                                                          const Spacer(),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.of(context).pop();
                                                                            },
                                                                            child:
                                                                                Image.asset('assets/close.png'),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        height:
                                                                            5),
                                                                    Container(
                                                                      width: MediaQuery.of(context)
                                                                              .size
                                                                              .width *
                                                                          0.7,
                                                                      child:
                                                                          Column(
                                                                        children: [
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 5.0),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: Color(0xFFF5F5F5)),
                                                                              color: Color(0xFFD9D9D9),
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            child:
                                                                                TextField(
                                                                              keyboardType: TextInputType.number,
                                                                              inputFormatters: <TextInputFormatter>[
                                                                                FilteringTextInputFormatter.digitsOnly
                                                                              ],
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Amount',
                                                                                hintStyle: TextStyle(color: Color(0xFF808080)),
                                                                                border: InputBorder.none,
                                                                                contentPadding: EdgeInsets.all(20),
                                                                              ),
                                                                              style: textFieldStyle,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 15),
                                                                          Stack(
                                                                            children: [
                                                                              Image.asset('assets/qr_code.png'),
                                                                              Image.asset('assets/bg_qr_code.png'),
                                                                            ],
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(top: 25.0, bottom: 20.0),
                                                                            child:
                                                                                Row(
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Divider(
                                                                                    color: Color(0xFF808080),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                                                                  child: Text("OR", style: orText),
                                                                                ),
                                                                                Expanded(
                                                                                  child: Divider(
                                                                                    color: Color(0xFF808080),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Container(
                                                                            margin:
                                                                                EdgeInsets.only(bottom: 5.0),
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              border: Border.all(color: Color(0xFFF5F5F5)),
                                                                              color: Color(0xFFD9D9D9),
                                                                              borderRadius: BorderRadius.circular(5),
                                                                            ),
                                                                            child:
                                                                                TextField(
                                                                              keyboardType: TextInputType.number,
                                                                              inputFormatters: <TextInputFormatter>[
                                                                                FilteringTextInputFormatter.digitsOnly
                                                                              ],
                                                                              decoration: InputDecoration(
                                                                                hintText: 'Enter Lipa namba',
                                                                                hintStyle: TextStyle(color: Color(0xFF808080)),
                                                                                border: InputBorder.none,
                                                                                contentPadding: EdgeInsets.all(20),
                                                                              ),
                                                                              style: textFieldStyle,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 15),
                                                                          Container(
                                                                            width:
                                                                                MediaQuery.of(context).size.width * 0.8,
                                                                            height:
                                                                                MediaQuery.of(context).size.width * 0.12,
                                                                            child:
                                                                                TextButton(
                                                                              onPressed: () {
                                                                                showModalBottomSheet(
                                                                                  context: context,
                                                                                  builder: (BuildContext context) {
                                                                                    return Container(
                                                                                      height: MediaQuery.of(context).size.height - 125.0,
                                                                                      alignment: Alignment.bottomCenter,
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Container(
                                                                                            margin: EdgeInsets.all(5),
                                                                                            child: Row(
                                                                                              children: [
                                                                                                const Spacer(),
                                                                                                InkWell(
                                                                                                  onTap: () {
                                                                                                    Navigator.of(context).pop();
                                                                                                  },
                                                                                                  child: Image.asset('assets/close.png'),
                                                                                                ),
                                                                                              ],
                                                                                            ),
                                                                                          ),
                                                                                          Stack(
                                                                                            children: [
                                                                                              Image.asset('assets/waikiki.png'),
                                                                                              Positioned(
                                                                                                bottom: 0,
                                                                                                right: 0,
                                                                                                child: Image.asset('assets/lc_check.png'),
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                          const SizedBox(height: 15),
                                                                                          Text('LC Waikiki', style: pointsDesc),
                                                                                          const SizedBox(height: 20),
                                                                                          Text('Transaction value', style: dialogTextSm),
                                                                                          const SizedBox(height: 15),
                                                                                          Text('150,000', style: filterText),
                                                                                          const SizedBox(height: 30),
                                                                                          Text('What do you want to do?', style: label_sm),
                                                                                          const SizedBox(height: 20),
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.8,
                                                                                            height: MediaQuery.of(context).size.width * 0.12,
                                                                                            child: TextButton(
                                                                                              style: btnGrey,
                                                                                              onPressed: () {
                                                                                                showModalBottomSheet(
                                                                                                  context: context,
                                                                                                  builder: (BuildContext context) {
                                                                                                    return Container(
                                                                                                      height: MediaQuery.of(context).size.height - 125.0,
                                                                                                      alignment: Alignment.bottomCenter,
                                                                                                      child: SingleChildScrollView(
                                                                                                        child: Column(
                                                                                                          children: [
                                                                                                            Container(
                                                                                                              margin: EdgeInsets.all(5),
                                                                                                              child: Row(
                                                                                                                children: [
                                                                                                                  const Spacer(),
                                                                                                                  Text('Make payment to', style: settingsTitle),
                                                                                                                  const Spacer(),
                                                                                                                  InkWell(
                                                                                                                    onTap: () {
                                                                                                                      Navigator.of(context).pop();
                                                                                                                    },
                                                                                                                    child: Image.asset('assets/close.png'),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                            const SizedBox(height: 30),
                                                                                                            Stack(
                                                                                                              children: [
                                                                                                                Image.asset('assets/waikiki.png'),
                                                                                                                Positioned(
                                                                                                                  bottom: 0,
                                                                                                                  right: 0,
                                                                                                                  child: Image.asset('assets/lc_check.png'),
                                                                                                                ),
                                                                                                              ],
                                                                                                            ),
                                                                                                            const SizedBox(height: 15),
                                                                                                            Text('LC Waikiki', style: pointsDesc),
                                                                                                            const SizedBox(height: 10),
                                                                                                            Text('150,000', style: filterText),
                                                                                                            const SizedBox(height: 10),
                                                                                                            Text('Amount to pay', style: dialogTextSm),
                                                                                                            const SizedBox(height: 30),
                                                                                                            Container(
                                                                                                              width: MediaQuery.of(context).size.width * 0.5,
                                                                                                              child: Text('Enter phone number make payment', style: label_sm, textAlign: TextAlign.center),
                                                                                                            ),
                                                                                                            const SizedBox(height: 15),
                                                                                                            Container(
                                                                                                              width: MediaQuery.of(context).size.width * 0.8,
                                                                                                              decoration: BoxDecoration(
                                                                                                                border: Border.all(color: const Color(0xFFF5F5F5)),
                                                                                                                color: const Color(0xFFD9D9D9),
                                                                                                                borderRadius: BorderRadius.circular(5),
                                                                                                              ),
                                                                                                              child: Row(
                                                                                                                children: [
                                                                                                                  Container(
                                                                                                                    margin: const EdgeInsets.symmetric(horizontal: 15),
                                                                                                                    child: Image.asset('assets/ion_keypad.png'),
                                                                                                                  ),
                                                                                                                  Expanded(
                                                                                                                    child: TextField(
                                                                                                                      // controller: passwordController,
                                                                                                                      keyboardType: TextInputType.number,
                                                                                                                      inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                                                                      obscureText: true,
                                                                                                                      decoration: const InputDecoration(
                                                                                                                        hintText: 'Phone number',
                                                                                                                        hintStyle: TextStyle(color: Color(0xFF808080)),
                                                                                                                        border: InputBorder.none,
                                                                                                                      ),
                                                                                                                      style: textFieldStyle,
                                                                                                                    ),
                                                                                                                  ),
                                                                                                                ],
                                                                                                              ),
                                                                                                            ),
                                                                                                            const SizedBox(height: 5),
                                                                                                            Text('Pop up will send to your phone to complete payment', style: desc),
                                                                                                            const SizedBox(height: 20),
                                                                                                            Container(
                                                                                                              width: MediaQuery.of(context).size.width * 0.8,
                                                                                                              height: MediaQuery.of(context).size.width * 0.12,
                                                                                                              child: TextButton(
                                                                                                                onPressed: () {
                                                                                                                  showModalBottomSheet(
                                                                                                                    context: context,
                                                                                                                    builder: (BuildContext context) {
                                                                                                                      return Container(
                                                                                                                        height: MediaQuery.of(context).size.height - 125.0,
                                                                                                                        alignment: Alignment.bottomCenter,
                                                                                                                        child: SingleChildScrollView(
                                                                                                                          child: Column(
                                                                                                                            children: [
                                                                                                                              Container(
                                                                                                                                margin: EdgeInsets.all(5),
                                                                                                                                child: Row(
                                                                                                                                  children: [
                                                                                                                                    const Spacer(),
                                                                                                                                    Text('Payment successful', style: settingsTitle),
                                                                                                                                    const Spacer(),
                                                                                                                                    InkWell(
                                                                                                                                      onTap: () {
                                                                                                                                        Navigator.of(context).pop();
                                                                                                                                      },
                                                                                                                                      child: Image.asset('assets/close.png'),
                                                                                                                                    ),
                                                                                                                                  ],
                                                                                                                                ),
                                                                                                                              ),
                                                                                                                              Column(
                                                                                                                                children: [
                                                                                                                                  const SizedBox(height: 30),
                                                                                                                                  Stack(
                                                                                                                                    children: [
                                                                                                                                      Image.asset('assets/waikiki.png'),
                                                                                                                                      Positioned(
                                                                                                                                        bottom: 0,
                                                                                                                                        right: 0,
                                                                                                                                        child: Image.asset('assets/lc_check.png'),
                                                                                                                                      ),
                                                                                                                                    ],
                                                                                                                                  ),
                                                                                                                                  const SizedBox(height: 15),
                                                                                                                                  Text('LC Waikiki', style: pointsDesc),
                                                                                                                                  const SizedBox(height: 30),
                                                                                                                                  Text('15,000', style: filterText),
                                                                                                                                  const SizedBox(height: 5),
                                                                                                                                  Text('Bonus reward points', style: dialogTextSm),
                                                                                                                                  const SizedBox(height: 20),
                                                                                                                                  Center(
                                                                                                                                    child: Row(
                                                                                                                                      children: [
                                                                                                                                        const Spacer(),
                                                                                                                                        Column(
                                                                                                                                          crossAxisAlignment: CrossAxisAlignment.end,
                                                                                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                                                                                          children: [
                                                                                                                                            Text('150,000', style: numGreyText),
                                                                                                                                            Text('Transaction value', style: dialogTextSm),
                                                                                                                                          ],
                                                                                                                                        ),
                                                                                                                                        const SizedBox(width: 15),
                                                                                                                                        Image.asset('assets/line_col.png'),
                                                                                                                                        const SizedBox(width: 20),
                                                                                                                                        Column(
                                                                                                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                                                                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                                                                                                          children: [
                                                                                                                                            Text('10%', style: numGreyText),
                                                                                                                                            Text('Reward', style: dialogTextSm)
                                                                                                                                          ],
                                                                                                                                        ),
                                                                                                                                        const Spacer(),
                                                                                                                                      ],
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  const SizedBox(height: 50),
                                                                                                                                  Container(
                                                                                                                                    width: MediaQuery.of(context).size.width * 0.9,
                                                                                                                                    height: MediaQuery.of(context).size.height * 0.07,
                                                                                                                                    child: TextButton(
                                                                                                                                      onPressed: () {
                                                                                                                                        showModalBottomSheet(
                                                                                                                                          context: context,
                                                                                                                                          builder: (BuildContext context) {
                                                                                                                                            return Container(
                                                                                                                                              child: SizedBox(
                                                                                                                                                height: MediaQuery.of(context).size.height - 125.0,
                                                                                                                                                child: SingleChildScrollView(
                                                                                                                                                  child: Column(
                                                                                                                                                    children: [
                                                                                                                                                      Container(
                                                                                                                                                        margin: EdgeInsets.all(5),
                                                                                                                                                        child: Row(
                                                                                                                                                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                                                                                                                          children: <Widget>[
                                                                                                                                                            const Spacer(),
                                                                                                                                                            Text('Save rewards', style: alertTitle),
                                                                                                                                                            const Spacer(),
                                                                                                                                                            InkWell(
                                                                                                                                                              onTap: () {
                                                                                                                                                                Navigator.of(context).pop();
                                                                                                                                                              },
                                                                                                                                                              child: Image.asset('assets/close.png'),
                                                                                                                                                            ),
                                                                                                                                                          ],
                                                                                                                                                        ),
                                                                                                                                                      ),
                                                                                                                                                      const SizedBox(height: 20.0),
                                                                                                                                                      Container(
                                                                                                                                                        width: MediaQuery.of(context).size.width * 0.48,
                                                                                                                                                        child: Text(
                                                                                                                                                          'Enter your phone number to save your rewards point temporary.\n\nNote. You will need to complete registration within 7 days.',
                                                                                                                                                          style: desc,
                                                                                                                                                          textAlign: TextAlign.center,
                                                                                                                                                        ),
                                                                                                                                                      ),
                                                                                                                                                      const SizedBox(height: 50),
                                                                                                                                                      Container(
                                                                                                                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                                                        decoration: BoxDecoration(
                                                                                                                                                          border: Border.all(color: const Color(0xFFF5F5F5)),
                                                                                                                                                          color: const Color(0xFFD9D9D9),
                                                                                                                                                          borderRadius: BorderRadius.circular(5),
                                                                                                                                                        ),
                                                                                                                                                        child: Row(
                                                                                                                                                          children: [
                                                                                                                                                            Container(
                                                                                                                                                              margin: const EdgeInsets.symmetric(horizontal: 15),
                                                                                                                                                              child: Image.asset('assets/ion_keypad.png'),
                                                                                                                                                            ),
                                                                                                                                                            Expanded(
                                                                                                                                                              child: TextField(
                                                                                                                                                                // controller: passwordController,
                                                                                                                                                                keyboardType: TextInputType.number,
                                                                                                                                                                inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                                                                                                                                                                obscureText: true,
                                                                                                                                                                decoration: const InputDecoration(
                                                                                                                                                                  hintText: 'Phone number',
                                                                                                                                                                  hintStyle: TextStyle(color: Color(0xFF808080)),
                                                                                                                                                                  border: InputBorder.none,
                                                                                                                                                                ),
                                                                                                                                                                style: textFieldStyle,
                                                                                                                                                              ),
                                                                                                                                                            ),
                                                                                                                                                          ],
                                                                                                                                                        ),
                                                                                                                                                      ),
                                                                                                                                                      const SizedBox(height: 20),
                                                                                                                                                      Container(
                                                                                                                                                        width: MediaQuery.of(context).size.width * 0.8,
                                                                                                                                                        height: MediaQuery.of(context).size.width * 0.12,
                                                                                                                                                        child: TextButton(
                                                                                                                                                          onPressed: () {
                                                                                                                                                            Navigator.of(context).push(
                                                                                                                                                              MaterialPageRoute(
                                                                                                                                                                builder: (context) => Home_NewUser(),
                                                                                                                                                              ),
                                                                                                                                                            );
                                                                                                                                                          },
                                                                                                                                                          style: btnGold2,
                                                                                                                                                          child: Text(
                                                                                                                                                            'Save rewards',
                                                                                                                                                            style: btnGoldText2,
                                                                                                                                                          ),
                                                                                                                                                        ),
                                                                                                                                                      )
                                                                                                                                                    ],
                                                                                                                                                  ),
                                                                                                                                                ),
                                                                                                                                              ),
                                                                                                                                            );
                                                                                                                                          },
                                                                                                                                        );
                                                                                                                                      },
                                                                                                                                      style: btnGrey,
                                                                                                                                      child: Text('Save reward point', style: label_sm2),
                                                                                                                                    ),
                                                                                                                                  ),
                                                                                                                                  const SizedBox(height: 50),
                                                                                                                                ],
                                                                                                                              )
                                                                                                                            ],
                                                                                                                          ),
                                                                                                                        ),
                                                                                                                      );
                                                                                                                    },
                                                                                                                  );
                                                                                                                },
                                                                                                                style: btnGold2,
                                                                                                                child: Text(
                                                                                                                  'Pay',
                                                                                                                  style: btnGoldText2,
                                                                                                                ),
                                                                                                              ),
                                                                                                            ),
                                                                                                            const SizedBox(height: 30)
                                                                                                          ],
                                                                                                        ),
                                                                                                      ),
                                                                                                    );
                                                                                                  },
                                                                                                );
                                                                                              },
                                                                                              child: Text(
                                                                                                'Pay to collect reward points',
                                                                                                style: btnGreyText,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(height: 5),
                                                                                          Container(
                                                                                            width: MediaQuery.of(context).size.width * 0.8,
                                                                                            height: MediaQuery.of(context).size.width * 0.12,
                                                                                            child: TextButton(
                                                                                              style: btnGrey,
                                                                                              onPressed: () {
                                                                                                Navigator.of(context).pop();
                                                                                              },
                                                                                              child: Text(
                                                                                                'Redeem your points',
                                                                                                style: btnGreyText,
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                          const SizedBox(height: 30)
                                                                                        ],
                                                                                      ),
                                                                                    );
                                                                                  },
                                                                                );
                                                                              },
                                                                              style: btnGold2,
                                                                              child: Text(
                                                                                'Next',
                                                                                style: btnGoldText2,
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(data.name,
                                                              style: dealText),
                                                          const SizedBox(
                                                              height: 5),
                                                          Row(
                                                            children: [
                                                              Image.asset(
                                                                  'assets/d_count.png'),
                                                              const SizedBox(
                                                                  width: 10),
                                                              Text(
                                                                  data.count
                                                                          .toString() +
                                                                      ' Interested',
                                                                  style:
                                                                      remainText)
                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () {},
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Image.asset(
                                                        'assets/d_share.png'),
                                                    const SizedBox(height: 5),
                                                    Text('Share',
                                                        style: likeText)
                                                  ],
                                                ),
                                              ),
                                              // const SizedBox(width: 20),
                                              Column(
                                                children: [
                                                  Image.asset(data.like
                                                      ? 'assets/deal_active.png'
                                                      : 'assets/deal_inactive.png'),
                                                  const SizedBox(height: 5),
                                                  Text(
                                                      data.like
                                                          ? 'Unlike'
                                                          : 'Like',
                                                      style: likeText)
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              isExpanded: dealExpansionMap[data.title] ?? false,
                            );
                          }).toList(),
                          expansionCallback: (int panelIndex, bool isExpanded) {
                            setState(() {
                              dealExpansionMap[deal_Data[panelIndex].title] =
                                  !isExpanded;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 30.0),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
              decoration: BoxDecoration(
                color: Color(0xFFD9D9D9),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/deals.png'),
                        SizedBox(height: 5),
                        Text('Deals', style: footerText),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Rewards(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/rewards.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Rewards',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Image.asset('assets/redeem.png',
                            color: Color.fromRGBO(0, 0, 0, 0.3)),
                        SizedBox(height: 5),
                        Text('Redeem',
                            style: footerText.copyWith(
                                color: Color.fromRGBO(0, 0, 0, 0.3))),
                      ],
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Brands(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/brands.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Brands',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Profile(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.asset('assets/profile.png',
                              color: Color.fromRGBO(0, 0, 0, 0.3)),
                          SizedBox(height: 5),
                          Text('Profile',
                              style: footerText.copyWith(
                                  color: Color.fromRGBO(0, 0, 0, 0.3))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
