//
//  AppDelegate.swift
//  BringChuChuba
//
//  Created by 한상진 on 2021/01/03.
//

import UIKit
import Firebase
import Alamofire
import SwiftyJSON

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()
        Auth.auth().signInAnonymously { (authResult, error) in
            guard let user = authResult?.user else {
                print("\(#file) Firebase SignIn Fail")
                fatalError()
            }

            user.getIDTokenForcingRefresh(true) { (idToken, error) in
                if error != nil {
                    print("\(#file) Firebase getIDToken Fail")
                    // TODO: 타임아웃, 네트워크 연결 요청 처리
                    fatalError()
                }

                GlobalData.shared.userToken = idToken
                // getMyInfo
                APIClient.getMember(completion: { result in
                    switch result {
                    case .success(let member):
                        print(member)
                    case .failure(let error):
                        print("\(#line) \(error)")
                    }
                })

                // getFamily
                let familyId = 10
                APIClient.getFamily(familyId: familyId, completion: { result in
                    switch result {
                    case .success(let family):
                        print(family)
                    case .failure(let error):
                        print(error)
                    }
                })
//
//                // createFamily
//                let familyName = "test fam"
//                APIClient.createFamily(familyName: familyName, completion: { result in
//                    switch result {
//                    case .success(let family):
//                        print(family)
//                    case .failure(let error):
//                        print(error)
//                    }
//                })
//                // joinFamily
//                APIClient.joinFamily(familyId: familyId, completion: { result in
//                    switch result {
//                    case .success(let family):
//                        print(family)
//                    case .failure(let error):
//                        print(error)
//                    }
//                })
//                // createMission
//                APIClient.createMission(description: "test desc", expireAt: "2021-01-07 22:22", familyId: 10, reward: "good", title: "wow", completion: { result in
//                    switch result {
//                    case .success(let missions):
//                        print(missions)
//                    case .failure(let error):
//                        print(error)
//                    }
//                })
                // getMissions
                APIClient.getMissions(familyId: familyId, completion: { result in
                    switch result {
                    case .success(let missions):
                        print(missions)
                    case .failure(let error):
                        print(error)
                    }
                })
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
}
