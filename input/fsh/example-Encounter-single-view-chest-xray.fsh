Instance: example-Encounter-CT-abdomen
InstanceOf: Encounter
Title: "Chest X-ray Encounter example"
Description: "An encounter with the imaging department for the purpose of performing a single view chest X-ray study"
Usage: #example

* status = #completed
* class = #AMB // Ambulatory, i.e. outpatient
* subject = Reference(Patient/example-Patient)
* basedOn = Reference(ServiceRequest/example-ServiceRequest-single-view-chest-xray)
