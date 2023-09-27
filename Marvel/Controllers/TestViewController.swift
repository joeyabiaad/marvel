//
//  TestViewController.swift
//  Marvel
//
//  Created by Joey Abi Aad on 26/09/2023.
//

import UIKit
import Moya
import SwiftyJSON

class TestViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    
    /// pagination
    private var pageIndex: Int = 0
    private let limit: Int = 20
    private var isFetchingData: Bool = false
    private var hasMoreData: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.getCharacters()
    }
}

//// MARK: - APIs
//
//extension TestViewController {
//
//    func getCharacters() {
//
//        let provider = MoyaProvider<CharactersService>(plugins: [NetworkLoggerPlugin()])
//
//        provider.request(CharactersService.getCharacters) { [weak self] (result) in
//            guard let self = self else { return }
//            defer {
//            }
//
//            switch result {
//            case let .success(response):
//                do {
//                    #if DEBUG
//                    let json = try JSON(data: response.data)
//                    print(json)
//                    print(response.statusCode)
//                    #endif
//                    let status = HttpStatus(rawValue: response.statusCode) ?? .none
//                    if status.success {
//                        let result = try JSONDecoder().decode(CharactersModel.self, from: response.data)
//                        self.textLabel.text = result.data?.results?.first?.name
//                    } else {
//                        let error = try JSONDecoder().decode(ErrorModel.self, from: response.data)
//                        print(error.errors)
//                    }
//                } catch {
//                    print(Messages.unexpectedError)
//                }
//            case .failure(_):
////                print(Messages.noNetwork) { [weak self] (okPressed) in
////                    guard let self = self else { return }
////                    if okPressed {
//                        self.getCharacters()
////                    }
////                }
//            }
//        }
//    }
//}
