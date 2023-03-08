//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(const MainCalendar());

class MainCalendar extends StatelessWidget {
  const MainCalendar({super.key});

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      restorationScopeId: 'app',
      title: _title,
      home: TwitterSearchPage(restorationId: 'main'),
    );
  }
}

class TwitterSearchPage extends StatefulWidget {
  const TwitterSearchPage({super.key, this.restorationId});

  final String? restorationId;

  @override
  //State<TwitterSearchPage> createState() => _TwitterSearchPage();

  _TwitterSearchPage createState() => _TwitterSearchPage();
}

/// RestorationProperty objects can be used because of RestorationMixin.
class _TwitterSearchPage extends State<TwitterSearchPage>
    with RestorationMixin {
  // In this example, the restoration ID for the mixin is passed in through
  // the [StatefulWidget]'s constructor.
  @override
  String? get restorationId => widget.restorationId;
  List<String> myLists = [];
  List<String> test = [];
  final DateSearchController = TextEditingController();

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2021, 7, 25));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: new DateTime.now().add(new Duration(days: -1)),
          firstDate: new DateTime.now().subtract(new Duration(days: 30)),
          lastDate: new DateTime.now().add(new Duration(days: 30)),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        DateSearchController.text =
            "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
        // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        //   content: Text(
        //       'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
        // ));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
        borderRadius: BorderRadius.horizontal(left: Radius.circular(5)));

    FirebaseFirestore firestore = FirebaseFirestore.instance;

    var mytest;
    var list = List;
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title:
            Text("Search Trand Twitter", style: TextStyle(color: Colors.white)),
        backgroundColor: Color.fromARGB(255, 183, 236, 123),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10),
                        hintText: 'Search',
                        border: border,
                        errorBorder: border,
                        disabledBorder: border,
                        focusedBorder: border,
                        focusedErrorBorder: border,
                        suffixIcon: IconButton(
                            icon: Icon(Icons.clear),
                            onPressed: () {
                              print('Clear');
                              DateSearchController.clear();
                            }),
                      ),
                      controller: DateSearchController,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 12, 147, 16),
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(10))),
                    child: IconButton(
                        icon: Icon(
                          Icons.calendar_month,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          _restorableDatePickerRouteFuture.present();
                        }),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  constraints: BoxConstraints.expand(height: 50),
                  // ignore: sort_child_properties_last
                  child: Center(
                    child: Container(
                      child: Material(
                        type: MaterialType.transparency,
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                          onTap: () => setState(() {
                            print("Tap Search");
                            myLists.clear();
                            test = ['A', 'B', 'C', 'D', 'E'];
                            myLists.addAll(test);
                            var startAtTimestamp =
                                Timestamp.fromMillisecondsSinceEpoch(
                                    DateTime.parse("${_selectedDate.value}")
                                        .millisecondsSinceEpoch);

                            var endAtTimestamp = Timestamp
                                .fromMillisecondsSinceEpoch(DateTime.parse(
                                        "${_selectedDate.value.add(Duration(days: 1))}")
                                    .millisecondsSinceEpoch);

                            print(_selectedDate.value);
                            print(startAtTimestamp);
                            print(endAtTimestamp);
                            FirebaseFirestore.instance
                                .collection("trends")
                                //.orderBy('name').startAt(Text('2023-01-01')).endAt(name+'\uf8ff')
                                .where("snap_time",
                                    isGreaterThanOrEqualTo: startAtTimestamp)
                                .where("snap_time",
                                    isLessThanOrEqualTo: endAtTimestamp)
                                // .where('name', isEqualTo: 'Happy New Year')
                                // .where(Text(timeago
                                //     .format(DateTime.tryParse(
                                //         document['snap_time']
                                //             .toDate()
                                //             .toString()))
                                //     .toString()))
                                .get()
                                .then(
                              (querySnapshot) {
                                print("Successfully completed");
                                for (var docSnapshot in querySnapshot.docs) {
                                  print(
                                      '${docSnapshot.id} => ${docSnapshot.data()['name']}');

                                  // print(DateTime.parse(docSnapshot
                                  //     .data()['snap_time']
                                  //     .toDate()
                                  //     .toString()));

                                  ///DateTime.parse(timestamp.toDate().toString())
                                }
                              },
                              onError: (e) => print("Error completing: $e"),
                            );
                          }),
                          child: Text(
                            "Search",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.green[200]),
                  margin: EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(12)),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Expanded(
                  child: ListView.builder(
                shrinkWrap: true,
                itemCount: myLists.length,
                itemBuilder: (context, index) => Card(
                    child: ListTile(
                        leading: CircleAvatar(
                            backgroundImage: AssetImage('images/' +
                                (myLists.indexOf(myLists[index]) + 1)
                                    .toString() +
                                '.png')),
                        title: Text(myLists[index]),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                // Retrieve the text the that user has entered by using the
                                // TextEditingController.

                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Image.asset(
                                        'images/' +
                                            (myLists.indexOf(myLists[index]) +
                                                    1)
                                                .toString() +
                                            '.png',
                                        width: 50,
                                        height: 50,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    Text(DateSearchController.text),
                                    Text(myLists[index]),
                                  ],
                                ),
                              );
                            },
                          );
                        })),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

class GetUserName extends StatelessWidget {
  final String documentId;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  GetUserName(this.documentId);

  @override
  Widget build(BuildContext context) {
    print("In class");
    CollectionReference users = FirebaseFirestore.instance.collection('trends');

    print(documentId);

    return FutureBuilder<DocumentSnapshot>(
      future: users.doc('2023-01-01-01').get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print("111111111");
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data!.exists) {
          print("2222222");
          return Text("Document does not exist");
        }

        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          print("33333333");
          print(data);
          return Text("Full Name: ${data['name']} ");
        }
        print("4444444444");
        return Text("loading");
      },
    );
  }
}

class OutputWindow extends StatelessWidget {
  final String output;
  OutputWindow(this.output);

  @override
  Widget build(BuildContext context) {
    return Text(output,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 35,
          color: Colors.black87,
        ));

    print("dddd55555");
  }
}

class Animals {
  var animalList = ['dog', 'cat', 'cow'];

  // function for printing the list of animals

  void animalListPrinter() {
    for (var animal in animalList) {
      print(animal);
    }
  }
}
