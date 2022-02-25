//
//  CovidDetailViewController.swift
//  COVID19-2
//
//  Created by kmjmarine on 2022/02/23.
//

import UIKit
import SnapKit

final class CovidDetailViewController: UIViewController {
    var covidOverview: CovidOverview? //선택된 지역의 코로나 현황 데이터 전달 받음
    
    var cellLabelList: [String] = ["신규 확진자", "누적 확진자", "완치자", "사망자", "발생률", "해외유입 신규 확진자", "지역발생 신규 확진자"]
    var cellVauleList: [String] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(configureOverview), for: .valueChanged)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CovidListCell.self, forCellReuseIdentifier: "CovidListCell")
        tableView.layer.backgroundColor = UIColor.red.cgColor
        
        self.setUILayout()
        self.configureOverview()
    }

    @objc func configureOverview() {
        //covidOverview 프로퍼티를 옵셔널 바인딩 함
        guard let covidOverview = self.covidOverview else {
            return
        }
        
        self.title = covidOverview.countryName //네이게이션바 타이틀에 지역이름 표시
        cellVauleList.append("\(covidOverview.newCase)명")
        cellVauleList.append("\(covidOverview.totalCase)명")
        cellVauleList.append("\(covidOverview.recovered)명")
        cellVauleList.append("\(covidOverview.death)명")
        cellVauleList.append("\(covidOverview.percentage)%")
        cellVauleList.append("\(covidOverview.newCcase)명")
        cellVauleList.append("\(covidOverview.newFcase)명")
        
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
}


private extension CovidDetailViewController {
    func setUILayout() {
        [tableView]
            .forEach { self.view.addSubview($0) }
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview().offset(5.0)
            $0.width.equalToSuperview()
        }
    }
}

extension CovidDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CovidListCell", for: indexPath) as? CovidListCell else { return UITableViewCell() }
        
        let cellLabelList = cellLabelList[indexPath.row]
        let cellValueList = cellVauleList[indexPath.row]
        cell.configureLabelName(with: cellLabelList)
        cell.configureLabelValue(with: cellValueList)
        
        return cell
    }
}


    

