Profile:        ImagingDiagnosticReport
Parent:         DiagnosticReport
Id:             imaging-diagnosticreport
Title:          "Imaging Diagnostic Report"
Description:    "IHE Imaging Diagnostic Report (IDR) Profile of DiagnosticReport"
* ^purpose = """
Each instance of an imaging diagnostic report shall be encoded as a single DiagnosticReport resource. 

Note: A subsequent addendum would result in an additional DiagnosticReport instance, however that workflow is not yet fully documented in this Profile. 
"""
//TODO Review and be intentional about which elements are MS, and highlight in the narrative for implementers
//TODO Review for SHALL in comments and decide how to migrate into normative mechanisms
//TODO Leverage the Versioning Package as described in ChatGPT and tag things as AddR5toF4, AddR6toR4, or IDR

* text 1..1 MS
* text ^short = "Fully-rendered, human-readable report"
* text ^definition = ""

//TODO mirror the Accession # solution worked out for ImagingStudy. .identifer  
//TODO add  Note: This accession number is expected to match those in the ImagingStudy and ServiceRequest. In some urgent or encounter-based scenarios, a ServiceRequest might not exist at the time of reporting.
//TODO Note: Some workflows may involve the creation of local accession numbers in the imaging workflow which are later replaced by accession numbers assigned in enterprise systems. When such replacement takes place, it is important to consider the potential presence of the local accession number in the narrative text, or in rendered PDF documents, as well as in resource attributes.

* basedOn 0..* MS
* basedOn ^comment = """
Note 1. For result resources like DiagnosticReport, .basedOn references the authorizing request being fulfilled; i.e. the order, not the input data. So DiagnosticReport.basedOn references the imaging ServiceRequest, not the ImagingStudy.

Note 2. Report Creators do not create orders. It is expected that an appropriate ServiceRequest resource will exist which may have been created by another system more integrated with order management. The hospital may originate orders as ServiceRequest resources, or may create ServiceRequests based on HL7 v2 ORM or OMG messages. In either case, reporting systems are not the Source of Truth for order management; it would be disruptive for them to directly create/modify order resources.

Note 3. \"Group Cases\": While one report typically corresponds to one order (ServiceRequest) comprised of one study, some reports do cover multiple orders. A radiologist may satisfy multiple ServiceRequests in a single report. Depending on site preferences related to billing and workflow, systems should be prepared to handle this as a single report basedOn multiple ServiceRequests, or as multiple copies of the same report, each basedOn a different ServiceRequest.

Note 4. DiagnosticReport.basedOn may be empty in some scenarios, e.g. when emergency imaging is performed and an order has not been backfilled before reporting.
"""

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"
* basedOn ^slicing.ordered = false

* basedOn contains serviceRequest 0..*
* basedOn[serviceRequest] only Reference(IDRImagingServiceRequest)
* basedOn[serviceRequest] ^short = "The imaging order"
* basedOn[serviceRequest] ^definition = "The order for the imaging procedure being reported."

//TODO do we want to limit the VS or just profile the usage of the codes? 
//It IS helpful to reduce the number of different codes in play if we can. (Ask John?)
//Make the VS extensible, not required. So we can nudge to convergence. 
//Extensions may be in later WF profile or local implementations
//Kinson- COULD consider profiling the code system to refine the definitions, then use that to make our value set
* status from IDRDiagnosticReportStatusVS
* status ^comment = """
Values of preliminary and final shall be used when their conventional meaning for imaging reports applies. A value of registered state be used while the report is being composed during the interpretation process. For addenda, a value of amended shall be used. .
Note:	Other FHIR status values such as modified, corrected, or appended are not profiled here.  They may be addressed in a reporting workflow profile.
"""

//TODO Consider if we should add a VS as recommended 
* category 1..* MS
* category ^short = "Diagnostic Service"
* category ^definition = "A code for the diagnostic service that performed the imaging study"
* category ^comment = """
It is recommended that this code focus on the service/department, since the modality is already reflected in DiagnosticReport.code.

Potential codes may be drawn from DICOM [PS3.16 CID 7030](https://dicom.nema.org/medical/dicom/current/output/html/part16.html#sect_CID_7030) \"Institutional Department/Unit/Service\" and the HL7 terminology code set referenced in FHIR. 

This value may be copied from the ServiceRequest.category that the report is basedOn. 
"""

//TODO Does the HL7 preferred binding to LOINC Diagnostic Report Codes need refinement? It points to a mega-list
* code ^comment = """
Imaging report titles are frequently site specific, but commonly communicate the modality, body part, and/or clinical focus of the performed imaging procedure.

Note 1. Since report titles often mirror the name of the ordered imaging procedure, the codes from the RSNA Radlex Playbook provide a useful example codeset. ([Search LOINC](https:\\search.loinc.org) for \“playbook\”)
"""


// Shall reference on Patient
* subject 1..1 MS
* subject only Reference(IDRPatient)
* subject ^short = "The imaged patient"
* subject ^comment = """
Note 1. Report Creators do not create patient resources. It is expected that an appropriate Patient resource will exist, even if only a John Doe, created by another system more integrated with patient management. Imaging systems are not the Source of Truth for patient demographics and management; it would be disruptive for them to directly create/modify patient resources. If a patient reference is a pre-requisite to publish imaging DiagnosticReport resources, the local infrastructure will arrange for appropriate Patient resources for the Report Creator to use.
"""

* issued 1..1
* issued ^short = "DateTime report was published."

// Ambiguious in case of imaging report. So exclude it. 
//TODO retain. R6 description being fixed FHIR-48767 - set the definition to highlight its the imaging procedure
//TODO Look in sushi-config.yaml and have a dependency section that "pulls in" the relevant extensions
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
* performer ^comment = """
The organization (which may be a diagnostic service) responsible for the report is captured here. The specific clinician is captured in resultsInterpreter.
"""

// At least one resultsInterpreter is a Practitioner or PractitionerRole
* resultsInterpreter 1..*
* resultsInterpreter only Reference(Practitioner or PractitionerRole)
* resultsInterpreter ^comment = """
This is imaging clinician(s) the study is reported by.

Additional report authors may also be referenced. PractitionerRole resources may be used to record participants such as residents, collaborating clinicians and the role they played.
"""

* result 0..* MS
* result only Reference(IDRObservation)
* result ^short = "Findings"
* result ^definition = """
Detailed description of the findings on the imaging study. The findings should be described in a clear and concise manner, using standardized anatomic, pathologic, and radiologic terminology whenever possible.
"""

//Permit but discourage usage of .note
* note ^short = "See Detailed Description Comments"
* note ^comment = """
In imaging diagnostic reports, statements about significant, unexpected or unreliable result values appear as needed in the Findings, Conclusions, or Procedure, not in .note. Other imaging usage was not identified.
"""

/* (Procedure being added in FHIR-49614)
* procedure ^comment = """

"""

*/

// Shall include at least one referenced study
* study 1..* MS
* study only Reference(IDRReportedImagingStudy)
* study ^short = "Reported Imaging Study"
* study ^definition = "Study interpreted by the imaging clinician in this report."
* study ^comment = """
The ImagingStudy for the study being read shall be referenced unless no such ImagingStudy resource exists.

Note 1. Report Creators do not typically create ImagingStudy resources. It is expected that an appropriate ImagingStudy resource will exist, created by another system more integrated with image management, such as the PACS, or the VNA, or the EMR in response to messaging from the PACS or VNA. Report Creators are not the Source of Truth for imaging study management. In the absence of an ImagingStudy, the ServiceRequest and Accession Number will serve to provide basic linkages between the images and the report.
 
Note 2. Studies available for comparison during reporting are tracked in the comparison element, not the study element.
"""

// Media are intended for auxilliary use. Reported images are referenced in .study
* media ^short = "Auxilliary media"
* media ^comment = """
Graphical elements such as charts and icons that appear in the presentedForm of the report may go here if they cannot be included inline in the format used (PDF, etc.).

The interpreted study is referenced from the .study element, not here. Those study images may be accessible as RESTful resources via DICOMweb (which includes parameterized renderings using the /rendered DICOMweb endpoint to adjust windowing and other parameters). Selected parts or points of those images are encoded as ImagingSelection resources. Comparison studies are referenced from the .comparison element. 
"""

// Permitted but not required. Supports supplemental composition. 
* composition 0..1
* composition ^short = "Additional compositions"
* composition ^comment = """
Composition may be included to supplement .text and .presentedForm with additional presentations and compositions of the report content to meet the preferences of different readers, tasks, or site guidelines.
"""

* conclusion MS
* conclusion ^short = "Impression / Conclusion"
* conclusion ^definition = ""
* conclusion ^comment = """
Note 1. In the presentedForm (PDF, HTML, etc.), section text titled Impression frequently contains not just impressions, but also recommendations, and communications. IDR profiles usage of specific encodings for those in the recommendation and communication elements.
"""

* conclusionCode MS
//TODO specify IDRObservation and IDRImpressionCondition
* conclusionCode ^short = "Impression / Conclusion (coded)"
* conclusionCode ^definition = ""
* conclusionCode ^comment = """
A .conclusionCode item, being a CodeableReference, may contain an individual code instead of a reference when a code exists that encompasses the conclusion or impression.

An impression drawn from a \*-RADS System, such as BI-RADS TOLINK, is encoded as a .conclusionCode item containing the corresponding code. For example, (397143007, SCT, \"Mammography assessment (Category 3) - Probably benign finding, short interval follow-up\").

Note 1. \*-RADS codes correspond to the result of a composite assessment, and the conclusion may represent a point on a diagnostic pathway, which encompasses both a differential diagnosis and protocolized follow-up actions.
"""

/* TODO Profile IDRImpressionCondition resource
Note 1. Condition is used here as a proxy for a diagnosis or problem that is
not yet determined, per its FHIR documentation.
*/

// * communication 0..* MS
// Add R6 .communication to R4
* extension contains AddR6toR4DiagnosticReportCommunication named communication 0..* MS
* extension[communication] ^comment = """
These communications are limited to those initiated during the generation of the DiagnosticReport by members of the organization fulfilling that order. E.g. direct communication of time critical results by the radiologist to the referring physician. Communications that follow publication of the report (e.g. between the referring physician and the patient or a subsequent specialist) are not referenced here.
"""

//TODO need to clean up IDRComparisonImagingStudy - as a new attribute, not our extension

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
* value[x] only Reference(IDRImagingProcedure)

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

Extension: AddR6toR4DiagnosticReportCommunication
Title: "DiagnosticReport.communication (AddR6toR4)"
Id: idrDiagnosticReportCommunication
Description: "Communication initiated during the reporting process."
Context: DiagnosticReport
* value[x] only Reference(IDRCommunication)

Extension: IDRSignatureExt
Title: "IDR Signature"
Id: idrSignature
Description: "Report signature"
Context: DiagnosticReport
* value[x] only Reference(IDRSignatureProvenance)