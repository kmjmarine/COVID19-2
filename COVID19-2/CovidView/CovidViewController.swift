//
//  CovidViewController.swift
//  COVID19-2
//
//  Created by kmjmarine on 2022/02/22.
//

import UIKit
import Alamofire
import Charts

final class CovidViewController: UIViewController {
    
    //메인 뷰 영역
    lazy var covidView: CovidView = {
        return CovidView(frame: self.view.bounds)
    }()
    
    var indicatorView: UIActivityIndicatorView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = covidView

        //self.indicatorView.startAnimating()
    }
    

}

