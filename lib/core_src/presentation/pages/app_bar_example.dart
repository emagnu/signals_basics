//  //   ///
//  Import LIBRARIES
import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';
//  Import FILES
import '../../data/persons_data.dart';
import '../../domain_models/person.dart';
import 'next_page.dart';
//  //   ///

class AppBarExample extends StatefulWidget {
  const AppBarExample({super.key});

  @override
  State<AppBarExample> createState() => _AppBarExampleState();
}

class _AppBarExampleState extends State<AppBarExample> {
  static Person person = Person(name: 'John', lastName: 'Doe');

  // SIGNALS - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
  //  State - Since this is the state class for the AppBarExample it is logical to place here all the state variables that relate to the state of the AppBarExample widget. This way, when we finish using this applet, the state variables used by signal will be released.

  // counter - This signal variable is for the counter. Every time you click on the bell, the snack bar will show a message indicating the count (how many times you have clicked it), and the name that was changed.
  Signal<int> counterSignal = signal(0);

  // personSignal - takes an object for tracking. It will NOT update if you just update either the name or lastName because they are components and the pointer to the object has not changed.
  static Signal personSignal = signal<Person>(person);

  // COMPUTED - This is an example of a computed (compounded) signal: the result is a signal, and to create it we use some component signals. This process forces a subscription to any signal used, i.e. it will be update if either of name/surname is updated
  final fullName = computed(
      () => '${personSignal.value.name}, ${personSignal.value.lastName}');

  @override
  Widget build(BuildContext context) {
    // final personSignal = signal(person);

    // setName(String name, String lastName, int counter) {
    //   final person = Person(name: personsData[counter]['name']!,lastName: personsData[counter]['lastName']!);personSignal.value = person;
    //   personSignal.value = person;
    // }

    setName(String name, String lastName) {
      final person = Person(name: name, lastName: 'Doe');

      personSignal.value = person;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('AppBar Example'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setName('Mike', 'Doe');
              // setName('Mike', 'Doe', counterSignal.value);
              counterSignal.value++;
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                      'This is a snackbar: $counterSignal,  ${personSignal.value.name} ${personSignal.value.lastName}'),
                ),
              );
            },
            icon: const Icon(Icons.add_alert),
            tooltip: 'Show Snackbar',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute<void>(
                  builder: (BuildContext context) => const NextPage(),
                ),
              );
            },
            icon: const Icon(Icons.navigate_next),
            tooltip: 'Go to the next page',
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // This one is not watched and will not update
            Text('Not watched: ${fullName.value}'),
            const SizedBox(height: 5.0),
            Watch((context) {
              return Text('Watched (fullName): ${fullName.value}');
            }),
            const SizedBox(height: 5.0),
            Watch((context) {
              return Text(
                  'Watched (personSignal):    Name: ${personSignal.value.name}, Surname: ${personSignal.value.lastName}');
            }),

            const SizedBox(height: 8.0),
            const Text(' - - - - - - - - '),
            const SizedBox(height: 8.0),
            Watch((context) {
              return Column(
                children: <Widget>[
                  const Text("The items below are are 'Watched'"),
                  Text(personSignal.value.name),
                  Text(personSignal.value.lastName),
                  Text('Times you clicked: $counterSignal'),
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}
