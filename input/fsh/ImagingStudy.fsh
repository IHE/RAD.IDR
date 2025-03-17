/*
Profile:        IDRComparisonStudy
Parent:         IDRReportedImagingStudy
Id:             idr-comparison-study
Title:          "IDR Comparison ImagingStudy"
Description:    "ImagingStudy(ies) available to the imaging clinician for comparison during reporting."

* text MS
*/

Profile:        IDRImagingStudy
Parent:         ImagingStudy
Id:             idr-imaging-study
Title:          "IDR ImagingStudy"
Description:    "ImagingStudy(ies) being reported or referenced as priors for comparison by the imaging clinician."

* text MS

// Must have an identifier which is the study instance UID
// TODO Confirm harmonization with R6 ImagingStudy. See also https://jira.hl7.org/browse/FHIR-49675
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

//TODO Kinson - Do we need to keep the following for IDR? And would Endpoint.fsh migrate into examples?
// Must have at least one endpoint at the study level of type IMRStudyEndpoint
* endpoint 1..*
* endpoint only Reference(ImagingStudyEndpoint)
