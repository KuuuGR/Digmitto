import SwiftUI

struct GuideStep: Identifiable {
    let id = UUID()
    let text: String
    let imageName: String
    let isImageOnLeft: Bool
}

struct GuideWalkthroughView: View {
    let steps: [GuideStep] = [
        GuideStep(text: "Welcome to the app! Here's how to get started.", imageName: "tut_step_0", isImageOnLeft: true),
        GuideStep(text: "Step 1: Use the 'Start Task' button to access the main application view.", imageName: "tut_step_1", isImageOnLeft: false),
        GuideStep(text: "Step 2: In this view, you will find three key elements: a random word, number wheels to set a value, and a 'Check' button to compare the word with the selected number.", imageName: "tut_step_2", isImageOnLeft: true),
        GuideStep(text: "Step 3: If the answer is correct, you will see the message 'Correct! 🌟'.", imageName: "tut_step_3", isImageOnLeft: false),
        GuideStep(text: "Step 4: For each first-attempt correct answer, you will earn +1 point and a fruit icon.", imageName: "tut_step_4", isImageOnLeft: true),
        GuideStep(text: "Step 5: If you press 'Check' but the answer is incorrect, the message 'Try again! ❌' will appear. In this case, correct your answer to proceed to the next word.", imageName: "tut_step_5", isImageOnLeft: false),
        GuideStep(text: "Step 6: To clarify mistakes, the app shows the expected code for the word and the code you entered on the wheels. Unfortunately, the score won't increase for corrected answers.", imageName: "tut_step_6", isImageOnLeft: true),
        GuideStep(text: "Step 7: There are two helper tools to make the learning process easier.", imageName: "tut_step_7", isImageOnLeft: false),
        GuideStep(text: "Step 8: Both helper tools can be enabled in the application settings.", imageName: "tut_step_8", isImageOnLeft: true),
        GuideStep(text: "Step 9: The first helper highlights letters that correspond to numbers. The colors for these letters and the letters to be ignored can be customized in the settings.", imageName: "tut_step_9", isImageOnLeft: false),
        GuideStep(text: "Step 10: The second helper is a cheat sheet showing letters and their corresponding numbers. You can refer to this sheet if you forget any values.", imageName: "tut_step_10", isImageOnLeft: true),
        GuideStep(text: "Step 11: Random words can be very long, sometimes exceeding the number of visible wheels on the screen.", imageName: "tut_step_11", isImageOnLeft: false),
        GuideStep(text: "Step 12: To resolve this, switch the screen orientation to horizontal.", imageName: "tut_step_12", isImageOnLeft: true),
        GuideStep(text: "Step 13: This horizontal position prevents the wheels from shrinking and ensures the entire coded number is visible.", imageName: "tut_step_13", isImageOnLeft: false),
        GuideStep(text: "Step 14: The wheels are grouped into sets of three, counted from the last number.", imageName: "tut_step_14", isImageOnLeft: true),
        GuideStep(text: "Step 15: This grouping helps you learn to read numbers in units, tens, thousands, millions, etc.", imageName: "tut_step_15", isImageOnLeft: false),
        GuideStep(text: "Step 16: The application tracks points for each session and maintains a total cumulative score across all sessions.", imageName: "tut_step_16", isImageOnLeft: true),
        GuideStep(text: "Step 17: You can view your points on the main screen or in the 'View Points' section.", imageName: "tut_step_17", isImageOnLeft: false),

//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: true),
//        GuideStep(text: "Step 3: Save your item to access it later.", imageName: "tut_step_3", isImageOnLeft: false),
        
        
        // Add more steps as needed
    ]
    
    // Configurable border properties
    var borderColor: Color = .white
    var borderWidth: CGFloat = 2
    var cornerRadius: CGFloat = 10
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(steps) { step in
                    HStack(spacing: 20) {
                        if step.isImageOnLeft {
                            styledImage(name: step.imageName)
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                        } else {
                            Text(step.text)
                                .font(.body)
                                .multilineTextAlignment(.leading)
                            styledImage(name: step.imageName)
                        }
                    }
                    .padding()
                }
            }
            .padding()
        }
        .navigationTitle("Guide Walkthrough")
    }
    
    // Helper function to style images
    @ViewBuilder
    private func styledImage(name: String) -> some View {
        Image(name)
            .resizable()
            .scaledToFit()
            .frame(width: 100, height: 100)
            .background(Color.clear) // Add a background color if needed
            .cornerRadius(cornerRadius)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
            )
    }
}

struct GuideWalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        GuideWalkthroughView()
    }
}
