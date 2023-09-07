//
//  BucketViewModel.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 6.09.2023.
//

import SwiftUI
import Combine
import Foundation



struct BucketItem: Identifiable {
    var id = UUID()
    var name: String
    var isToggled: Bool
}

class BucketViewModel: ObservableObject {
    @Published var bucket: [BucketItem] = []
    
    func addItem(_ item: String) {
        bucket.append(BucketItem(name: item, isToggled: false))
    }
    
    func removeItem(_ item: String) {
        bucket.removeAll { $0.name == item }
    }
    
    func containsItem(_ item: String) -> Bool {
        return bucket.contains { $0.name == item }
    }
    
    func toggleItem(_ item: String) {
        if let index = bucket.firstIndex(where: { $0.name == item }) {
            bucket[index].isToggled.toggle()
        }
    }
}

