# CCITBook — Flutter Social Media Replication
Compiled project covering Activity 1, Activity 2, Activity 3, and Lab Activity 4.

## Folder structure
```
lib/
  screens/
    home_screen.dart
    newsfeed_screen.dart
    notification_screen.dart
    profile_screen.dart
    detail_screen.dart
  widgets/
    custom_font.dart
    custom_button.dart
    post_card.dart        (renamed from newsfeed_card, per Activity 3)
    notification.dart
  constants.dart
  models.dart
  main.dart
pubspec.yaml
```

## Enhancements implemented
**Activity 1:** image placeholder widget, avatar for profile image, widget-based like/comment/share buttons.
**Activity 2:** 8 sample posts / 14 sample notifications, dynamic AppBar title, extra BottomNavigationBarItems, custom app name ("CCITBook"), custom color palette in `constants.dart`.
**Activity 3:** custom profile name, custom follower/following counts, reused `post_card.dart` for wall posts, About tab, Photos tab built with `GridView`.
**Lab Activity 4:** `PostCard` and `NotificationTile` are clickable and open `DetailScreen`; notification/profile icons fall back to a person icon when no image is set; like count on `DetailScreen` increments on tap.

---

## Step-by-step setup in VS Code

### 1. Install prerequisites
- Install the [Flutter SDK](https://docs.flutter.dev/get-started/install) and add it to your PATH.
- Install [VS Code](https://code.visualstudio.com/).
- In VS Code, go to **Extensions** (`Ctrl+Shift+X`) and install:
  - **Flutter** (this pulls in the Dart extension automatically)

### 2. Verify your Flutter install
Open a terminal (VS Code: `` Ctrl+` ``) and run:
```bash
flutter doctor
```
Resolve any red ❌ items it reports (Android SDK, licenses, etc.) before continuing.

### 3. Get the project into VS Code
- Unzip the provided `facebook_replication.zip` anywhere on your machine.
- In VS Code: **File → Open Folder…** → select the unzipped `facebook_replication` folder.

### 4. Install dependencies
In the VS Code terminal, inside the project folder, run:
```bash
flutter pub get
```
This downloads `flutter_screenutil` and the other dependencies listed in `pubspec.yaml`.

### 5. Pick a device
- Click the device selector in the bottom-right status bar of VS Code (or run `flutter devices` in the terminal).
- Options: an already-running Android emulator, an iOS simulator (Mac only), a connected phone, or **Chrome** (works out of the box, fastest for previewing UI).

### 6. Run the app
- Press `F5`, or
- Open the Command Palette (`Ctrl+Shift+P`) → **Flutter: Launch Emulator** (if you need to start one) → then `F5`, or
- From the terminal: `flutter run`

### 7. Hot reload while editing
While the app is running, save any `.dart` file and VS Code will hot-reload automatically (or press `r` in the terminal, `R` for a full hot restart).

### 8. What to expect on first run
- **Home tab:** scrollable newsfeed of 8 posts (tap any post → opens Detail screen).
- **Notifications tab:** scrollable list of 14 notifications (tap any → opens Detail screen).
- **Profile tab:** profile header, Posts/About/Photos tabs.
- **Detail screen:** tap the Like button — the number increments.
