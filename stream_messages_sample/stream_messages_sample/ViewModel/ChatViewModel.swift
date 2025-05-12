//
//  ChatViewModel.swift
//  stream_messages_sample
//
//  Created by Raul_Alonzo on 12/05/25.
//

import Foundation
import Combine

class ChatViewModel: ObservableObject {
    @Published var messages: [Message] = []
    private var remoteUpdates = PassthroughSubject<Message,Never>()
    private var currentUpdates = CurrentValueSubject<Message?, Never>(nil)
    private var userUpdates = PassthroughSubject<Message, Never>()
    private var cancellables = Set<AnyCancellable>()
    private var count = 1
    var hasStarted = false

    func startStream() {
        guard !hasStarted else { return }
        remoteUpdates.sink { _ in }.store(in: &cancellables)
        userUpdates.sink { _ in }.store(in: &cancellables)
        currentUpdates
            .compactMap { $0 }
            .merge(with: remoteUpdates)
            .merge(with: userUpdates)
            .sink { [weak self] message in
                print("Adding message from updates")
                self?.messages.append(message)
            }
            .store(in: &cancellables)
        hasStarted = true
        Task {
           await loadFromNetwork()
        }
        print("Stream started")
    }

    func stopStream() {
        for cancellable in cancellables {
            cancellable.cancel()
        }
        print("Stream Stopped")
        hasStarted = false
    }

    private func loadFromNetwork() async {
        let stream = networkStream()
        for await res in stream {
            switch (res) {
            case .success(let message):
                remoteUpdates.send(message)
            case .failure:
                continue
            }
        }
    }

    private func networkStream() -> AsyncStream<Result<Message, Never>> {
        return AsyncStream { continuation in
            Task {
                while count <= 50 {
                    try await Task.sleep(nanoseconds: 2_000_000_000)
                    let message = Message(id: count, primaryText: "Primary -> \(count)", secondaryText: "Secondary")
                    continuation.yield(.success(message))
                    count += 1
                }
                continuation.finish()
            }
        }
    }
}

