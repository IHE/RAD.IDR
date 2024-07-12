Instance: example-Encounter-CT-abdomen
InstanceOf: Encounter
Title: "Abdominal CT Encounter example"
Description: "An encounter with the imaging department for the purpose of performing an abdominal CT study"
Usage: #example

* status = #completed
* class = #AMB // Ambulatory, i.e. outpatient
* subject = Reference(Patient/example-Patient)
* basedOn = Reference(ServiceRequest/example-ServiceRequest-CT-abdomen)
