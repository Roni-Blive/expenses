import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  const TransactionList(this.transactions,this.removeTransaction, {super.key});

  final List<Transaction> transactions;
  final void Function(String) removeTransaction;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constrations) {
          return Column(
            children: [
              SizedBox(
                height: constrations.maxHeight * 0.05,
              ),
              SizedBox(
                height: constrations.maxHeight * 0.3,
                child: Text(
                  "Nenhuma Transação Cadastrada",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
              SizedBox(
                height: constrations.maxHeight * 0.05,
              ),
              SizedBox(
                height: constrations.maxHeight * 0.6,
                child: Image.asset(
                  'assets/images/waiting.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          );
        })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 10,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text("R\$${tr.value.toStringAsFixed(2)}"),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                  ),
                  trailing: IconButton(
                    onPressed: () => removeTransaction(tr.id),
                    icon: const Icon(Icons.delete),
                  ),
                ),
              );
            });
  }
}
