# Flutter Handoff

This plugin makes it easy to use [Apple's Handoff feature](https://support.apple.com/en-us/102426) in your Flutter applications.

Currently, it supports opening links from your application on other iCloud connected devices (Macs, iPads, iPhones).

## How to use?

After installing the plugin, you can just call the `setHandoffUrl` where appropriate
(probably after navigation to some page):

```dart
import 'package:handoff/handoff.dart';

void someFunction() async {
    await Handoff.setHandoffUrl(
        "https://example.com/some/path",
        title: "Some Title",
    );
}
```

and the system will take care of the rest.

On you connected devices, you will see the link in the Dock

![macOS dock with handoff icon](_docs/dock.webp)

or App Switcher

![iOS App Switcher with handoff icon](_docs/app_switcher.webp)

To hide the handoff icon, you can call `Handoff.clearHandoff()`.

## Automatic Handoff with Route Navigation

For even easier use, you can use `HandoffPageRoute` which automatically sets the handoff URL when the route is entered and clears it when the route is exited:

```dart
import 'package:handoff/handoff.dart';

void navigateToPage() {
  Navigator.of(context).push(
    HandoffPageRoute<void>(
      handoffUrl: "https://example.com/some/path",
      handoffTitle: "Some Title", // Optional
      builder: (context) => MyPageWidget(),
    ),
  );
}
```

This eliminates the need to manually call `setHandoffUrl()` and `clearHandoff()` - the route handles it automatically!

## Available methods

| Method                                       | Description                                                  |
| -------------------------------------------- | ------------------------------------------------------------ |
| `setHandoffUrl(String url, {String? title})` | Sets a handoff URL using a string URL with an optional title |
| `setHandoffUri(Uri uri, {String? title})`    | Sets a handoff URL using a Uri object with an optional title |
| `clearHandoff()`                             | Clears the current handoff activity                          |

## Available classes

| Class                     | Description                                                                                         |
| ------------------------- | --------------------------------------------------------------------------------------------------- |
| `HandoffPageRoute<T>`     | A MaterialPageRoute subclass that automatically manages handoff URLs on route enter/exit          |

## Development

### Automated Publishing

This package uses automated publishing to pub.dev. When a new tag is pushed to the main branch (in the format `vX.Y.Z`), a GitHub Action will:

1. Run tests and validation
2. Extract the version from the tag
3. Parse the corresponding entry from CHANGELOG.md  
4. Create a GitHub release with the changelog notes
5. Publish the package to pub.dev

To release a new version:
1. Update the version in `pubspec.yaml`
2. Add an entry to `CHANGELOG.md` with the same version number
3. Commit the changes to main
4. Create and push a tag: `git tag v1.0.0 && git push origin v1.0.0`

The publishing process requires the `PUB_TOKEN` secret to be configured in the repository settings.
