Profile:        ImagingDiagnosticReport
Parent:         DiagnosticReport
Id:             idr-imaging-diagnostic-report
Title:          "IDR Imaging Diagnostic Report"
Description:    "IHE Imaging Diagnostic Report (IDR) Profile of DiagnosticReport"
* ^purpose = """
Each instance of an imaging diagnostic report shall be encoded as a single DiagnosticReport resource. 

Note: A subsequent addendum would result in an additional DiagnosticReport instance, however that workflow is not yet fully documented in this Profile. 
"""
//TODO2 Review and be intentional about which elements are MS, and highlight in the narrative for implementers
//TODO2 Review for SHALL in comments and decide how to migrate into normative mechanisms
//TODO2 Leverage the Versioning Package as described in ChatGPT and tag things as AddR5toF4, AddR6toR4, or IDR
//TODO2 determine what elements should be Summary - review FHIR guidance - don't include things that are bulky and not always used

// TODO2 figure out how to get tooling to autogenerate examples without triggering complaints if its 1..1
* text 0..1 MS
* text ^short = "Fully-rendered, human-readable report"
* text ^definition = ""

//Added Note 4 to mirror the Accession # solution worked out for ImagingStudy.basedOn see https://jira.hl7.org/browse/FHIR-49675
//TODO2 Update Note 5 that This accession number is expected to match those in the ImagingStudy and ServiceRequest. In some urgent or encounter-based scenarios, a ServiceRequest might not exist at the time of reporting.
//TODO2 Note: Some workflows may involve the creation of local accession numbers in the imaging workflow which are later replaced by accession numbers assigned in enterprise systems. When such replacement takes place, it is important to consider the potential presence of the local accession number in the narrative text, or in rendered PDF documents, as well as in resource attributes.

* basedOn 0..* MS
* basedOn ^comment = """
Note 1. For result resources like DiagnosticReport, .basedOn references the authorizing request being fulfilled; i.e. the order, not the input data. So DiagnosticReport.basedOn references the imaging ServiceRequest, not the ImagingStudy.

Note 2. Report Creators do not create orders. It is expected that an appropriate ServiceRequest resource will exist which may have been created by another system more integrated with order management. The hospital may originate orders as ServiceRequest resources, or may create ServiceRequests based on HL7 v2 ORM or OMG messages. In either case, reporting systems are not the Source of Truth for order management; it would be disruptive for them to directly create/modify order resources.

Note 3. \"Group Cases\": While one report typically corresponds to one order (ServiceRequest) comprised of one study, some reports do cover multiple orders. A radiologist may satisfy multiple ServiceRequests in a single report. Depending on site preferences related to billing and workflow, systems should be prepared to handle this as a single report basedOn multiple ServiceRequests, or as multiple copies of the same report, each basedOn a different ServiceRequest.

Note 4. If the DiagnosticReport is associated with an Accession Number, this field should include a reference to that value in the form: identifier.value = (Accession Number Value) identifier.type = ACSN. A reference value pointing to a ServiceRequest resource is allowed but is not required.

Note 5. DiagnosticReport.basedOn may be empty in some scenarios, e.g. when emergency imaging is performed and an order has not been backfilled before reporting.
"""

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"

* basedOn contains serviceRequest 0..*
* basedOn[serviceRequest] only Reference(IDRImagingServiceRequest)
* basedOn[serviceRequest] ^short = "The imaging order"
* basedOn[serviceRequest] ^definition = "The order for the imaging procedure being reported."


* status ^comment = """
Values of preliminary and final shall be used when their conventional meaning for imaging reports applies. A value of registered state be used while the report is being composed during the interpretation process. For addenda, a value of amended shall be used.

Note: Other FHIR status values such as modified, corrected, or appended are not profiled here. They may be addressed in a reporting workflow profile.
"""

* issued 1..1
* issued ^short = "DateTime report was published."

//TODOQ TCQ Consider if we should add a VS as recommended 
* category 1..* MS
* category ^short = "Categories such as Diagnostic Service"
* category ^definition = "Category codes such as the diagnostic service that performed the imaging study"
* category ^comment = """
Category SHOULD include a general code like <http://terminology.hl7.org/CodeSystem/v2-0074>#RAD \"Radiology\" or <http://terminology.hl7.org/CodeSystem/v2-0074#IMG \"Diagnostic Imaging\" to distinguish imaging reports from lab, pathology, or other diagnostic reports.

It is recommended to include an additional code to indicate the service/department that performed the imaging. That code value may be copied from ServiceRequest.category of the order referenced in .basedOn. The department is expected to correspond to the Organization referenced in .performer, if any. It is recommended that this code focus on the service/department, since the modality is already reflected in DiagnosticReport.code.

Potential department codes may be drawn from DICOM [PS3.16 CID 7030](https://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_7030.html) \"Institutional Department/Unit/Service\" and the HL7 terminology code set referenced in FHIR.

Additional category codes MAY be included to support site needs.
"""

//FUTURE The HL7 preferred binding to LOINC Diagnostic Report Codes needs refinement. It points to a mega-list
* code ^comment = """
DiagnosticReport.code: The code SHOULD communicate the type of imaging report, addressing the modality used, the body part scanned. Often the clinical focus of the reported imaging procedure or key details, such as contrast usage, are also included e.g. (24866-6, LN, “CT Pelvis W contrast IV”). 

Since report titles often mirror the name of the ordered imaging procedure being reported, the codes from the RSNA Radlex Playbook provide a useful example codeset. ([Search LOINC](https://search.loinc.org) for \“playbook\”)

Imaging report titles (and the corresponding code meaning text) are frequently site specific, particularly in terms of the abbreviations used and anatomic labelling conventions.
"""

// Shall reference on Patient
* subject 1..1 MS
* subject only Reference(Patient)
* subject ^short = "The imaged patient"
* subject ^comment = """
IDR Report Creators do not create patient resources. It is expected that an appropriate Patient resource will exist, even if only a John Doe, created by another system more integrated with patient management. Imaging systems are not the Source of Truth for patient demographics and management; it would be disruptive for them to directly create/modify patient resources. If a patient reference is a pre-requisite to publish imaging DiagnosticReport resources, the local infrastructure will arrange for appropriate Patient resources for the Report Creator to use.
"""

// Ambiguious in case of imaging report. So exclude it?
// JIRA FHIR-48767 [Applied] fixes description to highlight this is the encounter during which the data/sample being reported was obtained. Could drop this revised Definition text?
* encounter 0..1
* encounter ^definition = """
If present, will reflect the encounter of the imaging procedure being reported (which may also be found in DiagnosticReport.procedure.encounter.)
To find the encounter during with the order for the imaging procedure was placed, see DiagnosticReport.basedOn[ServiceRequest].encounter.
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

// JIRA FHIR-49614 added .procedure
// TRACK JIRA-58532 to fix ballot5 ^comment which reads "This is a summary of the report, not a list of results." It's not a summary of the report.
* procedure ^comment = """
The .procedure element in part mirrors the .specimen element in describing how the data being reported was obtained and prepared.  
"""

// Shall include at least one referenced study
* study 1..* MS
* study only Reference(IDRImagingStudy)
* study ^short = "Reported Imaging Study"
* study ^definition = "Study interpreted by the imaging clinician in this report."
* study ^comment = """
The ImagingStudy for the study being interpreted shall be referenced unless no such ImagingStudy resource exists.

Note 1. Report Creators do not typically create ImagingStudy resources. It is expected that an appropriate ImagingStudy resource will exist, created by another system more integrated with image management, such as the PACS, or the VNA, or the EMR in response to messaging from the PACS or VNA. Report Creators are not the Source of Truth for imaging study management. 

In the absence of an ImagingStudy, DiagnosticReport.study.identifier shall include the StudyUID (obtained from the reviewed DICOM images). The StudyUID, ServiceRequest and Accession Number all serve to provide basic linkages between the images and the report.
 
Note 2. Studies available for comparison during reporting are tracked in the comparison element, not the study element.
"""

/* TODO Still no ballot4/5 support in Sushi
* comparison 0..1 MS
* comparison ^short = "A List of relevant prior exams"
* comparison ^definition = "A List containing references to prior imaging studies and reports that were considered relevant to the current study and made available to the imaging clinician at the time of reporting."
* comparison ^comment = """
"""
* comparison only Reference(IDRComparisonList)
*/

// Patient History is merged into supportingInfo
// JIRA FHIR-48391 to cover patient history [Triaged]
* supportingInfo ^slicing.discriminator.type = #pattern
* supportingInfo ^slicing.discriminator.path = "type"
* supportingInfo ^slicing.rules = #open
* supportingInfo contains PtHistory 0..*

* supportingInfo[PtHistory].type = http://hl7.org/fhir/diagnosticreport-relevant-information-types#PHX
* supportingInfo[PtHistory].reference only Reference(Observation or FamilyMemberHistory or Condition or AllergyIntolerance or Procedure)
* supportingInfo[PtHistory] ^short = "Patient History"
* supportingInfo[PtHistory] ^definition = "References to resources that constitute the patient history made available to the reporting physician."
* supportingInfo[PtHistory] ^comment = """
Reports do not include the entire medical history available but rather include history details determined to be relevant to the study, usually by the imaging clinician. This might include medical, surgical, social, and family history, as well as risk factors and allergies. Also, the details are as known to the imaging clinician at the time of interpretation; different information may be available when any given reader reads the report, but the report will reflect what was known at interpretation.

While IDR requires the ability to include coded history information, it does not specify how much history information is in coded form. The Patient History may be entirely text (See [Unstructured Observation](StructureDefinition-idr-observation-unstructured.html)).

Condition resources SHALL be used when conditions being tracked (and possibly treated) are encoded. Condition.clinicalStatus indicates whether the condition is currently active or inactive.

AllergyIntolerance SHALL be used when patient allergies or intolerances are encoded.

Procedure SHALL be used when past procedures performed on the patient are encoded. E.g., knee surgery, an appendectomy, or spinal fusion.

FamilyMemberHistory SHALL be used when history from a relative of the patient is encoded. E.g., demographics, known conditions or procedures.

Observation resources SHALL be used when relevant observations are encoded. E.g., those from the referring physician, nursing notes, past care, and past diagnostics such as anatomic histopathology or clinical laboratory result values. This may include recorded observations of the presence or absence of a condition at a particular point in time (independent of whether it is being tracked and/or treated). An [Unstructured Observation](StructureDefinition-idr-observation-unstructured.html) can be a pragmatic way to include a block of narrative patient history if the implementation is unable to create corresponding coded entries.

This history will often include details that also serve as indication(s) for the imaging study. The information coded in the ServiceRequest.reason (See TOLINK 6.7.3.2 Order) is the explicit record of the indications, even if they are also duplicated here.
"""

// Media are for auxilliary use.
* media ^short = "Auxilliary media (not reported images)"
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
This text also appears in the Impression section of the DiagnosticReport.text. It is available here as a convenience for easy access to the key outcome of the report, and to support applications that expect content in this element. Note that due to common imaging report patterns, this text might also include recommendations and communications during the reporting process.
"""

* conclusionCode MS
/* TODOQ Change type of conclusionCode to match R6; Grrr may have to make a conclusionCodeR extension and ask around?
* conclusionCode only CodeableReference
*/
* conclusionCode ^short = "supplemented by conclusionCodeR"
* conclusionCode ^definition = ""
* conclusionCode ^comment = """
R6 makes .conclusionCode a CodeableReference to allow an Observation to be a coded conclusion.

TODO Since I haven't figured out how to do that in a Profile (it is an expansion, not a constraint on the underlying resource) I have created a sister element .conclusionCodeR so I can continue building sample objects and resolving brittle build issues. 
"""

/* TODO Profile IDRImpressionCondition resource
Note 1. Condition is used here as a proxy for a diagnosis or problem that is
not yet determined, per its FHIR documentation.
*/
//TODO Look in sushi-config.yaml and have a dependency section that "pulls in" the relevant extensions

* conclusionCode ^short = "Impression / Conclusion (coded)"
* conclusionCode ^definition = ""
* conclusionCode ^comment = """
A .conclusionCode item, being a CodeableReference, may contain an individual code instead of a reference when a code exists that encompasses the conclusion or impression.

An impression drawn from a \*-RADS System, such as BI-RADS TOLINK, is encoded as a .conclusionCode item containing the corresponding code. For example, $SCT#397143007 \"Mammography assessment (Category 3) - Probably benign finding, short interval follow-up\".

Note 1. \*-RADS codes correspond to the result of a composite assessment, and the conclusion may represent a point on a diagnostic pathway, which encompasses both a differential diagnosis and protocolized follow-up actions.
"""
// TRACK - When sushi does b5, can fix typo b3.recomendation to b5.recommendation
// JIRA FHIR-45290 added .recommendation as a codeableReference
* recomendation 0..* MS
* recomendation ^short = "Recommendations from Radiologist"
* recomendation ^definition = "Proposed follow-up actions based on the findings and interpretations of the diagnostic test for which this report is the subject."
* recomendation ^comment = """
Recommendations for subsequent imaging or lab tests would be encoded as new draft ServiceRequests. Recommendations for formal specialist consultations could also be encoded as new draft ServiceRequests while simpler communications could be encoded as draft CommunicationRequests. In the event an imaging clinician chose to recommend a specific care plan in the report, that would be encoded as a draft CarePlan.

Machine-readable recommendations are intended to facilitate workflow and clinical pathway automation, such as agentic tools, to support the referring physician doing things like placing orders based on the recommendations. If necessary, non-machine-readable text recommendations can be provided in DiagnosticReport.recommendation.concept.text entries since the .recommendation element is a CodeableReference.  Similarly, a partially machine-readable ServiceRequest can populate ServiceRequest.code.concept.text with descriptive text.

> Note: The presence of recommendations might support, or directly trigger, the creation of Flag resources by the referring physician, consuming systems, or even the radiologist. Such behaviors are described in IHE RAD TF-1:56.4.2.4.1.3 but are not a requirement in this profile.
"""
* recomendation ^slicing.discriminator.type = #type
* recomendation ^slicing.discriminator.path = resolve()
* recomendation ^slicing.rules = #open
* recomendation ^slicing.description = "Slice based on the recommendation reference type"

* recomendation contains recommendedservice 0..*
* recomendation[recommendedservice] only Reference(IDRRecommendationServiceRequest)
* recomendation[recommendedservice] ^short = "Recommended follow-up service"
* recomendation[recommendedservice] ^definition = "A follow-up service recommended by the radiologist."

// JIRA FHIR-48390 added .communication as a Reference
* communication 0..* MS
* communication only Reference(IDRCommunication)
* communication ^short = "Communication initiated during reporting process"
* communication ^comment = """
These communications are limited to those initiated during the generation of the DiagnosticReport by members of the organization fulfilling that order. E.g. direct communication of time critical results by the radiologist to the referring physician. Communications that follow publication of the report (e.g. between the referring physician and the patient or a subsequent specialist) are not referenced here.

This information is included in the body of the report, in part for medicolegal purposes. If future HIT infrastructure handles tracking such communications directly in the EMR, the practice of using the diagnostic report to implement such accountability and tracking might change, but for now it is expected to persist.

This information may also facilitate performance metrics such as the speed with which the Referring Physician is notified of key clinical results or other conformance to best practices for patient safety and quality of care.
"""

* presentedForm obeys IDRAttachmentInvariant
* presentedForm ^comment = """
It is recommended that the `Attachment.title` for each presented form attachment be populated to facilitate the recipient being able to distinguish between multiple presented forms and select an appropriate one. `Attachment.language` may also help labelling and selecting an appropriate form.
"""
* presentedForm.contentType 1..1 MS
* presentedForm.size 1..1 MS
* presentedForm.hash 0..1 MS
* presentedForm.title 0..1 MS
* presentedForm.language 0..1 MS