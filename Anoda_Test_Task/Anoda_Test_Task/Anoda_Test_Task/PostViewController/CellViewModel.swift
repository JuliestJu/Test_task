//
//  CellViewModel.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 17.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

struct PostModel {
    var profileImage = String()
    var userName = String()
    var location = String()
    var images = [String]()
    var peopleWhoLiked = NSAttributedString()
    var postDescription = NSAttributedString()
    var createdTime = String()
}

final class CellViewModel {
    
    var cellData = [PostModel]()
    var updateCollection: (() -> Void)?
    private let jsonParcer = JSONParser()
    
    // MARK: - Init
    
    init() {
        self.getCellObjects()
    }
    
    // MARK: - Public methods
    
    func createCellDataObject(_ model: DataModel) -> PostModel {
        var cellDataObject = PostModel()
        cellDataObject.userName = model.author.username
        cellDataObject.location = model.location
        cellDataObject.profileImage = model.author.profileImage
        cellDataObject.images = model.images
        cellDataObject.peopleWhoLiked = self.createLikedByString(usersWhoLiked: model.likedBy.map { $0.username })
        cellDataObject.postDescription = self.createDescriptionString(author: model.author.username, description: model.description.text)
        cellDataObject.createdTime = self.makeTimeDiffString(timeStamp: Int(model.createdTime)!)!
        
        return cellDataObject
    }
    
    // MARK: - Private Methods
    
    private func getCellObjects() {
        guard let data = jsonParcer.parseJSON(file: "json") else { return }
        self.cellData  = data.map { self.createCellDataObject($0)}
    }
    
    private func createLikedByString(usersWhoLiked: [String]) -> NSAttributedString {
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

