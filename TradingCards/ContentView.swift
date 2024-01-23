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
    @Binding var selectedPlayer: String?

    func playerFacts(playerName: String) -> String {
        switch playerName {
        case "Alex Ovechkin":
            return "Alex Ovechkin, also known as 'The Great Eight,' is a Russian professional ice hockey winger. He is widely considered one of the greatest goal-scorers in the history of the NHL."
        case "Sidney Crosby":
            return "Sidney Crosby, the 'Kid' from Cole Harbour, is a Canadian professional ice hockey center. He is known for his exceptional playmaking and leadership on and off the ice."
        case "Connor McDavid":
            return "Connor McDavid, often called 'McJesus,' is a Canadian professional ice hockey center and captain of the Edmonton Oilers. He is known for his incredible speed and skill."
        default:
            return ""
        }
    }

    var body: some View {
        VStack {
            if selectedPlayer == playerName {
                ScrollView {
                    VStack {
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
                        }
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(LinearGradient(gradient: Gradient(colors: teamColors), startPoint: .leading, endPoint: .trailing))
                                .frame(height: 200)
                        )
                        .cornerRadius(10)
                        .shadow(radius: 5)
                        .onTapGesture {
                            withAnimation {
                                selectedPlayer = nil
                            }
                        }
                    }

                    Text(playerFacts(playerName: playerName))
                        .foregroundColor(.black)
                        .padding()
                        .transition(.opacity)
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
                    .onTapGesture {
                        withAnimation {
                            selectedPlayer = playerName
                        }
                    }
            }
        }
        .padding()
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
            HockeyCard(playerName: playerName, imageName: imageName, teamColors: teamColors, stats: stats, achievements: achievements, selectedPlayer: .constant(playerName))
        }
        .navigationTitle(playerName)
        .font(.title)
    }
}

struct ContentView: View {
    @State private var selectedPlayer: String?

    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(destination: PlayerDetailView(playerName: "Alex Ovechkin", imageName: "Image", teamColors: [.red, .white], stats: "Goals: 700, Assists: 500", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "5")])) {
                    HockeyCard(playerName: "Alex Ovechkin", imageName: "Image", teamColors: [.red, .white], stats: "Goals: 700, Assists: 500", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "5")], selectedPlayer: $selectedPlayer)
                }

                NavigationLink(destination: PlayerDetailView(playerName: "Sidney Crosby", imageName: "Image 2", teamColors: [.black, .yellow], stats: "Goals: 450, Assists: 600", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "4")])) {
                    HockeyCard(playerName: "Sidney Crosby", imageName: "Image 2", teamColors: [.black, .yellow], stats: "Goals: 450, Assists: 600", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "4")], selectedPlayer: $selectedPlayer)
                }

                NavigationLink(destination: PlayerDetailView(playerName: "Connor McDavid", imageName: "Image 1", teamColors: [.blue, .orange], stats: "Goals: 300, Assists: 400", achievements: [Achievement(title: "Art Ross Trophies", description: "2"), Achievement(title: "Hart Trophies", description: "1")])) {
                    HockeyCard(playerName: "Connor McDavid", imageName: "Image 1", teamColors: [.blue, .orange], stats: "Goals: 300, Assists: 400", achievements: [Achievement(title: "Art Ross Trophies", description: "2"), Achievement(title: "Hart Trophies", description: "1")], selectedPlayer: $selectedPlayer)
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

