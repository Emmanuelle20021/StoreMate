import 'package:flutter/material.dart';
import 'package:store_mate/constants/enums.dart';
import 'package:store_mate/models/models.dart';

class NewProductScreen extends StatefulWidget {
  const NewProductScreen({super.key});

  @override
  State<NewProductScreen> createState() => _NewProductScreenState();
}

class _NewProductScreenState extends State<NewProductScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late FocusNode _priceFocusNode;
  late FocusNode _categoryFocusNode;
  late FocusNode _descriptionFocusNode;

  String imagePath = '';
  String qrCodePath = '';
  Color _selectedColor = Colors.white;
  ProductSize? _selectedSize;

  @override
  void initState() {
    _priceFocusNode = FocusNode();
    _categoryFocusNode = FocusNode();
    _descriptionFocusNode = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nuevo Producto'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Nombre del Producto',
                  ),
                  autofocus: true,
                  validator: _validator,
                  onFieldSubmitted: (value) {
                    _priceFocusNode.requestFocus();
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Precio del Producto',
                  ),
                  focusNode: _priceFocusNode,
                  keyboardType: TextInputType.number,
                  validator: _validator,
                  onFieldSubmitted: (value) {
                    _categoryFocusNode.requestFocus();
                  },
                ),
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(
                    labelText: 'Categoria del Producto',
                  ),
                  focusNode: _categoryFocusNode,
                  validator: _validator,
                  onFieldSubmitted: (value) {
                    _descriptionFocusNode.requestFocus();
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Descripción del Producto',
                  ),
                  focusNode: _descriptionFocusNode,
                  validator: _validator,
                ),
                SizedBox(
                  height: 66.0,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _generateColorButton(),
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceEvenly,
                    children: List.generate(
                      ProductSize.values.length,
                      (index) {
                        final size = ProductSize.values[index];
                        return FloatingActionButton(
                          heroTag: Key(
                            'Floating_Action_Button_Size_$size',
                          ),
                          onPressed: () => _changeSize(size),
                          backgroundColor: _selectedSize == size
                              ? Colors.green
                              : Colors.transparent,
                          elevation: 0,
                          child: Text(size.name),
                        );
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveNewProduct,
                  child: const Text('Guardar Producto'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String? _validator(String? text) {
    if (text == null || text.isEmpty) {
      return 'No deje el campo vacío';
    }
    return null;
  }

  List<Widget> _generateColorButton() {
    final List<Widget> colorButtons = [];
    final List<Color> colors = [
      ...Colors.primaries,
      ...Colors.accents,
      Colors.white,
      Colors.black
    ];
    const checkColor = Colors.white;
    for (final color in colors) {
      colorButtons.add(
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Material(
            color: color,
            child: InkWell(
              onTap: () => _selectColor(color),
              child: Container(
                height: 50.0,
                width: 50.0,
                decoration: BoxDecoration(
                  color: color,
                  border: color == Colors.black
                      ? Border.all(
                          color: Colors.white,
                          width: 1,
                        )
                      : null,
                ),
                child: Icon(
                  Icons.check,
                  color: _selectedColor == color
                      ? _selectedColor == Colors.white
                          ? Colors.black
                          : checkColor
                      : color,
                ),
              ),
            ),
          ),
        ),
      );
    }
    return colorButtons;
  }

  void _selectColor(Color color) {
    setState(() {
      _selectedColor = color;
    });
  }

  void _saveNewProduct() {
    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        category: _categoryController.text,
        imagePath: imagePath,
        qrCodePath: qrCodePath,
        enable: true,
      );
      debugPrint(newProduct.toString());
    }
  }

  void _changeSize(ProductSize size) {
    if (size == _selectedSize) {
      setState(() {
        _selectedSize = null;
      });
      return;
    }
    setState(() {
      _selectedSize = size;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _priceFocusNode.dispose();
    _categoryFocusNode.dispose();
    _descriptionFocusNode.dispose();
    super.dispose();
  }
}
