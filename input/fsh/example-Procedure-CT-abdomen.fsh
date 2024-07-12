Instance: example-Procedure-CT-abdomen
InstanceOf: Procedure
Title: "CT Abdomen-Pelvis w/o"
Description: "Radiologic Examination, Abdoment-Pelvis CT; w/o Contrast"
Usage: #example
/* Could populate reason, bodySite, outcome, report but that feels duplicative? */

* basedOn = Reference(ServiceRequest/example-ServiceRequest-CT-abdomen)
* status = #completed // The procedure is completed at end of scan. The ServiceRequest is completed at report publication?
* code = LOINC#36813-4 "CT Abdomen and Pelvis W Contrast IV"
* subject = Reference(Patient/example-Patient)
* encounter = Reference(Encounter/example-Encounter-CT-abdomen)