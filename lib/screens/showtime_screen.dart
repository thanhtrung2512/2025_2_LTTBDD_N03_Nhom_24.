import 'package:flutter/material.dart';
import 'booking_screen.dart';

class ShowtimeScreen extends StatefulWidget {
  final Map movie;
  const ShowtimeScreen({super.key, required this.movie});

  @override
  State<ShowtimeScreen> createState() => _ShowtimeScreenState();
}

class _ShowtimeScreenState extends State<ShowtimeScreen> {
  int selectedDateIndex = 0;
  String selectedRegion = "MIỀN BẮC";

  final List<String> regions = ["MIỀN BẮC", "MIỀN TRUNG", "MIỀN NAM"];
  final List<Map<String, String>> dates = [
    {"day": "CN", "date": "15/03"}, {"day": "T2", "date": "16/03"}, {"day": "T3", "date": "17/03"},
    {"day": "T4", "date": "18/03"}, {"day": "T5", "date": "19/03"}, {"day": "T6", "date": "20/03"}, {"day": "T7", "date": "21/03"},
  ];

  final Map<String, List<Map<String, dynamic>>> cinemasByRegion = {
    "MIỀN BẮC": [
      {
        "name": "TT Cinema Hà Đông",
        "times": [
          {"start": "19:00", "end": "21:00", "seats": "45/120"},
          {"start": "21:00", "end": "23:00", "seats": "79/120"},
          {"start": "23:40", "end": "01:40", "seats": "Hết vé"}
        ]
      },
      {
        "name": "TT Cinema Cầu Giấy",
        "times": [{"start": "10:00", "end": "12:00", "seats": "15/100"}]
      }
    ],
    "MIỀN TRUNG": [{"name": "TT Cinema Sơn Trà", "times": [{"start": "14:00", "end": "16:00", "seats": "50/120"}]}],
    "MIỀN NAM": [{"name": "TT Cinema Gò Vấp", "times": [{"start": "19:30", "end": "21:30", "seats": "200/250"}]}],
  };

  @override
  Widget build(BuildContext context) {
    var cinemas = cinemasByRegion[selectedRegion] ?? [];
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 500),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                _buildAppBar(),
                _buildHeaderList(dates, true),
                _buildHeaderList(regions, false),
                const Divider(height: 1),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: cinemas.length,
                    itemBuilder: (context, i) => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(cinemas[i]["name"], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                        const SizedBox(height: 12),
                        Wrap(
                          spacing: 10, runSpacing: 10,
                          children: (cinemas[i]["times"] as List).map((t) => _buildTimeChip(t)).toList(),
                        ),
                        const Divider(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() => Container(
    color: const Color(0xFFE51937),
    child: SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          IconButton(icon: const Icon(Icons.arrow_back, color: Colors.white), onPressed: () => Navigator.pop(context)),
          Expanded(child: Center(child: Text(widget.movie["name"]?.toString().toUpperCase() ?? "LỊCH CHIẾU", style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)))),
          const SizedBox(width: 48),
        ]),
      ),
    ),
  );

  Widget _buildHeaderList(List list, bool isDate) => Container(
    height: isDate ? 70 : 50,
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: list.length,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemBuilder: (context, i) {
        bool selected = isDate ? selectedDateIndex == i : selectedRegion == list[i];
        return GestureDetector(
          onTap: () => setState(() => isDate ? selectedDateIndex = i : selectedRegion = list[i]),
          child: Container(
            margin: const EdgeInsets.only(right: 12),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(color: selected ? const Color(0xFFE51937) : Colors.transparent, borderRadius: BorderRadius.circular(8)),
            child: isDate 
              ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(dates[i]["day"]!, style: TextStyle(color: selected ? Colors.white : Colors.black38, fontSize: 11)),
                  Text(dates[i]["date"]!.split('/')[0], style: TextStyle(color: selected ? Colors.white : Colors.black, fontSize: 16, fontWeight: FontWeight.bold)),
                ])
              : Center(child: Text(list[i], style: TextStyle(color: selected ? Colors.white : Colors.black45, fontWeight: selected ? FontWeight.bold : FontWeight.normal, fontSize: 13))),
          ),
        );
      },
    ),
  );

  Widget _buildTimeChip(Map t) {
    bool soldOut = t["seats"] == "Hết vé";
    return GestureDetector(
      onTap: soldOut ? null : () => Navigator.push(context, MaterialPageRoute(builder: (_) => BookingScreen(movie: widget.movie, timeData: t))),
      child: Container(
        width: 100, padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(border: Border.all(color: Colors.black12), borderRadius: BorderRadius.circular(8), color: soldOut ? Colors.grey[100] : Colors.white),
        child: Column(children: [
          Text("${t["start"]} ~ ${t["end"]}", style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: soldOut ? Colors.black26 : Colors.black)),
          const SizedBox(height: 2),
          Text(t["seats"], style: TextStyle(fontSize: 9, color: soldOut ? Colors.black12 : Colors.black38)),
        ]),
      ),
    );
  }
}