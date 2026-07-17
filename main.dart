
import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

void main() => runApp(const YousefSandyApp());

class YousefSandyApp extends StatelessWidget {
  const YousefSandyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yousef ♥ Sandy',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF070408),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFC857),
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
        fontFamily: 'sans',
      ),
      home: const MainShell(),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});
  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;
  final pages = const [
    LiveRoomPage(),
    MomentsPage(),
    AlbumPage(),
    GamesPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: index, children: pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        backgroundColor: const Color(0xEE120B11),
        indicatorColor: const Color(0x55FFC857),
        onDestinationSelected: (v) => setState(() => index = v),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.mic_none), selectedIcon: Icon(Icons.mic), label: 'الروم'),
          NavigationDestination(icon: Icon(Icons.auto_awesome_motion), label: 'اللحظات'),
          NavigationDestination(icon: Icon(Icons.photo_library_outlined), label: 'الألبوم'),
          NavigationDestination(icon: Icon(Icons.sports_esports_outlined), label: 'الألعاب'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'حسابي'),
        ],
      ),
    );
  }
}

class LiveRoomPage extends StatefulWidget {
  const LiveRoomPage({super.key});
  @override
  State<LiveRoomPage> createState() => _LiveRoomPageState();
}

class _LiveRoomPageState extends State<LiveRoomPage> with TickerProviderStateMixin {
  bool micOn = false;
  bool videoOn = false;
  int wealth = 12840;
  int xp = 68;
  final chat = <ChatMessage>[
    const ChatMessage('ساندي', 'أهلًا بك في لحظتنا الخاصة ❤️', true),
    const ChatMessage('يوسف', 'كل سنة ونحن معًا يا أجمل صدفة', false),
  ];
  final controller = TextEditingController();
  OverlayEntry? giftOverlay;

  void send() {
    final text = controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      chat.add(ChatMessage('يوسف', text, false));
      xp = min(100, xp + 2);
    });
    controller.clear();
  }

  void react(String emoji) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 650),
        backgroundColor: const Color(0xDD2A1322),
        content: Center(child: Text(emoji, style: const TextStyle(fontSize: 32))),
      ),
    );
  }

  void showGift(String title, String emoji, int cost) {
    setState(() => wealth += cost);
    giftOverlay?.remove();
    giftOverlay = OverlayEntry(
      builder: (_) => GiftAnimation(title: title, emoji: emoji),
    );
    Overlay.of(context).insert(giftOverlay!);
    Timer(const Duration(seconds: 4), () {
      giftOverlay?.remove();
      giftOverlay = null;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    giftOverlay?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset('assets/images/sandy.jpg', fit: BoxFit.cover),
        ),
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(.35),
                  const Color(0xB8070307),
                  const Color(0xFF090408),
                ],
              ),
            ),
          ),
        ),
        SafeArea(
          child: Column(
            children: [
              _topBar(),
              _levelStrip(),
              const SizedBox(height: 12),
              _micSeats(),
              const Spacer(),
              _chatPanel(),
              _reactionBar(),
              _messageBox(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _topBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 22,
            backgroundImage: AssetImage('assets/images/yousef.jpg'),
          ),
          const SizedBox(width: 9),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('لحظة يوسف وساندي', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                Text('روم خاص • متصل الآن', style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
              ],
            ),
          ),
          FilledButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.person_add_alt_1, size: 18),
            label: const Text('دعوة'),
            style: FilledButton.styleFrom(backgroundColor: const Color(0xFFC9942D)),
          ),
        ],
      ),
    );
  }

  Widget _levelStrip() {
    return Container(
      margin: const EdgeInsets.all(12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.48),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x55FFD36C)),
      ),
      child: Row(
        children: [
          const Icon(Icons.workspace_premium, color: Color(0xFFFFD36C)),
          const SizedBox(width: 8),
          const Text('المستوى 18'),
          const SizedBox(width: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: xp / 100,
                minHeight: 8,
                backgroundColor: Colors.white12,
                valueColor: const AlwaysStoppedAnimation(Color(0xFFFFC857)),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Text('$wealth 💎', style: const TextStyle(color: Color(0xFFFFD36C))),
        ],
      ),
    );
  }

  Widget _micSeats() {
    Widget seat(String name, String image, bool active) {
      return Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: active ? Colors.greenAccent : const Color(0xFFFFC857), width: 3),
              boxShadow: const [BoxShadow(color: Color(0x88FF3D8E), blurRadius: 22)],
            ),
            child: CircleAvatar(radius: 48, backgroundImage: AssetImage(image)),
          ),
          const SizedBox(height: 7),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(active ? 'يتحدث الآن' : 'على المايك', style: TextStyle(fontSize: 11, color: active ? Colors.greenAccent : Colors.white70)),
        ],
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        seat('يوسف', 'assets/images/yousef.jpg', micOn),
        seat('ساندي', 'assets/images/sandy.jpg', false),
      ],
    );
  }

  Widget _chatPanel() {
    return Container(
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.42),
        borderRadius: BorderRadius.circular(18),
      ),
      child: ListView.builder(
        reverse: true,
        itemCount: chat.length,
        itemBuilder: (_, i) {
          final m = chat[chat.length - 1 - i];
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: RichText(
              text: TextSpan(
                style: const TextStyle(fontSize: 14),
                children: [
                  TextSpan(
                    text: '${m.name}: ',
                    style: TextStyle(
                      color: m.isSandy ? const Color(0xFFFF83B7) : const Color(0xFFFFD36C),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: m.text),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _reactionBar() {
    return SizedBox(
      height: 58,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        scrollDirection: Axis.horizontal,
        children: [
          _circleAction(micOn ? Icons.mic : Icons.mic_off, () => setState(() => micOn = !micOn), micOn ? Colors.green : Colors.red),
          _circleAction(videoOn ? Icons.videocam : Icons.videocam_off, () => setState(() => videoOn = !videoOn), Colors.blueGrey),
          _circleAction(Icons.card_giftcard, _giftSheet, const Color(0xFFC9942D)),
          for (final e in ['❤️', '😍', '🌹', '🔥', '😂']) _emojiAction(e),
        ],
      ),
    );
  }

  Widget _circleAction(IconData icon, VoidCallback onTap, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),
        child: CircleAvatar(backgroundColor: color.withOpacity(.85), child: Icon(icon, color: Colors.white)),
      ),
    );
  }

  Widget _emojiAction(String e) {
    return Padding(
      padding: const EdgeInsets.only(left: 6),
      child: InkWell(
        onTap: () => react(e),
        child: CircleAvatar(backgroundColor: Colors.white12, child: Text(e, style: const TextStyle(fontSize: 21))),
      ),
    );
  }

  Widget _messageBox() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: (_) => send(),
              decoration: InputDecoration(
                hintText: 'اكتب رسالة...',
                filled: true,
                fillColor: Colors.black54,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton.filled(onPressed: send, icon: const Icon(Icons.send)),
        ],
      ),
    );
  }

  void _giftSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF170D15),
      showDragHandle: true,
      builder: (_) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
        child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 4,
          children: [
            _gift('وردة', '🌹', 10),
            _gift('خاتم', '💍', 120),
            _gift('قلعة الحب', '🏰', 500),
            _gift('علم سوريا', '🇸🇾', 880),
            _gift('حمام السلام', '🕊️', 220),
            _gift('قلب كريستال', '💖', 300),
            _gift('ألعاب نارية', '🎆', 450),
            _gift('مرور عام', '🎉', 1000),
          ],
        ),
      ),
    );
  }

  Widget _gift(String name, String emoji, int value) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        showGift(name, emoji, value);
      },
      borderRadius: BorderRadius.circular(18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 34)),
          Text(name, textAlign: TextAlign.center, style: const TextStyle(fontSize: 11)),
          Text('$value 💎', style: const TextStyle(fontSize: 10, color: Color(0xFFFFD36C))),
        ],
      ),
    );
  }
}

class GiftAnimation extends StatefulWidget {
  final String title;
  final String emoji;
  const GiftAnimation({super.key, required this.title, required this.emoji});
  @override
  State<GiftAnimation> createState() => _GiftAnimationState();
}

class _GiftAnimationState extends State<GiftAnimation> with SingleTickerProviderStateMixin {
  late final AnimationController c;
  @override
  void initState() {
    super.initState();
    c = AnimationController(vsync: this, duration: const Duration(seconds: 3))..forward();
  }
  @override
  void dispose() { c.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        color: Colors.black45,
        child: Center(
          child: AnimatedBuilder(
            animation: c,
            builder: (_, __) {
              final s = Curves.elasticOut.transform(min(1, c.value * 1.5));
              return Opacity(
                opacity: min(1, c.value * 3) * (1 - max(0, (c.value - .75) * 4)),
                child: Transform.scale(
                  scale: s,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(widget.emoji, style: const TextStyle(fontSize: 130)),
                      Text(widget.title, style: const TextStyle(fontSize: 30, color: Color(0xFFFFD36C), fontWeight: FontWeight.bold)),
                      const Text('يوسف أرسل هدية إلى ساندي ❤️', style: TextStyle(fontSize: 17)),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class MomentsPage extends StatelessWidget {
  const MomentsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const SectionPage(
      title: 'لحظاتنا',
      icon: Icons.auto_awesome_motion,
      cards: [
        FeatureCard('ذكرى اللقاء', '23 يوليو 2025 • بداية أجمل حكاية', Icons.favorite),
        FeatureCard('فيديو القلعة والعلم', 'مشهد سينمائي محفوظ للمشاهدة والتنزيل', Icons.movie),
        FeatureCard('لحظة اليوم', 'أضيفا صورة أو فيديو وشاركا التعليقات', Icons.add_a_photo),
      ],
    );
  }
}

class AlbumPage extends StatelessWidget {
  const AlbumPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ألبوم يوسف وساندي')),
      body: GridView.count(
        padding: const EdgeInsets.all(12),
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        children: const [
          PhotoTile('assets/images/yousef.jpg', 'يوسف'),
          PhotoTile('assets/images/sandy.jpg', 'ساندي'),
          AddTile(),
          AddTile(),
        ],
      ),
    );
  }
}

class GamesPage extends StatelessWidget {
  const GamesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return const SectionPage(
      title: 'ألعابنا',
      icon: Icons.sports_esports,
      cards: [
        FeatureCard('أسئلة الحبيبين', 'من يعرف الآخر أكثر؟', Icons.quiz),
        FeatureCard('عجلة الحظ', 'تحديات ومفاجآت لطيفة', Icons.track_changes),
        FeatureCard('اختيار الصندوق', 'اختارا صندوقًا واكتشفا الهدية', Icons.inventory_2),
        FeatureCard('حجر ورقة مقص', 'جولة سريعة داخل الروم', Icons.back_hand),
      ],
    );
  }
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حساب يوسف')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(radius: 54, backgroundImage: AssetImage('assets/images/yousef.jpg')),
          const SizedBox(height: 12),
          const Center(child: Text('يوسف', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold))),
          const Center(child: Text('ID: YS-230725', style: TextStyle(color: Colors.white60))),
          const SizedBox(height: 20),
          _stat('مستوى المستخدم', '18', Icons.workspace_premium),
          _stat('مستوى الثروة', '12', Icons.diamond),
          _stat('النقاط', '12,840', Icons.stars),
          _stat('الهدايا المرسلة', '47', Icons.card_giftcard),
          _stat('أيام الذكرى', '23 يوليو', Icons.event),
        ],
      ),
    );
  }

  Widget _stat(String title, String value, IconData icon) {
    return Card(
      child: ListTile(
        leading: Icon(icon, color: const Color(0xFFFFD36C)),
        title: Text(title),
        trailing: Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class SectionPage extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<FeatureCard> cards;
  const SectionPage({super.key, required this.title, required this.icon, required this.cards});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), actions: [Icon(icon), const SizedBox(width: 14)]),
      body: ListView(padding: const EdgeInsets.all(14), children: cards),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        icon: const Icon(Icons.add),
        label: const Text('إضافة'),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  const FeatureCard(this.title, this.subtitle, this.icon, {super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        minVerticalPadding: 18,
        leading: CircleAvatar(backgroundColor: const Color(0x33FFC857), child: Icon(icon, color: const Color(0xFFFFD36C))),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.chevron_left),
      ),
    );
  }
}

class PhotoTile extends StatelessWidget {
  final String asset;
  final String title;
  const PhotoTile(this.asset, this.title, {super.key});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(asset, fit: BoxFit.cover),
          const DecoratedBox(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black87]))),
          Positioned(right: 10, bottom: 10, child: Text(title, style: const TextStyle(fontWeight: FontWeight.bold))),
        ],
      ),
    );
  }
}

class AddTile extends StatelessWidget {
  const AddTile({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(18), border: Border.all(color: Colors.white24)),
      child: const Column(mainAxisAlignment: MainAxisAlignment.center, children: [Icon(Icons.add_a_photo, size: 38), SizedBox(height: 8), Text('إضافة صورة أو فيديو')]),
    );
  }
}

class ChatMessage {
  final String name;
  final String text;
  final bool isSandy;
  const ChatMessage(this.name, this.text, this.isSandy);
}
