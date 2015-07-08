//
//  Auto.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 22-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import Foundation
import CoreData

class Auto: NSManagedObject {

    @NSManaged var marca: String
    @NSManaged var modelo: String
    @NSManaged var ano: String
    @NSManaged var kilometraje: NSNumber
    @NSManaged var dueno: Contacto?
    @NSManaged var patenteString:String

    class func new(moc: NSManagedObjectContext, _marca:String, _modelo:String, _ano:String, _kilometraje:Int) -> Auto {
        let newAuto = NSEntityDescription.insertNewObjectForEntityForName("Auto", inManagedObjectContext: moc) as! EjemploCoreData.Auto
        
        newAuto.marca = _marca
        newAuto.modelo = _modelo
        newAuto.ano = _ano
        newAuto.kilometraje = _kilometraje
        
        return newAuto
    }
    
    func eliminarDueno() {
        dueno = nil
    }
    
    func asignarDueno(contacto:Contacto) {
        dueno = contacto
    }
    
    var patente: String {
        get { return patenteString }
        set { patenteString = newValue }
    }
}
