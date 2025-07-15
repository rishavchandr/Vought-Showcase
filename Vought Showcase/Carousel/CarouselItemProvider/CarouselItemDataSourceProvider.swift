//
//  CarouselItemDataSourceProvider.swift
//  Vought Showcase
//
//  Created by Burhanuddin Rampurawala on 06/08/24.
//

import Foundation
import UIKit

class CarouselItemDataSourceProvider: CarouselItemDataSourceProviderType {
    private let imageList  = ["butcher" , "frenchie", "hughei" , "mm"]
    
    private lazy var carouselList: [CarouselItem] = {
        return imageList.map {HeroCarouselItem(imageName: $0)}
    }()
    
    
    func items() -> [CarouselItem] {
        return carouselList
    }
}

