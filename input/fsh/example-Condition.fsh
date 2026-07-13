//TODO Need Rewrite in light of Condition 
Instance: example-Condition-Infarct
InstanceOf: IDRImpressionCondition
Title: "Condition: Pulmonary Infarct"
Description: "Pulmonary infarct in lower lobe of right lung"
Usage: #example

* category = IDRImpressionConditionCategoryCS#diagnostic-imaging-impression
* clinicalStatus = FHIRConditionClinical#active
* verificationStatus = FHIRConditionVerStatus#provisional
* code = SCT#64662007 "Pulmonary infarct"

* bodySite = SCT#10024003 "Base of lung"
/* TODO R6 adds bodyStructure which we prefer (and update to lower lobe of right lung)
* extension[bodyStructure]
  * value[0] = 
*/
* subject = Reference(Patient/example-Patient)
* asserter = Reference(Practitioner/example-Practitioner-Radiologist)

Instance: example-BodyStructure-Left-Breast
InstanceOf: BodyStructure
Title: "BodyStructure: Left Breast"
Usage: #example
* patient = Reference(Patient/example-Patient)
// R4 BodyStructure uses location + locationQualifier
* includedStructure[0].structure = http://snomed.info/sct#76752008 "Breast structure (body structure)"
* includedStructure[0].laterality = http://snomed.info/sct#7771000 "Left (qualifier value)"

/* TODO Convert this to an observation? */
Instance: example-Condition-Density
InstanceOf: IDRImpressionCondition
Title: "Condition: Suspicious Density"
Description: "A suspicious soft tissue density in the left breast"
Usage: #example

* category = IDRImpressionConditionCategoryCS#diagnostic-imaging-impression
* clinicalStatus = FHIRConditionClinical#active
* verificationStatus = FHIRConditionVerStatus#provisional
* code = SCT#28328005 "Abnormal Radiologic Density"

* bodyStructure = Reference(BodyStructure/example-BodyStructure-Left-Breast)
* subject = Reference(Patient/example-Patient)
* asserter = Reference(Practitioner/example-Practitioner-Radiologist)


Instance: example-Condition-ChestPain
InstanceOf: Condition
Title: "Condition: Chest Pain"
Description: "Chest Pain as current problem being worked up"
Usage: #example

* category = FHIRConditionCategory#problem-list-item
* clinicalStatus = FHIRConditionClinical#active
* verificationStatus = FHIRConditionVerStatus#provisional
* code = ICD10#R07.9 "Chest pain, unspecified"

* subject = Reference(Patient/example-Patient)
* asserter = Reference(Practitioner/example-Practitioner-Radiologist)

Instance: example-Condition-ShortnessOfBreath
InstanceOf: Condition
Title: "Condition: Shortness of Breath"
Description: "Shortness of Breath as current problem being worked up"
Usage: #example

* category = FHIRConditionCategory#problem-list-item
* clinicalStatus = FHIRConditionClinical#active
* verificationStatus = FHIRConditionVerStatus#provisional
* code = ICD10#R06.02 "Shortness of Breath"

* subject = Reference(Patient/example-Patient)
* asserter = Reference(Practitioner/example-Practitioner-Radiologist)
