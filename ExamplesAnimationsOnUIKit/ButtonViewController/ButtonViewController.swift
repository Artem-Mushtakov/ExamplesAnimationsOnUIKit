//
//  ButtonViewController.swift
//  ExamplesAnimationsOnUIKit
//
//  Created by Artem Mushtakov on 19.03.2022.
//

import UIKit

class ButtonViewController: UIViewController {

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubview()
        setupConstraint()
    }

    // MARK: - Button

    private lazy var flashingAnimationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemMint
        button.layer.cornerRadius = 10
        button.setTitle("FlashingAnimation", for: .normal)
        button.addTarget(self, action: #selector(flashingAnimation), for: .touchUpInside)
        return button
    } ()

    // MARK: - Stack view

    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 10
        return stackView
    } ()

    // MARK: - Setup Animations

    // Flashing Animation
    @objc func flashingAnimation(sender button: UIButton) {

        let flashingAnimation = CABasicAnimation(keyPath: "opacity")
        flashingAnimation.duration = 0.5
        flashingAnimation.fromValue = 1
        flashingAnimation.toValue = 0.1
        flashingAnimation.timingFunction = CAMediaTimingFunction(name: .default)
        flashingAnimation.autoreverses = true
        flashingAnimation.repeatCount = 1
        button.layer.add(flashingAnimation, forKey: nil)
        print("Started flashing animation for button.")
    }

    // MARK: - Setup layout

    func setupSubview() {
        view.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(flashingAnimationButton)
    }

    func setupConstraint() {

        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        flashingAnimationButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            flashingAnimationButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}
