//
//  ProductsPresenter.swift
//  RicosCafe
//
//  Created by Bruce McTigue on 12/31/18.
//  Copyright © 2018 tiguer. All rights reserved.
//

import UIKit
import Tiguer

extension Products {
    final class Presenter<Model, ViewModel>: Tiguer.Presenter<Model, ViewModel> {
        
        public override init(_ models: [Model] = [Model](), main: Dispatching = AsyncQueue.main, background: Dispatching = AsyncQueue.background) {
            super.init(models, main: main, background: background)
        }
        
        override var baseViewModels: [ViewModel] {
            var resultModels = [ViewModel]()
            let productModels = models as! [Product]
            for model in productModels {
                let displayedModel = Products.ViewModel(productId: model.productId, name: model.name, text: model.text)
                resultModels.append(displayedModel as! ViewModel)
            }
            return resultModels
        }
        
        override func updatedViewModels(completionHandler: @escaping ([ViewModel]) -> Void) {
            background.dispatch { [weak self] in
                if let self = self {
                    self.main.dispatch {
                        completionHandler(self.viewModels)
                    }
                }
            }
        }
    }
}