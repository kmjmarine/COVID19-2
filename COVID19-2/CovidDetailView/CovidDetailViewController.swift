//
//  CovidDetailViewController.swift
//  COVID19-2
//
//  Created by kmjmarine on 2022/02/23.
//

import Foundation
import UIKit

final class CovidDetailViewController: UITableViewController {
    
    var covidOverview: CovidOverview? //선택된 지역의 코로나 현황 데이터 전달 받음
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CovidListCell.self, forCellReuseIdentifier: "CovidListCell")
        
        self.configureOverview()
    }

    func configureOverview() {
        //covidOverview 프로퍼티를 옵셔널 바인딩 함
        guard let covidOverview = self.covidOverview else {
            return
        }
        self.title = covidOverview.countryName //네이게이션바 타이틀에 지역이름 표시
//        self.newCaseCell.detailTextLabel?.text = "\(covidOverview.newCase)명"
//        self.totalCaseCell.detailTextLabel?.text = "\(covidOverview.totalCase)명"
//        self.recoveredCell.detailTextLabel?.text = "\(covidOverview.recovered)명"
//        self.deathCell.detailTextLabel?.text = "\(covidOverview.death)명"
//        self.percentageCell.detailTextLabel?.text = "\(covidOverview.percentage)%"
//        self.overseasInflowCell.detailTextLabel?.text = "\(covidOverview.newFcase)명"
//        self.regionalOutbreakCell.detailTextLabel?.text = "\(covidOverview.newCase)명"
    }
    
}
