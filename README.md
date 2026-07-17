# Yousef ❤️ Sandy

نسخة أولية من تطبيق روم خاص مستوحى من تطبيقات الرومات، بهوية مستقلة ليوسف وساندي.

## الموجود حاليًا

- روم خاص ومقاعد مايك.
- أزرار مايك وفيديو تجريبية.
- دردشة محلية.
- إيموجي وتفاعلات.
- هدايا وتأثير عرض.
- ألبوم صور ولحظات.
- ألعاب أولية.
- نقاط ومستوى وثروة.
- ملف شخصي.
- بناء APK تلقائي عبر GitHub Actions.

## بناء APK على GitHub

اقرأ الملف:

```text
GITHUB_APK_GUIDE_AR.md
```

## تشغيل محلي

```bash
flutter create --platforms=android --org com.yousefsandy --project-name yousef_sandy_moment .
flutter pub get
flutter run
```

## بناء محلي

```bash
flutter build apk --release
```

## المرحلة التالية

- Firebase Authentication.
- Firestore للدردشة والنقاط واللحظات.
- Firebase Storage للصور والفيديو.
- LiveKit أو Agora للصوت والفيديو.
- إشعارات ودعوات الغرفة.
