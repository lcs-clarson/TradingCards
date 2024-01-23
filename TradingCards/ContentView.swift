import SwiftUI

struct Achievement {
    var title: String
    var description: String
}

struct HockeyCard: View {
    var playerName: String
    var imageName: String
    var teamColors: [Color]
    var stats: String
    var achievements: [Achievement]
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
                            .stroke(LinearGradient(gradient: Gradient(colors: teamColors), startPoint: .leading, endPoint: .trailing), lineWidth: 20)
                    )

                Text(playerName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()

                Text("Stats: \(stats)")
                    .font(.subheadline)
                    .foregroundColor(.gray)

                VStack(alignment: .leading) {
                    Text("Achievements:")
                        .font(.headline)
                        .padding(.top, 4)

                    ForEach(achievements, id: \.title) { achievement in
                        Text("\(achievement.title): \(achievement.description)")
                            .foregroundColor(.gray)
                            .padding(.leading, 10)
                    }
                }
            } else {
                Text(playerName)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding()
                    .foregroundColor(Color.white) // Set initial text color

            }
        }
        .padding()
        .onTapGesture {
            withAnimation {
                showDetails.toggle()
            }
        }
        .background(
            ZStack {
                if !showDetails {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(LinearGradient(gradient: Gradient(colors: teamColors), startPoint: .leading, endPoint: .trailing))
                        .frame(height: 200)
                }
            }
        )
        .cornerRadius(10)
    }
}

struct PlayerDetailView: View {
    var playerName: String
    var imageName: String
    var teamColors: [Color]
    var stats: String
    var achievements: [Achievement]

    var body: some View {
        VStack {
            HockeyCard(playerName: playerName, imageName: imageName, teamColors: teamColors, stats: stats, achievements: achievements)
        }
        .navigationTitle(playerName)
        .font(.title)
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: PlayerDetailView(playerName: "Alex Ovechkin", imageName: "Image", teamColors: [.red, .white], stats: "Goals: 700, Assists: 500", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "5")])) {
                    HockeyCard(playerName: "Alex Ovechkin", imageName: "Image", teamColors: [.red, .white], stats: "Goals: 700, Assists: 500", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "5")])
                }

                NavigationLink(destination: PlayerDetailView(playerName: "Sidney Crosby", imageName: "Image 2", teamColors: [.black, .yellow], stats: "Goals: 450, Assists: 600", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "4")])) {
                    HockeyCard(playerName: "Sidney Crosby", imageName: "Image 2", teamColors: [.black, .yellow], stats: "Goals: 450, Assists: 600", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "4")])
                }

                NavigationLink(destination: PlayerDetailView(playerName: "Connor McDavid", imageName: "Image 1", teamColors: [.blue, .orange], stats: "Goals: 300, Assists: 400", achievements: [Achievement(title: "Art Ross Trophies", description: "2"), Achievement(title: "Hart Trophies", description: "1")])) {
                    HockeyCard(playerName: "Connor McDavid", imageName: "Image 1", teamColors: [.blue, .orange], stats: "Goals: 300, Assists: 400", achievements: [Achievement(title: "Art Ross Trophies", description: "2"), Achievement(title: "Hart Trophies", description: "1")])
                }
            }
            .navigationTitle("Hockey Cards")
            .font(.title)
            .foregroundColor(.black)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

