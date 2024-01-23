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
                ScrollView {
                    Image(imageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(LinearGradient(gradient: Gradient(colors: teamColors), startPoint: .leading, endPoint: .trailing), lineWidth: 20)
                        )

                    VStack(alignment: .leading, spacing: 10) {
                        Text("Player:")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text(playerName)
                            .font(.title)
                            .fontWeight(.bold)

                        Text("Style:")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text("Powerful forward with a knack for scoring goals.")
                            .font(.body)
                            .foregroundColor(.black)

                        Text("Stats:")
                            .font(.headline)
                            .foregroundColor(.gray)
                        Text(stats)
                            .font(.body)
                            .foregroundColor(.black)

                        Text("Achievements:")
                            .font(.headline)
                            .foregroundColor(.gray)

                        ForEach(achievements, id: \.title) { achievement in
                            Text("\(achievement.title): \(achievement.description)")
                                .foregroundColor(.gray)
                        }

                        // Add additional content if needed
                    }
                    .padding()
                }
            } else {
                Text(playerName)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .fill(LinearGradient(gradient: Gradient(colors: teamColors), startPoint: .leading, endPoint: .trailing))
                            .frame(height: 200)
                    )
                    .cornerRadius(10)
                    .shadow(radius: 5)
            }
        }
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
    @State private var showWelcomeText = true

    var body: some View {
        NavigationView {
            VStack {
                if showWelcomeText {
                    Text("Welcome to Hockey Stars")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                        .onTapGesture {
                            withAnimation {
                                showWelcomeText.toggle()
                            }
                        }
                }

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
            .navigationTitle("Hockey Stars")
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

