# NewsFlashNetworking

A modular networking package for Swift that supports environments, async/await, and is SPM-compatible.

## Features
- 🔄 Async/await-based networking
- 🔧 Environment support (dev, staging, prod)
- ✅ Unit testable with mock sessions
- ♻️ Designed for VIPER/Clean Architecture

## 📦 Installation

### Swift Package Manager (SPM)

1. Open your Xcode project
2. Go to **File > Add Packages**
3. Paste this repo URL:

https://github.com/YOUR_USERNAME/NewsFlashNetworking.git

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
