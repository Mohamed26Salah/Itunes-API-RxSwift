//
//  ItunesViewModel.swift
//  Itunes-API-RxSwift
//
//  Created by Mohamed Salah on 14/08/2023.
//

import Foundation
import RxSwift
import RxRelay

class ItunesViewModel {
    private let apiHandler: APIHandler
    private let disposeBag = DisposeBag()

    var itunesSearchResultArray = BehaviorRelay<[ItunesSearchResult]>(value: [])
    var errorMessage: String = ""
    init() {
        self.apiHandler = APIHandler()
    }
    func fetchSearchResults(for query: String = "ali") {
        let url = URL(
            string: "https://itunes.apple.com/search?term=\(query)&media=all"
        )!
        apiHandler.fetchGlobal(parsingType: ItunesParser.self, url: url).subscribe(onNext: { games in
            self.itunesSearchResultArray.accept(games.results)
        }, onError: { error in
            self.errorMessage = error.localizedDescription
        }).disposed(by: disposeBag)
    }
}
