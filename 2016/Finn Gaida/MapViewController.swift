//
//  MapViewController.swift
//  Finn Gaida
//
//  Created by Finn Gaida on 25.04.16.
//  Copyright © 2016 Finn Gaida. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet var mapView: MKMapView!
    var line:MKPolyline?
    
    let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(53.789800, 9.994517)
    let appleLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(37.332460, -122.030225)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let doc = UIBarButtonItem(image: UIImage(named: "doc"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(MapViewController.showLicenses))
        self.navigationItem.leftBarButtonItem = doc
        
        let done = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(MapViewController.hide))
        self.navigationItem.rightBarButtonItem = done
        
        self.title = "How far I'd travel"
        
        let meAnnotation = MKPointAnnotation()
        meAnnotation.coordinate = pinLocation
        meAnnotation.title = "Me"
        self.mapView.addAnnotation(meAnnotation)
        
        let youAnnotation = MKPointAnnotation()
        youAnnotation.coordinate = appleLocation
        youAnnotation.title = "You"
        self.mapView.addAnnotation(youAnnotation)
        
        let center = CLLocationCoordinate2D(latitude: (pinLocation.latitude + appleLocation.latitude) / 2, longitude: (pinLocation.longitude + appleLocation.longitude) / 2)
        
        let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(abs(pinLocation.latitude - appleLocation.latitude), abs(pinLocation.longitude - appleLocation.longitude) + 50))
        self.mapView.setRegion(region, animated: true)
        
        var coordinates = [pinLocation, appleLocation]
        line = MKPolyline(coordinates: &coordinates, count: 2)
        self.mapView.addOverlay(line!)
    }
    
    func showLicenses() {
        let alert = UIAlertController(title: "Licenses", message: "This app was built using some open source frameworks not included in the iOS SDK. The following lists their licenses:\n\n PeekPop - https://github.com/marmelroy/PeekPop\nThe MIT License (MIT)\n\nCopyright (c) 2016 Roy Marmelstein\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.\n\n GradientView - https://github.com/soffes/GradientView\nCopyright (c) 2009-2015 Sam Soffes, http://soff.es\n\nPermission is hereby granted, free of charge, to any person obtaining\na copy of this software and associated documentation files (the\n    \"Software\"), to deal in the Software without restriction, including\nwithout limitation the rights to use, copy, modify, merge, publish,\ndistribute, sublicense, and/or sell copies of the Software, and to\npermit persons to whom the Software is furnished to do so, subject to\nthe following conditions:\n\nThe above copyright notice and this permission notice shall be\nincluded in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND,\n                                  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF\nMERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND\nNONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE\nLIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION\nOF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION\nWITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n JTSImageViewController - https://github.com/jaredsinclair/JTSImageViewController\nThe MIT License (MIT)\n\nCopyright (c) 2014 Jared Sinclair\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.\n\n Panoramic - https://github.com/iSame7/Panoramic\nThe MIT License (MIT)\n\nCopyright (c) 2014 Sameh Mabrouk\n\nPermission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the \"Software\"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.\n\n LivePhotoDemo - https://github.com/genadyo/LivePhotoDemo\nThe MIT License (MIT)\n\nCopyright (c) 2015 Genady Okrain\n\nPermission is hereby granted, free of charge, to any person obtaining a copy\nof this software and associated documentation files (the \"Software\"), to deal\nin the Software without restriction, including without limitation the rights\nto use, copy, modify, merge, publish, distribute, sublicense, and/or sell\ncopies of the Software, and to permit persons to whom the Software is\nfurnished to do so, subject to the following conditions:\n\nThe above copyright notice and this permission notice shall be included in all\ncopies or substantial portions of the Software.\n\nTHE SOFTWARE IS PROVIDED \"AS IS\", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR\nIMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,\nFITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE\nAUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER\nLIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,\nOUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE\nSOFTWARE.", preferredStyle: .Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .Default, handler: { (action) in
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let center = locations.last?.coordinate
        let objectAnnotation = MKPointAnnotation()
        objectAnnotation.coordinate = center!
        objectAnnotation.title = "You"
        self.mapView.addAnnotation(objectAnnotation)
        
        let region = MKCoordinateRegionMake(center!, MKCoordinateSpanMake(abs(pinLocation.latitude - center!.latitude) + 2, abs(pinLocation.longitude - center!.longitude) + 2))
        self.mapView.setRegion(region, animated: true)
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: self.line!)
        renderer.strokeColor = UIColor.redColor()
        renderer.lineWidth = 3
        return renderer
    }
    
    func hide() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
