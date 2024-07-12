Instance: example-Procedure-single-view-chest-xray
InstanceOf: Procedure
Title: "Simple XR Chest Procedure"
Description: "Radiologic Examination, Chest X-Ray; Single View"
Usage: #example
/* Could populate reason, bodySite, outcome, report but that feels duplicative? */

* basedOn = Reference(ServiceRequest/example-ServiceRequest-single-view-chest-xray)
* status = #completed // The procedure is completed at end of scan. The ServiceRequest is completed at report publication?
* code = LOINC#36554-4 "XR Chest Single View"
* subject = Reference(Patient/example-Patient)
* encounter = Reference(Encounter/example-Encounter-single-view-chest-xray)