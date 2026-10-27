# iOS Mini Projects

This workspace contains a set of small, focused iOS sample projects demonstrating common patterns and features.

Projects

- `infinity_scroll_feed_sample` — Example feed with infinite scrolling and presenter/repository separation.
- `local_persistence_form_sample` — Form UI with local persistence (Core Data model included).
- `stream_messages_sample` — Simple messaging/streaming UI demonstrating live updates and view model usage.

Prerequisites

- macOS with Xcode installed (use the latest stable Xcode for best compatibility).
- A recent iOS Simulator device or a physical iOS device for running the apps.

Quick start (per sample)

1. Open the project in Xcode. You can open the project file or workspace located inside each sample folder, for example:
   - Open `infinity_scroll_feed_sample/infinity_scroll_feed_sample.xcodeproj` or the workspace if present.

2. Select the target (app) and a simulator/device, then Build & Run (Cmd+R).

3. To run unit or UI tests: Product → Test (or Cmd+U) in Xcode, or run `xcodebuild test` with the appropriate project/scheme/destination.

Repository structure

- `infinity_scroll_feed_sample/` — feed sample app; main app code under `Controller`, `Core`, `Presenter`, `Data`.
- `local_persistence_form_sample/` — form persistence sample; includes a `.xcdatamodeld` Core Data model.
- `stream_messages_sample/` — streaming/messages sample; includes simple ViewModel and Controller structure.

Project details

1. infinity_scroll_feed_sample

- Purpose: Demonstrates an infinite-scrolling feed with simulated pagination and a clean separation between view, presenter, and repository.
- UI: Built in code using UIKit (no Storyboards).
- Key files / classes:
  - `Controller/ViewController.swift` — main `ViewController` that builds the header and `UITableView` in code, implements data prefetching, shows a loading cell, and applies incremental updates when new pages load.
  - `Presenter/FeedPresenter.swift` — `FeedPresenter` responsible for requesting pages from the repository and forwarding payloads to the view.
  - `Core/PayloadProtocol.swift`, `Core/RepositoryProtocol.swift`, `Core/ViewDataProtocol.swift` — small protocols used to decouple layers.
  - `Data/Repositiory/FeedRepository.swift` — `FeedRepository` simulates a paginated network using `Task.sleep(...)` and returns `FeedPayload` objects.
  - `AppDelegate.swift` / `SceneDelegate.swift` — standard entry points (no special storage/background work here).

2. local_persistence_form_sample

- Purpose: Shows a simple form that persists user records locally using Core Data, including a background task handler for periodic cleaning.
- UI: Built in code using UIKit (no Storyboards).
- Key files / classes:
  - `Controller/FormViewController.swift` — `FormViewController` builds the form UI in code, validates inputs, and calls into the repository to store users asynchronously. It also updates UI state for submitting/loading and displays success/error messages.
  - `Core/CoreDataStack.swift` — `CoreDataStack` singleton that configures the `NSPersistentContainer`, provides helper contexts, save/delete/fetch helpers, and stores `lastCleaned` metadata in `UserDefaults`.
  - `Data/UserRepository.swift` — `UserRepository` wrapper around `CoreDataStack` that exposes `storeUser(user:)` and returns typed `Result` values.
  - `AppDelegate.swift` — registers a `BGTaskScheduler` handler (`cleanHandlerIdentifier`) and exposes `scheduleDatabaseCleaning()` and `handleDatabaseCleaning(with:)` which fetch old users and delete them using the `CoreDataStack`. Also provides `saveContext()` helper calling `CoreDataStack`.
  - `local_persistence_form_sample.xcdatamodeld` — Core Data model that defines `UserEntity` used by the stack.

3. stream_messages_sample

- Purpose: Simulates a message stream (remote + user-sent messages) using Combine and async streams, showing how to append updates to a table view as messages arrive.
- UI: Built in code using UIKit (no Storyboards).
- Key files / classes:
  - `Controller/ViewController.swift` — `ViewController` builds UI in code, subscribes to the view model's published `messages` with Combine (`AnyCancellable`), inserts new rows and scrolls to the bottom when messages arrive, and provides a `Send` button to inject local messages.
  - `ViewModel/ChatViewModel.swift` — `ChatViewModel` is an `ObservableObject` that composes `PassthroughSubject`/`CurrentValueSubject` publishers and exposes `@Published var messages: [Message]`. It simulates a network source via `AsyncStream` and merges remote and local updates.
  - `Data/Model/Message.swift` — small `Message` struct used by the view model and view controller.
  - `AppDelegate.swift` / `SceneDelegate.swift` — standard entry points (no special background tasks here).

Notes

- All three samples use programmatic UIKit for their UI (no storyboard UI is required). This is intentional so you can see layout and view construction in code.
- The `local_persistence_form_sample` demonstrates background processing and Core Data usage; inspect `CoreDataStack.swift` and `AppDelegate.swift` for scheduling and cleaning logic.

How to run

1. Open a sample in Xcode, e.g. [infinity_scroll_feed_sample](infinity_scroll_feed_sample/infinity_scroll_feed_sample.xcodeproj).
2. Select the app target and a simulator or device, then Build & Run (Cmd+R).
3. To run tests for a sample, open its test target and run Product → Test (Cmd+U), or use `xcodebuild test` with the appropriate scheme and destination.

License

This repository is provided for educational purposes. Add a license file if you intend to change distribution terms.

Notes

- These are small samples intended for learning and experimentation. They are not production apps.
- Dependency managers: these samples do not require CocoaPods or Swift Package Manager by default — open the project files and inspect for any package integrations.
