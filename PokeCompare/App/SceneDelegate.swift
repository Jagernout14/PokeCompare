//
//  SceneDelegate.swift
//  PokeCompare
//
//  Created by Роман Пичугин on 26.09.2026.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let client = NetworkClient()
        let viewModel = PokemonListViewModel(client: client)
        let viewController = PokemonListViewController(viewModel: viewModel)
        let navigationController = UINavigationController(rootViewController: viewController)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
