//
//  HeroCarouselItem.swift
//  Vought Showcase
//
//  Created by Rishav chandra on 15/07/25.
//

import UIKit

final class HeroCarouselItem: CarouselItem {
    private var viewController: UIViewController?
    private var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
    
    func getController() -> UIViewController {
        // Check if view controller is already created
        // If not, create new view controller
        // else return the existing view controller
        guard let viewController = viewController else {
            viewController = ImageViewController(imageName: imageName)
            return viewController!
        }
        return viewController
    }
}
