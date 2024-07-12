Instance: example-ServiceRequest-CT-abdomen
InstanceOf: ImagingServiceRequest
Title: "CT Abdomen"
Description: "Order for a CT study of the abdomen and pelvis without contrast"
Usage: #example

* identifier[accession].type = HL7V2#ACSN
* identifier[accession].system = "http://www.acme.com/identifiers/accession"
* identifier[accession].value = "A1234568"
* status = #active
* intent = FHIRIntent#order "Order"
* category = SCT#363679005 "Imaging"
* priority = #urgent
* code.concept = CPT#74177 "COMPUTED TOMOGRAPHY, ABDOMEN AND PELVIS; WITH CONTRAST"
* subject = Reference(Patient/example-Patient)
* requester = Reference(Practitioner/example-Practitioner-family-doctor)
* encounter = Reference(Encounter/example-Encounter-doctor-visit) // TODO
* reason[0] = Reference(Observation/example-Observation-abdominal-pain) // TODO
* reason[1] = Reference(Observation/example-Observation-abdominal-distension) 
/* TODO should we replace these observations with suspected bowel obstruction encoded as an unconfirmed condition (which seems to be the current way of doing that) */
