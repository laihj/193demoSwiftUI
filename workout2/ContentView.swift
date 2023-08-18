//
//  ContentView.swift
//  workout2
//
//  Created by laihj on 2023/7/5.
//

import SwiftUI
import WorkoutKit

struct ContentView: View {
    @ObservedObject var game:EmojiMemoryGame = EmojiMemoryGame()

    @State var emojiCount = 10
    
    var body: some View {
        VStack(alignment: .leading) {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))], content: {
                ForEach(game.cards) { emoji in
                    CardView(card: emoji)
                        .aspectRatio(2/3,contentMode: .fit)
                        .onTapGesture {
                            
                            game.choose(card: emoji)
                        }
                }
            }).padding()
        }
        Spacer()
    }
}

struct CardView: View {
    var card:MemoryGame<String>.Card
    
    var body: some View {
        ZStack() {
            let shape = RoundedRectangle(cornerRadius: 25.0)
            if card.isFaceUp {
                shape
                    .fill().foregroundColor(.white)
                shape
                    .stroke(lineWidth: 3.0)
                
                Text(card.content)
                    .padding()
            } else if card.isMatched {
                shape.opacity(0)
            }
            else {
                shape
                    .fill(.red)
            }
        }
    }
}



#Preview {
    ContentView().preferredColorScheme(.light)
//
//    ContentView().preferredColorScheme(.light)
    
}

extension View {
    func debug() -> Self {
        print(Mirror(reflecting: self))
        return self;
    }
}

struct LabelView:View {
    @Binding var number:Int
    @ViewBuilder var helper:some View {
//        Button("Tap me!") { self.number += 1 }
        if number > 0 {
            Text("you tap \(number) timers")
        } else {
            Image(systemName: "lightbulb")
        }
    }
    
    var body:some View {
        helper
//        Button("Tap me!") { self.number += 1 }
//        if number > 0 {
//            Text("you tap \(number) timers")
//        }
    }
}

struct KnobShape: Shape {
    var pointerSize: CGFloat = 0.1 // these are relative values
    var pointerWidth: CGFloat = 0.1
    func path(in rect: CGRect) -> Path {
        let pointerHeight = rect.height * pointerSize
        let pointerWidth = rect.width * self.pointerWidth
        let circleRect = rect.insetBy(dx: pointerHeight, dy: pointerHeight)
        return Path { p in
            p.addEllipse(in: circleRect)
            p.addRect(CGRect(x: rect.midX - pointerWidth/2, y: 0, width: pointerWidth, height: pointerHeight + 2))
        }
    }
}

struct Knob:View {
    @Binding var value:Double
    var body: some View {
        KnobShape()
            .fill(Color.primary)
            .rotationEffect(Angle(degrees: value * 360))
            .onTapGesture {
                self.value = self.value < 0.5 ? 1.0 : 0.0
            }
    }
}

fileprivate struct PointerSizeKey: EnvironmentKey {
    static let defaultValue: CGFloat = 0.1
}

final class Contact: ObservableObject, Identifiable {
    let id = UUID()
    @Published var name: String
    @Published var city: String
    init(name: String, city: String) {
        self.name = name
        self.city = city
    }
}


extension EnvironmentValues {
    var knobPointerSize: CGFloat {
        get { self[PointerSizeKey.self] }
        set { self[PointerSizeKey.self] = newValue }
    }
}

extension View {
    func knobPointerSize(_ size: CGFloat) -> some View {
        self.environment(\.knobPointerSize, size)
    }
}
