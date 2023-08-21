import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
  TextEditingController nombreController = TextEditingController();
  TextEditingController precioController = TextEditingController();
  TextEditingController descripcionController = TextEditingController();
  String infoText = '';
  DateTime selectedDate = DateTime.now();
  bool isDatePickerVisible = false;
  XFile? pickedImage;
  String selectedOption = 'Nelson'; // Variable para el ComboBox

  List<String> opciones = [
    'Nelson',
    'Juan',
    'Carlos',
    'Goevanny',
    'Anderson',
    'Carla'
  ]; // Opciones del ComboBox

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
    List listaNames = [
      'Nelson',
      'Juan',
      'Carlos',
      'Goevanny',
      'Anderson',
      'Carla'
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text("Ingreso de productos"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // DropdownButton al principio del formulario
            Container(
              width: double
                  .infinity, // Esto hace que el DropdownButton ocupe todo el ancho
              child: DropdownButton<String>(
                value: selectedOption,
                onChanged: (String? newValue) {
                  setState(() {
                    if (opciones.contains(newValue)) {
                      selectedOption = newValue!;
                    } else {
                      // Maneja el caso en que el valor no está en la lista.
                      // Puedes mostrar un mensaje de error o seleccionar un valor predeterminado.
                      selectedOption =
                          'ValorPredeterminado'; // Cambia 'ValorPredeterminado' por tu opción predeterminada real.
                    }
                  });
                },
                items: opciones.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
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
              onPressed: () {
                print('Nombre: ${nombreController.text}');
                print('Precio: ${precioController.text}');
                print('Descripción: ${descripcionController.text}');
                print('Fecha seleccionada: $selectedDate');
                print('Ruta de imagen: ${pickedImage?.path}');
                print('Opción seleccionada: $selectedOption');

                setState(() {
                  infoText =
                      'Producto: ${nombreController.text}\nPrecio: \$${precioController.text}\nDescripción: ${descripcionController.text}\nFecha: ${DateFormat('yyyy-MM-dd').format(selectedDate)}\nOpción seleccionada: $selectedOption';
                });
              },
              child: Text('Mostrar información'),
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
