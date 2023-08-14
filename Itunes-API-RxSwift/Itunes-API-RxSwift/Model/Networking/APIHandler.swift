//
//  APIHandler.swift
//  Itunes-API-RxSwift
//
//  Created by Mohamed Salah on 14/08/2023.
//

import Foundation
import RxSwift
import RxCocoa

final class APIHandler {
    let disposeBag = DisposeBag()
    private enum Error: Swift.Error {
        case invalidResponse(URLResponse?)
        case invalidJSON(Swift.Error)
    }
    func fetch() -> Observable<ItunesParser> {
        let url = URL(
            string: "https://itunes.apple.com/search?term=ali&media=all"
        )!
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw Error.invalidResponse(result.response)
                }
                return result.data
            }.map { data in
                do {
                    let searchResult = try JSONDecoder().decode(
                        ItunesParser.self, from: data
                    )
                    return searchResult
                } catch let error {
                    throw Error.invalidJSON(error)
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
    func fetchGlobal<T: Codable>(parsingType: T.Type, url: URL) -> Observable<T> {
        let request = URLRequest(url: url)
        return URLSession.shared.rx.response(request: request)
            .map { result -> Data in
                guard result.response.statusCode == 200 else {
                    throw Error.invalidResponse(result.response)
                }
                return result.data
            }.map { data in
                do {
                    let searchResult = try JSONDecoder().decode(
                        T.self, from: data
                    )
                    return searchResult
                } catch let error {
                    throw Error.invalidJSON(error)
                }
            }
            .observe(on: MainScheduler.instance)
            .asObservable()
    }
    
}
