//
//  MapViewController.swift
//  Bars
//
//  Created by Ахмед Фокичев on 28.09.2020.
//

import UIKit
import SnapKit
import GoogleMaps
import RxSwift
import RxCocoa

class MapViewController: UIViewController {
    
    var viewModel: MapViewModelProtocol?
    
    lazy private(set) var mapView: GMSMapView = {
        let gmsMapView = GMSMapView()
        gmsMapView.delegate = self
        gmsMapView.isMyLocationEnabled = true
        return gmsMapView
    }()
    
    private lazy var buttonZoomPlus: UIButton = {
        let button = UIButton()
        button.setTitle("+", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    private lazy var buttonZoomMinus: UIButton = {
        let button = UIButton()
        button.setTitle("-", for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
    }
    var rxdisposableBag = DisposeBag()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(mapView, at: 0)
        
        view.addSubview(buttonZoomPlus)
        view.addSubview(buttonZoomMinus)
        
        
        buttonZoomPlus.snp.makeConstraints {
            $0.centerY.equalTo(self.view).offset(-20)
            $0.trailing.equalTo(self.view).offset(-24)
            $0.width.height.equalTo(44)
        }
        buttonZoomPlus.layer.cornerRadius = 22
        
        buttonZoomMinus.snp.makeConstraints {
            $0.top.equalTo(buttonZoomPlus.snp.bottom).offset(8)
            $0.trailing.equalTo(self.view).offset(-24)
            $0.width.height.equalTo(44)
        }
        buttonZoomMinus.layer.cornerRadius = 22
        
        
        
        
        buttonZoomPlus.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let zoom = self.mapView.camera.zoom
                self.mapView.animate(toZoom: zoom + 2)
            })
            .disposed(by: rxdisposableBag)
        buttonZoomMinus.rx.tap
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let zoom = self.mapView.camera.zoom
                self.mapView.animate(toZoom: zoom - 2)
            })
            .disposed(by: rxdisposableBag)
        
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
}
