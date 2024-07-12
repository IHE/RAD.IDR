Instance: example-Condition-impression-CT-bowel-obstruction
InstanceOf: Condition
Title: "CT Impression Bowel Obstruction"
Description: "A bowel obstruction identified on an abdominal CT. Clinical content from Hartung, et al, How to Create a Great Radiology Report, RadioGraphics 2020 40:6, 1658-1670"
Usage: #example

* text = "Small bowel obstruction with transition point in the right lower quadrant, likely due to adhesions."
* clinicalStatus = #active
* verificationStatus = #confirmed
* category = #imaging-impression "Imaging Impression"
* code = $SCT#281255004 "Small bowel obstruction"
* bodySite = $SCT#30315005 "Small bowel" // TODO can we encode the lower right quadrant as a modifier?
* note[0].text = "obstruction transition point is in the right lower quadrant"
* note[1].text = "obstruction likely due to adhesions" // TODO consider second Condition for $SCT#307198001 "Small bowel adhesions" likely
* subject = Reference(Patient/example-Patient)
* encounter = Reference(Encounter/example-CT-abdominal) // TODO imaging encounter
* recordedDate = TODO // time of report
* participant[0].function = http://terminology.hl7.org/CodeSystem/provenance-participant-type#author // TODO check w Security WG if this is best
* participant[0].actor = Reference(Practitioner/example-Practitioner-radiologist) // TODO reporting radiologist
* evidence = Reference(ImagingStudy/example-CT-abdominal) //TODO should we also reference the report or is that redundant?

