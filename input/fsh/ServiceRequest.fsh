Profile:        ImagingServiceRequest
Parent:         ServiceRequest
Id:             imaging-service-request
Title:          "Imaging ServiceRequest"
Description:    "Imaging order that this imaging diagnostic report is based on."

* text MS

// Must have an identifier which is the accession number
* identifier 1..*

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type.coding"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.type.coding"
* identifier ^slicing.ordered = false

* identifier contains accession 1..1 MS
* identifier[accession].type 1..1 MS
* identifier[accession].type.coding = HL7V2#ACSN
* identifier[accession].value 1..1 MS

* code 1..1 MS

* intent from ImagingServiceRequestIntentVS (required)

* subject only Reference(IDRPatient)

* reason MS
* reason only CodeableReference(Condition or Observation)
* reason ^short = "Indications for the imaging study"

ValueSet: ImagingServiceRequestIntentVS
Id: imaging-servicerequest-intent-vs
Title: "Imaging ServiceRequest intent Value Set"
Description: "Codes representing the applicable intent for a ServiceRequest."
* FHIRIntent#order "Order"
* FHIRIntent#original-order "Original Order"
* FHIRIntent#reflex-order "Reflex Order"
* FHIRIntent#filler-order "Filler Order"
* FHIRIntent#instance-order "Instance Order"



Profile:        IDRRecommendationServiceRequest
Parent:         ServiceRequest
Id:             idr-recommendation-service-request
Title:          "Recommendation"
Description:    "Recommendations as ServiceRequest"

* text MS

* status = #draft

* intent from RecommendationServiceRequestIntentVS (required)

* reason MS
* reason only CodeableReference(IDRImpressionCondition)

* occurrence[x] 1..1 MS

* performerType MS


ValueSet: RecommendationServiceRequestIntentVS
Id: recommendation-servicerequest-intent-vs
Title: "Recommendation Imaging ServiceRequest intent Value Set"
Description: "Codes representing the recommendation intent for a ServiceRequest."
* FHIRIntent#plan "Plan"
* FHIRIntent#proposal "Proposal"
