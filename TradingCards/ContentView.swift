import SwiftUI

struct HockeyCard: View {
    var playerName: String
    var imageName: String
    var teamColors: [Color] // An array of two colors for the border
    var stats: String
    @State private var showDetails = false

    var body: some View {
        VStack {
            if showDetails {
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 200)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(LinearGradient(gradient: Gradient(colors: teamColors), startPoint: .leading, endPoint: .trailing), lineWidth: 20) // Adjust the lineWidth for a thicker border
                    )

                Text(playerName)
                    .font(.headline)
                    .padding()

                Text("Stats: \(stats)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            } else {
                Text(playerName)
                    .font(.headline)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            showDetails.toggle()
                        }
                    }
            }
        }
        .padding()
        .onTapGesture {
            withAnimation {
                showDetails.toggle()
            }
        }
    }
}

struct PlayerDetailView: View {
    var playerName: String
    var imageName: String
    var teamColors: [Color]
    var stats: String

    var body: some View {
        VStack {
            HockeyCard(playerName: playerName, imageName: imageName, teamColors: teamColors, stats: stats)
        }
        .navigationTitle(playerName)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: PlayerDetailView(playerName: "Alex Ovechkin", imageName: "Image", teamColors: [.red, .white], stats: "Goals: 700, Assists: 500")) {
                    HockeyCard(playerName: "Alex Ovechkin", imageName: "Image", teamColors: [.red, .white], stats: "Goals: 700, Assists: 500")
                }

                NavigationLink(destination: PlayerDetailView(playerName: "Sidney Crosby", imageName: "Image 2", teamColors: [.black, .yellow], stats: "Goals: 450, Assists: 600")) {
                    HockeyCard(playerName: "Sidney Crosby", imageName: "Image 2", teamColors: [.black, .yellow], stats: "Goals: 450, Assists: 600")
                }

                NavigationLink(destination: PlayerDetailView(playerName: "Connor McDavid", imageName: "Image 1", teamColors: [.blue, .orange], stats: "Goals: 300, Assists: 400")) {
                    HockeyCard(playerName: "Connor McDavid", imageName: "Image 1", teamColors: [.blue, .orange], stats: "Goals: 300, Assists: 400")
                }
            }
            .navigationTitle("Hockey Cards")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

