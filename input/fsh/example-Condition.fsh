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
