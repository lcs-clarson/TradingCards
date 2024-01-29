import SwiftUI

struct Achievement {
    var title: String
    var description: String
}

struct HockeyCard: View, Identifiable {
    var id = UUID() // Add a unique identifier
    var playerName: String
    var imageName: String
    var gradientColors: [Color]
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
                        ZStack {
                            LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing)
                                .cornerRadius(10)
                                .frame(height: 200)

                            Image(imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 200)
                                .background(Color.clear)
                                .cornerRadius(10)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("Player:")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(playerName)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)

                            Text("Stats:")
                                .font(.headline)
                                .foregroundColor(.black)
                            Text(stats)
                                .font(.body)
                                .foregroundColor(.black)

                            Text("Achievements:")
                                .font(.headline)
                                .foregroundColor(.black)

                            ForEach(achievements, id: \.title) { achievement in
                                Text("\(achievement.title): \(achievement.description)")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding()
                        .cornerRadius(10)
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
                            .fill(LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .topLeading, endPoint: .bottomTrailing))
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
    var gradientColors: [Color]
    var stats: String
    var achievements: [Achievement]

    var body: some View {
        VStack {
            HockeyCard(playerName: playerName, imageName: imageName, gradientColors: gradientColors, stats: stats, achievements: achievements, selectedPlayer: .constant(playerName))
        }
        .navigationTitle(playerName)
        .font(.title)
    }
}

struct ContentView: View {
    @State private var selectedPlayer: String?

    // Create instances of HockeyCard in an array
    var hockeyCards: [HockeyCard] = [
        HockeyCard(playerName: "Alex Ovechkin", imageName: "Image", gradientColors: [.white, .red], stats: "Goals: 700, Assists: 500", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "5")], selectedPlayer: .constant(nil)),
        HockeyCard(playerName: "Sidney Crosby", imageName: "Image 2", gradientColors: [.black, .yellow], stats: "Goals: 450, Assists: 600", achievements: [Achievement(title: "Stanley Cups", description: "3"), Achievement(title: "MVP Awards", description: "4")], selectedPlayer: .constant(nil)),
        HockeyCard(playerName: "Connor McDavid", imageName: "Image 1", gradientColors: [.blue, .orange], stats: "Goals: 300, Assists: 400", achievements: [Achievement(title: "Art Ross Trophies", description: "2"), Achievement(title: "Hart Trophies", description: "1")], selectedPlayer: .constant(nil))
    ]

    var body: some View {
        NavigationView {
            List(hockeyCards) { hockeyCard in
                NavigationLink(destination: PlayerDetailView(playerName: hockeyCard.playerName, imageName: hockeyCard.imageName, gradientColors: hockeyCard.gradientColors, stats: hockeyCard.stats, achievements: hockeyCard.achievements)) {
                    hockeyCard
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

