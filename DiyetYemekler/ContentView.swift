//
//  ContentView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 4.09.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var bucketViewModel: BucketViewModel
    
    @State private var selectedTab = 0 {
        didSet {
            print("selectedTab changed to \(selectedTab)")
        }
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "fork.knife")
                        Text("Ana Sayfa")
                    }
                   
                }
                

            BucketView(bucketViewModel: bucketViewModel)
                .tabItem {
                    VStack {
                        Image(systemName: "cart")
                        Text("Alışveriş Listesi")
                    }
                   
                }
               
            
            FavoriView()
                .tabItem {
                    VStack {
                        Image(systemName: "heart.fill")
                        Text("Favoriler")
                    }
                   
                }
                
            
            SettingsView()
                .tabItem {
                    VStack {
                        Image(systemName: "i.circle")
                        Text("Ayarlar")
                    }
                    
                }
               
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(BucketViewModel())
    }
}


