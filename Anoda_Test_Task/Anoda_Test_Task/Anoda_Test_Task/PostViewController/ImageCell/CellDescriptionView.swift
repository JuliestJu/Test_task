//
//  CellDescriptionView.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 09.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

protocol CellDescriptionModel {
    var peopleWhoLiked: [String] { get }
    var author: String { get }
    var description: String { get }
    var createdTime: String { get }
}

final class CellDescriptionView: UIView {
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.distribution = .fill
        return stackView
    }()
    
    private var likedByLabel: UILabel = {
        let likedByLabel = UILabel()
        likedByLabel.translatesAutoresizingMaskIntoConstraints = false
        likedByLabel.numberOfLines = 0
        return likedByLabel
    }()
    
    private var postDescriptionLabel: UILabel = {
        let postDescriptionLabel = UILabel()
        postDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        postDescriptionLabel.numberOfLines = 0
        return postDescriptionLabel
    }()
    
    private var createdTimeLabel: UILabel = {
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
    
    func fill(with model: CellDescriptionModel) {
        self.likedByLabel.attributedText = self.createLikedByString(model.peopleWhoLiked)
        self.postDescriptionLabel.attributedText = self.createDescriptionString(author: model.author,
                                                                                description: model.description)
        self.createdTimeLabel.text = self.makeTimeDiffString(timeStamp: model.createdTime)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        self.addSubview(self.stackView)
        self.stackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        self.stackView.addArrangedSubview(self.likedByLabel)
        self.stackView.addArrangedSubview(self.postDescriptionLabel)
        self.stackView.addArrangedSubview(self.createdTimeLabel)
    }
    
    private func createLikedByString(_ usersWhoLiked: [String]) -> NSAttributedString {
        var finalString = NSAttributedString()
        
        let regularAttributes = [NSAttributedString.Key.font: UIFont(name: "NunitoSans-Regular", size: 15)]
        let boldAttributes = [NSAttributedString.Key.font: UIFont(name: "NunitoSans-Bold", size: 15)]
        
        let likesCalculated = self.calculateLikes(from: usersWhoLiked)
        
        let likedByString = NSAttributedString(string: "Liked by ",
                                               attributes: regularAttributes as [NSAttributedString.Key : Any])
        let firstThreeLikers = NSAttributedString(string: likesCalculated.0.joined(separator: ", "),
                                                  attributes: boldAttributes as [NSAttributedString.Key : Any])
        let andString = NSAttributedString(string: " and ",
                                           attributes: regularAttributes as [NSAttributedString.Key : Any])
        let othersString = NSAttributedString(string: likesCalculated.1 + " others",
                                              attributes: boldAttributes as [NSAttributedString.Key : Any])
        
        if usersWhoLiked.count > 3 {
            finalString = likedByString + firstThreeLikers + andString + othersString
            return finalString
        } else {
            finalString = likedByString + firstThreeLikers
            return finalString
        }
    }
    
    private func calculateLikes(from users: [String]) -> ([String], String) {
        if users.count > 3 {
            return ((Array(users.prefix(upTo: 3)), String(users.count - 3)))
        } else {
            return (users, "")
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
        let authorAttributedString = NSAttributedString(string: author + " ", attributes: boldAttributes as [NSAttributedString.Key : Any])
        
        
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
    
    private func makeTimeDiffString(timeStamp: String) -> String? {
        var madeAt = Date()
        if let timeStampInt = Double(timeStamp) {
            madeAt = Date(timeIntervalSince1970: timeStampInt)
        }
        return String.getDiffTime(olderDate: madeAt, newerDate: Date())?.uppercased()
    }
}
