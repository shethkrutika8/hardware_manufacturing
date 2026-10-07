# Assets Directory

This folder contains all non-code files and static media used across the Flutter application.

## Directory Structure

### images/
Static visual media used in your app UI.
- Supported formats: `.png`, `.jpg`, `.jpeg`, `.webp`

### icons/
Scalable vector graphics that remain crisp regardless of screen density.
- Supported formats: `.svg`

### fonts/
Typography files to apply custom text styles throughout the application.
- Supported formats: `.ttf`, `.otf`

### audio/
Media assets used for background sounds, notifications, or audio clips.
- Supported formats: `.mp3`, `.wav`

### video/
Video assets used in the application.
- Supported formats: `.mp4`

### data/
Static data files used locally within the app (e.g., country lists, mock API responses, or app settings).
- Supported formats: `.json`, `.xml`, `.yaml`

### animations/
Vector and interactive animation assets.
- Supported formats: `.json` (Lottie), `.riv` / `.flr` (Rive)

## Usage

All asset directories are already configured in `pubspec.yaml`. When adding new files to these directories, they will be automatically available in your Flutter app.

To use assets in your Flutter code:
```dart
// Images
Image.asset('assets/images/your_image.png')

// Icons (with flutter_svg package)
SvgPicture.asset('assets/icons/your_icon.svg')

// Audio (with audioplayers package)
AudioPlayer().play(AssetSource('audio/your_audio.mp3'))
```
