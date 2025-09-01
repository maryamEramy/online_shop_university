import 'package:flutter/cupertino.dart';
import 'package:uni_online_shop/views/shared/text_field_widget.dart';

class NameTextFieldWidget extends StatelessWidget {
  const NameTextFieldWidget({
    super.key,
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return RoundedTextField(
      controller: _nameController,
      hintText: 'Enter your Name',
      validator: (name) {
        return name != null && name.isNotEmpty
            ? null
            : 'Please enter your name';
      },
    );
  }
}