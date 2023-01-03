//
//  ScrumStore.swift
//  Scrumdinger
//
//  Created by Huy Bui on 2023-01-02.
//

import Foundation
import SwiftUI

class ScrumStore: ObservableObject { // ObservableObject: class-constrained protocol for connecting external model data to SwiftUI views.
    @Published var scrums: [DailyScrum] = []
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                    in: .userDomainMask,
                                    appropriateFor: nil,
                                    create: false)
            .appendingPathComponent("scrums.data")
    }
    
    // Async interface for legacy load method.
    static func load() async throws -> [DailyScrum] {
        try await withCheckedThrowingContinuation { // Suspend load function, then pass continuation to closure.
            continuation in // continuation: value that represent code after an awaited function.
            load { result in
                // Must call continuation's resume() exactly once on every possible execution path.
                switch result {
                case .success(let scrums):
                    continuation.resume(returning: scrums) // Resume the task awaiting continuation by having it return normally from its suspension point.
                case .failure(let error):
                    continuation.resume(throwing: error) // Resume the task awaiting continuation by having it throw an error from its suspension point.
                }
            }
        }
    }
    
    // Legacy load method.
    static func load(
        completion: @escaping (Result<[DailyScrum], Error>) -> Void // Result will be an array of scrums (success) or an error (failure).
    ) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    // Unable to open file handle (might be first app launch and scrums.data doesn't exist) -> call completion with empty array.
                    DispatchQueue.main.async {
                        completion(
                            .success([])
                        )
                    }
                    return
                }
                
                let dailyScrums = try JSONDecoder().decode([DailyScrum].self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(
                        .success(dailyScrums)
                    )
                }
            } catch {
                DispatchQueue.main.async {
                    completion(
                        .failure(error)
                    )
                }
            }
        }
    }
    
    // Async interface for legacy save method.
    static func save(scrums: [DailyScrum]) async throws -> Int {
        try await withCheckedThrowingContinuation({ continuation in
            save(scrums: scrums) { result in
                switch result {
                case .success(let numberOfScrumsSaved):
                    continuation.resume(returning: numberOfScrumsSaved)
                case .failure(let error):
                    continuation.resume(throwing: error)
                }
            }
        })
    }
    
    // Legacy save method.
    static func save(
        scrums: [DailyScrum],
        completion: @escaping (Result<Int, Error>) -> Void // Result will be the number of saved scrums (success) or an error (failure).
    ) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(scrums)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(
                        .success(scrums.count)
                    )
                }
            } catch {
                DispatchQueue.main.async {
                    completion(
                        .failure(error)
                    )
                }
            }
        }
    }
}
