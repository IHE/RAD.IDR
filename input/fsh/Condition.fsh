Profile:        IDRPatientHistoryCondition
Parent:         Condition
Id:             idr-patient-history-condition
Title:          "Past diagnosis of patient in Imaging Diagnostic Report"
Description:    "A past diagnosis of a patient in an Imaging Diagnostic Report."

* text MS


Profile:        IDRImpressionCondition
Parent:         Condition
Id:             idr-impression-condition
Title:          "Impression as Condition"
Description:    "An impression as a condition in imaging report."

* text MS

* category 1..1 MS
* category from IDRImpressionConditionCategoryVS (required)

* verificationStatus 1..1 MS

* code 1..1 MS

* severity MS

* stage MS

* bodySite 1..1 MS

* participant 1..* MS

* evidence MS

* extension contains IDRImpressionLaterality named laterality 0..1 MS

* extension contains IDRImpressionLikelihood named likelihood 0..1 MS

* extension contains IDRImpressionOrder named order 1..1 MS

* extension contains IDRImpressionActionable named actionable 0..1 MS

* extension contains IDRImpressionIncidental named incidental 0..1 MS

Extension: IDRImpressionLaterality
Title: "IDR BodySite Laterality in Impression."
Id: idrImpressionLaterality
Description: "Laterality of impression"
Context: Condition
* value[x] only CodeableConcept

Extension: IDRImpressionLikelihood
Title: "IDR BodySite Likelihood in Impression."
Id: idrImpressionLikelihood
Description: "likelihood of impression"
Context: Condition
* value[x] only CodeableConcept

Extension: IDRImpressionOrder
Title: "Impression Order."
Id: IDRImpressionOrder
Description: "Order in impression"
Context: Condition
* value[x] only positiveInt

Extension: IDRImpressionActionable
Title: "Actionable indication in Impression."
Id: idrImpressionActionable
Description: "Actionable indication in impression."
Context: Condition
* value[x] only CodeableConcept

Extension: IDRImpressionIncidental
Title: "Incidental indication of Impression."
Id: idrImpressionIncidental
Description: "Incidental indication of impression."
Context: Condition
* value[x] only boolean