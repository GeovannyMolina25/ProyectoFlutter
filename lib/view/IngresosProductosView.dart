import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:proyectofinal/Services/firebase_services.dart';
import 'package:proyectofinal/Services/firebase_storage.dart';
import 'package:proyectofinal/view/ListaProductosView.dart';

void main() {
  runApp(MaterialApp(
    home: FormularioProducto(),
  ));
}

class FormularioProducto extends StatefulWidget {
  const FormularioProducto({Key? key}) : super(key: key);

  @override
  State<FormularioProducto> createState() => _FormularioProductoState();
}

class _FormularioProductoState extends State<FormularioProducto> {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  String infoText = '';
  DateTime selectedDate = DateTime.now();
  bool isDatePickerVisible = false;
  XFile? pickedImage;

  List<String> items = ['Ninguno', 'Nelson', 'Geovanny', 'Amy'];
  String selectedItem = 'Ninguno'; // Valor seleccionado por defecto

  void toggleDatePicker() {
    setState(() {
      isDatePickerVisible = !isDatePickerVisible;
    });
  }

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        pickedImage = XFile(pickedFile.path);
      });
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        pickedImage = XFile(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber, // Cambia a tu color deseado
        title: const Text('Ingreso de productos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedItem,
              onChanged: (newValue) {
                setState(() {
                  selectedItem = newValue!;
                });
              },
              items: items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            TextField(
              controller: nombreController,
              decoration: InputDecoration(labelText: 'Nombre del producto'),
            ),
            TextField(
              controller: precioController,
              decoration: InputDecoration(labelText: 'Precio'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            ElevatedButton(
              onPressed: toggleDatePicker,
              child: Text('Seleccionar Fecha'),
            ),
            if (isDatePickerVisible)
              CalendarDatePicker(
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                onDateChanged: (date) {
                  setState(() {
                    selectedDate = date;
                    isDatePickerVisible = false;
                  });
                },
              ),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: pickImage,
                    child: Text('Seleccionar Foto'),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: pickImageFromCamera,
                    child: Text('Tomar Foto'),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 2.0,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: pickedImage != null
                  ? Image.file(
                      File.fromUri(Uri.parse(pickedImage!.path)),
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : Icon(Icons.image, size: 50),
            ),
            ElevatedButton(
              onPressed: () async {
                final currentContext = context;
                print('Nombre: ${nombreController.text}');
                print('Precio: ${precioController.text}');
                print('Descripción: ${descripcionController.text}');
                print('Fecha seleccionada: $selectedDate');
                print('Ruta de imagen: ${pickedImage?.path}');

                String imagePath = pickedImage?.path ?? '';
                DateTime formattedDate = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                );
                File photoAsFile = File(pickedImage!.path);
                String URLImagen = await uploadImage(photoAsFile);
                await saveProductos(
                  nombreController.text,
                  int.parse(precioController.text),
                  descripcionController.text,
                  formattedDate,
                  URLImagen,
                );
               Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => ListaProductos()),
                );
              },
              child: const Text("Guardar"),
            ),
            SizedBox(height: 20),
            Text(
              infoText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
