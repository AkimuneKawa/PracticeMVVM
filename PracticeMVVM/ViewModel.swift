//
//  ViewModel.swift
//  PracticeMVVM
//
//  Created by 河明宗 on 2021/01/05.
//  Copyright © 2021 河明宗. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

final class ViewModel {
    let validationText: Observable<String?>
    let loadLabelColor: Observable<UIColor>
    
    let idTextSubject = PublishSubject<String?>()
    let passwordTextSubject = PublishSubject<String?>()
    
    init(model: ModelProtocol) {
        let event = Observable
            .combineLatest(idTextSubject, passwordTextSubject)
            .flatMap { idText, passwordText -> Observable<Event<Void>> in
                return model
                    .validate(idText: idText, passwordText: passwordText)
                    .materialize()
            }
            .share()

        self.validationText = event
            .flatMap { event -> Observable<String?> in
                switch event {
                case .next:
                    return .just("OK!!!")
                case let .error(error as ModelError):
                    return .just(error.errorText)
                case .error, .completed:
                    return .empty()
                }
            }
            .startWith("IDとPasswordを入力してください。")


        self.loadLabelColor = event
            .flatMap { event -> Observable<UIColor> in
                switch event {
                case .next:
                    return .just(.green)
                case .error:
                    return .just(.red)
                case .completed:
                    return .empty()
                }
        }
    }
}

extension ModelError {
    fileprivate var errorText: String {
        switch self {
        case .invalidIdAndPassword: return "ID と Password が未入力です。"
        case .invalidId: return "ID が未入力です。"
        case .invalidPassword: return "Password が未入力です。"
        }
    }
}
