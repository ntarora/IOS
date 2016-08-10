//
//  CustomAnnotation.swift
//  MapExampleiOS8
//

import UIKit
import MapKit

class CustomAnnotation : NSObject, MKAnnotation {
    
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var detailURL: NSURL
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, detailURL: NSURL) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.detailURL = detailURL
    }
    
    func annotationView() -> MKAnnotationView {
        let view = MKAnnotationView(annotation: self, reuseIdentifier: "CustomAnnotation")

        view.enabled = true
        view.canShowCallout = true
        view.image = UIImage(named: "AnnotationPin")
        view.centerOffset = CGPointMake(0, -32)
        return view
    }
}