import UIKit
import FirebaseAuth

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var registrarseButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var mostrarContraBoton: UIButton!
    @IBOutlet weak var olvideContraBoton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mostrarContraBoton.addTarget(self, action: #selector(cambiarVisibilidad), for: .touchUpInside)
        setupHideKeyboardOnTap()
    }

    @objc func cambiarVisibilidad() {
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert(title: "Error", message: "Error al iniciar sesión: \(error.localizedDescription)")
            } else if let user = authResult?.user {
                if user.isEmailVerified {
                    print("User signed in successfully and email is verified")
                    UserDefaults.standard.set(true, forKey: "isUserLoggedIn")
                    self.navigateToMainScreen()
                } else {
                    self.showAlert(title: "Verificación requerida", message: "Por favor, verifica tu correo electrónico antes de iniciar sesión.")
                    try? Auth.auth().signOut()
                }
            }
        }
    }

    @IBAction func forgotPasswordButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Restablecer Contraseña", message: "Introduce tu correo electrónico para recibir un enlace de restablecimiento de contraseña.", preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "Correo electrónico"
            textField.keyboardType = .emailAddress
        }
        let sendAction = UIAlertAction(title: "Enviar", style: .default) { _ in
            if let email = alertController.textFields?.first?.text {
                Auth.auth().sendPasswordReset(withEmail: email) { error in
                    if let error = error {
                        self.showAlert(title: "Error", message: "Error al enviar el enlace de restablecimiento: \(error.localizedDescription)")
                    } else {
                        self.showAlert(title: "Éxito", message: "Se ha enviado un enlace de restablecimiento de contraseña a tu correo electrónico.")
                    }
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(sendAction)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func navigateToMainScreen() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainViewController = mainStoryboard.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController {
            mainViewController.modalPresentationStyle = .fullScreen
            self.present(mainViewController, animated: true, completion: nil)
        }
    }
    
    func showAlert(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
