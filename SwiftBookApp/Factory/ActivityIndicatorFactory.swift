//
//  ActivityIndicatorBuilder.swift
//  SwiftBookApp
//
//  Created by Alexey Turulin on 9/26/23.
//

import UIKit

protocol ActivityIndicatorFactoryProtocol {
    func createActivityIndicator() -> UIActivityIndicatorView
}

final class ActivityIndicatorFactory: ActivityIndicatorFactoryProtocol {
    let style: UIActivityIndicatorView.Style
    
    init(style: UIActivityIndicatorView.Style) {
        self.style = style
    }
    
    func createActivityIndicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: style)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.color = .black
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        return activityIndicator
    }
}
