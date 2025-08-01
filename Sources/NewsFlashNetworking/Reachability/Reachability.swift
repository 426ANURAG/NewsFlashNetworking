//
//  File.swift
//  NewsFlashNetworking
//
//  Created by Anurag Sharma on 01/08/25.
//

import Foundation
import Network

public actor Reachability {
    public static let shared = Reachability()
    
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue(label: "ReachabilityMonitor")
    
    private var isMonitoring = false
    private var isConnected: Bool = false

    private var continuation: AsyncStream<Bool>.Continuation?

    private init() {}

    public func startMonitoring() {
        guard !isMonitoring else { return }
        isMonitoring = true
        
        monitor.pathUpdateHandler = { [weak self] path in
            let status = path.status == .satisfied
            Task {
                await self?.handlePathUpdate(status)
            }
        }
        monitor.start(queue: queue)
    }

    private func handlePathUpdate(_ status: Bool) {
        isConnected = status
        continuation?.yield(status)
    }

    public func statusStream() -> AsyncStream<Bool> {
        return AsyncStream { continuation in
            self.continuation = continuation
        }
    }

    public func currentStatus() -> Bool {
        return isConnected
    }
}
