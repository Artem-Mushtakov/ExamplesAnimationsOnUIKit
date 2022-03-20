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

    private lazy var upAlphaAnimationButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.setTitle("UpAlphaAnimation", for: .normal)
        button.addTarget(self, action: #selector(startUpAlphaAnimationButton), for: .touchUpInside)
        return button
    } ()

    // MARK: - Stack view

    private lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    } ()

    private lazy var oneHorizontalStackView = createStackViewHorizontal()
    private lazy var twoHorizontalStackView = createStackViewHorizontal()

    // MARK: - Setup Animations

    // Flashing Animation
    @objc private func flashingAnimation(sender button: UIButton) {

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

    // Up Alpha Animation
    @objc private func startUpAlphaAnimationButton(sender button: UIButton) {

        UIView.animateKeyframes(withDuration: 2, delay: 0, animations: {

            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25, animations: {
                button.backgroundColor = .magenta
            })

            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25, animations: {
                button.alpha = 0.5
            })

            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25, animations: {
                button.center.y -= 10
            })

            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                button.center.y += 10
                button.alpha = 1
                button.backgroundColor = .orange
            })
        })
        print("Started up alpha animation for button.")
    }

    // MARK: - Setup layout

    private func setupSubview() {
        view.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(oneHorizontalStackView)
        verticalStackView.addArrangedSubview(twoHorizontalStackView)

        oneHorizontalStackView.addArrangedSubview(flashingAnimationButton)
        oneHorizontalStackView.addArrangedSubview(tapUpDownAnimationButton)
        twoHorizontalStackView.addArrangedSubview(upAlphaAnimationButton)
    }

    private func setupConstraint() {

        offTranslatesAutoresizingMask(elements: [oneHorizontalStackView, twoHorizontalStackView,
                                                verticalStackView, flashingAnimationButton,
                                                tapUpDownAnimationButton, upAlphaAnimationButton])

        NSLayoutConstraint.activate([
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            verticalStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            verticalStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),

            flashingAnimationButton.heightAnchor.constraint(equalToConstant: 50),
            flashingAnimationButton.widthAnchor.constraint(equalToConstant: 200),
            tapUpDownAnimationButton.heightAnchor.constraint(equalToConstant: 50),
            tapUpDownAnimationButton.widthAnchor.constraint(equalToConstant: 200),
            upAlphaAnimationButton.heightAnchor.constraint(equalToConstant: 50),
            upAlphaAnimationButton.widthAnchor.constraint(equalToConstant: 200)
        ])
    }

    // MARK: - Settings function elements

    private func createStackViewHorizontal() -> UIStackView {
        let stackView: UIStackView = {
            let stackView = UIStackView()
            stackView.alignment = .center
            stackView.distribution = .fillEqually
            stackView.axis = .horizontal
            stackView.spacing = 10
            return stackView
        } ()
        return stackView
    }

    private func offTranslatesAutoresizingMask<T: UIView>(elements: [T]) {
        // TODO: - Разобраться как убрать ворнинг
        elements.map { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
}
