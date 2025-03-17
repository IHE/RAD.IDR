Instance: example-Condition-Infarct
InstanceOf: IDRImpressionCondition
Title: "Condition: Pulmonary Infarct"
Description: "Pulmonary infarct in lower lobe of right lung"
Usage: #example

* category = #diagnostic-imaging-impression
* clinicalStatus = #active
* verificationStatus = #provisional
* code = SCT#64662007 "Pulmonary infarct"

* bodySite = SCT#10024003 "R5Dummy: Structure of Lung Base"
/* TODO R6 adds bodyStructure which we prefer (and update to lower lobe of right lung)
* extension[bodyStructure]
  * value[0] = 
*/
* subject = Reference(Patient/example-Patient)


/* TODO Convert this to an observation? */
Instance: example-Condition-Density
InstanceOf: IDRImpressionCondition
Title: "Condition: Suspicious Density"
Description: "A suspicious soft tissue density in the left breast"
Usage: #example

* category = #diagnostic-imaging-impression
* clinicalStatus = #active
* verificationStatus = #provisional
* code = SCT#28328005 "Abnormal Radiologic Density"

* bodySite = SCT#266920000 "R5Dummy: Structure of Left Breast"
/* R6 adds bodyStructure which we prefer
* extension[bodyStructure]
  * value[0] = 
*/
* subject = Reference(Patient/example-Patient)


Instance: example-Condition-ChestPain
InstanceOf: Condition
Title: "Condition: Chest Pain"
Description: "Chest Pain as current problem being worked up"
Usage: #example

* category = #problem-list
* clinicalStatus = #active
* verificationStatus = #provisional
* code = ICD10#R07.9 "Chest Pain"

* subject = Reference(Patient/example-Patient)

Instance: example-Condition-ShortnessOfBreath
InstanceOf: Condition
Title: "Condition: Shortness of Breath"
Description: "Shortness of Breath as current problem being worked up"
Usage: #example

* category = #problem-list
* clinicalStatus = #active
* verificationStatus = #provisional
* code = ICD10#R06.02 "Shortness of Breath"

* subject = Reference(Patient/example-Patient)
