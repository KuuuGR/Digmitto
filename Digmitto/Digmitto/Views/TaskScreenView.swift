import SwiftUI

struct TaskScreenView: View {
    @State private var selectedWord = "motor"
    @State private var userInput = ""
    
    var body: some View {
        VStack {
            // Back Button
            Button(action: {
                // Navigate back
            }) {
                Text(LocalizedStringKey("ts_back_button"))
            }
            .padding()
            
            // Selected Word Display
            Text(selectedWord)
                .font(.largeTitle)
                .padding()
            
            // User Input Field
            TextField(LocalizedStringKey("ts_user_input_placeholder"), text: $userInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            // Code Button
            Button(action: {
                // Validate input
            }) {
                Text(LocalizedStringKey("ts_code_button"))
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
        .navigationBarTitle(LocalizedStringKey("ts_screen_title"), displayMode: .inline)
    }
}

struct TaskScreenView_Previews: PreviewProvider {
    static var previews: some View {
        TaskScreenView()
    }
}
