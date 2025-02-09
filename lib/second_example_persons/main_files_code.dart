
import 'dart:convert';
import 'dart:io';
import 'package:block_for_managing_state/second_example_persons/bloc/bloc_actions.dart';
import 'package:block_for_managing_state/second_example_persons/bloc/person.dart';
import 'package:block_for_managing_state/second_example_persons/bloc/persons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as devtools show log;


extension Log on Object {
  void log() => devtools.log(toString());
}

///2:21:25 / 11:29:38

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (_) => PersonsBloc(),
        child: const HomePage(),
      ),
    ),
  );
}

Future<Iterable<Person>> getPersons(String url) => HttpClient()
    .getUrl(Uri.parse(url))
    .then((req) => req.close())
    .then((resp) => resp.transform(utf8.decoder).join())
    .then((str) => json.decode(str) as List<dynamic>)
    .then((list) => list.map((e) => Person.fromJson(e)));

extension Subscript<T> on Iterable<T> {
  T? operator [](int index) => length > index ? elementAt(index) : null;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  context.read<PersonsBloc>().add(
                    const LoadPersonsAction(
                      url: persons1Url,
                      loader: getPersons,
                    ),
                  );
                },
                child: const Text(
                  'Load json #1',
                ),
              ),
              TextButton(
                onPressed: () {
                  context.read<PersonsBloc>().add(
                    const LoadPersonsAction(
                      url: persons2Url,
                      loader: getPersons,
                    ),
                  );
                },
                child: const Text(
                  'Load json #2',
                ),
              ),
            ],
          ),
          BlocBuilder<PersonsBloc, FetchResult?>(
            buildWhen: (previousResult, currentResult) {
              return previousResult?.persons != currentResult?.persons;
            },
            builder: (context, fetchResult) {
              fetchResult?.log();
              final persons = fetchResult?.persons;

              if (persons == null) {
                return const SizedBox();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: persons.length,
                  itemBuilder: (context, index) {
                    final person = persons[index]!;

                    return ListTile(
                      title: Text(person.name),
                      subtitle: Text(person.age.toString()),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
