import 'package:flutter/material.dart';

class LoadingIndicator extends StatelessWidget {
  final bool isLoading;
  const LoadingIndicator({
    Key? key,
    required this.isLoading
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();
    
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.grey.withOpacity(0.3),
      child: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
