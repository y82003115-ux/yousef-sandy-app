# ربط التطبيق بالإنترنت

1. أنشئ مشروع Firebase.
2. أضف تطبيق Android بالمعرّف:
   com.yousef.sandy.moment
3. ضع google-services.json داخل android/app/
4. أضف Firebase Auth, Firestore, Storage, Messaging.
5. استخدم Agora أو LiveKit للصوت والفيديو.

مخطط المجموعات المقترح:
users/{uid}
rooms/{roomId}
rooms/{roomId}/messages/{messageId}
moments/{momentId}
gifts/{giftId}
transactions/{transactionId}
albums/{albumId}/items/{itemId}
