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

    private lazy var tapUpDownAnimationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemPink
        button.layer.cornerRadius = 10
        button.setTitle("TapUpDownAnimation", for: .normal)
        button.addTarget(self, action: #selector(startTapUpDownAnimation), for: .touchUpInside)
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

    // Tab Up/Down Animation
    @objc private func startTapUpDownAnimation(sender button: UIButton) {
        button.addTarget(self, action: #selector(animateDown), for: [.touchDown, .touchDragEnter])
        button.addTarget(self, action: #selector(animateUp), for: .touchUpInside)
        print("Started tapUpDown animation for button.")
    }

    @objc private func animateDown(sender: UIButton) {
        animate(sender, transform: CGAffineTransform.identity.scaledBy(x: 0.95, y: 0.95))
    }

    @objc private func animateUp(sender: UIButton) {
        animate(sender, transform: .identity)
    }

    private func animate(_ button: UIButton, transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 3,
                       options: [.curveEaseInOut],
                       animations: {
            button.transform = transform
        }, completion: nil)
    }

    // MARK: - Setup layout

    func setupSubview() {
        view.addSubview(horizontalStackView)
        horizontalStackView.addArrangedSubview(flashingAnimationButton)
        horizontalStackView.addArrangedSubview(tapUpDownAnimationButton)
    }

    func setupConstraint() {

        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        flashingAnimationButton.translatesAutoresizingMaskIntoConstraints = false
        tapUpDownAnimationButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            horizontalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            horizontalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            flashingAnimationButton.heightAnchor.constraint(equalToConstant: 50),
            tapUpDownAnimationButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
