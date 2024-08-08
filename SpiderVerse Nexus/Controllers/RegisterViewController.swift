import UIKit
import FirebaseAuth
import FirebaseFirestore

class RegisterViewController: UIViewController {

    @IBOutlet weak var nombreRegistro: UITextField!
    @IBOutlet weak var apellidoRegister: UITextField!
    @IBOutlet weak var emailRegistro: UITextField!
    @IBOutlet weak var passwordRegistro: UITextField!
    @IBOutlet weak var telefonoRegistro: UITextField!
    @IBOutlet weak var botonRegistro: UIButton!
    @IBOutlet weak var botonMostrarContra: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        botonRegistro.addTarget(self, action: #selector(botonRegistroTapped), for: .touchUpInside)
        botonMostrarContra.addTarget(self, action: #selector(cambiarVisibilidad), for: .touchUpInside)
        setupHideKeyboardOnTap()
    }

    @objc func cambiarVisibilidad() {
        passwordRegistro.isSecureTextEntry.toggle()
    }
    
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc func botonRegistroTapped(_ sender: UIButton) {
        guard let nombre = nombreRegistro.text, !nombre.isEmpty,
              let apellido = apellidoRegister.text, !apellido.isEmpty,
              let email = emailRegistro.text, !email.isEmpty,
              let password = passwordRegistro.text, !password.isEmpty,
              let telefono = telefonoRegistro.text, !telefono.isEmpty else {
            showAlert(title: "Error", message: "Todos los campos son obligatorios.")
            return
        }

        DispatchQueue.global(qos: .userInitiated).async {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    DispatchQueue.main.async {
                        self.showAlert(title: "Error", message: "Hubo un error al crear el usuario: \(error.localizedDescription)")
                    }
                    return
                } else {
                    print("User registered successfully")
                    self.saveUserData(nombre: nombre, apellido: apellido, email: email, telefono: telefono)
                    self.sendVerificationEmail()
                }
            }
        }
    }

    func saveUserData(nombre: String, apellido: String, email: String, telefono: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }

        let db = Firestore.firestore()
        db.collection("users").document(userId).setData([
            "nombre": nombre,
            "apellido": apellido,
            "email": email,
            "telefono": telefono
        ]) { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(title: "Error", message: "Hubo un error al guardar los datos: \(error.localizedDescription)")
                } else {
                    print("User data saved successfully")
                }
            }
        }
    }

    func sendVerificationEmail() {
        guard let user = Auth.auth().currentUser else { return }
        user.sendEmailVerification { error in
            DispatchQueue.main.async {
                if let error = error {
                    self.showAlert(title: "Error", message: "Hubo un error al enviar el correo de verificación: \(error.localizedDescription)")
                } else {
                    print("Verification email sent successfully")
                    self.showVerificationAlert()
                }
            }
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

    func showVerificationAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Verificación de correo",
                                          message: "Se ha enviado un correo de verificación. Por favor, revisa tu bandeja de entrada y sigue las instrucciones para verificar tu cuenta.",
                                          preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true, completion: nil)
            }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
}
