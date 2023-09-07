//
//  BucketView.swift
//  DiyetYemekler
//
//  Created by yasarkilic on 4.09.2023.
//
import SwiftUI
import Combine
import Foundation

struct BucketItem: Identifiable, Codable {
    let id = UUID()
    var name: String
    var isToggled: Bool
}



struct BucketView: View {
    @ObservedObject var bucketViewModel: BucketViewModel

    var body: some View {
        ZStack {
            Color.white.edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Text("Alışveriş Sepeti")
                        .font(.largeTitle)
                        .padding(.top, 25)
                        .padding(.leading, 10)
                        .fontWeight(.bold)
                    Spacer()
                }

                Spacer()

                if bucketViewModel.bucket.isEmpty {
                    VStack {
                        Image("carts")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 250)
                        Text("Sepetiniz Boş")
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                } else {
                    List {
                        ForEach(bucketViewModel.bucket.indices, id: \.self) { index in
                            HStack {
                                ZStack {
                                    Image(systemName: "circle")
                                        .resizable()
                                        .frame(width: 29, height: 29)
                                        .foregroundColor(.gray)
                                    if bucketViewModel.bucket[index].isToggled {
                                        Image(systemName: "checkmark")
                                            .foregroundColor(.green)
                                    }
                                }
                                .onTapGesture {
                                    bucketViewModel.bucket[index].isToggled.toggle()
                                }

                                Text(bucketViewModel.bucket[index].name)

                                Spacer()

                                Button("Sil") {
                                    withAnimation {
                                        var tempBucket = bucketViewModel.bucket
                                        tempBucket.remove(at: index)
                                        bucketViewModel.bucket = tempBucket
                                    }
                                }
                                .foregroundColor(.red)
                            }
                        }
                    }

                    // Profesyonel Tasarımıyla Yeni Buton
                    if bucketViewModel.bucket.contains(where: { $0.isToggled }) {
                        Button("Seçili Öğeleri Sil") {
                            withAnimation {
                                bucketViewModel.bucket.removeAll { $0.isToggled }
                            }
                        }
                        .padding(.vertical, 16)
                        .padding(.horizontal, 24)
                        .background(
                            Capsule()
                                .fill(Color.red)
                        )
                        .foregroundColor(.white)
                        .font(.headline)
                        .shadow(radius: 5)
                        .scaleEffect(1)
                        .transition(.scale)
                        .animation(.easeIn(duration: 0.5))
                        .padding([.leading, .trailing])
                    }
                }

                Spacer()
            }
        }
    }
}

struct BucketView_Previews: PreviewProvider {
    static var previews: some View {
        BucketView(bucketViewModel: BucketViewModel())
    }
}

