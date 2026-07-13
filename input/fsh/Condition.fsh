//TODO Need rewrite in light of workflow/active management essence of Condition 
//TODOQ Can drop this first one? Or are we mandating the text for assembling History text
Profile:        IDRPatientHistoryCondition
Parent:         Condition
Id:             idr-patient-history-condition
Title:          "IDR Patient History Condition"
Description:    "A past diagnosis of a patient in an imaging report."

* text MS


Profile:        IDRImpressionCondition
Parent:         Condition
Id:             idr-impression-condition
Title:          "IDR Report Impression Condition"
Description:    "A condition appearing in the impression of an imaging report."

* text MS

* category 1..1 MS
// JIRA FHIR-48358 and UP-635 are adding the "diagnostic-report-impression" code to R6. WIP 2025.08.01
// TODOQ If we want to fix it to "diagnostic-report-impression" is VS the right mechanism?
* category from IDRImpressionConditionCategoryVS (required)

* verificationStatus 1..1 MS
* verificationStatus ^comment = """
Typical values will be confirmed, differential, provisional, unconfirmed, and refuted. 

\"confirmed\" would not be used unless the imaging report is the definitive source of such a diagnosis.

\"refuted\", per <https://www.hl7.org/fhir/R5/condition.html#9.2.4.5>, is used for subsequent disproof of a previously asserted condition so it would not be used unless the condition was previously asserted and the radiology report is negative and is definitive for such an assertion. Other negative assertions are handled as observations.
"""

* code 1..1 MS
* code ^comment = """
Codes may be drawn from SNOMED or similar coding system.
"""

* severity MS
* severity ^comment = """
Note 1. Severity does not map directly to patient risk. A mild stroke might present a greater risk than a severe ingrown toenail.
"""

* stage MS
* stage ^comment = """
This typically depends on the condition having formal (often disease-specific) staging concepts. The imaging clinician might not always assess the stage.
"""

// JIRA FHIR-50859 for ImagingStudy positioningset up use of BodyStructure encoding not bodySite. Variability increases implementation and testing complexity
* bodySite 0..*
* bodySite ^comment = """
Should not be present. R6 specifies not to use bodySite when bodyStructure is present. This IG specifies usage of bodyStructure. 
"""

* bodyStructure 0..1 MS
/* TOAddR6toR4 
* extension contains AddR6toR4ConditionBodyStructure named bodyStructure 0..1 MS
*/
* bodyStructure ^comment = """
The BodyStructure.includedStructure.structure may contain codes drawn from SNOMED or similar coding system. BodyStructure.laterality shall record laterality if the bodyStructure is a paired structure.

Note: When a condition spans multiple structures, .includedStructure may include multiple items.  
"""
// TODOQ TCQ should we include guidance on when to use fine grained/pre-coordinated structure codes vs the .qualifier element?

/* TOAddR6toR5 Note: In R4, not R5, back in R6. Need extension for implementers? */
* asserter 1..1 MS
* asserter ^comment = "In an imaging report, this is the imaging clinician."

* clinicalStatus ^comment = """
This element is required to be present by the Condition resource. In diagnostic reports, the clinicalStatus will frequently be \"unknown\", but the other defined values may be used when appropriate.
"""

* evidence MS
* evidence ^comment = """
May contain a reference to the DiagnosticReport and/or references to Observation resources in the Findings and/or Impression sections, or references to other information elsewhere that contributed to this impression item.
"""

* extension contains IDRImpressionLikelihood named likelihood 0..1 MS

* extension contains IDRImpressionActionable named actionable 0..1 MS

Extension: IDRImpressionLikelihood
Title: "IDR Impression Condition Likelihood."
Id: idrImpressionLikelihood
Description: "likelihood of condition assertion"
Context: Condition
* value[x] only CodeableConcept

/* TODO
- Condition.likelihood shall record the likelihood of the
  condition, if expressed by the imaging clinician. (See Open Issue
  about adoption of a coding system)

Note: "Consistent with" in the narrative form of an impression typically
implies strong imaging support for an existing (tentative) diagnosis in
place beforehand. Most other impressions represent conditions put
forward by the imaging clinician. If the Condition resource for the
existing diagnosis is known, consider referencing that instance and
adding information to Condition.evidence.
*/

Extension: IDRImpressionActionable
Title: "IDR Actionable Condition"
Id: idrImpressionActionable
Description: "Actionable indication in impression."
Context: Condition
* value[x] only CodeableConcept

/* TOAddR6toR4
Extension: AddR6toR4ConditionBodyStructure
Title: "(AddR6toR4) Condition.bodyStructure"
Id: idrConditionBodyStructure
Description: "Body Structure where the condition occurs."
Context: Condition
* value[x] only Reference(BodyStructure)
*/