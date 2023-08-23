import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

FirebaseFirestore BaseDatos = FirebaseFirestore.instance;

Future<List>getProductos()async{
  List Productos = [];
  CollectionReference colecionProductos = BaseDatos.collection('Productos');
  QuerySnapshot queryProductos = await colecionProductos.get();

  for (var element in queryProductos.docs) { 
    final Map<String,dynamic> data = element.data() as Map<String,dynamic>;
    final producto = {
      "uid":element.id,
      "Descripcion":data['Descripcion'],
      "Fecha":data['Fecha'],
      "Imagen":data['Imagen'],
      "Nombre":data['Nombre'],
      "Precio":data['Precio'],
    };
    Productos.add(producto);
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

Future<void> updateProductos(String id,String newnombre, int newprecio, String newdescripcion, DateTime newfecha, String? newimagen)async {
  await BaseDatos.collection("Productos").doc(id).set({"Descripcion":newdescripcion,"Fecha":newfecha,"Imagen":newimagen,"Nombre":newnombre,"Precio":newprecio});
}

