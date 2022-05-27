import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();

  String _note = '';
  final List<String> _notes = ['Default first note'];

  _showAlertDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _notes.add(_note);
                      controller.clear();
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Save Note'))
            ],
            title: const Text('Enter Note'),
            content: TextField(
              controller: controller,
              decoration:
                  const InputDecoration(contentPadding: EdgeInsets.all(10)),
              onChanged: (val) {
                setState(() {
                  _note = val;
                });
              },
            ),
          );
        });
  }

  _resetNotes() {
    setState(() {
      _notes
          .retainWhere((element) => element.toString() == 'Default first note');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
          itemCount: _notes.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text(index.toString()),
              title: Text(_notes[index].toString()),
            );
          }),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _showAlertDialog,
            tooltip: 'AddNote',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
            onPressed: _resetNotes,
            tooltip: 'Reset',
            child: const Icon(Icons.replay),
          ),
        ],
      ),
    );
  }
}
