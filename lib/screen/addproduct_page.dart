import 'package:flutter/material.dart';
import 'package:hardware_manufacturing/screen/common_widgets.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  void saveProduct() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Product saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    categoryController.dispose();
    priceController.dispose();
    stockController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AdminDrawer(),
      appBar: AppBar(
        backgroundColor: kAppBarBlue,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Add Product',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            tooltip: 'Save',
            onPressed: saveProduct,
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF68A5D2),
              Color(0xFF365D7B),
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUploadBox(),
                  const SizedBox(height: 20),

                  _buildLabel('Product Name *'),
                  const SizedBox(height: 6),
                  _buildTextFormField(
                    controller: productNameController,
                    hintText: 'e.g. Hex Head Screw M8',
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Enter product name'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('Category *'),
                  const SizedBox(height: 6),
                  _buildTextFormField(
                    controller: categoryController,
                    hintText: 'e.g. Fasteners, Hand Tools',
                    validator: (v) => v == null || v.trim().isEmpty
                        ? 'Enter category'
                        : null,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Price (Rs.) *'),
                            const SizedBox(height: 6),
                            _buildTextFormField(
                              controller: priceController,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              hintText: '0.00',
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Enter price'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel('Stock *'),
                            const SizedBox(height: 6),
                            _buildTextFormField(
                              controller: stockController,
                              keyboardType: TextInputType.number,
                              hintText: '0',
                              validator: (v) => v == null || v.trim().isEmpty
                                  ? 'Enter stock'
                                  : null,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('Description'),
                  const SizedBox(height: 6),
                  _buildTextFormField(
                    controller: descriptionController,
                    hintText: 'Enter brief product specifications...',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 28),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      onPressed: saveProduct,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF365D7B),
                        elevation: 1,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Save Product',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUploadBox() {
    return Container(
      width: double.infinity,
      height: 130,
      decoration: BoxDecoration(
        color: const Color(0xFFF9F9FF),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 45,
            height: 45,
            child: CustomPaint(
              painter: UploadCloudPainter(),
            ),
          ),
          const SizedBox(height: 7),
          RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.black,
                fontSize: 12,
              ),
              children: [
                TextSpan(text: 'Drag & drop files or '),
                TextSpan(
                  text: 'Browse',
                  style: TextStyle(
                    color: Color(0xFF4330A0),
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Supported formats: JPEG, PNG, GIF, MP4, PDF',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Color(0xFF6BA8DF),
            width: 1.5,
          ),
        ),
        errorStyle: const TextStyle(color: Colors.white),
      ),
    );
  }
}

class UploadCloudPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = const Color(0xFF6253D4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final Path cloud = Path();
    cloud.moveTo(11, 31);
    cloud.cubicTo(5, 31, 2, 27, 2, 22);
    cloud.cubicTo(2, 17, 5, 13, 10, 13);
    cloud.cubicTo(10, 7, 14, 3, 19, 3);
    cloud.cubicTo(23, 3, 27, 6, 28, 10);
    cloud.cubicTo(33, 9, 38, 13, 38, 19);
    cloud.cubicTo(38, 25, 34, 29, 29, 29);

    canvas.drawPath(cloud, paint);

    canvas.drawCircle(const Offset(20, 30), 10, paint);

    final Paint arrowPaint = Paint()
      ..color = const Color(0xFF6253D4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round;

    canvas.drawLine(const Offset(20, 36), const Offset(20, 25), arrowPaint);
    canvas.drawLine(const Offset(20, 25), const Offset(16.5, 29), arrowPaint);
    canvas.drawLine(const Offset(20, 25), const Offset(23.5, 29), arrowPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}