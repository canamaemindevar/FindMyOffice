//
//  OfficeDetailPresenter.swift
//  FindMyOffice
//
//  Created by Emincan on 6.08.2022.
//

import Foundation

protocol OfficeDetailPresentationLogic: AnyObject {
    func presentOfficeDetail(response: OfficeDetail.Fetch.Response)
    }

final class OfficeDetailPresenter: OfficeDetailPresentationLogic {
    func presentOfficeDetail(response: OfficeDetail.Fetch.Response) {
        viewController?.displayOfficeDetail(viewModel:
                                                OfficeDetail.Fetch.ViewModel(
                                                    name: response.officeDetail?.name,
                                                    address: response.officeDetail?.address,
                                                    rooms: response.officeDetail?.rooms,
                                                    capacity: response.officeDetail?.capacity,
                                                    space: response.officeDetail?.space,
                                                    image: response.officeDetail?.image, images: OfficeDetail.Fetch.ViewModel.Media(url:
                                                                                                                                        response.officeDetail?.images,
                                                                                                                                    isVideo: Bool.random()), latitude: response.officeDetail?.location?.latitude,
                                                    longitude: response.officeDetail?.location?.longitude))
    }

    weak var viewController: OfficeDetailDisplayLogic?
    
}

/*
 images: OfficeDetail.Fetch.ViewModel.Media(url:
                                             response.officeDetail?.images,
                                            isVideo: Bool.random())))
 */
