# Protect your data models from being renamed (Obfuscation)
-keep class com.example.furni_mobile_app.product.data.** { *; }
-keep class com.example.furni_mobile_app.models.** { *; }

# Protect JSON parsing attributes
-keepattributes Signature, *Annotation*, InnerClasses
-keepclassmembers class * {
    @com.google.gson.annotations.SerializedName <fields>;
}