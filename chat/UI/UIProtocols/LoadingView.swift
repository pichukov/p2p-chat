//
//  LoadingView.swift
//  chat
//
//  Created by Alexey Pichukov on 05.11.2017.
//  Copyright © 2017 Alexey Pichukov. All rights reserved.
//

import Foundation
import UIKit

class LoadingView {
    
    private var container: UIView?
    
    func show(onView view: UIView) {
        container = UIView()
        container!.frame = view.frame
        container!.center = view.center
        container!.backgroundColor = UIColor(white: 0, alpha: 0.3)
        
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = view.center
        loadingView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        actInd.activityIndicatorViewStyle =
            UIActivityIndicatorViewStyle.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container!.addSubview(loadingView)
        view.addSubview(container!)
        actInd.startAnimating()
    }
    
    func hide() {
        guard container != nil else {
            assert(false, "Error: LoadingView.\(#function) - container is nil")
            return
        }
        container!.removeFromSuperview()
    }
}
