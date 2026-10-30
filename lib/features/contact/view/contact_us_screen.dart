import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoply_admin/core/local/local_storage_user.dart';
import 'package:shoply_admin/core/utils/theme/app_colors.dart';
import 'package:shoply_admin/core/utils/widgets/button/custom_button.dart';
import 'package:shoply_admin/core/utils/widgets/textfield/custom_text_field.dart';
import 'package:shoply_admin/core/utils/l10n/app_l10n.dart';

// Messages are saved in the supportMessages collection
class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _form = GlobalKey<FormState>();
  final _subject = TextEditingController();
  final _message = TextEditingController();
  bool _sending = false;

  @override
  void dispose() {
    _subject.dispose();
    _message.dispose();
    super.dispose();
  }

  void _notify(String message, {bool error = false}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : AppColors.primaryColor,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _send() async {
    if (_sending || !_form.currentState!.validate()) return;
    setState(() => _sending = true);
    try {
      final user = LocalStorageUser.instance;
      await FirebaseFirestore.instance.collection('supportMessages').add({
        'uid': user.uid,
        'name': user.fullName,
        'email': user.email,
        'subject': _subject.text.trim(),
        'message': _message.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      if (!mounted) return;
      _subject.clear();
      _message.clear();
      _notify(context.l10n.messageSent);
    } catch (e) {
      if (mounted) _notify(context.l10n.sendFailed('$e'), error: true);
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.contactUs,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.contactSubtitle,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 15,
                ),
              ),
              SizedBox(height: 20),
              CustomTextField(
                validator: (subject) {
                  if (subject?.trim().isEmpty ?? true) {
                    return l10n.subjectRequired;
                  }
                  return null;
                },
                controller: _subject,
                hinText: l10n.subject,
              ),
              CustomTextField(
                validator: (message) {
                  if (message?.trim().isEmpty ?? true) {
                    return l10n.messageRequired;
                  }
                  return null;
                },
                controller: _message,
                hinText: l10n.messageHint,
                maxLines: 6,
              ),
              SizedBox(height: 10),
              CustomButton(
                buttonText: _sending ? l10n.sending : l10n.send,
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.onPrimary,
                  fontWeight: FontWeight.w700,
                ),
                onPressed: _sending ? null : _send,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
