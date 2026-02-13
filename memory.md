# Teakworld Mobile App - Project Memory and Context

## Project Overview
**Teakworld** is a Flutter-based mobile application for an e-commerce furniture store. It is a fork of the "Furni" project, rebranded and customized for Teakworld.

## Environment & Setup
- **OS**: Windows
- **Framework**: Flutter
- **Language**: Dart
- **Java Home**: `C:\Users\zubai\develop\java-1.8.0-openjdk-1.8.0.392-1.b08.redhat.windows.x86_64`
- **Android SDK**: `C:\Users\zubai\AppData\Local\Android\Sdk` (API Level 34 installed, NDK 28.2)
- **Emulator**: `Medium_Phone_API_36.1` (Android 16)

## Backend / Data Source
- **CMS**: Strapi
- **URL**: `http://159.65.15.249:1337`
- **API Endpoint**: `/api/hero-section` (and others)
- **Note**: Hero banner text and images are dynamic and managed via this CMS.

## Key Changes Implemented

### 1. Rebranding (Furni -> Teakworld)
-   **Colors**: Updated primary color to Teal (`Color.fromRGBO(1, 100, 109, 1)`).
-   **Logos**:
    -   App Icon: `assets/images/icon tw2.png` (via `flutter_launcher_icons`).
    -   Splash Screen: `assets/images/teakworld.mu-0.svg`.
    -   Login/Signup: `assets/images/teakworld.mu-0.svg`.
    -   Home Header: `assets/images/teakworld.mu-0.svg`.
-   **Text**: Updated "Furni" references to "Teakworld".

### 2. UI/UX Adjustments
-   **Splash Screen**: Full-screen Teal background, centered logo, white login/teal-text buttons.
-   **Login/Signup**: Adjusted logo position (top padding 30, height 30) for better spacing.
-   **Home Page**:
    -   Disabled "Category" section.
    -   Disabled "More Products" button.
    -   Updated Header background and logo.
-   **Product Page**:
    -   Disabled "Breadcrumb/Navigation".
    -   Review section commented out.
    -   Implemented `Stack` layout with `GlassFloatingNavBar`.
-   **Headers**: Consistent Teal background across Profile, Shop, Cart, and Contact pages.

### 3. Android Deployment
-   **Toolchain**: Fixed missing Android SDK, NDK, and Build-Tools issues. Accepted licenses.
-   **Build**: Successfully built `app-release.apk`.
-   **Distribution**: Deployed to **TestApp.io**.
    -   **App ID**: `Jn26bkO2xB`
    -   **Release**: `v1.0.0 (1+)`
    -   **CLI Tool**: `ta-cli.exe` (installed in project root).

## Deployment Workflow (TestApp.io)
To deploy a new update:
1.  **Build Release APK**:
    ```powershell
    flutter build apk --release
    ```
2.  **Publish via CLI**:
    ```powershell
    .\ta-cli.exe publish --api_token=[YOUR_TOKEN] --app_id=Jn26bkO2xB --release=android --apk=build/app/outputs/flutter-apk/app-release.apk --notify=true
    ```

## Known Issues / TODOs
-   **Public Link**: Public install links must be enabled manually in the TestApp.io dashboard.
-   **Icons**: Ensure `assets/images/icon tw2.png` is preserved or finalized.

## Important Contacts/Resources
-   **TestApp.io Portal**: https://portal.testapp.io/app/Jn26bkO2xB/releases
