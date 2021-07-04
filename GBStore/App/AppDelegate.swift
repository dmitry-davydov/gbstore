//
//  AppDelegate.swift
//  GBStore
//
//  Created by Дима Давыдов on 20.06.2021.
//

import UIKit
import Swinject
import Alamofire

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let container: Container = {
        let configuration = Configuration()
        let container = Container()
        
        container.register(AbstractErrorParser.self) { _ in ErrorParser() }
        container.register(UserRequestFactory.self) { (_, errorParser: AbstractErrorParser, session: Session, queue: DispatchQueue) in
            return User(errorParser: errorParser, sessionManager: session, queue: queue, configurtation: configuration)
        }
        container.register(ProductRequestFactory.self) { (_, errorParser: AbstractErrorParser, session: Session, queue: DispatchQueue) in
            return Product(errorParser: errorParser, sessionManager: session, queue: queue, configurtation: configuration)
        }
        container.register(ReviewsRequestFactory.self) { (_, errorParser: AbstractErrorParser, session: Session, queue: DispatchQueue) in
            return Reviews(errorParser: errorParser, sessionManager: session, queue: queue, configurtation: configuration)
        }
        
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

