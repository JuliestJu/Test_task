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
        stackView.spacing = 5
        return stackView
    }()
    
    var likedByLabel: UILabel = {
        let likedByLabel = UILabel()
        likedByLabel.translatesAutoresizingMaskIntoConstraints = false
        likedByLabel.numberOfLines = 0
        return likedByLabel
    }()
    
    var postDescriptionLabel: UILabel = {
        let postDescriptionLabel = UILabel()
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        postDescriptionLabel.numberOfLines = 0
        return postDescriptionLabel
    }()
    
    var createdTimeLabel: UILabel = {
        let createdTimeLabel = UILabel()
        createdTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        createdTimeLabel.numberOfLines = 1
        createdTimeLabel.font = UIFont(name: "NunitoSans-ExtraLight", size: 13)
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
    
    func fill(likedBy: [String], description: String, date: Int, author: String) {
        self.likedByLabel.attributedText = self.createLikedByString(usersWhoLiked: likedBy)
        self.postDescriptionLabel.attributedText = self.createDescriptionString(author: author, description: description)
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
    
    private func createLikedByString(usersWhoLiked: [String]) -> NSAttributedString {
        var finalString = NSAttributedString()
        
        let regularAttributes = [NSAttributedString.Key.font: UIFont(name: "NunitoSans-Regular", size: 15)]
        let boldAttributes = [NSAttributedString.Key.font: UIFont(name: "NunitoSans-Bold", size: 15)]
        
        let likesCalculated = self.calculateLikes(from: usersWhoLiked)
        
        let likedByString = NSAttributedString(string: "Liked by ", attributes: regularAttributes)
        let firstThreeLikers = NSAttributedString(string: likesCalculated.0.joined(separator: ", "), attributes: boldAttributes)
        let andString = NSAttributedString(string: " and ", attributes: regularAttributes)
        let othersString = NSAttributedString(string: likesCalculated.1 + " others", attributes: boldAttributes)
        
        if usersWhoLiked.count > 3 {
            finalString = likedByString + firstThreeLikers + andString + othersString
            return finalString
        } else {
            finalString = likedByString + firstThreeLikers
            return finalString
        }
    }
    
    private func createDescriptionString(author: String, description: String) -> NSAttributedString {
        var descrString: [NSAttributedString] = []
        var finalString = NSAttributedString()
        
        let wordsArray = description.components(separatedBy: .whitespaces)
        
        let blueRegularAtributes = [NSAttributedString.Key.font: UIFont(name: "NunitoSans-Regular", size: 15),
                                    NSAttributedString.Key.foregroundColor: UIColor.systemBlue]
        let regularAttributes = [NSAttributedString.Key.font: UIFont(name: "NunitoSans-Regular", size: 15)]
        let boldAttributes = [NSAttributedString.Key.font: UIFont(name: "NunitoSans-Bold", size: 15)]
        let authorAttributedString = NSAttributedString(string: author + " ", attributes: boldAttributes)
        
        
        wordsArray.forEach {
            if $0.contains("#") || $0.contains("@") {
                descrString.append(NSAttributedString(string: $0, attributes: blueRegularAtributes as [NSAttributedString.Key : Any]))
            } else {
                descrString.append(NSAttributedString(string: $0, attributes: regularAttributes as [NSAttributedString.Key : Any]))
            }
        }
        
        finalString = authorAttributedString + descrString.joined(with: " ")
        return finalString
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
