//
//  RankingCellViewModel.swift
//  BringChuChuba
//
//  Created by 홍다희 on 2021/01/24.
//

import Foundation

import RxCocoa
import RxSwift

class RankingCellViewModel {

    let rank = BehaviorRelay<Int?>(value: nil)
    let title = BehaviorRelay<String?>(value: nil)
    let detail = BehaviorRelay<String?>(value: nil)
    //    let image = BehaviorRelay<UIImage?>(value: nil)

    init() { }

    init(with title: String, detail: String) {
        self.title.accept(title)
        self.detail.accept(detail)
    }

}
