//
//  ItunesViewModel.swift
//  Itunes-API-RxSwift
//
//  Created by Mohamed Salah on 14/08/2023.
//

import Foundation
import RxSwift
import RxRelay
//space and Arabic
//Selection
class ItunesViewModel {
    private let apiHandler: APIHandler
    private let disposeBag = DisposeBag()

    var itunesSearchResultArray = BehaviorRelay<[ItunesSearchResult]>(value: [])
    var errorMessageSubject = PublishSubject<String>()

    init() {
        self.apiHandler = APIHandler()
    }
    func fetchSearchResults(for query: String = "ali") {
        if let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            let urlString = "https://itunes.apple.com/search?term=\(encodedQuery)&media=all"
            if let url = URL(string: urlString) {
                apiHandler.fetchGlobal(parsingType: ItunesParser.self, url: url)
                    .subscribe(onNext: { games in
                        self.itunesSearchResultArray.accept(games.results)
                    }, onError: { error in
                        self.errorMessageSubject.onNext(error.localizedDescription)
                    })
                    .disposed(by: disposeBag)
            } else {
                self.errorMessageSubject.onNext("Invalid URL")
            }
        } else {
            self.errorMessageSubject.onNext("Invalid search query")
        }
    }

}
