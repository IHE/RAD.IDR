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
* result 0..* MS
* result only Reference(IDRObservationSingle or IDRObservationComponent or IDRObservationSingleWithComponent or IDRObservationComplex)
* result ^short = "Findings"
* result ^definition = """
Detailed description of the findings on the imaging study. The findings should be described in a clear and concise manner,
using standardized anatomic, pathologic, and radiologic terminology whenever possible.
"""

// For including potential additional details like the Procedure details.
* supportingInfo MS

// Must have one conclusion
* conclusion 1..1 MS
* conclusion ^short = "Impression"
* conclusion ^definition = """
Impression, sometimes also called Conclusion or Diagnosis, provides the radiologist's overall interpretation of the findings,
a specific diagnosis and/or differential diagnosis when possible, answers to any clinical questions posed by the referring physician,
and any recommendations for further management and/or confirmation, as appropriate. Any adverse events may also be briefly noted here.
"""

// Shall include at least one referenced study
* study 1..* MS
* study only Reference(ImagingStudy)
* study ^short = "Study subject to this report"
* study ^definition = "Study subject to this report. Note: Any associated study (e.g. comparison studies) used during reporting should be tracked in the associatedStudy extension."

* extension contains IDRAssociatedStudy named associatedStudy 0..* MS

* extension contains IDRPatientHistory named patientHistory 0..* MS
* extension[patientHistory] ^short = "Patient medical history"
* extension[patientHistory] ^definition = """
May include patient history and other prior clinical details of potential relevance
to the imaging study that has been extracted from the medical record by imaging staff,
automated tools, or by the radiolgoists themselves
"""

* extension contains IDRImagingProcedure named procedure 0..* MS
* extension[procedure] ^short = "Imaging procedure"
* extension[procedure] ^definition = """
Imaging procedure used to acquire the study.
"""

* extension contains IDRRecommendation named recommendation 0..* MS
* extension[procedure] ^short = "Recommendations"
* extension[procedure] ^definition = """
Recommendations a radiologist provides in the report for possible follow up actions.
"""

* extension contains IDRSignature named approval 0..* MS
* extension[procedure] ^short = "Attestation"
* extension[procedure] ^definition = """
Attestation by a radiologist that the report content is correct.
"""


Extension: IDRAssociatedStudy
Title: "IDR DiagnosticReport Associated Study"
Id: idrAssociatedStudy
Description: "Associated studies used in part of diagnostic reporting"
Context: DiagnosticReport
* value[x] only Reference(ImagingStudy or DiagnosticReport)

Extension: IDRPatientHistory
Title: "IDR Patient History"
Id: idrPatientHistory
Description: "Patient history that are relevant for the report"
Context: DiagnosticReport
* value[x] only Reference(Condition or Observation or Procedure or FamilyMemberHistory)

Extension: IDRImagingProcedure
Title: "IDR Imaging Procedure"
Id: idrImagingProcedure
Description: "Imaging procedure used for the imaging acquisition"
Context: DiagnosticReport
* value[x] only Reference(Procedure)

Extension: IDRRecommendation
Title: "IDR Recommendation"
Id: idrRecommendations
Description: "Recommendations for any follow up actions"
Context: DiagnosticReport
* value[x] only CodeableConcept

Extension: IDRSignature
Title: "IDR Signature"
Id: idrSignature
Description: "Report signature"
Context: DiagnosticReport
* value[x] only Reference(Provenance)