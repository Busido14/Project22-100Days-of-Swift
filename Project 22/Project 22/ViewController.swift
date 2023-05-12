//
//  ViewController.swift
//  Project 22
//
//  Created by Артем Чжен on 12/05/23.
//
import CoreLocation
import UIKit

class ViewController: UIViewController, CLLocationManagerDelegate {
    @IBOutlet var distanceReading: UILabel!
    @IBOutlet var circleView: UIView!
    @IBOutlet var nameLabel: UILabel!
    
    var locationManager: CLLocationManager?
    var beacons = [Beacon]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.requestWhenInUseAuthorization()
        
        view.backgroundColor = .gray
        
        circleView.layer.cornerRadius = 128
        
        let uuidOne = Beacon(uuid: UUID(uuidString: "AAAAAAAA-174E-4BAC-A814-092E77F6B7E5")!, major: 123, minor: 545, identifier: "FirstBeacon")
        let uuidTwo = Beacon(uuid: UUID(uuidString: "BBBBBBBB-174E-4BAC-A814-092E77F6B7E5")!, major: 345, minor: 654, identifier: "SecondBeacon")
        let uuidThree = Beacon(uuid: UUID(uuidString: "CCCCCCCC-174E-4BAC-A814-092E77F6B7E5")!, major: 678, minor: 345, identifier: "ThirdBeacon")
        let uuidFour = Beacon(uuid: UUID(uuidString: "DDDDDDDD-174E-4BAC-A814-092E77F6B7E5")!, major: 901, minor: 123, identifier: "FourthBeacon")
        let uuidFive = Beacon(uuid: UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!, major: 234, minor: 456, identifier: "FifthBeacon")
        
        beacons += [uuidOne, uuidTwo, uuidThree, uuidFour, uuidFive]
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    }
                }
            }
        }
    
    func startScanning() {
        let uuid = UUID(uuidString: "5A4BCFCE-174E-4BAC-A814-092E77F6B7E5")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 123, minor: 456, identifier: "MyBeacon")

        locationManager?.startMonitoring(for: beaconRegion)
        locationManager?.startRangingBeacons(in: beaconRegion)
    }
        
        func update(distance: CLProximity) {
            UIView.animate(withDuration: 1) {
                switch distance {
                case .far:
                    self.view.backgroundColor = .blue
                    self.distanceReading.text = "FAR"
                    self.circleView.transform = CGAffineTransform(scaleX: 0.25, y: 0.25)
                    
                case .near:
                    self.view.backgroundColor = .orange
                    self.distanceReading.text = "NEAR"
                    self.circleView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
                case .immediate:
                    self.view.backgroundColor = .red
                    self.distanceReading.text = "RIGHT HERE"
                    self.circleView.transform = CGAffineTransform(scaleX: 1, y: 1)
                default:
                    
                    self.view.backgroundColor = .gray
                    self.distanceReading.text = "UNKNOWN"
                    self.circleView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                }
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
            if let beacon = beacons.first {
                let ac = UIAlertController(title: "Found first beacon detected", message: nil, preferredStyle: .alert)
                ac.addAction(UIAlertAction(title: "OK", style: .default))
                present(ac, animated: true)
                update(distance: beacon.proximity)
            } else {
                update(distance: .unknown)
            }
        }
    }
