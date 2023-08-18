import 'package:flutter/material.dart';
import 'package:proyectofinal/models/modelVideojuegos.dart';
import 'package:proyectofinal/Services/videoJuegos_services.dart';

class ListaProductos extends StatefulWidget {
  const ListaProductos({Key? key}) : super(key: key);

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  // Lista de productos ficticia
  List<Videojuego>? listaVideojuedo;

  loadVideojuego() async {
    VideojuegosService service = VideojuegosService();
    listaVideojuedo = await service.getComputador();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadVideojuego();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de los productos"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height *
            0.7, // Altura máxima de la mitad de la pantalla
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 250,
                    childAspectRatio: 4 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: listaVideojuedo?.length?? 0,
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Deshabilitar el scroll del GridView
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Center(
                        child: Text(listaVideojuedo?[index].nombrejuego ?? " "),
                      ),
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 100),
            ElevatedButton(
              onPressed: () {
                // Lógica para eliminar productos
                setState(() {
                  listaVideojuedo?.clear();
                });
              },
              child: Text('Eliminar'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ListaProductos(),
  ));
}
