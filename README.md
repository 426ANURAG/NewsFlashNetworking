# NewsFlashNetworking

A modular networking package for Swift that supports environments, async/await, and is SPM-compatible.

## Features
- 🔄 Async/await-based networking
- 🔧 Environment support (dev, staging, prod)
- ✅ Unit testable with mock sessions
- ♻️ Designed for VIPER/Clean Architecture
- 🔌 Built-in Reachability support using Swift Concurrency (`actor`, `AsyncStream`)

## 📦 Installation

### Swift Package Manager (SPM)

1. Open your Xcode project
2. Go to **File > Add Packages**
3. Paste this repo URL:

https://github.com/426ANURAG/NewsFlashNetworking.git

4. Select the version (e.g., `1.0.0`) and add the package to your target.

---

## 🚀 Usage

```swift
let shared = await NFNetworkManager.shared
let request = Networkrequest(endpoint: .getNews(section: .allSections, period: "7"))

let result: Result<NewsListEntity, NetworkError> = await shared.request(requestData: request)

switch result {
case .success(let data):
    print(data)
case .failure(let error):
    print(error)
}
```
---

## 🔌 Reachability Support

The package includes an `actor`-based Reachability utility that detects internet connectivity in real time using `NWPathMonitor`.

### ✅ Start Monitoring

Start it once when your app launches:

```swift
Task {
    await Reachability.shared.startMonitoring()
}
```

🔁 Listen for Network Changes
No closures needed — use AsyncStream:

```swift
Task {
    for await isConnected in await Reachability.shared.statusStream() {
        print("Network is \(isConnected ? "Connected" : "Disconnected")")
    }
}
```

📶 Check Current Status
```swift
let online = await Reachability.shared.currentStatus()
```

🧪 Unit Testing
NetworkManager is initialized with a mockable URLSession for testing API logic.

🛠 Requirements
iOS 13+

Swift 5.7+

Xcode 14+

🧾 License
MIT License. See LICENSE for details.
