import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:proyectofinal/view/IngresosProductosView.dart';
import 'package:proyectofinal/view/ListaProductosView.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Colors.red, Colors.yellow],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://moodleltga.espe.edu.ec/moodle/pluginfile.php/1/theme_eguru/logo/1689336800/logo%20espe%20100%20an%CC%83os%20variaciones-06%20%281%29.png', // Reemplaza con la ubicación de tu imagen.
                        width: 400, // Ancho deseado de la imagen.
                        height: 100, // Alto deseado de la imagen.
                      ),
                      SizedBox(
                          height: 10), // Espacio entre la imagen y el texto.
                    ],
                  ),
                ),
                ExpansionTile(
                  leading: Icon(Icons.people_alt_outlined),
                  title: Text('Integrantes'),
                  children: <Widget>[
                    ListTile(
                      title: Text('Nelson Molina'),
                    ),
                    ListTile(
                      title: Text('Fabricio Tapia'),
                    ),
                    ListTile(
                      title: Text('Taylor Viscaino'),
                    ),
                  ],
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
            backgroundColor: Colors.red, // Cambia a tu color deseado
            title: const Text('PROYECTO FINAL'),
          ),
          body: Center(
            child: Image.network(
                'https://th.bing.com/th/id/R.f5c98485e19e875073dd3c392a2d1376?rik=MK9Yk%2b03ftp1ew&pid=ImgRaw&r=0'), // Reemplaza 'URL_de_tu_imagen' con la URL de tu imagen en línea.
          ),
        ));
  }
}
