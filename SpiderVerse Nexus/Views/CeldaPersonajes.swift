import UIKit

class CeldaPersonajes: UICollectionViewCell {

    @IBOutlet weak var nombrePersonaje: UILabel!
    @IBOutlet weak var personajeImagen: UIImageView!
    @IBOutlet weak var descripcionPersonaje: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupRoundedCorners()
        setupOverlay()
    }
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private func setupOverlay() {
        personajeImagen.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            overlayView.topAnchor.constraint(equalTo: personajeImagen.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: personajeImagen.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: personajeImagen.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: personajeImagen.bottomAnchor)
        ])
    }
    
    private func setupRoundedCorners() {
        self.layer.cornerRadius = 30.0
        self.layer.masksToBounds = false

        self.contentView.layer.cornerRadius = 30.0
        self.contentView.layer.masksToBounds = true
        
        self.personajeImagen.layer.cornerRadius = 30.0
        self.personajeImagen.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.25
        self.layer.masksToBounds = false
    }
    
    func configure(with personaje: Personajes) {
        nombrePersonaje.text = personaje.nombre
        personajeImagen.image = UIImage(named: personaje.imagenUrl)
        descripcionPersonaje.text = personaje.descripcion
        descripcionPersonaje.isHidden = true
    }

}
