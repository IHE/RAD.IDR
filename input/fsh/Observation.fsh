Profile:        IDRObservationSingle
Parent:         Observation
Id:             idr-observation-single
Title:          "Observation with a single value"
Description:    "An observation that captures a single value"

// Shall reference one ServiceRequest
* basedOn 1..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 1..*
* basedOn[serviceRequest] only Reference(ImagingServiceRequest)

// Specify the category to be imaging
* category 1..*

* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "coding"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the category.coding"
* category ^slicing.ordered = false

* category contains imaging 1..1 MS
* category[imaging].coding = FHIRObservation#imaging

// Shall reference on Patient
* subject 1..1
* subject only Reference(Patient)

// At least one performer is an Organization
* performer only Reference(Practitioner or PractitionerRole or Organization)

* value[x] 1..1 MS

// Maximum one study to be referenced in derivedFrom
* derivedFrom 0..* MS

* derivedFrom ^slicing.discriminator.type = #type
* derivedFrom ^slicing.discriminator.path = resolve()
* derivedFrom ^slicing.rules = #open
* derivedFrom ^slicing.description = "Slice based on the derivedFrom reference type"
* derivedFrom ^slicing.ordered = false

* derivedFrom contains imagingStudy 0..*
* derivedFrom[imagingStudy] only Reference(ImagingStudy)
* derivedFrom contains imagingSelection 0..*
* derivedFrom[imagingSelection] only Reference(ImagingSelection)

* component 0..0



Profile:        IDRObservationComponent
Parent:         Observation
Id:             idr-observation-component
Title:          "Observation with a single result consists of multiple components"
Description:    "An observation that captures a single result which consists of multiple components"

// Shall reference one ServiceRequest
* basedOn 1..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 1..*
* basedOn[serviceRequest] only Reference(ImagingServiceRequest)

// Specify the category to be imaging
* category 1..*

* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "coding"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the category.coding"
* category ^slicing.ordered = false

* category contains imaging 1..1 MS
* category[imaging].coding = FHIRObservation#imaging

// Shall reference on Patient
* subject 1..1
* subject only Reference(Patient)

// At least one performer is an Organization
* performer only Reference(Practitioner or PractitionerRole or Organization)

* value[x] 0..0

// Maximum one study to be referenced in derivedFrom
* derivedFrom 0..* MS

* derivedFrom ^slicing.discriminator.type = #type
* derivedFrom ^slicing.discriminator.path = resolve()
* derivedFrom ^slicing.rules = #open
* derivedFrom ^slicing.description = "Slice based on the derivedFrom reference type"
* derivedFrom ^slicing.ordered = false

* derivedFrom contains imagingStudy 0..*
* derivedFrom[imagingStudy] only Reference(ImagingStudy)
* derivedFrom contains imagingSelection 0..*
* derivedFrom[imagingSelection] only Reference(ImagingSelection)

* component 1..*


Profile:        IDRObservationSingleWithComponent
Parent:         Observation
Id:             idr-observation-single-with-component
Title:          "Observation with a single value and component(s)"
Description:    "An observation that captures a single value with component(s)"

// Shall reference one ServiceRequest
* basedOn 1..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 1..*
* basedOn[serviceRequest] only Reference(ImagingServiceRequest)

// Specify the category to be imaging
* category 1..*

* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "coding"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the category.coding"
* category ^slicing.ordered = false

* category contains imaging 1..1 MS
* category[imaging].coding = FHIRObservation#imaging

// Shall reference on Patient
* subject 1..1
* subject only Reference(Patient)

// At least one performer is an Organization
* performer only Reference(Practitioner or PractitionerRole or Organization)

* value[x] 1..1 MS

// Maximum one study to be referenced in derivedFrom
* derivedFrom 0..* MS

* derivedFrom ^slicing.discriminator.type = #type
* derivedFrom ^slicing.discriminator.path = resolve()
* derivedFrom ^slicing.rules = #open
* derivedFrom ^slicing.description = "Slice based on the derivedFrom reference type"
* derivedFrom ^slicing.ordered = false

* derivedFrom contains imagingStudy 0..*
* derivedFrom[imagingStudy] only Reference(ImagingStudy)
* derivedFrom contains imagingSelection 0..*
* derivedFrom[imagingSelection] only Reference(ImagingSelection)

* component 1..*


Profile:        IDRObservationComplex
Parent:         Observation
Id:             idr-observation-complex
Title:          "Observation with complex values"
Description:    "An observation that captures a complex results, possibly with nested structure."

* instantiates[x] 1..1 MS

// Shall reference one ServiceRequest
* basedOn 1..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 1..*
* basedOn[serviceRequest] only Reference(ImagingServiceRequest)

// Specify the category to be imaging
* category 1..*

* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "coding"
* category ^slicing.rules = #open
* category ^slicing.description = "Slice based on the category.coding"
* category ^slicing.ordered = false

* category contains imaging 1..1 MS
* category[imaging].coding = FHIRObservation#imaging

// Shall reference on Patient
* subject 1..1
* subject only Reference(Patient)

// At least one performer is an Organization
* performer only Reference(Practitioner or PractitionerRole or Organization)

* value[x] MS
* value[x] ^definition = "Value at each node in the complex observation structure. Note: A node may not have an explicit value if its purpose is to define the branching structure of child nodes."

* hasMember 1..* MS

// Maximum one study to be referenced in derivedFrom
* derivedFrom 0..* MS

* derivedFrom ^slicing.discriminator.type = #type
* derivedFrom ^slicing.discriminator.path = resolve()
* derivedFrom ^slicing.rules = #open
* derivedFrom ^slicing.description = "Slice based on the derivedFrom reference type"
* derivedFrom ^slicing.ordered = false

* derivedFrom contains imagingStudy 0..*
* derivedFrom[imagingStudy] only Reference(ImagingStudy)
* derivedFrom contains imagingSelection 0..*
* derivedFrom[imagingSelection] only Reference(ImagingSelection)

* component MS