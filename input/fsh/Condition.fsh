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