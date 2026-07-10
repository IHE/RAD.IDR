Instance: example-Procedure-chest-xray
InstanceOf: Procedure
Title: "Procedure: XR Chest"
Description: "Radiologic Examination, Chest; Two View"
Usage: #example

* status = #completed
* code = LOINC#36643-5 "XR Chest 2 Views"
* subject = Reference(Patient/example-Patient)
* basedOn = Reference(ServiceRequest/example-ServiceRequest-chest-xray)

Instance: example-Procedure-chest-xray-comparison
InstanceOf: Procedure
Title: "Procedure: XR Chest (Comparison)"
Description: "Radiologic Examination, Chest; Single View; Comparison"
Usage: #example

* status = #completed
* code = LOINC#36554-4 "XR Chest Single View"
* subject = Reference(Patient/example-Patient)
* basedOn = Reference(ServiceRequest/example-ServiceRequest-chest-xray-comparison)
