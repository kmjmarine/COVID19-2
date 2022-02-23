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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = covidView

        self.fetchCovidOverview(completionHandler: { [weak self] result in //순환참조 방지
            guard let self = self else { return } //일시적으로 스트롱 매서드로 변환
           
            self.covidView.totalCaseLabel.isHidden = false
            self.covidView.pieChartView.isHidden = false
            switch result {
            case let .success(result):
                self.configureStackView(koreaCovidOverView: result.korea)
                let covidOverViewList = self.makeCovidOverviewList(cityCovidOverView: result)
                self.configureChartView(covidOverviewList: covidOverViewList)
            case let .failure(result):
                debugPrint("error \(result)")
            }
        })
    }
    
    func makeCovidOverviewList(
        cityCovidOverView: CityCovidOverview
    ) -> [CovidOverview] {
        return [ //Json CovidOverView 응답은 객체로 반환되기에 배열로 변환
            cityCovidOverView.seoul,
            cityCovidOverView.busan,
            cityCovidOverView.daegu,
            cityCovidOverView.incheon,
            cityCovidOverView.gwangju,
            cityCovidOverView.daejeon,
            cityCovidOverView.ulsan,
            cityCovidOverView.sejong,
            cityCovidOverView.gyeonggi,
            cityCovidOverView.gangwon,
            cityCovidOverView.chungbuk,
            cityCovidOverView.chungnam,
            cityCovidOverView.jeonbuk,
            cityCovidOverView.jeonnam,
            cityCovidOverView.gyeongbuk,
            cityCovidOverView.gyeongnam,
            cityCovidOverView.jeju,
        ]
    }
    
    func configureChartView(covidOverviewList: [CovidOverview]) {
        covidView.pieChartView.delegate = self
        let entries = covidOverviewList.compactMap { [weak self] overview -> PieChartDataEntry? in
            guard let self = self else { return nil }
            return PieChartDataEntry(
                value: self.removeFormatString(string: overview.newCase),
                label: overview.countryName,
                data: overview
            )
        }
        let dataSet = PieChartDataSet(entries: entries, label: "코로나 발생 현황")
        dataSet.sliceSpace = 1
        dataSet.entryLabelColor = .label
        dataSet.entryLabelColor = .label
        dataSet.xValuePosition = .outsideSlice
        dataSet.valueLinePart1OffsetPercentage = 0.8
        dataSet.valueLinePart1Length = 0.2
        dataSet.valueLinePart2Length = 0.3
        dataSet.colors = ChartColorTemplates.vordiplom() + ChartColorTemplates.joyful() + ChartColorTemplates.liberty() + ChartColorTemplates.pastel() + ChartColorTemplates.material()
        self.covidView.pieChartView.data = PieChartData(dataSet: dataSet)
        self.covidView.pieChartView.spin(duration: 0.6, fromAngle: self.covidView.pieChartView.rotationAngle, toAngle: self.covidView.pieChartView.rotationAngle + 80)
    }
    
    func removeFormatString(string: String) -> Double {
        let formmater = NumberFormatter()
        formmater.numberStyle = .decimal
        return formmater.number(from: string)?.doubleValue ?? 0
    }
    
    func configureStackView(koreaCovidOverView: CovidOverview) {
        covidView.totalCaseLabel.text = "\(koreaCovidOverView.totalCase)명"
        covidView.newCaseLabel.text = "\(koreaCovidOverView.newCase)명"
    }
    
    func fetchCovidOverview(
        //클로져에 응답받은 데이터 전달 (escaping 클로져)
        completionHandler: @escaping (Result<CityCovidOverview, Error>) -> Void
    ) {
        let url = "https://api.corona-19.kr/korea/country/new/"
        //딕셔너리 선언
        let param = [
            "serviceKey": "tBfPTFEsqweS9OhluDoKmz6i7Nc5QjrkJ"
        ]
        
        //Alamofire로 API호출 (request 메서드)
        AF.request(url, method: .get, parameters: param)
        //응답받을 데이터 체이닝 (응답받을 데이터가 클로져에 전달됨)
            .responseData(completionHandler: { response in
                switch response.result {
                case let .success(data):
                    do {
                        let decoder = JSONDecoder()
                        let result = try decoder.decode(CityCovidOverview.self, from: data)
                        completionHandler(.success(result)) //fecthCovidOverView의 completionHandler 클로져 호출
                    } catch {
                        completionHandler(.failure(error))
                    }
                case let .failure(error):
                    completionHandler(.failure(error))
                }
            })
    }
}

extension CovidViewController: ChartViewDelegate {
    //차트의 항목을 선택했을때 호출되는 매서드(엔트리 파라미터를 통해 선택된 항목에 저장된 데이터를 가져옴)
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        //CovidDetailViewContoller로 푸쉬
        let covidDetailViewController = CovidDetailViewController() //스토리보드의 CovidDetailViewController를 인스턴스화
        guard let covidOverView = entry.data as? CovidOverview else { return } //CovidOverView 타입으로 다운캐스팅
        covidDetailViewController.covidOverview = covidOverView
        self.navigationController?.pushViewController(covidDetailViewController, animated: true) //covidDetailViewController 에 데이터 푸쉬
    }
}
