import UIKit
import SafariServices

class NoticiasViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var newsList: [Noticias] = [
        Noticias(fuente: "MeriStation", descripcion: "‘Spider-Man Noir’ será la nueva serie de Amazon Prime Video y estará protagonizada por Nicolas Cage, este se encargará de dar vida a una de las versiones alternativas y más oscuras que hay del Hombre Araña", imagenUrl: "Spider-Man_Noir.jpg", videoUrl: nil, autor: "Cristian Ciuraneta Catalán", webUrl:"https://as.com/meristation/series/nicolas-cage-sera-el-protagonista-de-spider-man-noir-la-nueva-serie-de-amazon-prime-video-n/"),
        Noticias(fuente: "Albertigues", descripcion: "Jon Watts deja atrás la franquicia arácnida en el UCM, aunque antes tiene un consejo para el próximo director de ‘Spider-Man 4′.", imagenUrl: "the_amazing_spiderman_15.jpg", videoUrl: nil, autor: "Alberto Zaragoza Lerma", webUrl: "https://as.com/meristation/noticias/david-fincher-pudo-haber-dirigido-spider-man-pero-creyo-que-su-historia-de-origen-era-estupida-n/"),
        Noticias(fuente: "AS", descripcion: "David Fincher pudo haber dirigido ‘Spider-Man’ pero creyó que su historia de origen era *estúpida*", imagenUrl: "fincher.jpg", videoUrl: nil, autor: "Cristian Ciuraneta Catalán", webUrl: "https://as.com/meristation/cine/el-director-del-spider-man-de-tom-holland-tiene-un-mensaje-para-el-proximo-cineasta-de-la-saga-no-pierdas-el-tiempo-n/")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CeldaNoticias", bundle: nil), forCellWithReuseIdentifier: "CeldaNoticias")
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CeldaNoticias", for: indexPath) as! CeldaNoticias
        let news = newsList[indexPath.item]
        cell.configure(with: news)
        cell.webButtonAction = {
            self.openWebPage(urlString: news.webUrl)
        }
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let collectionViewSize = collectionView.frame.size.width - padding
        let news = newsList[indexPath.item]
        let width = collectionView.bounds.width - 50
        
        let height: CGFloat = news.videoUrl != nil ? 350 : 150
        return CGSize(width: width, height: height)
    }
    
    func openWebPage(urlString: String) {
        if let url = URL(string: urlString) {
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true, completion: nil)
        }
    }
}
