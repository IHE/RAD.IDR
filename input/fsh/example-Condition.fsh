Instance: example-Observation-Infarct
InstanceOf: Observation
Title: "Observation: Pulmonary Infarct"
Description: "Pulmonary infarct in lower lobe of right lung"
Usage: #example

* text.status = #additional
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
Right lower lobe pulmonary infarct consistent with the clinical scenario.
</div>"""
* subject = Reference(Patient/example-Patient)
* category[0] = $FHIRObservationCategory#imaging
* code = $SCT#705057003 "Presence"
* valueCodeableConcept = $SCT#52101004 "Present"
* bodyStructure = Reference(BodyStructure/example-BodyStructure-Right-Lung-Lower-Lobe)
* status = #final
* effectiveDateTime = 2020-11-11T10:20:50-05:00

Instance: example-BodyStructure-Right-Lung-Lower-Lobe
InstanceOf: BodyStructure
Title: "BodyStructure: Right Lung Lower Lobe"
Usage: #example
* patient = Reference(Patient/example-Patient)
/* TRACK move this back when ballot5 is supported (sigh)
* includedStructure[0].morphology = $SCT#55641003 "Infarct"
*/
* morphology = $SCT#55641003 "Infarct"
* includedStructure[0].structure = $SCT#90572001 "Lower lobe of lung (body structure)"
* includedStructure[0].laterality = $SCT#24028007 "Right"

Instance: example-BodyStructure-Left-Breast
InstanceOf: BodyStructure
Title: "BodyStructure: Left Breast"
Usage: #example
* patient = Reference(Patient/example-Patient)
// R4 BodyStructure uses location + locationQualifier
* includedStructure[0].structure = $SCT#76752008 "Breast structure (body structure)"
* includedStructure[0].laterality = $SCT#7771000 "Left"

/* TODO Convert this to an IDR observation */
Instance: example-Observation-Density
InstanceOf: Observation
Title: "Observation: Suspicious Density"
Description: "A suspicious soft tissue density in the left breast"
Usage: #example

* category = $FHIRConditionCategory#diagnostic-report-impression
* code = $SCT#28328005 "Abnormal Radiologic Density"
* status = #final

* bodyStructure = Reference(BodyStructure/example-BodyStructure-Left-Breast)
* subject = Reference(Patient/example-Patient)

Instance: example-Condition-ChestPain
InstanceOf: Condition
Title: "Condition: Chest Pain"
Description: "Chest Pain as current problem being worked up"
Usage: #example

* category = $FHIRConditionCategory#problem-list-item
* clinicalStatus = $FHIRConditionClinical#active
* verificationStatus = $FHIRConditionVerStatus#provisional
* code = $ICD10#R07.9 "Chest pain, unspecified"

* subject = Reference(Patient/example-Patient)
* asserter = Reference(Practitioner/example-Practitioner-Referring)

Instance: example-Condition-ShortnessOfBreath
InstanceOf: Condition
Title: "Condition: Shortness of Breath"
Description: "Shortness of Breath as current problem being worked up"
Usage: #example

* category = $FHIRConditionCategory#problem-list-item
* clinicalStatus = $FHIRConditionClinical#active
* verificationStatus = $FHIRConditionVerStatus#provisional
* code = $ICD10#R06.02 "Shortness of Breath"

* subject = Reference(Patient/example-Patient)
* asserter = Reference(Practitioner/example-Practitioner-Referring)
