Profile:        IDRObservation
Parent:         Observation
Id:             idr-observation
Title:          "IDR Imaging Observation"
Description:    "Findings or impressions in imaging reports"

* text MS

// Shall reference one ServiceRequest
* basedOn 1..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 1..*
* basedOn[serviceRequest] only Reference(IDRImagingServiceRequest)

// Shall reference on Patient
* subject 1..1
* subject only Reference(Patient)

* encounter MS

* partOf MS
* partOf only Reference(IDRImagingStudy)

// Specify the category to be imaging
* category 1..*

* category ^slicing.discriminator.type = #value
* category ^slicing.discriminator.path = "coding"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the category.coding"
* category ^slicing.ordered = false

* category contains imaging 1..1 MS
* category[imaging].coding = FHIRObservation#imaging

* status MS
* status = FHIRObservationStatus#final

// At least one performer is an Organization
* performer only Reference(Practitioner or PractitionerRole or Organization)

// Optional reference to an ImagingSelection
* derivedFrom 0..* MS

* derivedFrom ^slicing.discriminator.type = #type
* derivedFrom ^slicing.discriminator.path = resolve()
* derivedFrom ^slicing.rules = #open
* derivedFrom ^slicing.description = "Slice based on the derivedFrom reference type"
* derivedFrom ^slicing.ordered = false

* derivedFrom contains imagingSelection 0..*
* derivedFrom[imagingSelection] only Reference(ReportKeyImages)


Profile:        IDRObservationSingle
Parent:         IDRObservation
Id:             idr-observation-single
Title:          "IDR Single Value Observation: Experimental"
Description:    "An observation that captures a single value"

* value[x] 1..1 MS

* component 0..0



Profile:        IDRObservationComponent
Parent:         IDRObservation
Id:             idr-observation-component
Title:          "IDR Multi-Component Observation: Experimental"
Description:    "An observation that captures a single result which consists of multiple components"

* value[x] 0..0

* component 1..*


Profile:        IDRObservationSingleWithComponent
Parent:         IDRObservation
Id:             idr-observation-single-with-component
Title:          "IDR Single Value And Component Observation: Experimental"
Description:    "An observation that captures a single value with component(s)"

* value[x] 1..1 MS

* component 1..*


Profile:        IDRObservationComplex
Parent:         IDRObservation
Id:             idr-observation-complex
Title:          "IDR Complex Values Observation: Experimental"
Description:    "An observation that captures a complex results, possibly with nested structure."

* value[x] MS
* value[x] ^definition = "Value at each node in the complex observation structure. Note: A node may not have an explicit value if its purpose is to define the branching structure of child nodes."

* hasMember 1..* MS

* component MS