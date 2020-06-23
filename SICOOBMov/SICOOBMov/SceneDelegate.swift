//
//  SceneDelegate.swift
//  Movs
//
//  Created by Renato Ferraz on 21/06/20.
//  Copyright © 2020 Renato Ferraz. All rights reserved.
//

import UIKit
import Reachability

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var reachability: Reachability!
    let semConxao = Bundle.main.loadNibNamed("SemConexao", owner: self, options: nil)![0] as? SemConexao

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        reachability = try! Reachability()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(networkStatusChanged(_:)),
            name: .reachabilityChanged,
            object: reachability
        )
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
        
        
        guard let _ = (scene as? UIWindowScene) else { return }
           
    }
    
    @objc func networkStatusChanged(_ notification: Notification) {
        
        let reachability = notification.object as! Reachability

        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            self.showMainPage()
        case .cellular:
            print("Reachable via Cellular")
            self.showMainPage()
        case .unavailable:
            print("Network not reachable")
            self.showOfflinePage()
        case .none:
            print("Network not reachable")
            self.showOfflinePage()
        }
        
        
    }
        
    private func showOfflinePage() -> Void {
        DispatchQueue.main.async {
            self.semConxao?.frame = UIScreen.main.bounds
            self.window?.addSubview(self.semConxao!)
            self.window?.tag = 133
        }
    }
    
    private func showMainPage() -> Void {
        DispatchQueue.main.async {
            
            if ((self.window?.viewWithTag(133)) != nil) {
                self.semConxao!.removeFromSuperview()
            }
            
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

