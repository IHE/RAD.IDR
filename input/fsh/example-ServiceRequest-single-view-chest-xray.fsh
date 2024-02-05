Instance: example-ServiceRequest-single-view-chest-xray
InstanceOf: ImagingServiceRequest
Title: "Simple XR Chest"
Description: "Single View Chest XRay"
Usage: #example

* identifier[accession].type = HL7V2#ACSN
* identifier[accession].system = "http://www.acme.com/identifiers/accession"
* identifier[accession].value = "A1234567"

* status = #active

* intent = FHIRIntent#order "Order"

* subject = Reference(Patient/example-Patient)

* code.concept = CPT#71045 "RADIOLOGIC EXAMINATION, CHEST; SINGLE VIEW"



Instance: example-ServiceRequest-single-view-chest-xray-history
InstanceOf: ImagingServiceRequest
Title: "Simple XR Chest"
Description: "Single View Chest XRay"
Usage: #example

* identifier[accession].type = HL7V2#ACSN
* identifier[accession].system = "http://www.acme.com/identifiers/accession"
* identifier[accession].value = "A111111"

* status = #completed

* intent = FHIRIntent#order "Order"

* subject = Reference(Patient/example-Patient)

* code.concept = CPT#71045 "RADIOLOGIC EXAMINATION, CHEST; SINGLE VIEW"