import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectofinal/view/IngresosProductosView.dart';
import 'package:proyectofinal/view/ListaProductosView.dart';

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
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Proyecto'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        home: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blue),
                  child: Text(
                    'Universidad de las fuerzas armadas',
                    style: TextStyle(color: Colors.white, fontSize: 24),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.add),
                  title: Text('Ingreso de productos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FormularioProducto()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.list),
                  title: Text('Lista de productos'),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListaProductos()),
                    );
                  },
                ),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Exit'),
                  onTap: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            ),
          ),
          appBar: AppBar(
            title: const Text('Proyecto final'),
          ),
          body: Image.network(
            'https://images-wixmp-ed30a86b8c4ca887773594c2.wixmp.com/f/7b930f4a-212d-48c1-b02f-5252f1a5b9d2/dcrk3ll-e2c0b9b3-63ed-41e0-b05d-c095d2aad183.png/v1/fill/w_1156,h_691,strp/nbc_logo_in_dot__dee__and_del_s_colors_by_lukesamsthesecond_dcrk3ll-pre.png?token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJ1cm46YXBwOjdlMGQxODg5ODIyNjQzNzNhNWYwZDQxNWVhMGQyNmUwIiwiaXNzIjoidXJuOmFwcDo3ZTBkMTg4OTgyMjY0MzczYTVmMGQ0MTVlYTBkMjZlMCIsIm9iaiI6W1t7ImhlaWdodCI6Ijw9MTE5NyIsInBhdGgiOiJcL2ZcLzdiOTMwZjRhLTIxMmQtNDhjMS1iMDJmLTUyNTJmMWE1YjlkMlwvZGNyazNsbC1lMmMwYjliMy02M2VkLTQxZTAtYjA1ZC1jMDk1ZDJhYWQxODMucG5nIiwid2lkdGgiOiI8PTIwMDAifV1dLCJhdWQiOlsidXJuOnNlcnZpY2U6aW1hZ2Uub3BlcmF0aW9ucyJdfQ.N4IFZsonb1XRAemwS0V3-x4CHU7ythg_QFTTSLCQmJg',
          ),
        ));
  }
}
