import UIKit

private func createDescriptionString(description: String) -> String {
    var wordsArray = description.components(separatedBy: .whitespaces)
    
    let blueRegularAtributes = [NSAttributedString.Key.font: UIFont(name: "ProximaNovaRegular", size: 13),
                                NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
    
    var descrString: [String] = []
 
    for word in wordsArray {
        
        if word.contains("#") || word.contains("@") {
            descrString.append("\(NSAttributedString(string: word, attributes: blueRegularAtributes))")
        } else {
            descrString.append(word)
        }
    }
    
    return descrString.joined(separator: " ")
}

let str = "@teta_blond #lala здравствуйте🤗 26 см"

print(createDescriptionString(description: str))
