//
//  SceneDelegate.swift
//  Anoda_Test_Task
//
//  Created by Юлия Воротченко on 08.06.2020.
//  Copyright © 2020 Юлия Воротченко. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
       self.window = UIWindow(windowScene: UIWindowScene(session: session, connectionOptions: connectionOptions))
        self.window?.rootViewController = PostViewController()
        self.window?.makeKeyAndVisible()
    }
}

