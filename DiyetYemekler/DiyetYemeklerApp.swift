//
//  DiyetYemeklerApp.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 4.09.2023.
//

import SwiftUI
import Combine

@main
struct DiyetYemekler: App {
    @StateObject var bucketViewModel = BucketViewModel()
    @StateObject var favoriteViewModel = FavoriteViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(bucketViewModel)
                .environmentObject(favoriteViewModel)
        }
    }
}

struct RootView: View {
    @State private var isActive = false
    
    var body: some View {
        Group {
            if isActive {
                ContentView()
            } else {
                SplashScreenView(isActive: $isActive)
            }
        }
    }
}

struct SplashScreenView: View {
    @Binding var isActive: Bool
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        VStack {
            VStack {
                Image("SplashScreen") 
                    .resizable()
                    .frame(height: 480)
            }
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                withAnimation(.easeIn(duration: 1.6)) {
                    self.size = 0.9
                    self.opacity = 1.0
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {  
                self.isActive = true
            }
        }
    }
}

