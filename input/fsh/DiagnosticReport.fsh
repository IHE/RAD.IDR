Profile:        ImagingDiagnosticReport
Parent:         DiagnosticReport
Id:             imaging-diagnosticreport
Title:          "Imaging Diagnostic Report"
Description:    "IHE Imaging Diagnostic Report (IDR) profile on DiagnosticReport"

* text 1..1 MS

// May reference no ServiceRequest for other -ologies in enterprise imaging
* basedOn 0..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 0..*
* basedOn[serviceRequest] only Reference(ImagingServiceRequest)
* basedOn[serviceRequest] ^short = "The order for imaging."

* status from IDRDiagnosticReportStatusVS

* category 1..* MS

// Shall reference on Patient
* subject 1..1 MS
* subject only Reference(IDRPatient)
* subject ^short = "The imaged patient"

* issued 1..1
* issued ^short = "DateTime that this diagnostic report is published."

// Deprecated attributes in IDR
* note 0..0
* composition 0..0
* media 0..0

// Ambiguious in case of imaging report. So exclude it.
* encounter 0..0
* encounter ^definition = """
For imaging procedure encounter, DiagnosticReport.procedure.encounter.
For ordering encounter, DiagnosticReport.basedOn[ServiceRequest].encounter.

DiagnosticReport.encounter is redundant and ambiguious. So it is excluded.
"""

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

* result 0..* MS
* result only Reference(IDRObservation)
* result ^short = "Findings"
* result ^definition = """
Detailed description of the findings on the imaging study. The findings should be described in a clear and concise manner,
using standardized anatomic, pathologic, and radiologic terminology whenever possible.
"""

// Shall include at least one referenced study
* study 1..* MS
* study only Reference(ImagingStudyInImagingReport)
* study ^short = "Study subject to this report"
* study ^definition = "Study subject to this report. Note: Any associated study (e.g. comparison studies) used during reporting should be tracked in the associatedStudy extension."

* conclusion MS

* extension contains IDRComparisonStudiesExt named comparison 0..* MS

* extension contains IDRPatientHistoryExt named patientHistory 0..* MS
* extension[patientHistory] ^short = "Patient history items selected by radiologist"
* extension[patientHistory] ^definition = """
May have originally been extracted from the medical record by imaging staff,
automated tools, or by the radiologists themselves.
"""

* extension contains IDRImagingProcedureExt named procedure 0..* MS
* extension[procedure] ^short = "Imaging procedure"
* extension[procedure] ^definition = """
Imaging procedure used to acquire the study.
"""

* extension contains IDRImpressionExt named impression 1..* MS
* extension[impression] ^short = "Impression"
* extension[impression] ^definition = """
Impression in the imaging report.
"""

* extension contains IDRRecommendationExt named recommendation 0..* MS
* extension[recommendation] ^short = "Recommendations"
* extension[recommendation] ^definition = """
Recommendations a radiologist provides in the report for possible follow up actions.
"""

* extension contains IDRCommunicationExt named communication 0..* MS
* extension[communication] ^short = "Communications with other care providers"
* extension[communication] ^definition = """
Communications captures what communications have been made with other care providers.
"""

* extension contains IDRSignatureExt named approval 0..* MS
* extension[approval] ^short = "Attestation"
* extension[approval] ^definition = """
Attestation by a radiologist that the report content is correct.
"""


Extension: IDRComparisonStudiesExt
Title: "IDR DiagnosticReport Comparison Study"
Id: idrComparisonStudy
Description: "Studies used for comparison in part of diagnostic reporting"
Context: DiagnosticReport
* value[x] only Reference(IDRComparisonStudy)

Extension: IDRPatientHistoryExt
Title: "IDR Patient History"
Id: idrPatientHistory
Description: "Patient history that are relevant for the report"
Context: DiagnosticReport
* value[x] only Reference(IDRPatientHistoryCondition or IDRPatientHistoryObservation or IDRPatientHistoryProcedure or IDRPatientHistoryFamilyMemberHistory)

Extension: IDRImagingProcedureExt
Title: "IDR Imaging Procedure"
Id: idrImagingProcedure
Description: "Imaging procedure used for the imaging acquisition"
Context: DiagnosticReport
* value[x] only Reference(IDRProcedure)

Extension: IDRImpressionExt
Title: "IDR Impression"
Id: idrImpression
Description: "Impression in the imaging report"
Context: DiagnosticReport
* value[x] only Reference(IDRImpressionCondition or IDRObservation)

Extension: IDRRecommendationExt
Title: "IDR Recommendation"
Id: idrRecommendation
Description: "Recommendations for any follow up actions"
Context: DiagnosticReport
* value[x] only Reference(IDRRecommendationServiceRequest)

Extension: IDRCommunicationExt
Title: "IDR Communication"
Id: idrCommunication
Description: "Communications captures what communications have been made with other care providers"
Context: DiagnosticReport
* value[x] only Reference(IDRCommunication)

Extension: IDRSignatureExt
Title: "IDR Signature"
Id: idrSignature
Description: "Report signature"
Context: DiagnosticReport
* value[x] only Reference(IDRSignatureProvenance)