//
//  ContentView.swift
//  TradingCards
//
//  Created by Charlie Larson on 2024-01-18.
//

import SwiftUI

struct HockeyCard: View {
    var playerName: String
    var imageName: String

    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200) // Set the height of the image, adjusting the width accordingly

            Text(playerName)
                .font(.headline)
                .padding()
        }
        .border(Color.gray, width: 1)
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            HockeyCard(playerName: "Alex Ovechkin", imageName: "Image")
            HockeyCard(playerName: "Sidney Crosby", imageName: "Image 2")
            HockeyCard(playerName: "Connor Mcdavid", imageName: "Image 1")
        }
    }
}

#Preview {
    ContentView()
}
