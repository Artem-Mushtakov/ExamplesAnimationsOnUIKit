# Примеры Анимаций UIKit
Здесь собраны анимации для различных UI элементов.

## Оглавление

1. [Кнопки/Button](#Кнопки/Button)
____
## Кнопки/Button


```Swift
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
```
