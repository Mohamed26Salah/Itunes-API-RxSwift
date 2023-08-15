//
//  ViewController.swift
//  Itunes-API-RxSwift
//
//  Created by Mohamed Salah on 14/08/2023.
//

import UIKit
import RxSwift
import SDWebImage

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var itunesTableView: UITableView!
    var itunesViewModel = ItunesViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itunesTableView.register(UINib(nibName: "ItunesTableViewCell", bundle: nil), forCellReuseIdentifier: "ItunesTableViewCell")
        itunesViewModel.fetchSearchResults()
        showSearchResult()
        search()
        selectedItune()
        reactiveAlert()
    }
    
}

extension ViewController {
    //put In One Function
    func search() {
        searchBar.rx.text.orEmpty
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] query in
                if !query.isEmpty{
                    self?.itunesViewModel.fetchSearchResults(for: query)
                }
            })
            .disposed(by: disposeBag)
    }
    func showSearchResult() {
        itunesViewModel.itunesSearchResultArray
            .bind(to: itunesTableView
                .rx
                .items(cellIdentifier: "ItunesTableViewCell", cellType: ItunesTableViewCell.self)) {
                    (tv, itune, cell) in
                    cell.productImageView.sd_setImage(with: URL(string: itune.artworkUrl100))
                    cell.productNameLabel.text = self.itunekindResult(itune: itune)
                    cell.productKindLabel.text = itune.kind?.rawValue ?? "Unknown"
                    cell.productPriceLabel.text = "\(itune.trackPrice ?? 0.0)"
                }
                .disposed(by: disposeBag)
    }
    func selectedItune() {
        itunesTableView
            .rx.modelSelected(ItunesSearchResult.self)
            .subscribe(onNext: { [weak self] itune in
                guard let self = self else { return }
                
//                if let selectedIndexPath = self.itunesTableView.indexPathForSelectedRow {
                    self.itunesTableView.deselectRow(at: self.itunesTableView.indexPathForSelectedRow!, animated: true)
//                }
                let ituneDetailsVc = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
                ituneDetailsVc.itune.accept(itune.previewURL ?? "https://www.youtube.com/watch?v=AqI97zHMoQw&list=RDAqI97zHMoQw&start_radio=1")
                
                
                self.navigationController?.pushViewController(ituneDetailsVc, animated: true)
            })
            .disposed(by: disposeBag)
        
    }
    
    func reactiveAlert() {
        itunesViewModel.errorMessageSubject
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] errorMessage in
                self?.showAlert(with: errorMessage)
            })
            .disposed(by: disposeBag)
    }
    func itunekindResult(itune: ItunesSearchResult) -> String {
        switch itune.kind {
        case .featureMovie, .song:
            return itune.trackName ?? "Unknown"
        case .tvEpisode:
            return itune.artistName
        case .podcast:
            return "Unknown"
        case .none:
            return "Unknown"
        }
    }
    
    private func showAlert(with message: String) {
          let alertController = UIAlertController(title: "yala 5roga", message: message, preferredStyle: .alert)
          alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
          self.present(alertController, animated: true, completion: nil)
      }
}

