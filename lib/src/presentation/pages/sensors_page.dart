import 'package:flutter/material.dart';
import 'package:smartcast/src/config/localization/app_localizations.dart';
import 'package:smartcast/src/core/constants/app_colors.dart';

class SensorsPage extends StatefulWidget {
  const SensorsPage({Key? key}) : super(key: key);

  @override
  State<SensorsPage> createState() => _SensorsPageState();
}

class _SensorsPageState extends State<SensorsPage> {
  final PageController _pageController = PageController();
  int _currentPage = 1; // Start with Pressure (middle)

  String selectedPeriod = 'Day';

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    final isAr = Localizations.localeOf(context).languageCode == 'ar';

    // Sensor data with localized titles and insights
    final List<Map<String, dynamic>> sensors = [
      {
        'type': 'Temperature',
        'title': '${loc.temperature} ${loc.translate('health.trend')}',
        'value': '38.6',
        'unit': '°C',
        'color': Colors.red,
        'insight': loc.skinTempNoSigns
      },
      {
        'type': 'Pressure',
        'title': '${loc.pressure} ${loc.translate('health.trend')}',
        'value': '38',
        'unit': 'mmHg',
        'color': Colors.blue,
        'insight': loc.skinPressureNoSigns
      },
      {
        'type': 'Humidity',
        'title': '${loc.humidity} ${loc.translate('health.trend')}',
        'value': '45',
        'unit': '%',
        'color': Colors.green,
        'insight': loc.humidityNoSigns
      },
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(isAr ? Icons.arrow_forward_ios : Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          loc.healthData,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FB),
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                loc.healthAnalytics,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 24),
              
              // Period Selector (Day/Week/Month)
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFE2E8F0),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  children: [loc.day, loc.week, loc.month].map((period) {
                    bool isSelected = (period == loc.day && selectedPeriod == 'Day') || 
                                     (period == loc.week && selectedPeriod == 'Week') || 
                                     (period == loc.month && selectedPeriod == 'Month');
                    
                    return Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                             if (period == loc.day) selectedPeriod = 'Day';
                             if (period == loc.week) selectedPeriod = 'Week';
                             if (period == loc.month) selectedPeriod = 'Month';
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.white : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            period,
                            style: TextStyle(
                              color: isSelected ? Colors.black : Colors.grey,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 24),

              // Horizontal Swiping Area for Charts
              SizedBox(
                height: 300,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: sensors.length,
                  onPageChanged: (index) => setState(() => _currentPage = index),
                  itemBuilder: (context, index) {
                    final sensor = sensors[index];
                    return _buildTrendCard(sensor, isAr);
                  },
                ),
              ),
              const SizedBox(height: 12),
              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(sensors.length, (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == index ? sensors[index]['color'] : Colors.grey.shade300,
                  ),
                )),
              ),
              const SizedBox(height: 24),

              // Medical Insight Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFBFDBFE)),
                ),
                child: Column(
                  crossAxisAlignment: isAr ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    Text(
                      loc.medicalInsight,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1D4ED8),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      sensors[_currentPage]['insight'],
                      textAlign: isAr ? TextAlign.right : TextAlign.left,
                      style: TextStyle(color: Colors.blue.shade800, fontSize: 14),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      loc.castPressureOptimal,
                      textAlign: isAr ? TextAlign.right : TextAlign.left,
                      style: TextStyle(color: Colors.blue.shade800, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrendCard(Map<String, dynamic> sensor, bool isAr) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.black12.withOpacity(0.05)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  sensor['title'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: sensor['color'],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${sensor['value']}${sensor['unit']}',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          // Simple Chart Placeholder using CustomPaint
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: CustomPaint(
                painter: SimpleLineChartPainter(color: sensor['color']),
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('00:00', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text('12:00', style: TextStyle(color: Colors.grey, fontSize: 12)),
              Text('23:59', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }
}

class SimpleLineChartPainter extends CustomPainter {
  final Color color;
  SimpleLineChartPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    // Different mock points for different types
    if (color == Colors.red) {
       path.moveTo(0, size.height * 0.7);
       path.lineTo(size.width * 0.3, size.height * 0.6);
       path.lineTo(size.width * 0.5, size.height * 0.3);
       path.lineTo(size.width * 0.8, size.height * 0.4);
       path.lineTo(size.width * 0.9, size.height * 0.1);
       path.lineTo(size.width, size.height * 0.3);
    } else if (color == Colors.blue) {
       path.moveTo(0, size.height * 0.8);
       path.lineTo(size.width * 0.2, size.height * 0.5);
       path.lineTo(size.width * 0.4, size.height * 0.6);
       path.lineTo(size.width * 0.6, size.height * 0.4);
       path.lineTo(size.width * 0.8, size.height * 0.45);
       path.lineTo(size.width, size.height * 0.2);
    } else {
       path.moveTo(0, size.height * 0.6);
       path.lineTo(size.width * 0.3, size.height * 0.6);
       path.lineTo(size.width * 0.4, size.height * 0.3);
       path.lineTo(size.width * 0.6, size.height * 0.5);
       path.lineTo(size.width * 0.9, size.height * 0.5);
       path.lineTo(size.width, size.height * 0.2);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
