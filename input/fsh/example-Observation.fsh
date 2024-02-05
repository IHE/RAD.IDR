Instance: example-Observation-PatientHistory
InstanceOf: IDRObservationSingle
Title: "Simple Finding example"
Description: "Simple Finding in DiagnosticReport"
Usage: #example

* basedOn = Reference(ServiceRequest/example-ServiceRequest-single-view-chest-xray-history)
* status = #final
* category[imaging].coding = FHIRObservation#imaging
* subject = Reference(Patient/example-Patient)
* performer = Reference(Organization/example-Organization)
* code = ICD10#J90 "Pleural effusion, not elsewhere classified"
* valueCodeableConcept.coding = LOINC#LL2898-6 "Present"