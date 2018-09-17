//
//  ViewController.swift
//  ParseFlightLogs
//
//  Created by Koray Birand on 7/1/15.
//  Copyright (c) 2015 Koray Birand. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    var flightNumberArray : [String] = []
    var mainarray = [[String]]()
    var header : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
         }
    
    func uniq<T: Hashable>(_ lst: [T]) -> [T] {
        var uniqueSet = [T : Void](minimumCapacity: lst.count)
        for x in lst {
            uniqueSet[x] = ()
        }
        return Array(uniqueSet.keys)
    }
    
    override func viewDidAppear() {
        
        let myFilePath = "/Users/koraybirand/Desktop/test2.txt"
        myFile = try! String(contentsOfFile: myFilePath, encoding: String.Encoding.utf8)
        var coordArray = myFile.components(separatedBy: "\n")
        
        for items in 0...coordArray.count - 1 {
            
            var parsedData = coordArray[items].components(separatedBy: ";")
            if parsedData[1] != "" {
            mainarray.append([parsedData[1],parsedData[2],parsedData[3],parsedData[4],parsedData[5]])
            flightNumberArray.append(parsedData[1])
            }
            
        }
        
        
        var uniqFlights = uniq(flightNumberArray)
        
  
        
        for indexNo in 0...uniqFlights.count - 1 {
            
            
            var coordinateLine = ""
            var myRoute = ""
            
            for indexNoMain in 0...self.mainarray.count - 1 {
                
                if (uniqFlights[indexNo] as String) == (self.mainarray[indexNoMain][0] )  {
                    
                    _ = (self.mainarray[indexNoMain][0] )
                    let fLat = (self.mainarray[indexNoMain][1] )
                    let fLon = (self.mainarray[indexNoMain][2] )
                    let fAlt = (self.mainarray[indexNoMain][3] as NSString).doubleValue
                    myRoute = (self.mainarray[indexNoMain][4] )
                    let fAltFormatted = String(format: "%.0f", fAlt)
                    
                    coordinateLine = coordinateLine + "\(fLon),\(fLat),\(fAltFormatted) "
                   
                }
            }
            
            
          
            
            header = ""
            _ = ((uniqFlights[indexNo] as String))
            
            let myFilePath = "/Users/koraybirand/Desktop/kml/\((uniqFlights[indexNo] as String)).kml"
            let myText = template("\((uniqFlights[indexNo] as String)).kml", description: "\(((uniqFlights[indexNo] as String)))--\(myRoute)", coordinates: coordinateLine)
            if myRoute.lowercased().range(of: "ist") != nil || myRoute.lowercased().range(of: "saw") != nil {
                try! myText.write(toFile: myFilePath, atomically: false, encoding: String.Encoding.utf8)
            }
            
            
        }
        
        
        //println(flightNumberArray)
        //println(mainarray)
    }
    
    func template(_ name:String, description:String, coordinates:String) -> String {
        
        header = header + "<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n"
        header = header + "<kml xmlns=\"http://www.opengis.net/kml/2.2\" xmlns:gx=\"http://www.google.com/kml/ext/2.2\" xmlns:kml=\"http://www.opengis.net/kml/2.2\" xmlns:atom=\"http://www.w3.org/2005/Atom\">\n"
        header = header + "<Document>\n"
        header = header + "<name>" + name + "</name>\n"
        header = header + "<Style id=\"sh_ylw-pushpin0\">" + "\n"
        header = header + "<IconStyle>" + "\n"
        header = header + "<scale>1.3</scale>" + "\n"
        header = header + "<Icon>" + "\n"
        header = header + "<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>" + "\n"
        header = header + "</Icon>" + "\n"
        header = header + "<hotSpot x=\"20\" y=\"2\" xunits=\"pixels\" yunits=\"pixels\"/>" + "\n"
        header = header + "</IconStyle>" + "\n"
        header = header + "</Style>" + "\n"
        header = header + "<StyleMap id=\"msn_ylw-pushpin0\">" + "\n"
        header = header + "<Pair>" + "\n"
        header = header + "<key>normal</key>" + "\n"
        header = header + "<styleUrl>#sn_ylw-pushpin0</styleUrl>" + "\n"
        header = header + "</Pair>" + "\n"
        header = header + "<Pair>" + "\n"
        header = header + "<key>highlight</key>" + "\n"
        header = header + "<styleUrl>#sh_ylw-pushpin0</styleUrl>" + "\n"
        header = header + "</Pair>" + "\n"
        header = header + "</StyleMap>" + "\n"
        header = header + "<Style id=\"sn_ylw-pushpin0\">" + "\n"
        header = header + "<IconStyle>" + "\n"
        header = header + "<scale>1.1</scale>" + "\n"
        header = header + "<Icon>" + "\n"
        header = header + "<href>http://maps.google.com/mapfiles/kml/pushpin/ylw-pushpin.png</href>" + "\n"
        header = header + "</Icon>" + "\n"
        header = header + "<hotSpot x=\"20\" y=\"2\" xunits=\"pixels\" yunits=\"pixels\"/>" + "\n"
        header = header + "</IconStyle>" + "\n"
        header = header + "</Style>" + "\n"
        header = header + "<Placemark>" + "\n"
        header = header + "<name>" + description + "</name>" + "\n"
        header = header + "<styleUrl>#msn_ylw-pushpin0</styleUrl>" + "\n"
        header = header + "<LineString>" + "\n"
        header = header + "<extrude>1</extrude>" + "\n"
        header = header + "<tessellate>1</tessellate>" + "\n"
        header = header + "<altitudeMode>relativeToGround</altitudeMode>" + "\n"
        header = header + "<gx:altitudeMode>relativeToSeaFloor</gx:altitudeMode>" + "\n"
        header = header + "<coordinates>" + "\n"
        header = header + coordinates + "\n"
        header = header + "</coordinates>" + "\n"
        header = header + "</LineString>" + "\n"
        header = header + "</Placemark>" + "\n"
        header = header + "</Document>" + "\n"
        header = header + "</kml>" + "\n"
        
        return header
    }
    

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

