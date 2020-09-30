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
    private lazy var buttonMenu: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "menuButtonNormal"), for: .normal)
        button.backgroundColor = .lightGray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        
        viewModel?.loadTransports()
    }
    var rxdisposableBag = DisposeBag()
    var markers = [String: GMSMarker]()
    
    override func loadView() {
        super.loadView()
        
        view.backgroundColor = .white
        
        mapView.frame = view.bounds
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.insertSubview(mapView, at: 0)
        
        view.addSubview(buttonZoomPlus)
        view.addSubview(buttonZoomMinus)
        view.addSubview(buttonMenu)
        
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
        
        buttonMenu.snp.makeConstraints {
            $0.top.equalTo(self.view).offset(44)
            $0.leading.equalTo(self.view).offset(24)
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
        
        buttonMenu.rx.tap
            .subscribe(onNext: { [weak self] _ in
                self?.openMenu()
            })
            .disposed(by: rxdisposableBag)
        
        
        viewModel?.rxTransports
            .asObservable()
            .subscribe(onNext: { [weak self] transports in
                self?.redrowMap(transports: transports)
            })
            .disposed(by: rxdisposableBag)
    }
    
    func redrowMap(transports: [Transport]) {
        mapView.clear()
        
        if !transports.isEmpty {
            let transport = transports[0]
            mapView.animate(toLocation: transport.position.location)
            mapView.animate(toZoom: 12)
        }
        
        for transport in transports {
            let marker = GMSMarker(position: transport.position.location)
            marker.title = transport.name
            print(transport.name)
            marker.map = mapView
            let icon = UIImage(named: "pin")
            if transport.eye {
                marker.icon = icon
            } else {
                marker.icon = icon?.image(alpha: 0.5)
            }
            markers.updateValue(marker, forKey: transport.id)
        }
    }
    
    func openMenu() {
        let viewController = MenuViewController()
        if let transports = viewModel?.transports {
            viewController.transports = transports
            viewController.delegate = self
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}

extension MapViewController: GMSMapViewDelegate {
    
}

extension MapViewController: MenuViewControllerDelegate {
    func selectTrasport(id: String) {
        if let marker = markers[id] {
            mapView.animate(toLocation: marker.position)
            mapView.selectedMarker = marker
        }
    }
}
