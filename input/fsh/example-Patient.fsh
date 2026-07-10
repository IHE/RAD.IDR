Instance: example-Patient
InstanceOf: Patient
Title: "Patient: Jane Doe"
Description: "Simple Patient"
Usage: #example
* identifier.type.coding = HL7V2#MR "Medical Record Number"
* identifier.system = "http://www.acme.com/identifiers/patient"
* identifier.value = "1234567"
* name.family = "Doe"
* name.given = "Jane"
* gender = #female