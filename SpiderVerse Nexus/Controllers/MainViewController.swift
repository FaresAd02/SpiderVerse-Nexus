import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var imagenInicio: UIImageView!
    @IBOutlet weak var gifImageView: UIImageView!
    @IBOutlet weak var contenidoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        let swinging_spider=UIImage.gifImageWithName("swingin_spider")
        gifImageView.image = swinging_spider
    }
}
