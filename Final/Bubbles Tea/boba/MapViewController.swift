//
//  MapViewController.swift
//  boba
//
//  Created by Kenneth Zhang on 2/26/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var estimatedTime: UILabel!
    @IBOutlet weak var calculate: UIButton!
    
    var sourceAddressText: String = ""
    var destinationAddressText: String = ""
    var directions: MKDirections?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self

        // Set the source and destination addresses
        sourceAddressText = "2400 N Sheffield Ave, Chicago, IL 60614"
        destinationAddressText = data.shared.address

        // Calculate the route when the view loads
        calculateRoute()
    }

    @IBAction func calculateRouteButtonTapped(_ sender: UIButton) {
        destinationAddressText = data.shared.address
        if(destinationAddressText == ""){
            let alertController = UIAlertController(title: "Error", message: "Please enter destination address.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
        else{
            calculateRoute()
        }
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        data.shared.cartItemNumber = [0, 0, 0, 0]
        data.shared.cost = 0
        data.shared.address = ""
        data.shared.addOrder = true
        estimatedTime.text = "0 minutes"
        directions?.cancel()
        let alertController = UIAlertController(title: "Order Cancelled!", message: "Successfully cancelled your delivery", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func calculateRoute() {
        guard !sourceAddressText.isEmpty, !destinationAddressText.isEmpty else {
            let alertController = UIAlertController(title: "Error", message: "Please enter destination address.", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }

        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(sourceAddressText) { (placemarks, error) in
            guard let placemark = placemarks?.first else {
                if let error = error {
                    print("Error geocoding source address: \(error.localizedDescription)")
                }
                return
            }

            let sourceLocation = placemark.location?.coordinate ?? CLLocationCoordinate2D()
            let sourcePlacemark = MKPlacemark(coordinate: sourceLocation)
            let sourceMapItem = MKMapItem(placemark: sourcePlacemark)

            geocoder.geocodeAddressString(self.destinationAddressText) { (placemarks, error) in
                guard let placemark = placemarks?.first else {
                    if let error = error {
                        print("Error geocoding destination address: \(error.localizedDescription)")
                    }
                    return
                }

                let destinationLocation = placemark.location?.coordinate ?? CLLocationCoordinate2D()
                let destinationPlacemark = MKPlacemark(coordinate: destinationLocation)
                let destinationMapItem = MKMapItem(placemark: destinationPlacemark)

                // Calculate the route
                let directionRequest = MKDirections.Request()
                directionRequest.source = sourceMapItem
                directionRequest.destination = destinationMapItem
                directionRequest.transportType = .automobile

                let directions = MKDirections(request: directionRequest)
                directions.calculate { (response, error) in
                    guard let response = response else {
                        if let error = error {
                            print("Error calculating directions: \(error.localizedDescription)")
                        }
                        return
                    }
                    self.mapView.removeOverlays(self.mapView.overlays)
                    
                    let route = response.routes[0]
                    self.mapView.addOverlay(route.polyline, level: .aboveRoads)

                    
                    // Zoom the map to the route
                    let region = route.polyline.boundingMapRect
                    self.mapView.setVisibleMapRect(region, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)

                    // Show the ETA for the route
                    let eta = route.expectedTravelTime
                    let etaString = String(format: "%.0f minutes", (eta / 60) + 10)
                    self.estimatedTime.text = etaString
                }
            }
        }
    }

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(overlay: overlay)
        renderer.strokeColor = .blue
        renderer.lineWidth = 3.0
        return renderer
    }
}
