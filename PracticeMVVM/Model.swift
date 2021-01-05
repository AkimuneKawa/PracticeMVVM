//
//  Model.swift
//  PracticeMVVM
//
//  Created by 河明宗 on 2021/01/05.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import RxSwift

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
}

protocol ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Observable<Void>
}

final class Model: ModelProtocol {
    func validate(idText: String?, passwordText: String?) -> Observable<Void> {
        switch (idText, passwordText) {
        case (.none, .none):
            return Observable.error(ModelError.invalidIdAndPassword)
        case (.some, .none):
            return Observable.error(ModelError.invalidPassword)
        case (.none, .some):
            return Observable.error(ModelError.invalidId)
        case (let idText?, let passwordText?):
            switch (idText.isEmpty, passwordText.isEmpty) {
            case (true, true):
                return Observable.error(ModelError.invalidIdAndPassword)
            case (false, true):
                return Observable.error(ModelError.invalidPassword)
            case (true, false):
                return Observable.error(ModelError.invalidId)
            case (false, false):
                return Observable.just(())
            }
        }
    }
}
