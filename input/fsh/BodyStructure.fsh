// TODO Description is OK as overview, but it also gets pulled into the IG Artifacts Summary Page

Profile:        IDRAnatomicEntity
Parent:         BodyStructure
Id:             idr-anatomic-entity
Title:          "IDR Anatomic Entity BodyStructure"
Description:    "A BodyStructure that represents an Anatomic Entity (i.e. a body part) that is the target of an Observation.

BodyStructure.includedStructure.structure shall identify the anatomic entity that is target of an observation. The code shall be fully pre-coordinated except for the laterality.
  - For example, if the volume of the caudate lobe of the liver is being measured, the structure will use a code for the caudate lobe, not the entire liver. See also [Table B.3-1 Example Observation Encoding Patterns](volume-3.html#b3-example-finding-encoding-patterns).
  - It is recommended that an observation on multiple structures be encoded as multiple observations on individual structures, each with a separate bodyStructure resource. In the case of [Compound Statement](StructureDefinition-idr-observation-compound-statement.html), it is required to encode separate Observations.

 BodyStructure.includedStructure.laterality shall identify the laterality if .structure is a paired structure. See [DICOM PS3.16 Table L-5. Pairedness of Anatomic Concepts](https://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_L.html#table_L-5). E.g., the left ventricle is not a paired structure.

BodyStructure.includedStructure.qualifier may be used if a pre-coordinated code for .structure that incorporates the qualifier semantics, such as (41879009, SCT, “Distal Right Coronary Artery”), is not available.

BodyStructure.excludedStructure is not typically used when encoding observations.
"
// TODO Consider setting an IG example/preferred value set based on the SNOMED semantic tags of (body structure), (morphologic abnormality), and (physical object)?
// TODO Consider adding ^requirements to explain the realworld need(s) being met for each entity type.


Profile:        IDRPathologicEntity
Parent:         BodyStructure
Id:             idr-pathologic-entity
Title:          "IDR Pathologic Entity BodyStructure"
Description:    "A BodyStructure that represents a Pathologic Entity (i.e. a morphological abnormality) that is the target of an Observation.

BodyStructure.includedStructure.morphology shall identify the type of morphologic abnormality that is the target of the observation. The code shall not pre-coordinate the associated anatomy if an appropriate code is available that is not anatomy-specific. E.g. Codes for pleural effusion or cardiomegaly are acceptable even though they do pre-coordinate some anatomical context because there is not a useful more general code.

BodyStructure.includedStructure.structure shall identify the anatomy associated with the morphologic abnormality identified in .morphology. The code shall be fully pre-coordinated except for the laterality.

- Typically, only a single structure will be referenced. It is permitted to reference multiple structures if needed to describe a single morphologic abnormality that affects multiple structures (e.g. an advanced lung lesion that involves the pleura and thoracic wall), or when the position of a morphologic abnormality is described relative to multiple landmarks.

BodyStructure.includedStructure.laterality shall identify the laterality if .structure is a paired structure.

BodyStructure.includedStructure.qualifier may be used if a pre-coordinated code for .structure that incorporates the qualifier semantics, such as (41879009, SCT, “Distal Right Coronary Artery”), is not available.

Different Observation resources should reference the same BodyStructure resource when they are describing the same pathologic entity, particularly within a single DiagnosticReport. 

When multiple DiagnosticReports describe the same pathologic entity, they may or may not have access to, or be able to correlate or share, the same BodyStructure resource.  In such cases, a Tracking UID may be used in the BodyStructure.identifier to correlate multiple observations on the same entity (e.g. a given lung nodule) or to distinguish between multiple observations on different similar entities (e.g. several lung nodules).
- BodyStructure.identifier.type shall use the value (112039, DCM, “Tracking Identifier”) when encoding a DICOM Tracking Identifier. BodyStructure.identifier.type shall use the value (112040, DCM, “Tracking UID”) when encoding a DICOM Tracking UID.
- It is possible that correlation might happen after the subsequent BodyStructure resources are created, in which case the matching Tracking UID might be added as a later entry to BodyStructure.identifier to relate the matched entities.
- A morphological abnormality might be reclassified over time, such as a lesion that is elevated to a tumor in a subsequent study. Consider creating a new BodyStructure with the new .morphology value that shares the same Tracking UID as the prior BodyStructure resource.
- Two tumors might subsequently merge, perhaps while growing. Consider creating a new BodyStructure which includes the Tracking UIDs of the two old BodyStructures.
- A tumor might subsequently split into two disjoint entities, perhaps while shrinking. Consider creating two new BodyStructure resources to reference in the new report with new Tracking UIDs. The database managing the original BodyStructure might add references from it to the new BodyStructures. While the original BodyStructure could be modified to describe multiple disjoint entities, there would be no way to assign new measurements to the appropriate disjoint entity.
"
// TODO structure is required but permitted to be very general if the morphologic abnormality is not being precisely localized
// TODO migrate identifier constraints and some morphology constraints into FSH 

Profile:        IDRPhysicalObjectEntity
Parent:         BodyStructure
Id:             idr-physical-object-entity
Title:          "IDR Physical Object Entity BodyStructure"
Description:    "A BodyStructure that represents a Physical Object Entity (e.g. a piece of shrapnel or a stent) that is the target of an Observation.

BodyStructure.includedStructure.morphology shall identify the type of physical object that is the target of the observation; preferably using an appropriate morphologic abnormality code from SNOMED, such as (840294004, SCT, “Retained metallic foreign body”). The code shall not pre-coordinate the associated anatomy if an appropriate code is available that is not anatomy-specific. E.g. use (65818007, SCT, “Stent”) rather than (705643001, SCT, “Coronary artery stent”); the anatomic location will be captured in includedStructure.structure.

- In this context, more precise codes (such as a code for coronary artery stent) MAY be used to indicate that the object has been determined to be of a specific type (e.g., a stent designed for insertion into coronary arteries) not to just indicate the location where it has been used.  Clinicians can choose to deploy objects like coronary artery stents in other parts of the body.
- Appropriate codes for physical object entities includes SNOMED codes that have the morphologic abnormality semantic tag and represent non-biological entities such as (840294004, SCT, “Retained metallic foreign body”), and codes that have the physical object semantic tag and may be found inside the body such as (65818007, SCT, “Stent”).

BodyStructure.includedStructure.structure, if present, shall identify the anatomy associated with the physical object. The code shall be fully pre-coordinated except for the laterality.  E.g. the coronary artery in which the stent is located.

BodyStructure.includedStructure.laterality shall identify the laterality if .structure is a paired structure.

BodyStructure.includedStructure.qualifier may be used if a pre-coordinated code for .structure that incorporates the qualifier semantics, such as (41879009, SCT, “Distal Right Coronary Artery”), is not available.
"

// TODO structure is required but permitted to be very general if the physical object is not being precisely localized
// TODO migrate identifier constraints and some morphology constraints into FSH 

