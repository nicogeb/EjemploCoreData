//
//  ViewControllerAutos.swift
//  EjemploCoreData
//
//  Created by Nicolás Gebauer on 26-06-15.
//  Copyright (c) 2015 Nicolás Gebauer. All rights reserved.
//

import CoreData
import UIKit

/// Vista de la lista de Autos junto con los TextFields que le corresponden.
class ViewControllerAutos: UIViewController, UITextFieldDelegate  {
    var managerAutos = AutosManager()
    var delegateTablaAutos : TablaAutosDelegate!
    var dueno : Contacto!
    
    // Referencia al TableView de autos
    @IBOutlet weak var TablaAutos: UITableView!
    
    // Los distintos TextField que el usuario va a llenar
    @IBOutlet weak var LabelNombreDueno: UILabel!
    @IBOutlet weak var TextFieldMarca: UITextField!
    @IBOutlet weak var TextFieldModelo: UITextField!
    @IBOutlet weak var TextFieldAno: UITextField!
    @IBOutlet weak var TextFieldKM: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managerAutos.dueno = dueno
        delegateTablaAutos = TablaAutosDelegate()
        delegateTablaAutos.autosManager = managerAutos
        delegateTablaAutos.referenciaALaTablaAutos = TablaAutos
        TablaAutos.delegate = delegateTablaAutos
        TablaAutos.dataSource = delegateTablaAutos
        
        TextFieldMarca.delegate = self
        TextFieldModelo.delegate = self
        TextFieldAno.delegate = self
        TextFieldKM.delegate = self
        
        managerAutos.fetchAutos()
        TablaAutos.reloadData()
        
        LabelNombreDueno.text = "Autos de \(dueno.nombre) \(dueno.apellido)"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    @IBAction func AgregarNuevoAuto(sender: AnyObject) {
        if TextFieldKM.text != "" && TextFieldKM.text.toInt() == nil {
            let alertController = UIAlertController(title: "Información incorrecta", message:"Escribe solo un numero en kilometraje, o déjalo vacio para que sea 0 automaticamente", preferredStyle: .Alert)
            alertController.addAction(UIAlertAction(title: "ok", style: .Default, handler: nil))
            self.presentViewController(alertController, animated: true, completion: nil)
            return
        }
        
        managerAutos.agregarNuevoAuto(TextFieldMarca.text, modelo: TextFieldModelo.text, ano: TextFieldAno.text, km: TextFieldKM.text)
        managerAutos.fetchAutos()
        TablaAutos.reloadData()
        borrarTextFields()
    }
    
    @IBAction func FetchAutos(sender: AnyObject) {
        if (TextFieldMarca.text != "" || TextFieldModelo.text != "" || TextFieldAno.text != "" || TextFieldKM.text != "") {
            managerAutos.fetchAutosWithPredicates(TextFieldMarca.text, modelo: TextFieldModelo.text, ano: TextFieldAno.text, km: TextFieldKM.text)
        }
        else {
            managerAutos.fetchAutos()
        }
        borrarTextFields()
        TablaAutos.reloadData()
    }
    
    func borrarTextFields() {
        TextFieldMarca.text = ""
        TextFieldModelo.text = ""
        TextFieldAno.text = ""
        TextFieldKM.text = ""
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField == TextFieldKM {
            textField.resignFirstResponder()
        }
        else if textField == TextFieldMarca {
            textField.resignFirstResponder()
            TextFieldModelo.select(self)
        }
        else if textField == TextFieldModelo {
            textField.resignFirstResponder()
            TextFieldAno.select(self)
        }
        else if textField == TextFieldAno {
            textField.resignFirstResponder()
            TextFieldKM.select(self)
        }
        return true
    }
}
