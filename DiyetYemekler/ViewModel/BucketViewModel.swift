//
//  BucketViewModel.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 6.09.2023.
//

import SwiftUI
import Combine

class BucketViewModel: ObservableObject {
    @Published var bucket: [BucketItem] = [] {
        didSet {
            if let encoded = try? JSONEncoder().encode(bucket) {
                UserDefaults.standard.set(encoded, forKey: "BucketItems")
            }
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "BucketItems"),
           let decoded = try? JSONDecoder().decode([BucketItem].self, from: data) {
            self.bucket = decoded
        } else {
            self.bucket = []
        }
    }

    func addItem(_ item: String) {
        bucket.append(BucketItem(name: item, isToggled: false))
    }

    func removeItem(_ item: String) {
        bucket.removeAll { $0.name == item }
    }

    func containsItem(_ item: String) -> Bool {
        return bucket.contains { $0.name == item }
    }
    
}



