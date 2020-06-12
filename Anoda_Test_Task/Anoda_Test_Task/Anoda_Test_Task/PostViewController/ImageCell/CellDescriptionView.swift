//
//  CellDescriptionView.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 09.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

final class CellDescriptionView: UIView {
    
    var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    var likedByLabel: UILabel = {
        let likedByLabel = UILabel()
        likedByLabel.text = "I love Medium's membership — it gives me access to the stories I love by the"
        likedByLabel.translatesAutoresizingMaskIntoConstraints = false
        likedByLabel.numberOfLines = 0
        return likedByLabel
    }()
    
    var postDescriptionLabel: UILabel = {
        let postDescriptionLabel = UILabel()
        postDescriptionLabel.text = "When adding an image the title is pushed to the right with the amount of the image width."
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        postDescriptionLabel.numberOfLines = 0
        return postDescriptionLabel
    }()
    
    var createdTimeLabel: UILabel = {
        let createdTimeLabel = UILabel()
        createdTimeLabel.text = "3 hours ago"
        createdTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        createdTimeLabel.numberOfLines = 1
        createdTimeLabel.font = UIFont(name: "ProximaNovaThin", size: 13)
        createdTimeLabel.textColor = .lightGray
        return createdTimeLabel
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    
    func fill(likedBy: [String], description: String, date: Int) {
        self.likedByLabel.text = self.createLikedByString(usersWhoLiked: likedBy)
        self.postDescriptionLabel.text = self.createDescriptionString(description: description)
        self.createdTimeLabel.text = self.makeTimeDiffString(timeStamp: date)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        self.backgroundColor = .systemTeal
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        self.stackView.addArrangedSubview(self.likedByLabel)
        self.stackView.addArrangedSubview(self.postDescriptionLabel)
        self.stackView.addArrangedSubview(self.createdTimeLabel)
        
        
        
        self.layoutIfNeeded()
    }
    
    private func createLikedByString(usersWhoLiked: [String]) -> String {
        let regularAttributes = [NSAttributedString.Key.font: UIFont(name: "ProximaNovaRegular", size: 13)]
        let boldAttributes = [NSAttributedString.Key.font: UIFont(name: "ProximaNovaAltBold", size: 13)]
        let likesCalculated = self.calculateLikes(from: usersWhoLiked)
        
        let likedByString = NSAttributedString(string: "Liked By ",
                                               attributes: regularAttributes as [NSAttributedString.Key : Any])
        let firstThreeLikers = NSAttributedString(string: likesCalculated.0.joined(separator: ", "),
                                                  attributes: boldAttributes as [NSAttributedString.Key : Any])
        let andString = NSAttributedString(string: " and",
                                           attributes: regularAttributes as [NSAttributedString.Key : Any])
        let othersString = NSAttributedString(string: likesCalculated.1 + " others",
                                              attributes: boldAttributes as [NSAttributedString.Key : Any])
        
        if usersWhoLiked.count > 3 {
            return "\(likedByString) + \(firstThreeLikers) + \(andString) + \(othersString)"
        } else {
            return "\(likedByString) + \(firstThreeLikers)"
        }
    }
    
    private func createDescriptionString(description: String) -> String {
        var descrString: [String] = []
        let wordsArray = description.components(separatedBy: .whitespaces)
        let blueRegularAtributes = [NSAttributedString.Key.font: UIFont(name: "ProximaNovaRegular", size: 13),
                                    NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        
        wordsArray.forEach {
            if $0.contains("#") || $0.contains("@") {
                descrString.append("\(NSAttributedString(string: $0, attributes: blueRegularAtributes as [NSAttributedString.Key : Any]))")
            } else {
                descrString.append($0)
            }
        }
        return descrString.joined(separator: " ")
    }
    
    private func calculateLikes(from users: [String]) -> ([String], String) {
        if users.count > 3 {
            return ((Array(users.prefix(upTo: 3)), String(users.count - 3)))
        } else {
            return (users, "")
        }
    }
    
    private func makeTimeDiffString(timeStamp: Int) -> String? {
        let madeAt = Date(timeIntervalSince1970: Double(timeStamp))
        return String.getDiffTime(olderDate: madeAt, newerDate: Date())?.uppercased()
    }
}
