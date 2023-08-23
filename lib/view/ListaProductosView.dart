import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:proyectofinal/Services/videoJuegos_services.dart';

import '../Services/firebase_services.dart';
import 'ActualizacionProductos.dart';
import 'IngresosProductosView.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: ListaProductos()));
}

class ListaProductos extends StatefulWidget {
  const ListaProductos({Key? key}) : super(key: key);

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber, // Cambia a tu color deseado
        title: const Text('Lista de productos'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: getProductos(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 350,
                          childAspectRatio: 2 / 3,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                        ),
                        itemCount: snapshot.data?.length ?? 0,
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          final Map<String, dynamic> data =
                              snapshot.data?[index] as Map<String, dynamic>;

                          final timestamp = data['Fecha'] as Timestamp;
                          final dateTime = timestamp.toDate();

                          return Card(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(data['Nombre'] ?? ''),
                                Text(data['Precio']?.toString() ?? ''),
                                Text(data['Descripcion'] ?? ''),
                                Text(dateTime.toString()),
                                SizedBox(
                                  height: 80,
                                  width: 80,
                                  child: Image.network(data['Imagen']),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              FormularioActualizar()),
                                    );
                                  },
                                  child: Text('Actualizar'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error fetching data'));
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
            ),
            SizedBox(height: 20), // Espacio entre la lista y el botón
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormularioProducto()),
                );
              },
              child: Text('Ingresar'),
            ),
          ],
        ),
      ),
    );
  }
}
