//
//  TabBarViewController.swift
//  ExamplesAnimationsOnUIKit
//
//  Created by Artem Mushtakov on 19.03.2022.
//

import UIKit

class TabBarViewController: UITabBarController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addViewControllers()
    }

    // MARK: - Setup TabBarController

    private func addViewControllers() {
        viewControllers = [ createViewController(for: ButtonViewController(), title: "First", titleImage: .actions),
                            createViewController(for: SecondViewController(), title: "Second", titleImage: .actions)]
    }

    private func createViewController(for viewController: UIViewController, title: String, titleImage: UIImage) -> UIViewController {

        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.tabBarItem.image = titleImage
        navigationController.tabBarItem.title = title
        viewController.navigationItem.title = title

        return navigationController
    }
}
