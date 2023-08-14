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
    }

}
extension ViewController {
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
                let ituneDetailsVc = self.storyboard?.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
                ituneDetailsVc.itune.accept(itune.previewURL)
                self.navigationController?.pushViewController(ituneDetailsVc, animated: true)
            })
            .disposed(by: disposeBag)
    }

    func itunekindResult(itune: ItunesSearchResult) -> String {
        switch itune.kind {
        case .featureMovie, .song:
            return itune.trackName ?? "Unknown"
        case .tvEpisode:
            return itune.artistName
        case .none:
            return "Unknown"
        }
    }
}

