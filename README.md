# Twice App
A two-screen Application, with a list-view and it corresponding details-view
Twice can serve as a generic two-screen-display app, for any API. (By swapping out the currently-used API URL with desired URL)

# Build-and-Run Instruction

1. Ensure you are using a Mac with macOS compatible with Xcode 16 or later.
2. Download and install Xcode 16 (or later) from the Mac App Store or Apple Developer website.
3. Ensure you are internet connected, as the file will fecth some dependecies remotely once opened
4. Open the `twice.xcodeproj` in Xcode.
5. Select the desired simulator or connected device from the Xcode toolbar.
6. Build the project by clicking the **Run** button (▶️) or using `Cmd + R`.
7. Wait for the build and installation to complete; the app should launch automatically in the selected simulator or device.


## Project Info
- Swift 5.0+
- iOS 15.0+
- Swift UI
- Xcode 16+


## Branches
- main


## Architecture
- MVVM (Model-View-ViewModel)  
   - Ensures separation of concerns for better maintainability and testability.
   - Views are built using **SwiftUI** and a custom view build in UIKit and bidge using the **UIViewRepresentable**

   
## Assets
- Systmen Assets: Images, Fonts, Colors


## Dependency Manager
- Swift Package Manager (SPM): Used for managing external dependencies.


## Dependency
1. **[Kingfisher](https://github.com/onevcat/Kingfisher)**  
   - Handles image downloading and caching.
   - Optimizes loading of images in the UI Kit Component.
   
   
## Packages(Local)
- twiceNetworking: Encapsulate the networking logic.


## Packages(Local) Dependency
1. **[Alamofire](https://github.com/Alamofire/Alamofire)**  
   - Used for handling network requests in a simple and elegant manner.
   - It simplifies making API calls to fetch real-time currency exchange rates.


## Links to Resources
- Demo Images/Video: [On Google Drive](https://drive.google.com/drive/folders/1BRyiT5xGTQ-3-d67dh6ytl1ydVXcwV31?usp=sharing)
