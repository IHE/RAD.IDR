Instance: example-Encounter-doctor-visit
InstanceOf: Encounter
Title: "Primary Care Provider Visit example"
Description: "An encounter with primary care physician (who then orders imaging)"
Usage: #example

* status = #completed
* class = #AMB // Ambulatory, i.e. outpatient
* subject = Reference(Patient/example-Patient)
* participant[0].type = http://terminology.hl7.org/CodeSystem/provenance-participant-type#ATND // TODO Attending? 
/* odd that it's type in encounter and function in findings */
* participant[0].actor = Reference(Practitioner/example-Practitioner-family-doctor) 
