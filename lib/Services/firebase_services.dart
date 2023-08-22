import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

FirebaseFirestore BaseDatos = FirebaseFirestore.instance;

Future<List>getProductos()async{
  List Productos = [];
  CollectionReference colecionProductos = BaseDatos.collection('Productos');
  QuerySnapshot queryProductos = await colecionProductos.get();

  for (var element in queryProductos.docs) { 
    Productos.add(element.data());
  }

  return Productos;
}


Future<void> saveProductos(String nombre, int precio, String descripcion, DateTime fecha, String? imagen) async {
  Map<String, dynamic> productoData = {
    "Descripcion": descripcion,
    "Fecha": fecha,
    "Imagen": imagen,
    "Nombre": nombre,
    "Precio": precio,
  };

  await BaseDatos.collection("Productos").add(productoData);
}
