Profile:        ImagingDiagnosticReport
Parent:         DiagnosticReport
Id:             imaging-diagnosticreport
Title:          "Imaging Diagnostic Report"
Description:    "IHE Imaging Diagnostic Report (IDR) profile on DiagnosticReport"

* text MS

// May reference no ServiceRequest for other -ologies in enterprise imaging
* basedOn 0..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 0..*
* basedOn[serviceRequest] only Reference(ImagingServiceRequest)

// Shall reference on Patient
* subject 1..1
* subject only Reference(Patient)

* issued 1..1
* issued ^short = "DateTime that this diagnostic report is signed-off and published."

// At least one performer is an Organization
* performer 1..*

* performer ^slicing.discriminator.type = #type
* performer ^slicing.discriminator.path = resolve()
* performer ^slicing.rules = #open
* performer ^slicing.description = "Slice based on the performer reference type"
* performer ^slicing.ordered = false

* performer contains organization 1..*
* performer[organization] only Reference(Organization)

// At least one resultsInterpreter is a Practitioner or PractitionerRole
* resultsInterpreter 1..*
* resultsInterpreter only Reference(Practitioner or PractitionerRole)
* resultsInterpreter ^short = "Primary intepreter of results"
* resultsInterpreter ^definition = "Primary intepreter of results"

// At least one finding
* result 1..* MS

// For including potential additional details like the Procedure details.
* supportingInfo MS

// Must have one conclusion
* conclusion 1..1 MS

// Shall include at least one referenced study
* study 1..* MS
* study only Reference(ImagingStudy)
* study ^short = "Study subject to this report"
* study ^definition = "Study subject to this report. Note: Any associated study (e.g. comparison studies) used during reporting should be tracked in the associatedStudy extension."

// Shall include at least one presentedForm which is the text with embedded multimedia content. May include PDF
* presentedForm 1..* MS

* presentedForm ^slicing.discriminator.type = #pattern
* presentedForm ^slicing.discriminator.path = contentType
* presentedForm ^slicing.rules = #open
* presentedForm ^slicing.description = "Slice based on the presentedForm content type"
* presentedForm ^slicing.ordered = false

* presentedForm obeys IDRAttachmentInvariant
* presentedForm.contentType 1..1 MS
* presentedForm.size 1..1 MS
* presentedForm.hash 1..1 MS
* presentedForm contains html 1..* and pdf 0..*
* presentedForm[html].contentType = MIME#text/html "HTML"
* presentedForm[pdf].contentType = MIME#application/pdf "PDF"

* extension contains AssociatedStudy named associatedStudy 0..* MS

Extension: AssociatedStudy
Title: "IDR DiagnosticReport Associated Study"
Id: associatedStudy
Description: "Associated studies used in part of diagnostic reporting"
Context: DiagnosticReport
* value[x] only Reference(ImagingStudy or DiagnosticReport)