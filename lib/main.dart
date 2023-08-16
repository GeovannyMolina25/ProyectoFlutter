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
                        MaterialPageRoute(
                            builder: (context) => ListaProductos()),
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
            body: const Center(
              child: Text("Hello world"),
            )));
  }
}
