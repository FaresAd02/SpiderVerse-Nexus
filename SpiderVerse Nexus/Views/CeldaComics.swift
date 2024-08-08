import UIKit

class CeldaComics: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var descargarButton: UIButton!
    
    var infoAction: (() -> Void)?
    var descargaAction: (() -> Void)?

    
    @IBAction func infoButtonTapped(_ sender: UIButton) {
        infoAction?()
    }
    
    @IBAction func descargaButtonTapped(_ sender: UIButton) {
        descargaAction?()
    }
    
    func configure(with comic: Comics) {
        tituloLabel.text = comic.titulo
        if let image = UIImage(named: comic.thumbnailUrl) {
                    thumbnailImageView.image = image
        }
    }
}
