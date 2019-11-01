

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager!
    
    @IBOutlet weak var viewTable: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        
    }
    
    
@IBAction func startFind(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    
        if status == .authorizedAlways {
            if CLLocationManager.isMonitoringAvailable(for: CLBeaconRegion.self) {
                if CLLocationManager.isRangingAvailable() {
                    startScanning()
                }
            }
        }
    }
    
    
    func startScanning() {
        let uuid = UUID(uuidString: "20CAE8A0-A9CF-11E3-A5E2-0800200C9A66")!
        let beaconRegion = CLBeaconRegion(proximityUUID: uuid, major: 234, minor: 55967, identifier: "MyBeacon")

        locationManager.startMonitoring(for: beaconRegion)
        locationManager.startRangingBeacons(in: beaconRegion)
    }
    
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        if beacons.count > 0 {
            updateDistance(beacons[0].proximity)
            print(beacons[0].proximity.rawValue)
        } else {
            updateDistance(.unknown)
            print("is 0")
        }
    }

    func updateDistance(_ distance: CLProximity) {
        
        UIView.animate(withDuration: 2.5) {
            switch distance {
            case .unknown:
                self.viewTable.backgroundColor = UIColor.gray
                    print("unkown")
            case .far:
                self.viewTable.backgroundColor = UIColor.blue
                    print("far")
            case .near:
                self.viewTable.backgroundColor = UIColor.green
                    print("near")
                    
            case .immediate:
                self.viewTable.backgroundColor = UIColor.red
                    print("immediate")
            }
        }
    }
    



}
