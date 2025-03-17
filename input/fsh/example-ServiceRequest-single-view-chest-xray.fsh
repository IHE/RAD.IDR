Instance: example-ServiceRequest-chest-xray
InstanceOf: IDRImagingServiceRequest
Title: "ServiceRequest: XR Chest"
Description: "Single View Chest XRay order"
Usage: #example

* identifier[accession].type = HL7V2#ACSN
* identifier[accession].system = "http://www.acme.com/identifiers/accession"
* identifier[accession].value = "A1234567"

* status = #active
* intent = FHIRIntent#order "Order"
* requester = Reference(Practitioner/example-Practitioner-Referring)
* subject = Reference(Patient/example-Patient)
* code.concept = CPT#71046 "RADIOLOGIC EXAMINATION, CHEST; TWO VIEW"
* reason[0] = Reference(Condition/example-Condition-ChestPain)
* reason[1] = Reference(Condition/example-Condition-ShortnessOfBreath)
* reason[2].concept.text = "Rule out pulmonary pathology"


Instance: example-ServiceRequest-chest-xray-history
InstanceOf: IDRImagingServiceRequest
Title: "ServiceRequest: XR Chest (History)"
Description: "Single View Chest XRay of a previous completed order"
Usage: #example

* identifier[accession].type = HL7V2#ACSN
* identifier[accession].system = "http://www.acme.com/identifiers/accession"
* identifier[accession].value = "A111111"

* status = #completed
* intent = FHIRIntent#order "Order"
* subject = Reference(Patient/example-Patient)
* code.concept = CPT#71045 "RADIOLOGIC EXAMINATION, CHEST; SINGLE VIEW"


Instance: example-ServiceRequest-CT-Abdomen-Pelvis
InstanceOf: IDRImagingServiceRequest
Title: "ServiceRequest: CT Abdomen Pelvis"
Description: "CT Abdomen Pelvis order"
Usage: #example

* identifier[accession].type = HL7V2#ACSN
* identifier[accession].system = "http://www.acme.com/identifiers/accession"
* identifier[accession].value = "A222222"

* status = #active
* intent = FHIRIntent#order "Order"
* subject = Reference(Patient/example-Patient)
* code.concept = CPT#74176 "COMPUTED TOMOGRAPHY, ABDOMEN AND PELVIS; WITHOUT CONTRAST MATERIAL"


Instance: example-ServiceRequest-Mammo-Recommendation
InstanceOf: IDRRecommendationServiceRequest
Title: "ServiceRequest: Mammography Recommendation"
Description: "Mammography Recommendation"
Usage: #example

* status = #draft
* intent = #proposal
* subject = Reference(Patient/example-Patient)
* reason = Reference(Condition/example-Condition-Infarct)
* code.concept = CPT#77066 "MAMMOGRAPHY, BILATERAL, DIAGNOSTIC"
