Instance: example-Observations-findings-CT-bowel-obstruction
InstanceOf: Observation
Title: "CT Findings Bowel Obstruction"
Description: "Findings related to an abdominal CT that included a bowel obstruction. Clinical content from Hartung, et al, How to Create a Great Radiology Report, RadioGraphics 2020 40:6, 1658-1670"
Usage: #example
/* Phase 2 will figure out frameworks that do more coding of findings and leverage CDE Sets */

* text = "Gastrointestinal Tract: Dilated fluid-filled loops of small bowel that gradually transition in the right lower quadrant. No mass. Mesenteric edema. No free intraperitoneal air."
* basedOn = Reference(ServiceRequest/example-ServiceRequest-CT-abdominal) // TODO
* partOf = Reference(ImagingStudy/example-ImagingStudy-CT-abdominal) // TODO
* status = #final
* category = #imaging
* subject = Reference(Patient/example-Patient)
* encounter = Reference(Encounter/example-Encounter-CT-abdominal) // TODO imaging encounter
* effectiveDateTime = TODO // time of exam
* performer = Reference(Practitioner/example-Practitioner-radiologist) // TODO reporting radiologist
* bodySite = $SCT#122865005 "Gastrointestinal Tract" 
* derivedFrom = Reference(ImagingStudy/example-ImagingStudy-CT-abdominal) //TODO should we also reference the report or is that redundant?
