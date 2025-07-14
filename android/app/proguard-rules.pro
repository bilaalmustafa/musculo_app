# Keep Flutter classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugins.** { *; }
-keep class io.flutter.embedding.** { *; }

# Keep Firebase
-keep class com.google.firebase.** { *; }
-keep class com.google.** { *; }
-dontwarn com.google.**

# Keep Gson (if you use JSON parsing)
-keep class com.google.gson.** { *; }
-keepattributes Signature
-keepattributes *Annotation*

# Keep ExoPlayer / video_player if used
-keep class com.google.android.exoplayer2.** { *; }

# Keep Facebook SDK
-keep class com.facebook.** { *; }
-dontwarn com.facebook.**

# Keep your model classes (important!)
-keep class com.example.musculo_app.model.** { *; }

# Keep any annotations that could break reflection
-keepattributes *Annotation*
# Stripe SDK
-keep class com.stripe.android.** { *; }
-keep class com.reactnativestripesdk.** { *; }
-dontwarn com.stripe.android.**
-dontwarn com.reactnativestripesdk.**

# Push Provisioning specific
-keep class com.reactnativestripesdk.pushprovisioning.** { *; }
-keep interface com.reactnativestripesdk.pushprovisioning.EphemeralKeyProvider { *; }