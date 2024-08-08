import UIKit
import FirebaseStorage

class ComicsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var descargasButton: UIButton!
    
    var comics: [Comics] = [
        Comics(titulo: "", thumbnailUrl: "gwen.jpg", descripcion: "Edge of SpiderVerse #2\n\n Sinopsis:\n Spider-Gwen, la versión de Gwen Stacy que se convierte en Spider-Woman en el universo Tierra-65. En este universo, Peter Parker se convierte en el Lagarto y muere durante una batalla con Gwen, quien es culpada por su muerte.Gwen lucha con su culpa y al final del cómic revela su identidad secreta a su padre, el capitán de policía George Stacy", descargaUrl: "gs://spiderverse-nexus.appspot.com/edge of spiderverse #2.pdf"),
        Comics(titulo: "", thumbnailUrl: "edge_spiderverse_3.jpg", descripcion: "Edge of SpiderVerse #3\n\n Sinopsis:\n En este se presenta a Aaron Aikman, el Spider-Man de un universo alternativo. Aaron es un científico brillante que se inyecta a sí mismo con un suero de ADN de araña para obtener habilidades especiales. En este cómic, lucha contra una villana llamada Naamurah", descargaUrl: "gs://spiderverse-nexus.appspot.com/edge of spiderverse #3(2014).pdf"),
        Comics(titulo: "", thumbnailUrl: "edge_spiderverse_4.jpg", descripcion: "Edge of SpiderVerse #4\n\n Sinopsis:\n El comic nos lleva al universo de Patton Parnel, una versión más siniestra de Peter Parker. Patton, un estudiante de secundaria, es mordido por una araña genéticamente modificada durante una visita escolar. Sin embargo, en lugar de convertirse en un héroe, usa sus nuevos poderes de manera perturbadora. ", descargaUrl: "gs://spiderverse-nexus.appspot.com/edge of spiderverse #4(2014).pdf"),
        Comics(titulo: "", thumbnailUrl: "edge_spiderverse_5.jpg", descripcion: "Edge of SpiderVerse #5\n\n Sinopsis:\n El comic presenta a Peni Parker, una adolescente huérfana que heredó el traje biomecánico SP//dr de su difunto padre. Se une a Daredevil para luchar contra Mysterio, quien planea desatar a su monstruo en la ciudad. Mientras tanto, los cazadores de herederos se acercan a Peni, señalando el evento Spider-Verse inminente. Al final del cómic, SP//dr se une a la lucha en el Spider-Verse.", descargaUrl: "gs://spiderverse-nexus.appspot.com/edge of spiderverse #5(2014).pdf"),
        Comics(titulo: "", thumbnailUrl: "Scarlet_Spiders_Vol_1_1.jpg", descripcion: "Scarlet Spiders #1\n\n Sinopsis:\n En el comic , los clones de Peter Parker (Ben Reilly, Kaine y Ultimate Jessica Drew) se infiltran en el universo de origen de los Herederos. Descubren una fábrica de clones que crea cuerpos de repuesto para los Herederos y se enfrentan a Jennix, el Heredero responsable de la tecnología de clonación.", descargaUrl: "gs://spiderverse-nexus.appspot.com/scarlet spiders #1.pdf"),
        Comics(titulo: "", thumbnailUrl: "Scarlet_Spiders_Vol_1_2.jpg", descripcion: "Scarlet Spiders #2\n\n Sinopsis:\n En el comic , Ben Reilly (Scarlet Spider), Kaine (otro Scarlet Spider) y Jessica Drew (Spider-Woman de la Tierra-1610) están en la Tierra de los Inheritors y descubren la fuente de sus clones. Mientras exploran el lugar, son atacados por los clones de los Inheritors. En la lucha, descubren que los Inheritors no pueden ser asesinados de manera permanente ya que sus conciencias pueden transferirse a cuerpos clonados. Al final, deciden destruir la instalación de clonación.", descargaUrl: "gs://spiderverse-nexus.appspot.com/scarlet spiders #2.pdf"),
        Comics(titulo: "", thumbnailUrl: "Scarlet_Spiders_Vol_1_3.jpg", descripcion: "Scarlet Spiders #3\n\n Sinopsis:\n En el comic, es la emocionante conclusión de la miniserie en la que Ben Reilly, Kaine y la Black Widow de la Tierra-1610 se infiltran en la base de los Inheritors en la Tierra-001. Descubren que los Inheritors han estado clonando sus cuerpos para resucitar cada vez que mueren.", descargaUrl: "gs://spiderverse-nexus.appspot.com/scarlet spiders #3.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Man_2099_Vol_2_6.jpg", descripcion: "Spider-Man 2099 (vol. 2) #6\n\n Sinopsis:\n En el comic , Miguel O'Hara (Spider-Man 2099) se une a Lady Spider del siglo XIX en una misión para descubrir la verdadera naturaleza y debilidad de los Herederos. Logran secuestrar el cuerpo del Heredero derrotado, Daemos, y comienzan a estudiarlo, lo que les brinda información clave sobre cómo detener a los villanos. Pero su victoria es breve, pues los Herederos atacan, en busca de recuperar el cuerpo de su hermano.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-man 2099 #6.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Man_2099_Vol_2_7.jpg", descripcion: "Spider-Man 2099 (vol. 2) #7\n\n Sinopsis:\n En el comic , Miguel O'Hara (Spider-Man 2099) y Lady Spider (May Reilly de la Tierra-803) llevan el cuerpo del robot asesinado de Master Weaver al siglo 22, buscando una manera de revivirlo. Allí, utilizan la avanzada tecnología del siglo 22 para intentar arreglar el robot y obtener respuestas sobre los Inheritors. Mientras tanto, siguen siendo perseguidos por los Inheritors, quienes están decididos a recuperar el cuerpo del Master Weaver.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-man 2099 #7.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Verse_Vol_1_1.jpg", descripcion: "Spider-Verse #1\n\n Sinopsis:\n Este comic es una recopilación de historias centradas en distintas versiones de Spider-Man en diferentes universos. Estas incluyen al Spider-Man de un universo de anime, la Lady Spider de un universo estilo victoriano, una joven versión femenina de Peter Parker, una niña llamada Peni Parker que pilota un traje de Spider-Man biomecánico en un futuro distante.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-verse #1.pdf.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Verse_Vol_1_2.jpg", descripcion: "Spider-Verse #2\n\n Sinopsis:\n El comic sigue a varios equipos de Spider-Totems mientras luchan contra los Inheritors en varios frentes.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-verse #2.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Verse_Team-Up_Vol_1_1.jpg", descripcion: "Spider-Verse Team-Up #1\n\n Sinopsis:\n En el comic El comic es una recopilación de historias que presenta diversos equipos de Spider-Men uniendo fuerzas para enfrentar a los Inheritors. ", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-verse teamup #1.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Verse_Team-Up_Vol_1_2.jpg", descripcion: "Spider-Verse Team-Up #2\n\n Sinopsis:\n El comic cuenta dos historias en un cómic. La primera historia lleva a Peter Parker, Spider-Man Noir y Six-Armed Spider-Man a la Tierra-7831, donde trabajan juntos. En la segunda historia, Spider-Ham, Spider-Monkey y Spider-Gwen se embarcan en una misión de rescate en un universo de animales.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-verse teamup #2.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Verse_Team-Up_Vol_1_3.jpg", descripcion: "Spider-Verse Team-Up #3\n\n Sinopsis:\n El comic presenta dos historias paralelas. En la primera, Spider-Man Noir y Six-Armed Spider-Man ayudan a un joven Peter Parker, aún en la etapa inicial de su carrera de superhéroe, a lidiar con la amenaza de un Inheritor. En la segunda historia, Spider-Ham y el Spider-Man de la serie animada de 1967 intentan evitar que el Inheritor, llamado Bora, acabe con el Spider-Man de ese universo, quien no está dispuesto a abandonar su mundo.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-verse teamup #3.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Woman_Vol_5_1.jpg", descripcion: "Spider-Woman (vol. 5) #1\n\n Sinopsis:\n En el comic Jessica Drew (Spider-Woman) es reclutada por Silk y Spider-Man para una misión encubierta en el corazón del reino de los Inheritors, Loomworld, ubicado en Tierra-001. Jessica cambia de lugar con la Inheritor conocida como la Madre de los Inheritors, con la esperanza de infiltrarse y encontrar información vital para derrotarlos.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-woman #1.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Woman_Vol_5_2.jpg", descripcion: "Spider-Woman (vol. 5) #2\n\n Sinopsis:\n En el comic, Jessica Drew (Spider-Woman) y Gwen Stacy (Spider-Woman de Tierra-65) se dirigen al universo de origen de los Herederos, intentando descubrir más acerca de sus enemigos. Jessica logra infiltrarse y obtener información valiosa, pero es descubierta por los Herederos. Ella y Gwen logran escapar, pero la traición de un aliado en las sombras hace que su misión sea más peligrosa. ", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-woman #2.pdf"),
        Comics(titulo: "", thumbnailUrl: "Spider-Woman_Vol_5_3.jpg", descripcion: "Spider-Woman (vol. 5) #3\n\n Sinopsis:\n En el comic, Jessica Drew (Spider-Woman) y Gwen Stacy (Spider-Gwen) se infiltran en Loomworld, el hogar de los Inheritors, disfrazándose como sirvientas. Mientras tanto, Silk, quien ha sido atraída a Loomworld debido a su conexión única con los Inheritors, es capturada.", descargaUrl: "gs://spiderverse-nexus.appspot.com/spider-woman #3.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_10.jpg", descripcion: "Amazing Spider-Man (vol. 3) #10\n\n Sinopsis:\n En este numero Spider-Men de diversas realidades unen fuerzas contra los Inheritors. Se forman dos equipos: uno liderado por Peter Parker y otro por el Superior Spider-Man (Doctor Octopus en cuerpo de Peter). En este enfrentamiento, Morlun, un Inheritor, captura a Silk para consumirla en su hogar, la Tierra-001. ", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #10.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_11.jpg", descripcion: "Amazing Spider-Man (vol. 3) #11\n\n Sinopsis:\n Este comic destaca por la batalla que ocurre en la Tierra-13 entre los Spider-Totems y los Inheritors. Este universo ha permanecido seguro gracias a su Peter Parker, que ha adquirido la Capa del Enigma, volviéndose casi invulnerable.", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #11.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_12.jpg", descripcion: "Amazing Spider-Man (vol. 3) #12\n\n Sinopsis:\n En el comic, la batalla se intensifica cuando los Spider-Men de varias realidades se enfrentan contra los Herederos. Sin embargo, los Herederos parecen tener ventaja, capturando a algunos Spider-Men, incluyendo a Silk. Durante la batalla, Peter Parker se une con Otto Octavius, el Spider-Man Superior, y juntos forman un plan para rescatar a los Spider-Men capturados y derrotar a los Herederos.", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #12.pdf.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_13.jpg", descripcion: "EAmazing Spider-Man (vol. 3) #13\n\n Sinopsis:\n En el comic, los equipos de Spider-Men se reagrupan y se preparan para el asalto final contra los Inheritors. Peter Parker dirige a los Spiders a la Tierra-3145, un universo post-apocalíptico irradiado por la radiación de un bombardeo nuclear que resulta letal para los Inheritors.", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #13.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_14.jpg", descripcion: "Amazing Spider-Man (vol. 3) #14\n\n Sinopsis:\n En el comic, los Spider-Totems, liderados por Peter Parker y Spider-Gwen, lanzan su asalto final en Loomworld, hogar de los Inheritors. Kaine,el otro clon de Peter Parker, mata a Solus, el padre de los Inheritors, cambiando el curso de la batalla.", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #14.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_7.jpg", descripcion: "Amazing Spider-Man (vol. 3) #7\n\n Sinopsis:\n Este comic es un preludio a la saga Spider-Verse. En este número, Spider-Man (Peter Parker) se une a Ms. Marvel para enfrentarse a una nueva amenaza llamada The Shocker. Mientras tanto, en una trama secundaria, Spider-UK se da cuenta de que los Spider-Men de diferentes universos están siendo cazados, lo que establece el escenario para los eventos del Spider-Verse. ", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #7.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_8.jpg", descripcion: "Amazing Spider-Man (vol. 3) #8\n\n Sinopsis:\n Este cómic cuenta con dos historias. En la primera, May Parker, tía de Peter Parker, y su novio, J. Jonah Jameson Sr., están de visita en Nueva York para pasar tiempo con su familia. Mientras tanto, Spider-Man está luchando contra una versión femenina de Electro a la cual con la ayuda de la Chica Ardilla. ", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #8.pdf"),
        Comics(titulo: "", thumbnailUrl: "Amazing_Spider-Man_Vol_3_9.jpg", descripcion: "Amazing Spider-Man (vol. 3) #9\n\n Sinopsis:\n En este cómic, la historia principal de Spider-Verse comienza con Morlun, un miembro de los Inheritors, asesinando a Spider-Man Noir. Este evento catastrófico desencadena una alarma a través del multiverso de Spider-Men, incluido Peter Parker del universo principal, la Tierra-616. ", descargaUrl: "gs://spiderverse-nexus.appspot.com/the amazing spiderman(2014) #9.pdf"),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CeldaComics", bundle: nil), forCellWithReuseIdentifier: "CeldaComics")
        
        // Configurar el botón de navegación
        descargasButton.addTarget(self, action: #selector(mostrarDescargas), for: .touchUpInside)
    }
    
    // Mostrar la lista de descargas
    @objc func mostrarDescargas() {
        let alertController = UIAlertController(title: "Descargas", message: nil, preferredStyle: .actionSheet)
        
        let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: documentsPath, includingPropertiesForKeys: nil)
            for fileURL in fileURLs {
                let action = UIAlertAction(title: fileURL.lastPathComponent, style: .default) { _ in
                    self.handleFileSelection(fileURL: fileURL)
                }
                alertController.addAction(action)
            }
        } catch {
            print("Error al listar los archivos descargados: \(error)")
        }
        
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController {
            popoverController.barButtonItem = navigationItem.rightBarButtonItem
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    func handleFileSelection(fileURL: URL) {
        print("Selected file URL: \(fileURL)")
        let documentInteractionController = UIDocumentInteractionController(url: fileURL)
        documentInteractionController.delegate = self
        documentInteractionController.presentPreview(animated: true)
    }
    
    // UICollectionViewDataSource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CeldaComics", for: indexPath) as! CeldaComics
        let comic = comics[indexPath.item]
        cell.configure(with: comic)
        
        cell.infoAction = {
            self.mostrarInfo(for: comic)
        }
        
        cell.descargaAction = {
            self.descargarComics(from: comic.descargaUrl)
        }
        
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let collectionViewSize = collectionView.frame.size.width - padding
        let width = collectionViewSize / 2
        return CGSize(width: width, height: width * 1.0)
    }
    
    func mostrarInfo(for comic: Comics) {
        let alertController = UIAlertController(title: comic.titulo, message: comic.descripcion, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cerrar", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func descargarComics(from url: String) {
        let storageRef = Storage.storage().reference(forURL: url)
        storageRef.downloadURL { (url, error) in
            if let error = error {
                print("Error al obtener la URL de descarga: \(error)")
                return
            }
            
            guard let downloadUrl = url else { return }
            
            let task = URLSession.shared.downloadTask(with: downloadUrl) { location, response, error in
                guard let location = location, error == nil else { return }
                
                let documentsPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
                let destinationURL = documentsPath.appendingPathComponent(response?.suggestedFilename ?? downloadUrl.lastPathComponent)
                
                do {
                    try FileManager.default.moveItem(at: location, to: destinationURL)
                    DispatchQueue.main.async {
                        let alertController = UIAlertController(title: "Descarga Completa", message: "El cómic se ha descargado correctamente.", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alertController, animated: true, completion: nil)
                    }
                } catch {
                    print("Error al mover el archivo: \(error)")
                }
            }
            
            task.resume()
        }
    }
}

extension ComicsViewController: UIDocumentInteractionControllerDelegate {
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController {
        return self
    }
}
