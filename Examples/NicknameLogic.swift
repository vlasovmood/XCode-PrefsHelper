import UIKit

class ViewController: UIViewController {
    private let nicknameKey = "Nickname"
    private var nicknameTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        if let savedNickname = KeychainHelper.get(key: nicknameKey) {
            showMessage("Ваш никнейм: \(savedNickname)")
        } else {
            promptForNickname()
        }
    }

    private func setupUI() {
        view.backgroundColor = .white
        nicknameTextField = UITextField(frame: CGRect(x: 50, y: 200, width: 300, height: 40))
        nicknameTextField.placeholder = "Введите ваш никнейм"
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.isHidden = true
        view.addSubview(nicknameTextField)
        
        let saveButton = UIButton(frame: CGRect(x: 150, y: 260, width: 100, height: 50))
        saveButton.setTitle("Сохранить", for: .normal)
        saveButton.setTitleColor(.systemBlue, for: .normal)
        saveButton.addTarget(self, action: #selector(saveNickname), for: .touchUpInside)
        saveButton.isHidden = true
        view.addSubview(saveButton)
        
        nicknameTextField.tag = 101
        saveButton.tag = 102
    }

    private func promptForNickname() {
        nicknameTextField.isHidden = false
        if let saveButton = view.viewWithTag(102) as? UIButton {
            saveButton.isHidden = false
        }
    }

    @objc private func saveNickname() {
        guard let nickname = nicknameTextField.text, !nickname.isEmpty else {
            showMessage("Пожалуйста, введите никнейм.")
            return
        }
        
        let success = KeychainHelper.save(key: nicknameKey, value: nickname)
        if success {
            showMessage("Никнейм сохранен: \(nickname)")
            nicknameTextField.isHidden = true
            if let saveButton = view.viewWithTag(102) as? UIButton {
                saveButton.isHidden = true
            }
        } else {
            showMessage("Ошибка сохранения никнейма.")
        }
    }
    
    private func showMessage(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ок", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
