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
        GuideStep(text: "Step 1: Use button 'Start Task' to get primary application view", imageName: "tut_step_1", isImageOnLeft: false),
        GuideStep(text: "Step 2: In this view You have three important elements: random word, wheels to set number, check button to compare word and 0 number", imageName: "tut_step_2", isImageOnLeft: true),
        GuideStep(text: "Step 3: If the answer is correct we got the message Correct! 🌟", imageName: "tut_step_3", isImageOnLeft: false),
        GuideStep(text: "Step 4: We also get +1 score and fruit for every first attempted correct answer", imageName: "tut_step_4", isImageOnLeft: true),
        GuideStep(text: "Step 5: If wy Check but our answer is wrong we have another message: Try again! ❌. In this case we should correct our answer to get next word.", imageName: "tut_step_5", isImageOnLeft: false),
        GuideStep(text: "Step 6: To ensure what was wrong we have also information what is the code coresponding to given word and code you set in the wheels. Unfortunetelly score won't be increased. ", imageName: "tut_step_6", isImageOnLeft: true),
        GuideStep(text: "Step 7: There are two helps that make you larn process easier", imageName: "tut_step_7", isImageOnLeft: false),
        GuideStep(text: "Step 8: Both you can enabled in application settings", imageName: "tut_step_8", isImageOnLeft: true),
        GuideStep(text: "Step 9: First help is colouring letters that should be represented by numbers. Color of these letters and color of the leters should be omit can be setted in settings", imageName: "tut_step_9", isImageOnLeft: false),
        GuideStep(text: "Step 10: Second helper is cheatsheet with leters and coresponding numbers. You can swap this to see if you forgot any", imageName: "tut_step_10", isImageOnLeft: true),
        GuideStep(text: "Step 11: Random word can be very long. Longer then number of wheels can be on screen. ", imageName: "tut_step_11", isImageOnLeft: false),
        GuideStep(text: "Step 12: To resolve this problem, there is a need to change screen position from vertical to horizontal.", imageName: "tut_step_12", isImageOnLeft: true),
        GuideStep(text: "Step 13: This posintion prevent from shrinkage wheels we need to see whole coding numeber ", imageName: "tut_step_13", isImageOnLeft: false),
        GuideStep(text: "Step 14: Wheels are colored by group of three cound from last number.", imageName: "tut_step_14", isImageOnLeft: true),
        GuideStep(text: "Step 15: This is for another use, to learn how to read numbers by tens, thousands, millions etc. values", imageName: "tut_step_15", isImageOnLeft: false),
        GuideStep(text: "Step 16: Application count points separte with every sesion and also have counter to keep sum of all points in every sesion", imageName: "tut_step_16", isImageOnLeft: true),
        GuideStep(text: "Step 17: You can see this points in main screen and 'View Poinsts' section", imageName: "tut_step_17", isImageOnLeft: false),
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
