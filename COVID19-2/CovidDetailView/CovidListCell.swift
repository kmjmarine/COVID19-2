//
//  CovidListCell.swift
//  COVID19-2
//
//  Created by kmjmarine on 2022/02/23.
//

import UIKit
import SnapKit

final class CovidListCell: UITableViewCell {
    private lazy var labelNameLabel: UILabel = {
         let label = UILabel()
         label.textColor = .label
         label.font = .systemFont(ofSize: 17.0, weight: .semibold)
         label.text = "라벨네임"
         label.textAlignment = .left
         label.baselineAdjustment = .alignCenters
         
         return label
     }()
    
    private lazy var labelValueLabel: UILabel = {
         let label = UILabel()
         label.textColor = .label
         label.font = .systemFont(ofSize: 17.0, weight: .semibold)
         label.text = "0명"
         label.textAlignment = .right
         label.baselineAdjustment = .alignCenters
         
         return label
     }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureLabelName(with cellLabelList: String) {
        labelNameLabel.text = cellLabelList
    }
    
    func configureLabelValue(with cellValueList: String) {
        labelValueLabel.text = cellValueList
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "CovidListCell")
      
        setUILayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CovidListCell {
    func setUILayout() {
        [labelNameLabel, labelValueLabel]
            .forEach { contentView.addSubview($0) }

        labelNameLabel.snp.makeConstraints {
            $0.top.equalTo(15.0)
            $0.leading.equalTo(20.0)
            $0.width.equalTo(150.0)
        }
        
        labelValueLabel.snp.makeConstraints {
            $0.top.equalTo(15.0)
            $0.leading.equalTo(labelNameLabel.snp.trailing).offset(80.0)
            $0.width.equalTo(150.0)
        }
    }
}
