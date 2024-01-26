Profile:        ImagingServiceRequest
Parent:         ServiceRequest
Id:             imaging-service-request
Title:          "Imaging ServiceRequest"
Description:    "IHE Imaging Diagnostic Report (IDR) profile on ServiceRequest"

// Must have an identifier which is the accession number
* identifier 1..*

* identifier ^slicing.discriminator.type = #pattern
* identifier ^slicing.discriminator.path = "type.coding"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.type.coding"
* identifier ^slicing.ordered = false

* identifier contains accession 1..1 MS
* identifier[accession].type 1..1 MS
* identifier[accession].type.coding = HL7V2#ACSN
* identifier[accession].value 1..1 MS

* intent from ImagingServiceRequestIntentVS (required)

* subject only Reference(Patient)

ValueSet: ImagingServiceRequestIntentVS
Id: imaging-servicerequest-intent-vs
Title: "Imaging ServiceRequest intent Value Set"
Description: "Codes representing the applicable intent for a ServiceRequest."
* FHIRIntent#order "Order"
* FHIRIntent#original-order "Original Order"
* FHIRIntent#reflex-order "Reflex Order"
* FHIRIntent#filler-order "Filler Order"
* FHIRIntent#instance-order "Instance Order"


