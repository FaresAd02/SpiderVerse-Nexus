import UIKit
import AVKit

class CeldaNoticias: UICollectionViewCell {
    
    @IBOutlet weak var fuenteLabel: UILabel!
    @IBOutlet weak var descripcionLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var noticiasImageView: UIImageView!
    @IBOutlet weak var botonNoticia: UIButton!
    @IBOutlet weak var videoContainerView: UIView!
    
    var videoPlayer: AVPlayer?
    var videoPlayerLayer: AVPlayerLayer?
    var webButtonAction: (() -> Void)?

    override func layoutSubviews() {
        super.layoutSubviews()
        videoPlayerLayer?.frame = videoContainerView.bounds
        setupRoundedCorners()
        botonNoticia.addTarget(self, action: #selector(webButtonTapped), for: .touchUpInside)
    }
    
    @objc func webButtonTapped() {
        webButtonAction?()
    }
    
    private func setupRoundedCorners() {
        self.layer.cornerRadius = 20.0
        self.layer.masksToBounds = true

        self.contentView.layer.cornerRadius = 20.0
        self.contentView.layer.masksToBounds = true

        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 0.25
        self.layer.masksToBounds = false 
        
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
    }
    
    func configure(with news: Noticias) {
        fuenteLabel.text = news.fuente
        descripcionLabel.text = news.descripcion
        autorLabel.text = news.autor
        
        noticiasImageView.image = UIImage(named: news.imagenUrl)
        
        if let videoUrlString = news.videoUrl, let videoUrl = URL(string: videoUrlString) {
            videoContainerView.isHidden = false
            if videoPlayer == nil {
                videoPlayer = AVPlayer(url: videoUrl)
                videoPlayerLayer = AVPlayerLayer(player: videoPlayer)
                videoPlayerLayer?.videoGravity = .resizeAspect
                videoContainerView.layer.addSublayer(videoPlayerLayer!)
                videoPlayer?.play()
            }
        } else {
            videoContainerView.isHidden = true
            videoPlayer?.pause()
            videoPlayerLayer?.removeFromSuperlayer()
            videoPlayer = nil
            videoPlayerLayer = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        videoPlayer?.pause()
        videoPlayerLayer?.removeFromSuperlayer()
        videoPlayer = nil
        videoPlayerLayer = nil
    }
}
