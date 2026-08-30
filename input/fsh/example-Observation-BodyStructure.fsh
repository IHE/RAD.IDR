Instance: example-Observation-Infarct
InstanceOf: IDRObservationConditionPresence
Title: "Observation: Pulmonary Infarct"
Description: "Pulmonary infarct in lower lobe of right lung"
Usage: #example
* subject = Reference(Patient/example-Patient)
* category[0] = $FHIRObservationCategory#imaging
* category[1] = $FHIRConditionCategory#diagnostic-report-impression
* code = $SCT#705057003 "Presence"
* valueCodeableConcept = $SCT#52101004 "Present"
* bodyStructure = Reference(BodyStructure/example-BodyStructure-Right-Lung-Lower-Lobe-Infarct)
* status = #final
* effectiveDateTime = 2020-11-11T10:20:50-05:00


Instance: example-BodyStructure-Right-Lung-Lower-Lobe-Infarct
InstanceOf: IDRPathologicEntity
Title: "BodyStructure: Infarct in Right Lung Lower Lobe"
Usage: #example
//TODO add identifier
* patient = Reference(Patient/example-Patient)
/* TRACK move morphology back (in a few places) when ballot5 is supported or not if reverted (sigh)
* includedStructure[0].morphology = $SCT#55641003 "Infarct"
*/
* morphology = $SCT#55641003 "Infarct"
* includedStructure[0].structure = $SCT#90572001 "Lower lobe of lung (body structure)"
* includedStructure[0].laterality = $SCT#24028007 "Right"


Instance: example-Observation-Density
InstanceOf: IDRObservationConditionPresence
Title: "Observation: Suspicious Density"
Description: "Suspicious soft tissue density overlying the left breast region"
Usage: #example
* subject = Reference(Patient/example-Patient)
* category[0] = $FHIRObservationCategory#imaging
* category[1] = $FHIRConditionCategory#diagnostic-report-impression
* bodyStructure = Reference(BodyStructure/example-BodyStructure-Left-Breast-Density)
* code = $SCT#705057003 "Presence"
* valueCodeableConcept = $SCT#52101004 "Present"
* status = #final
* effectiveDateTime = 2020-11-11T10:20:50-05:00
* note.text = "Cannot be fully characterized on this examination."

//TODO Drop this to allow render? Like for Infarct
* text.status = #additional
* text.div = """<div xmlns="http://www.w3.org/1999/xhtml">
Suspicious soft tissue density overlying the left breast region.
</div>"""


Instance: example-BodyStructure-Left-Breast-Density
InstanceOf: IDRPathologicEntity
Title: "BodyStructure: Density in Left Breast"
Usage: #example
* patient = Reference(Patient/example-Patient)
* morphology = $SCT#28328005 "Abnormal Radiologic Density"
* includedStructure[0].structure = $SCT#76752008 "Breast structure (body structure)"
* includedStructure[0].laterality = $SCT#7771000 "Left"


Instance: example-BodyStructure-Left-Breast
InstanceOf: IDRAnatomicEntity
Title: "BodyStructure: Left Breast"
Usage: #example
* patient = Reference(Patient/example-Patient)
// R4 BodyStructure uses location + locationQualifier
* includedStructure[0].structure = $SCT#76752008 "Breast structure (body structure)"
* includedStructure[0].laterality = $SCT#7771000 "Left"


Instance: example-Observation-Chex-Unstructured-1
InstanceOf: IDRObservationUnstructured
Title: "Observation: Chest normal"
Description: "Unstructured observations of heart and chest with normal appearance"
Usage: #example
* subject = Reference(Patient/example-Patient)
* category[0] = $FHIRObservationCategory#imaging
* code = $99IHEIDR#IDR01 "Unstructured Observation"
* valueString = "The cardiac silhouette is within normal size limits. Mediastinal contours are normal, with no evidence of widening or mediastinal shift."
* status = #final
* effectiveDateTime = 2020-11-11T10:20:50-05:00


Instance: example-Observation-Chex-Unstructured-Feature-2
InstanceOf: IDRObservationUnstructuredFeature
Title: "Observation: Lung Assessment"
Description: "Unstructured observations of lungs"
Usage: #example
* subject = Reference(Patient/example-Patient)
* category[0] = $FHIRObservationCategory#imaging
* bodyStructure = Reference(BodyStructure/example-BodyStructure-Lungs)
* code = $99IHEIDR#IDR02 "Unstructured Feature"
* valueString = "The lung volumes are adequate and the vascular markings are within normal limits. A wedge-shaped opacity is noted in the right lower lobe, consistent with a pulmonary infarct. No obvious consolidation, significant pleural effusion, or other focal airspace disease is detected in the remaining lung fields."
* status = #final
* effectiveDateTime = 2020-11-11T10:20:50-05:00


Instance: example-BodyStructure-Lungs
InstanceOf: IDRAnatomicEntity
Title: "BodyStructure: Lungs"
Usage: #example
* patient = Reference(Patient/example-Patient)
* includedStructure[0].structure = $SCT#39607008 "Lung (body structure)"
* includedStructure[0].laterality = $SCT#51440002 "Bilateral"
