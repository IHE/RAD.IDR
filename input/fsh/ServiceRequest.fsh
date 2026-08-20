Profile:        IDRImagingServiceRequest
Parent:         ServiceRequest
Id:             idr-imaging-service-request
Title:          "IDR Imaging ServiceRequest"
Description:    "Imaging order suitable for referencing from an IDR imaging diagnostic report."

* text MS

// Must code any accession number(s) as shown to facilitate linkage/searching in unusual scenarios
// This aligns with the ImagingStudy usage described here https://jira.hl7.org/browse/FHIR-49675
* identifier 1..*

* identifier ^slicing.discriminator.type = #value
* identifier ^slicing.discriminator.path = "type"
* identifier ^slicing.rules = #open
* identifier ^slicing.description = "Slice based on the identifier.type.coding"
* identifier ^slicing.ordered = false

* identifier contains accession 0..* MS
* identifier[accession].type 1..1 MS
* identifier[accession].type = $HL7V2#ACSN
* identifier[accession].value 1..1 MS

* code 1..1 MS
* code ^short = "Exam type (orderable code)"
* code ^definition = "The \"orderable code\" indicating the type of exam ordered."
* code ^comment = "Some sites may use LOINC Playbook codes, or some other standard. Others will invent local code sets."

* subject only Reference(Patient)

// TRACK JIRA-58530 allow Any (or at least Procedure, FamilyHistory, MedicationAdministration)
* reason MS
* reason ^short = "Indication(s) for the imaging order"
* reason ^comment = """
Indications might include patient conditions or observations, prior procedures or current medications for followup, family history items, etc.  Such resources may increasingly use ICD-10 codes.

Note 1. A Condition referenced as an indication might reasonably have a .verificationStatus of Provisional or Unconfirmed.
""" 

* reason.concept.text MS
* reason.concept.text ^comment = """
Clinical Questions from the referring physician to the imaging clinician SHALL be encoded in a ServiceRequest.reason item using the .concept.text element. 

The presence of clinical questions (and other reasons for exam) are intended to trigger their presentation to the imaging clinician during protocoling and during reporting, and result in text in the body of the diagnostic report that specifically addresses those question(s).

Note: These questions are asked by the requester (referring) and answered by the performer (imaging clinician) at reporting time. This differs from \"ask at order entry questions\" (aka AOEs) in lab orders which are \"pre-asked\" by the performer (lab clinician) and answered by the requester (referring physician) at order time (in ServiceRequest.supportingInfo).
"""

* encounter MS
* encounter ^comment = """
Note 1. While this encounter is the health care event when the imaging was ordered, and Procedure.encounter is the event when the the imaging occurred, those could be the same in the case of encounter-based imaging.  Whether a ServiceRequest is created for encounter-based imaging and how it is populated are left for future workflow profiling.
"""

* orderDetail ^comment = """
May specify details about how the ordered procedure is to be performed, such as imaging teechnique parameters to use or views to be obtained. Typically, however, such details are left to the imaging department.
"""


Profile:        IDRRecommendationServiceRequest
Parent:         ServiceRequest
Id:             idr-recommendation-service-request
Title:          "IDR Recommendation ServiceRequest"
Description:    "Draft ServiceRequests representing Recommendations from an Imaging Report"

* text MS

* status = #draft

* intent ^comment = """
The intent SHOULD be proposal, or possibly plan, since the imaging clinician is not pplacing an actual order by making the recommendation.
"""

* reason MS

* occurrence[x] MS
* occurrence[x] ^comment = """
Although not required, the occurence can specify a period of time within which it is recommended that service be performed. This can be helpful to set up triggers for time-appropriate followup reminders.
"""

* performerType MS
