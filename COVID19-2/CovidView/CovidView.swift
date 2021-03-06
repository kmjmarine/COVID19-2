//
//  CovidView.swift
//  COVID19-2
//
//  Created by kmjmarine on 2022/02/23.
//

import UIKit
import SnapKit
import Charts

final class CovidView: UIView {
    lazy var totalCaseTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.text = "국내 누적 확진자"
        label.textAlignment = .center
         
        return label
     }()
    
    lazy var totalCaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.text = "0명"
        label.textAlignment = .center
         
        return label
     }()
    
    lazy var newCaseTitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18.0, weight: .bold)
        label.text = "국내 신규 확진자"
        label.textAlignment = .center
         
        return label
     }()
    
    lazy var newCaseLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18.0, weight: .medium)
        label.text = "0명"
        label.textAlignment = .center
         
        return label
     }()
    
    lazy var pieChartView: PieChartView = {
        let chartView = PieChartView()
        chartView.backgroundColor = .systemBackground
        
        return chartView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUILayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CovidView {
    func setUILayout() {
        backgroundColor = .systemBackground

        let verticalStackView1 = UIStackView(arrangedSubviews: [totalCaseTitleLabel, totalCaseLabel])
        verticalStackView1.axis = .vertical
        verticalStackView1.alignment = .center
        verticalStackView1.distribution = .fillEqually
        verticalStackView1.spacing = 1.0
        
        let verticalStackView2 = UIStackView(arrangedSubviews: [newCaseTitleLabel, newCaseLabel])
        verticalStackView2.axis = .vertical
        verticalStackView2.alignment = .center
        verticalStackView2.distribution = .fillEqually
        verticalStackView2.spacing = 1.0
        
        let hotizontalStackView = UIStackView(arrangedSubviews: [verticalStackView1, verticalStackView2])
        hotizontalStackView.axis = .horizontal
        hotizontalStackView.spacing = 70.0
        
        [hotizontalStackView, pieChartView]
            .forEach { addSubview($0) }
        
        hotizontalStackView.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide).offset(16.0)
            $0.centerX.equalToSuperview()
            $0.height.equalTo(80.0)
        }
        
        pieChartView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(24.0)
            $0.trailing.equalToSuperview().inset(24.0)
            $0.top.equalTo(hotizontalStackView.snp.bottom).offset(10.0)
            $0.height.equalTo(600.0)
        }
    }
}
