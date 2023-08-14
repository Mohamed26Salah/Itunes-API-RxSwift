//
//  DetailsViewController.swift
//  Itunes-API-RxSwift
//
//  Created by Mohamed Salah on 15/08/2023.
//
import UIKit
import RxSwift
import RxCocoa
import RxRelay
import AVKit

class DetailsViewController: UIViewController {

    let itune: BehaviorRelay<String> = BehaviorRelay<String>(value: "")
    let ituneDetailsDisposeBag = DisposeBag()
    var trailerURL: URL?

    override func viewDidLoad() {
        super.viewDidLoad()
        itune
            .subscribe(onNext: { [weak self] itune in
                self?.trailerURL = URL(string: itune)
            })
            .disposed(by: ituneDetailsDisposeBag)
    }

    
    @IBAction func viewTrailerTapped(_ sender: UIButton) {
        if let url = trailerURL {
            playTrailer(url: url)
        }
    }
    
    func playTrailer(url: URL) {
        let player = AVPlayer(url: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        
        present(playerViewController, animated: true) {
            player.play()
        }
    }
}
