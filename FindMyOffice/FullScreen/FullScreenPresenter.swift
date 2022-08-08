//
//  FullScreenPresenter.swift
//  FindMyOffice
//
//  Created by Emincan on 8.08.2022.
//

import Foundation

protocol FullScreenPresentationLogic: AnyObject {
    func presentPics(response: FullScreen.Fetch.Response)
}

final class FullScreenPresenter: FullScreenPresentationLogic {
    func presentPics(response: FullScreen.Fetch.Response) {
        let office = response.responseImages
        viewController?.displayPics(viewModel: FullScreen.Fetch.ViewModel(images: office?.images ?? []))
    }
    
    
    weak var viewController: FullScreenDisplayLogic?
    
}
