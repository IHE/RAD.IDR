Profile:        IDRComparisonStudy
Parent:         ImagingStudy
Id:             idr-comparison-study
Title:          "Comaprison studies"
Description:    "This serves as a library of studies that imaging clinician took into considerations."

* text MS



Profile:        ImagingStudyInImagingReport
Parent:         ImagingStudy
Id:             idr-imaging-study-in-imaging-report
Title:          "IDR ImagingStudy"
Description:    "ImagingStudy that the findings and impressions in an imaging diagnostic report are based on."

* text MS

// Must have an identifier which is the study instance UID
* identifier 1..*

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = system
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.system"
* identifier ^slicing.ordered = false

* identifier contains studyUID 1..1 MS
* identifier[studyUID].system = DICOMUID
* identifier[studyUID].value 1..1 MS

* modality 1..*

* subject only Reference(Patient)

* started 1..1 MS

// Must have at least one endpoint at the study level of type IMRStudyEndpoint
* endpoint 1..*
* endpoint only Reference(ImagingStudyEndpoint)
