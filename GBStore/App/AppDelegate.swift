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
    
    let requestFactory = RequestFactory()
    
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
        
        return container
    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let user = requestFactory.makeUserRequestFatory()
        
        // registration
        user.create(model: CreateUserRequest(
                        username: "username",
                        password: "pass",
                        email: "user@example.com",
                        gender: .male,
                        creditCard: "0000-0000-0000-0000",
                        bio: "Funny guy")
        ) { response in
            switch response.result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        user.login(model: LoginRequest(userName: "username", password: "password")) { response in
            switch response.result {
            case .success(let login):
                print(login)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        user.update(model: UpdateUserRequest(
                        id: 123,
                        username: "username1",
                        password: "password1",
                        email: "user1@example.com",
                        gender: .female,
                        creditCard: "1111-1111-1111-1111",
                        bio: "Funny girl")
        ) { response in
            switch response.result {
            case .success(let user):
                print(user)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
        user.logout(completionHandler: { response in
            switch response.result {
            case .success(let logout):
                print(logout)
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
        
        
        
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

