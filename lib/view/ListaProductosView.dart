import 'package:flutter/material.dart';

class ListaProductos extends StatefulWidget {
  const ListaProductos({Key? key}) : super(key: key);

  @override
  State<ListaProductos> createState() => _ListaProductosState();
}

class _ListaProductosState extends State<ListaProductos> {
  // Lista de productos ficticia
  List<String> productos = [
    "Producto 2",
    "Producto 3",
    "Producto 4",
    "Producto 5",
    "Producto 6",
    "Producto 10",
    "Producto 20",
    "Producto 30",
    "Producto 40",
    "Producto 50",
    "Producto 60",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de productos"),
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
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                  ),
                  itemCount: productos.length,
                  shrinkWrap: true,
                  physics:
                      NeverScrollableScrollPhysics(), // Deshabilitar el scroll del GridView
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      child: Center(
                        child: Text(productos[index]),
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
                  productos.clear();
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
