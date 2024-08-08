import UIKit

class PersonajesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var personajesList: [Personajes] = [
        Personajes(nombre: "Peter Parker / Spider-Man (Tierra-616)", imagenUrl: "spiderman0616.jpg", descripcion: "El Spider-Man original, un joven de Nueva York que adquiere poderes arácnidos tras ser mordido por una araña radiactiva. Valiente y ingenioso, Peter es tanto un científico brillante como un superhéroe, luchando contra los villanos en el universo principal de Marvel (Tierra-616)"),
        Personajes(nombre: "Miles Morales / Spider-Man", imagenUrl: "miles_morales.jpg", descripcion: "Tras la muerte de Peter Parker en su universo (Tierra-1610), este adolescente de Brooklyn es mordido por una araña genéticamente modificada y adquiere habilidades similares a las de Spider-Man. Miles representa una nueva generación de héroes, aportando su propia perspectiva y estilo al manto de Spider-Man."),
        Personajes(nombre: "Gwen Stacy / Spider-Gwen (Tierra-65)", imagenUrl: "gwen_comics.jpg", descripcion: "En su universo (Tierra-65), Gwen Stacy es mordida por la araña radiactiva en lugar de Peter Parker. Como Spider-Woman, lucha contra el crimen con acrobacias y habilidades arácnidas, y se enfrenta a los desafíos de equilibrar su vida de superheroína con su vida personal."),
        Personajes(nombre: "Cindy Moon / Silk ", imagenUrl: "cindy_moon.jpg", descripcion: "Compañera de clase de Peter Parker, Cindy fue mordida por la misma araña radiactiva que a Peter. Como resultado, se convirtió en Silk, una heroína con habilidades arácnidas y una habilidad especial para detectar el peligro."),
        Personajes(nombre: "Miguel O'Hara / Spider-Man 2099", imagenUrl: "miguel_o'hara.jpg", descripcion: "Un genetista brillante del futuro (año 2099) que se convirtió en Spider-Man después de un experimento que buscaba replicar las habilidades de Spider-Man. Con un traje futurista y su propio conjunto de poderes arácnidos, lucha por la justicia en un futuro distópico"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.register(UINib(nibName: "CeldaPersonajes", bundle: nil), forCellWithReuseIdentifier: "CeldaPersonajes")
        
        if #available(iOS 15.0, *) {
                collectionView.contentInsetAdjustmentBehavior = .never
                } else {
                    automaticallyAdjustsScrollViewInsets = false
                }
                collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabBarController?.tabBar.frame.height ?? 0, right: 0)
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return personajesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CeldaPersonajes", for: indexPath) as! CeldaPersonajes
        let personaje = personajesList[indexPath.item]
        cell.configure(with: personaje)
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let collectionViewSize = collectionView.frame.size.width - padding
        let width = collectionView.bounds.width - 35
        let height: CGFloat = 250
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return -50
        }
    
    // UICollectionViewDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CeldaPersonajes
        cell.descripcionPersonaje.isHidden.toggle() 
        cell.nombrePersonaje.isHidden.toggle()
    }
}
