Instance: example-procedure-single-view-chest-xray
InstanceOf: Procedure
Title: "Procedure: XR Chest"
Description: "Radiologic Examination, Chest; Two View"
Usage: #example

* status = #completed
* code = LOINC#36643-5 "XR Chest 2 View2"
* subject = Reference(Patient/example-Patient)
* basedOn = Reference(ServiceRequest/example-ServiceRequest-)
