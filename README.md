# Примеры Анимаций UIKit
Здесь собраны анимации для различных UI элементов.

## Оглавление

1. [Кнопки/Button](#Кнопки/Button)
____
## Кнопки/Button

**ℹ️  Пример использования функций:**
```Swift
button.addTarget(self, action: #selector(Здесь функция анимации кнопки), for: .touchUpInside)
```
* :white_check_mark: Flashing Animation

![image](https://github.com/Artem-Mushtakov/ExamplesAnimationsOnUIKit/blob/develop/ExamplesAnimationsOnUIKit/Resources/Gif/Button/FlashingAnimationButton.gif)

```Swift
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
```

* :white_check_mark: Tab Up/Down Animation

![image](https://github.com/Artem-Mushtakov/ExamplesAnimationsOnUIKit/blob/develop/ExamplesAnimationsOnUIKit/Resources/Gif/Button/TabUp:Down%20AnimationButton.gif)
```Swift
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

* :white_check_mark: Up Alpha Animation

![image](https://github.com/Artem-Mushtakov/ExamplesAnimationsOnUIKit/blob/develop/ExamplesAnimationsOnUIKit/Resources/Gif/Button/UpAlphaAnimationButton.gif)

```Swift
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
```
