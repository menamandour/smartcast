import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21), // Dark navy as in image
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: isAr ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                  if (!isAr) _buildDoctorIcon(),
                  if (!isAr) const SizedBox(width: 12),
                  Text(
                    loc.doctorMessages,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (isAr) const SizedBox(width: 12),
                  if (isAr) _buildDoctorIcon(),
                ],
              ),
            ),

            // Messages List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _buildMessageCard(
                    name: loc.drAhmed,
                    message: loc.keepLegElevated,
                    time: '2 ${loc.minAgo}',
                    imageUrl: 'https://i.pravatar.cc/150?u=drahed', // Placeholder
                    isAr: isAr,
                  ),
                  const SizedBox(height: 16),
                  _buildMessageCard(
                    name: loc.drOmar,
                    message: loc.nextCheckupOnFri,
                    time: '1 ${loc.hrAgo}',
                    imageUrl: 'https://i.pravatar.cc/150?u=dromar', // Placeholder
                    isAr: isAr,
                  ),
                ],
              ),
            ),

            // Message Input
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Row(
                  children: [
                    if (isAr) _buildSendButton(),
                    Expanded(
                      child: TextField(
                        textAlign: isAr ? TextAlign.right : TextAlign.left,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: loc.typeYourMessage,
                          hintStyle: const TextStyle(color: Colors.white54),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                    if (!isAr) _buildSendButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorIcon() {
    return Stack(
      children: [
        const Icon(Icons.account_circle, color: Colors.white, size: 40),
        Positioned(
          right: 0,
          bottom: 0,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: const Color(0xFF0A0E21), width: 2),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSendButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color(0xFF1E60FF),
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.send, color: Colors.white, size: 20),
    );
  }

  Widget _buildMessageCard({
    required String name,
    required String message,
    required String time,
    required String imageUrl,
    required bool isAr,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (!isAr) CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
          if (!isAr) const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (isAr) Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (!isAr) Text(time, style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  message,
                  textAlign: isAr ? TextAlign.right : TextAlign.left,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
              ],
            ),
          ),
          if (isAr) const SizedBox(width: 16),
          if (isAr) CircleAvatar(radius: 24, backgroundImage: NetworkImage(imageUrl)),
        ],
      ),
    );
  }
}
