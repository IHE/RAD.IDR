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
Description:    "Draft ServiceRequests representing Recommendations from an Imaging Report

Draft ServiceRequests (and CommunicationRequests), when created, may
omit various details that the imaging clinician would not know or would
not be responsible for choosing. They are intended to serve as a
skeleton that facilitates the referring provider adding any needed
details and activating it as an order.
"

* text MS

* status = #draft
* status ^comment = """
The draft status draft (\"The request has been created but is not yet complete or ready for action.\") reflects the fact that it is ultimately up to the referring physician whether or not to act on one or more recommendations in the report. Also, the request will be sparsely encoded and things like procedure codes might not be locally correct so completion of details and code re-mapping might be needed before a subsequent request can be activated.
"""

* intent ^comment = """
The intent SHOULD be proposal (to leave it up to the referring physician), or possibly plan (if the imaging clinician feels it would be inappropriate if the recommended action does not take place), since the imaging clinician is not placing an actual order by making the recommendation.
"""

* reason MS
* reason ^comment = """
When the recommendation was motivated by a specific Observation referenced from the Impression, that Observation SHOULD also be referenced here. This serves both to justify the recommendation, and to associate the recommendation with the impression which can influence their presentation, e.g., the recommendation might be rendered immediately after the observation in the narrative based on local conventions.

To capture specific clinical/practice guidelines or literature citations that were applied in making the recommendation (e.g., the Fleischner Criteria for lung nodule follow-up), those can also be referenced from ServiceRequest.reason. In HL7 v2, the IHE Results Distribution (RD) Profile encoded this in OBX-15. Since FHIR does not currently have a PracticeGuideline resource, it would be appropriate to create a DocumentReference resource for the relevant policy or guideline document.
"""

* occurrence[x] MS
* occurrence[x] ^comment = """
Although not required, the occurence can specify a period of time within which it is recommended that service be performed. E.g., To encode a recommendation that a follow-up scan take place 6-9 months from now, the Report Creator calculates a start date 6 months from the current date, and an end date 9 months from the current date. 

Populating this element facilitates setting up triggers for time-appropriate followup reminders.

Per FHIR, the context of use makes it clear that the service is requested to occur at one time within the period. 
"""

* performerType MS
* performerType ^comment = """
Populating this element can be used to encode a referral to a particular type of specialist.
"""

* orderDetail MS
* orderDetail ^comment = """
This element can be used to further specify protocol parameters, acquisition technique, desired views, patient preparation, etc., as appropriate. Detailed guidance on this is beyond the scope of this profile.
"""

* note MS
* note ^comment = """
Recommendations, as expressed narratively, may also include conditional logic, e.g., if A is true then procedure X is recommended; if B is true then procedure Y is recommended; else procedure Z is recommended. The IDR Profile does not yet model this logic in the coded recommendations. As a placeholder, the condition text can be included in ServiceRequest.note, with the caveat that this does not support automated tooling. In this example scenario, all three procedures would be included as referenced ServiceRequest resources (with status = draft, as described above) and the referring physician would apply the logic in the narrative notes to decide which to act on, if any.
"""