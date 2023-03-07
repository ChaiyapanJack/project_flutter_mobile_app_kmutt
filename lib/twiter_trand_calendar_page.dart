import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
                            test = ['A', 'B', 'C', 'D', 'E'];
                            myLists.addAll(test);
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
                                    Text((myLists.indexOf(myLists[index]) + 1)
                                        .toString()),
                                    Text(myLists[index]),
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
