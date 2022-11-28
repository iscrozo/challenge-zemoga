//
//  NotificationBannerRender.swift
//  challenge-zemoga
//
//  Created by Camilo Rozo on 28/11/22.
//

import Foundation

import Foundation
import UIKit
import NotificationBannerSwift

struct NotificationBannerRender {
    static func showBanner(lsTitleBanner: String, lsDescriptionBanner: String, styleBanner: BannerStyle){
        NotificationBanner(title: lsTitleBanner,  subtitle: lsDescriptionBanner,  style: styleBanner).show()
    }
}
