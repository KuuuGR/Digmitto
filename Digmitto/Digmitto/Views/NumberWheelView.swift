import SwiftUI

struct NumberWheelView: View {
    let wordLength: Int
    @Binding var selectedNumbers: [Int]
    
    init(wordLength: Int, selectedNumbers: Binding<[Int]>) {
        self.wordLength = max(1, wordLength)
        self._selectedNumbers = selectedNumbers
    }
    
    var body: some View {
        HStack {
            ForEach(0..<wordLength, id: \.self) { index in
                if index < selectedNumbers.count {
                    Picker("Number \(index + 1)", selection: $selectedNumbers[index]) {
                        ForEach(0...9, id: \.self) { number in
                            Text("\(number)")
                                .tag(number)
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

struct NumberWheelView_Previews: PreviewProvider {
    @State static var numbers = Array(repeating: 0, count: 1)
    
    static var previews: some View {
        NumberWheelView(wordLength: 1, selectedNumbers: $numbers)
    }
} 