import UIKit
import FirebaseAuth
import FirebaseFirestore

class ActualizarInfoController: UIViewController {
    
    @IBOutlet weak var actualizarNombre: UITextField!
    @IBOutlet weak var actualizarApellido: UITextField!
    @IBOutlet weak var actualizarTelefono: UITextField!
    @IBOutlet weak var actualizarPassword: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var botonMostrarPass: UIButton!
    @IBOutlet weak var botonCancelar: UIButton!
    @IBOutlet weak var botonActualizar: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadUserData()
        setupHideKeyboardOnTap()
        botonMostrarPass.addTarget(self, action: #selector(cambiarVisibilidad), for: .touchUpInside)
    }
    
    @objc func cambiarVisibilidad() {
        actualizarPassword.isSecureTextEntry.toggle()
    }
    
    func setupHideKeyboardOnTap() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func loadUserData() {
        guard let user = Auth.auth().currentUser else { return }
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)

        userRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.actualizarNombre.text = data?["nombre"] as? String
                self.actualizarApellido.text = data?["apellido"] as? String
                self.actualizarTelefono.text = data?["telefono"] as? String
                self.emailTextField.text = data?["email"] as? String
                self.emailTextField.isEnabled = false
            } else {
                print("Document does not exist")
            }
        }
    }

    @IBAction func updateButtonTapped(_ sender: UIButton) {
        guard let user = Auth.auth().currentUser else { return }

        var updateData: [String: Any] = [:]

        if let nombre = actualizarNombre.text, !nombre.isEmpty {
            updateData["nombre"] = nombre
        }
        if let apellido = actualizarApellido.text, !apellido.isEmpty {
            updateData["apellido"] = apellido
        }
        if let telefono = actualizarTelefono.text, !telefono.isEmpty {
            updateData["telefono"] = telefono
        }
        
        if let newPassword = actualizarPassword.text, !newPassword.isEmpty {
            let alertController = UIAlertController(title: "Reautenticación", message: "Por favor ingresa tu contraseña actual para continuar", preferredStyle: .alert)
            alertController.addTextField { textField in
                textField.isSecureTextEntry = true
                textField.placeholder = "Contraseña actual"
            }
            let confirmAction = UIAlertAction(title: "Confirmar", style: .default) { _ in
                if let currentPassword = alertController.textFields?.first?.text {
                    self.reauthenticateUser(currentPassword: currentPassword, newPassword: newPassword, updateData: updateData)
                }
            }
            let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
            alertController.addAction(confirmAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        } else {
            updateUserData(user: user, updateData: updateData)
        }
    }

    func reauthenticateUser(currentPassword: String, newPassword: String, updateData: [String: Any]) {
        guard let user = Auth.auth().currentUser, let email = emailTextField.text else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: email, password: currentPassword)
        user.reauthenticate(with: credential) { [weak self] result, error in
            if let error = error {
                self?.showAlert(title: "Error", message: "Hubo un error al reautenticar: \(error.localizedDescription)")
            } else {
                user.updatePassword(to: newPassword) { error in
                    if let error = error {
                        self?.showAlert(title: "Error", message: "Hubo un error al actualizar la contraseña: \(error.localizedDescription)")
                    } else {
                        self?.updateUserData(user: user, updateData: updateData)
                    }
                }
            }
        }
    }
    
    func updateUserData(user: User, updateData: [String: Any]) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(user.uid)

        userRef.updateData(updateData) { [weak self] error in
            if let error = error {
                self?.showAlert(title: "Error", message: "Hubo un error al actualizar la información: \(error.localizedDescription)")
            } else {
                self?.showAlert(title: "Éxito", message: "Información actualizada correctamente.")
            }
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
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
