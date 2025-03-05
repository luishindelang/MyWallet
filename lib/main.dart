import 'package:flutter/material.dart';
import 'package:mywallet/DB/DataStrukture/ds_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/Dao/dao_bankaccount.dart';
import 'package:mywallet/DB/Sqlite/sql_connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() async {
    final db = await SqlConnection.instance.database;

    // DsBankaccount bankaccount = DsBankaccount("dgwerh", "test2", 93145);
    // await DaoBankaccount.insert(bankaccount);
    // print("erfolg");

    // List<DsBankaccount> bs = await DaoBankaccount.getAll();
    // print(bs);

    // List<Map> rawData = await db.query(TBankaccount.tableName);

    // print(rawData);

    // await SqlConnection.deleteTables(db);
    // await SqlConnection.createTables(db);
  }

  void _resetDb() async {
    await SqlConnection.resetDB();
    print("Reset Db");
  }

  void _insert() async {
    final db = await SqlConnection.instance.database;
    DsBankaccount bankaccount = DsBankaccount("test2", 93145);
    await DaoBankaccount.insert(bankaccount);
    print("erfolg");
  }

  void _show() async {
    final db = await SqlConnection.instance.database;
    List<DsBankaccount> bs = await DaoBankaccount.getAll();

    for (var value in bs) {
      String log =
          "Id: ${value.getId}, Name: ${value.getName}, Credit: ${value.getCredit}";
      print(log);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(onPressed: _resetDb, child: const Text("RestDB")),
            TextButton(onPressed: _insert, child: const Text("Insert")),
            TextButton(onPressed: _show, child: const Text("Show")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
