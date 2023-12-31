//
//  SFSymbols.swift
//  RickAndMortyApp
//
//  Created by Murat on 23.12.2023.
//

import Foundation
import UIKit

enum SFSymbols{
    static let loacation = UIImage(systemName: "location.fill" )!
    static let origin = UIImage(systemName: "house.circle.fill")!
    static let star =  UIImage(systemName: "star")!.resized(to: CGSize(width: 50, height: 50), tintColor: .systemYellow)
    static let fillStar = UIImage(systemName: "star.fill")!.resized(to: CGSize(width: 50, height: 50), tintColor: .systemYellow)
    static let circleGreen = UIImage(systemName: "circle.fill")!.resized(to: CGSize(width: 10, height: 10), tintColor: .systemGreen)
    static let circleRed = UIImage(systemName: "circle.fill")!.resized(to: CGSize(width: 10, height: 10), tintColor: .systemRed)
    static let circleGray = UIImage(systemName: "circle.fill")!.resized(to: CGSize(width: 10, height: 10), tintColor: .systemGray)
}
