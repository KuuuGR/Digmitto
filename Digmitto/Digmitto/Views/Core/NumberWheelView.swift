import SwiftUI

struct NumberWheelView: View {
    let wordLength: Int
    @Binding var selectedNumbers: [Int]
    let wheelColors: [Color] // Array of colors for each wheel
    
    init(wordLength: Int, selectedNumbers: Binding<[Int]>, wheelColors: [Color]) {
        self.wordLength = max(1, wordLength)
        self._selectedNumbers = selectedNumbers
        // If not enough colors provided, pad with default color
        if wheelColors.count < wordLength {
            self.wheelColors = wheelColors + Array(repeating: Color.primary, count: wordLength - wheelColors.count)
        } else {
            self.wheelColors = Array(wheelColors.prefix(wordLength))
        }
    }
    
    var body: some View {
        HStack {
            ForEach(0..<wordLength, id: \.self) { index in
                if index < selectedNumbers.count {
                    Picker("Number \(index + 1)", selection: $selectedNumbers[index]) {
                        ForEach(0...9, id: \.self) { number in
                            Text("\(number)")
                                .tag(number)
                                .foregroundColor(wheelColors[index])
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(width: 50, height: 100)
                    .clipped()
                }
            }
        }
        .padding()
    }
}

//struct NumberWheelView_Previews: PreviewProvider {
//    @State static var numbers = Array(repeating: 0, count: 3)
//    
//    static var previews: some View {
//        NumberWheelView(
//            wordLength: 3,
//            selectedNumbers: $numbers,
//            wheelColors: [.red, .blue, .green]
//        )
//    }
//} 
