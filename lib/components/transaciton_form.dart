import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm(this.onSubmit, {super.key});

  final void Function(String, double, DateTime) onSubmit;

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final TextEditingController valueController = TextEditingController();

  final TextEditingController titleController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  void _submit() {
    final String title = titleController.text;
    final double value = double.tryParse(valueController.text) ?? 0.0;
    final DateTime dateTime = _selectedDate;

    if (title.isEmpty || value <= 0) return;

    widget.onSubmit(
      title,
      value,
      dateTime,
    );
  }

  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom
          ),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: "Título",
                ),
              ),
              TextField(
                controller: valueController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: "Valor (R\$)",
                ),
              ),
              SizedBox(
                height: 70,
                child: Row(
                  children: [
                    Text(
                      "Data selecionada: ${DateFormat('d/M/y').format(_selectedDate)}",
                    ),
                    Container(
                      margin: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        style: const ButtonStyle(
                          foregroundColor:
                              MaterialStatePropertyAll(Colors.purple),
                          backgroundColor: MaterialStatePropertyAll(Colors.white),
                        ),
                        onPressed: _showDatePicker,
                        child: const Text(
                          "Selecionar data!",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text(
                        "Nova Transação",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
