import 'package:url_launcher/url_launcher.dart';
import '../models/order.dart';
import '../models/cart_item.dart';
import 'currency_helper.dart';

class WhatsAppHelper {
  static const String businessPhone = '254712241239';

  static Future<bool> sendOrder({
    required Order order,
    required List<CartItem> cartItems,
  }) async {
    final message = _buildOrderMessage(order, cartItems);
    final url = _buildWhatsAppUrl(message);

    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        return await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
      return false;
    } catch (e) {
      print('Error opening WhatsApp: $e');
      return false;
    }
  }

  static String _buildOrderMessage(Order order, List<CartItem> cartItems) {
    final buffer = StringBuffer();

    buffer.writeln('*PhimWear Collection - New Order*');
    buffer.writeln('');
    buffer.writeln('Order ID: ${order.orderId}');
    buffer.writeln('Date: ${_formatDate(order.createdAt)}');
    buffer.writeln('');

    buffer.writeln('*Customer Details:*');
    buffer.writeln('Name: ${order.delivery.fullName}');
    buffer.writeln('Phone: ${order.delivery.phone}');
    buffer.writeln('Address: ${order.delivery.address}');
    buffer.writeln('City: ${order.delivery.city}');
    buffer.writeln('Postal Code: ${order.delivery.postalCode}');
    buffer.writeln('');

    buffer.writeln('*Order Items:*');
    for (var item in cartItems) {
      buffer.writeln(
        '• ${item.quantity} x ${item.product.name} — ${CurrencyHelper.format(item.product.price)} each — Subtotal: ${CurrencyHelper.format(item.subtotal)}',
      );
    }
    buffer.writeln('');

    buffer.writeln('*Total: ${CurrencyHelper.format(order.total)}*');
    buffer.writeln('');

    if (order.notes.isNotEmpty) {
      buffer.writeln('*Delivery Notes:*');
      buffer.writeln(order.notes);
      buffer.writeln('');
    }

    buffer.writeln('Please confirm receipt of this order. Thank you!');

    return buffer.toString();
  }

  static String _buildWhatsAppUrl(String message) {
    final encodedMessage = Uri.encodeComponent(message);
    return 'https://wa.me/$businessPhone?text=$encodedMessage';
  }

  static String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} at ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
