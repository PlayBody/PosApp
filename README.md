# staff_pos_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


```bash
keytool -genkey -v -keystore pos_app.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias my-key-alias
keytool -importkeystore -srckeystore pos_app.keystore -destkeystore pos_app.p12 -deststoretype PKCS12 -srcalias my-key-alias
openssl pkcs12 -in pos_app.p12 -out pos_app.pem -nodes
```