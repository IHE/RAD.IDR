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
* code = SCT#60046008 "Pleural effusion"
* valueCodeableConcept.coding = LOINC#LL2898-6 "Present"


Instance: example-Observation-Chest-Normal
InstanceOf: IDRObservationSingle
Title: "Normal Chest Finding"
Description: "Normal Chest Finding in DiagnosticReport"
Usage: #example

* basedOn = Reference(ServiceRequest/example-ServiceRequest-CT-Abdomen-Pelvis)
* status = #final
* category[imaging].coding = FHIRObservation#imaging
* subject = Reference(Patient/example-Patient)
* performer = Reference(Organization/example-Organization)
* code = SCT#60046008 "Pleural effusion"
* valueCodeableConcept.coding = SCT#17621005 "Normal"
* bodySite = SCT#15776009 "Pancreas"
* interpretation = SCT#17621005 "Normal"


Instance: example-Observation-Liver-Hemangioma
InstanceOf: IDRObservationSingle
Title: "Liver with Hemangioma"
Description: "Liver with 2cm hemangioma in the right hepatic lob"
Usage: #example

* text.status = #generated
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">
LIVER: 2 cm hemangioma in the right hepatic lobe
</div>
"
* basedOn = Reference(ServiceRequest/example-ServiceRequest-CT-Abdomen-Pelvis)
* status = #final
* category[imaging].coding = FHIRObservation#imaging
* subject = Reference(Patient/example-Patient)
* performer = Reference(Organization/example-Organization)
* code = SCT#60046008 "Pleural effusion"
* valueQuantity.value = 2
* valueQuantity.system = UCUM
* valueQuantity.code = UCUM#cm
* bodySite = SCT#48521005 "Structure of right lobe of liver"
* interpretation = SCT#400210000 "Hemangioma"
