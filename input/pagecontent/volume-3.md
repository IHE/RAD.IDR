#### 4.3.2.Z Codes for the IDR Profile

The following codes have been defined for the IDR Profile and extensions. They are shown here as part of the IHE coding system and should be used for Trial Implementation. IHE Radiology intends to migrate these codes, and the templates they are used in, to the DICOM Standard prior to advancing the IDR Profile to Final Text.

**Table 4.3.2.Z-1: IDR Codes**

| Code    | codeScheme  | Code Meaning                          | Definition  | Reference             |
|---------|-------------|---------------------------------------|-------------|-----------------------|
| IDR01   | 99IHE       | Unstructured Observation              | An observation where the entire finding is unstructured narrative. | [Unstructured Observation](StructureDefinition-idr-observation-unstructured.html) |
| IDR02   | 99IHE       | Unstructured Feature                  | An observation with unstructured narrative describing a feature of a coded entity. | [Unstructured Feature](StructureDefinition-idr-observation-unstructured-feature.html) |
| IDR03   | 99IHE       | Procedure Radiation Dose Summary Text | A block of text that summarizes the radiation dose attributed to an imaging procedure. | [Radiation Dose Summary](StructureDefinition-idr-radiation-dose-summary) |
{: .grid}

## 6.7 Imaging Diagnostic Report Content

### 6.7.1 Scope

This IHE Radiology Content Specification defines standard encodings for diagnostic reports on imaging procedures. It is specifically intended to cover the output of reporting systems following the interpretation performed by an imaging clinician such as a radiologist.

Refer to [IHE RAD TF-1:56.4.1.2](volume-1.html#56412-purpose-and-structure) for real world expectations in the various report sections.

Pathology and Interventional procedures are not specifically addressed.

### 6.7.2 Referenced Standards

- DICOM: Digital Imaging and Communications in Medicine. <https://dicomstandard.org/>
- FHIR R4: [HL7 FHIR Release 4.0](https://www.hl7.org/FHIR/R4)
- FHIR R5: [HL7 FHIR Release 5.0](https://www.hl7.org/FHIR/R5)
- FHIR R6: [HL7 FHIR R6 Ballot5 (current build)](https://build.fhir.org/)
- LOINC: Logical Observation Identifiers Names and Codes. <https://loinc.org/>
- RadLex: A Lexicon for Uniform Indexing and Retrieval of Radiology Information Resources. <https://www.radlex.org/>
- SCT: SNOMED CT (Systematized Nomenclature of Medicine—Clinical Terms). <https://www.snomed.org/>

#### 6.7.2.1 FHIR Versions and Extensions

This Profile/IG is written in terms of FHIR R6 resources.

> Note 1. FHIR R6 (and R5) introduced specific elements to address key details of coded imaging diagnostic reports.
>
> Note 2. This work expects that HL7 FHIR R6 will be published as normative in 2027. Some prerequisites for this profile/IG to become Final Text include: HL7 FHIR R6 being published as normative, and the IHE Radiology Technical Committee reviewing any relevant changes to FHIR R6 during the HL7 ballot resolution process.

Implementations are permitted to conform based directly on FHIR R6, or based on FHIR R4 and/or FHIR R5 resources with the incorporation of HL7 FHIR cross-version packages (See <https://build.fhir.org/versions.html#extensions>) as needed to provide the elements and behaviors specified in this Profile/IG.

### 6.7.3 FHIR Resource Encodings (IDR)

This section defines how the necessary structure and content of
an imaging diagnostic report (as described in [IHE RAD TF-1:56.4.1.2](volume-1.html#56412-purpose-and-structure)) is encoded in FHIR.

> Note 1. The IG form of this specification creates FHIR profiles for constrained resources and provides a value which the Creator MAY use to set the meta.profile element for a corresponding resource instance. This facilitates validation of received resource instances.
>
> Note 2. A Creator MAY choose not to set meta.profile to a specific profile, or MAY set it to multiple profiles.

A Creator SHALL be capable of encoding imaging diagnostic reports as described in this section.

Imaging diagnostic reports SHALL conform to the normative profiling of the following FHIR Resources:

- [DiagnosticReport](StructureDefinition-imaging-diagnosticreport.html)

- [ServiceRequest (for Orders)](StructureDefinition-idr-imaging-service-request.html)
- [ServiceRequest (for Recommendations)](StructureDefinition-idr-recommendation-service-request.html)

- [Procedure (for Imaging Procedures)](StructureDefinition-idr-imaging-procedure.html)
  
- [ImagingStudy (for Reported or Comparison Study)](StructureDefinition-idr-imaging-study.html) - DICOM Study UID & text
- [List (for Comparison Studies)](StructureDefinition-idr-comparison-list.html)

- [Observation (for Patient History)](StructureDefinition-idr-patient-history-observation.html)
- [Observation (for Findings or Impressions)](StructureDefinition-idr-observation.html)
  - See [Section 6.7.3.1](#673a-observation-encoding-findings-and-impressions) for additional Observation Profiles for specific observation types and observation relationship patterns.

- [Body Structure (for Anatomic Entities)](StructureDefinition-idr-anatomic-entity.html)
- [Body Structure (for Pathologic Entities)](StructureDefinition-idr-pathologic-entity.html)
- [Body Structure (for Physicial Object Entities)](StructureDefinition-idr-physical-object-entity.html)

- [Imaging Selection (in Observations)](StructureDefinition-idr-imaging-selection.html)

- [Communication (for Reported Communications)](StructureDefinition-idr-communication.html)

This content definition makes only usage clarifications to the following FHIR Resources:

- Patient (Subject)

- FamilyMemberHistory (History)
- AllergyIntolerance (History)
- Procedure (History)
- Condition (History)
  
- Encounter (Imaging Encounter)
  
- Practitioner (Reporting or Referring)

- Provenance (Bundle Signing)

This content definition does not presume that all semantics in the report that are potentially codeable are actually coded in this resource. Profiles will likely identify some specific details which are required to be coded to conform to that profile; however, systems processing diagnostic reports should generally assume that there may be details in the narrative which are not also encoded. See also [IHE RAD TF-1:56.4.1.6](volume-1.html#56416-narrative-vs-encoded-content-and-structure) Narrative vs Encoded Content and Structure.

> Note: This profile changes the cardinality from 0.. to 1.. for some FHIR resource attributes. This is done when absence of the attribute would break interoperability. It is not done to enforce the presence of information that is simply desirable or convenient.

#### 6.7.3.a Observation Encoding (Findings and Impressions)

The bulk of most imaging diagnostic reports, especially the Findings and Impressions, will be encoded using FHIR Observation resources, which in turn will reference Body Structure resources and sometimes Imaging Selection resources.

The tremendous breadth of information that clinicians can glean across many medical imaging modalities means that imaging diagnostic reports encompass a very wide variety of possible observations. To bring some order to that complexity, the IDR profile introduces some terminology and concepts (See [RAD TF-1:56.4.1.7](volume-1.html#56417--terminology-for-findings-and-observations) and [56.4.1.8](volume-1.html#56418-findings-encoding-framework)) and models a number of patterns; specifically the types of entities that are the target of observations, the types of observations, and the types of relationships between associated observations. These patterns are expressed in the form of FHIR Profiles. The patterns are intended to help report creators produce more consistent encodings, which in turn will make it easier for report consumers.

See [Table B.3-1](#b3-example-finding-encoding-patterns) for examples and for guidance on how to organize dictated observations into one or more Observation Resources.

Creators SHALL be *capable* of creating at least one Finding encoded as an Observation and referencing it from <u>DiagnosticReport.result</u>. Creators are permitted to create reports where all of the findings use [Unstructured Observation](StructureDefinition-idr-observation-unstructured.html). Creators are encouraged to create reports that use as many Structured Observations (see below) as is practical.
> Note 1. Some Observations might not be referenced directly from .results, but rather might be referenced from .derivedFrom or .hasMember elements in another Observation which is part of a tree that is rooted in a reference from .results.
>
> Note 2. Some Observations referenced from DiagnosticReport.result might also be referenced from DiagnosticReport.conclusionCode, particularly if they have high clinical significance, such as actionable findings.  Such Observation resources are not duplicated; rather their Resource.id is referenced from both locations.

Creators SHALL be *capable* of creating at least one Impression encoded as an Observation and referencing it from <u>DiagnosticReport.conclusionCode</u>. Creators are permitted to create reports where all of the impressions use [Unstructured Observation](StructureDefinition-idr-observation-unstructured.html). Creators are encouraged to create reports that use as many Structured Observations (see below) as is practical.

<!-- TODO Consider creating an Impression Observation profile for this requirement too.-->
Observations referenced from DiagnosticReport.conclusionCode SHALL include the code <http://terminology.hl7.org/7.1.0/CodeSystem-condition-category.html#condition-category-diagnostic-report-impression> in Observation.category.

> Note 1. The imaging clinician might choose to omit from the Impression certain Observation resources referenced in DiagnosticReport.results that record the presence of conditions that the imaging clinician feels are not clinically significant. E.g., minor renal cysts. DiagnosticReport.conclusionCode would not reference those observations.
>
> Note 2. The imaging clinician might choose to include in the Impression certain Observation resources referenced in DiagnosticReport.results that record the absence of conditions the imaging clinician feels represent pertinent negatives. E.g., conditions in the reason for exam. DiagnosticReport.conclusionCode would reference those observations.

<!-- TODO does this go somewhere else? -->
The Report Creator is responsible for distinguishing and encoding dictated impressions, recommendations, and communications. This is intended to facilitate workflow and clinical pathway automation, such as agentic tools, to support the referring physician tracking critical findings, accessing and applying relevant clinical guidelines and other forms of clinical decision support.

- The order of references in .conclusionCode represents the default order of presentation as selected by the Report Creator. Systems rendering this clinical content may choose a different order that is driven by their presentation needs.
- The order of references in . conclusionCode (and permission to choose a different order driven by presentation needs) may also apply if .text is re-rendered by Report Creators to reflect updates to the resource content.

Some information that can be included in Observation metadata replicates information available in the DiagnosticReport metadata. It is recommended that Observation elements needed to facilitate usage of the Observation resources beyond the direct context of the parent DiagnosticReport, for example to perform Observation-level queries, be replicated in each Observation resource. These elements include details like TODO. Conversely, it is recommended that elements that might sometimes be of interest for provenance, but are not normally used for searching or processing, be omitted from each Observation resource since corresponding information is typically available in the DiagnosticReport resource from which they are referenced. These elements include details like .basedOn, .encounter, .issued, .performer, .device, and .partOf.

Details about the reporting process, such as what AI models were or were not run, and what AI
findings were not included in the report, may be documented by
associated systems in relevant logs, but are out of scope of this profile and will not appear directly in
the report itself unless the radiologist chooses to include such
details, for example by describing that in the Procedure/Technique section.

If/when one of these Observations provides the basis for a referring physician to create or update a Condition resource (e.g. to add pneumonia to the problem list, or update the clinical status of a pneumothorax to resolved), Condition.evidence in that Condition resource managed by the referring physician might be updated to include a reference to the Observation resource, and Condition.category might include <http://terminology.hl7.org/CodeSystem/condition-category#diagnostic-imaging-impression>. Such operations on Condition resources are performed by clinical management systems outside the scope of this profile.

##### 6.7.3.a.1 Observation Target

An imaging finding or impression is an Observation on a target entity that is one of three types:

- [An Anatomic Entity](StructureDefinition-idr-anatomic-entity.html), i.e., a body part, such as a pancreatic duct, the mitral valve annulus, the wall of the gall bladder, the lower lobe of the left lung, or potentially the whole body.
- [A Pathologic Entity](StructureDefinition-idr-pathologic-entity.html), i.e., a morphologic abnormality, such as a lesion in the liver, a dissection of the abdominal aorta, or a region of inflammation in the lung.
- [A Physical Object Entity](StructureDefinition-idr-physical-object-entity.html), i.e., a physican object in the body, such as a piece of shrapnel in a muscle, a screw in the left femur, or a stent in a coronary artery.

See [Table B.3-1](#b3-example-finding-encoding-patterns) for examples.

Entities, such as a particular lesion, are often the target of multiple observations (such as its size, margin, and solidity) and may be observed over time (such as tracking growth of the lesion) which is clear when the same BodyStructure instance is referenced by each of the Observation instances. Incorporation of business identifiers, such as lesion tracking UIDs, in the BodyStructure instances further facilitate tracking the entity and matching up Observations in cases where the earlier BodyStructure instance was either not available or not recognized at the time a new Observation was created, but are reconciled later.

> Note: By default the target entity exists in the Observation.subject unless Observation.focus is present in which case the target entity exists in the Observation.focus. E.g. a diameter observation of a cyst in the liver of the fetus rather than a cyst in the liver of the mother, or an observation on the positioning of a shunt in the kidney of the fetus.

##### 6.7.3.a.2 Observation Type

To organize and establish standard patterns among the many possible observations, several types of Observation have been profiled:

- [Measured Property](StructureDefinition-idr-observation-measured-property.html): an observation of a property or feature in the image that is quantitative (typically determined using a measurement tool or application, although they could be estimated)
- [Assessed Characteristic](StructureDefinition-idr-observation-assessed-characteristic.html): an observation of a characteristic or feature in the image that is assessed qualitatively
- [Condition Presence](StructureDefinition-idr-observation-condition-presence.html): an observation of the presence or absence of a condition (i.e. a pathologic entity)
- [Normality Assessment](StructureDefinition-idr-observation-normality-assessment.html): an observation of the normality of an anatomic entity
- [Unstructured Observation](StructureDefinition-idr-observation-unstructured.html): an observation that is fully unstructured narrative
- [Unstructured Feature](StructureDefinition-idr-observation-unstructured-feature.html): an observation that is unstructured narrative on a target entity that has been determined and coded

See [IHE RAD TF-1:56.4.1.8.1](volume-1.html#564181-observation-types) for further discussion of observation types.

##### 6.7.3.a.3 Observation Relationships

To organize and establish standard patterns for encoding the different ways observations may be related to each other, several Observation relationship patterns have been profiled:

- [Finding Set](StructureDefinition-idr-observation-finding-set.html): an observation that is part of a set of observations that collectively represent an assessment of a particular feature or pathology
- [Summary/Derived Observation](StructureDefinition-idr-observation-summary.html): an observation that summarizes other observations
- [Multi-factor Score](StructureDefinition-idr-observation-score-total.html): an observation that is a score totaled from a set of contributing factors (e.g. Balthazar Score or CT Severity Index for pancreatitis)
- [Computed Property](StructureDefinition-idr-observation-computed-property.html): an observation that is computed from other observations, see [Measured Property](StructureDefinition-idr-observation-measured-property.html).
- Temporal Comparison: an observation that captures the difference between observations of the same property of the same entity at different points in time, treat this as:
  - a [computed property](StructureDefinition-idr-observation-computed-property.html) for quantitative comparisons, or
  - a [summary/derived observation](StructureDefinition-idr-observation-summary.html) for qualitative comparisons, such as Increased/Decreased/Unchanged or Worsened/Improved/Unchanged.
  - Note: If a comparsion is made, the historical Observation is referenced from the Comparison observation. Alternatively, the historical Observation might be cited directly by the radiologist, in which case it can appear as a simple observation (with an earlier Observation.effectiveDateTime) referenced directly from DiagnosticReport.result.
- [SR Measurement Group](StructureDefinition-idr-observation-sr-measurement-group.html): a set of observations that correspond to a DICOM Measurement Group, but do not fit any other relationship pattern
- [Compound Statement](StructureDefinition-idr-observation-compound-statement.html): a set of observations that were expressed as a compound statement. E.g., "the kidneys and adrenal glands are unremarkable."
- [Hierarchical Target](StructureDefinition-idr-observation-hierarchical-target.html): a set of observations on a target entity that has hierarchical structure.
- [Supported Conclusion](StructureDefinition-idr-observation-supported-conclusion.html): an observation that represents a possible conclusion with identified support from other observations.

See [IHE RAD TF-1:56.4.1.8.2](volume-1.html#564182-observation-relationships-ie-organizations-and-groupings) for further discussion of observation relationship patterns.

Creators that need to address other cases may need to adopt additional patterns but are encouraged to be as consistent as possible with the patterns here.

For a Causal Relationship (an entity whose existence or state is, at least in part, caused by another observed entity or state), there is currently no mechanism in FHIR Core for etiology. There is a dueTo extension <https://build.fhir.org/ig/HL7/fhir-extensions/StructureDefinition-condition-dueTo.html> that implementations might consider.
This pattern also encompasses the case of multiple observations that share a common cause. Future work may provide explicit guidance for this pattern.

##### 6.7.3.a.4 Other Coding Guidance

The following are recommendations, but not normative requirements for the profile.

For paired anatomy, when an observation or finding applies to both, SNOMED recommends coding two observations, one for left one for right.

For coding the presence of a disorder, SNOMED recommends using values of Detected/Not detected rather than Present/Absent. This is a more accurate description of the situation in the imaging context. It is conceivable for something to be present but not visualized.

For coding interpretive concepts for a measurement, SNOMED recommends using values like above/within/below reference range rather than high/normal/low.

For pneumonia, SNOMED recommends reserving that code for infectious processes. When it is not clearly an infectious process, use pneumonitis.

For pulmonary embolisms, SNOMED recommends that the recorded finding location be a pulmonary artery rather than a region of the lung organ.

#### 6.7.3.b Narrative Text

An Imaging Diagnostic Report is comprised of a collection of Resources that capture the relevant information. These Resources and their associated metadata contain a lot of information (and support a variety of machine consumers). Not all of of that information appears in the typical narrative text of the human-readable rendered report, although the rendered report DOES include all of the key clinical information. While human-readable renderings could be rendered on the fly by the Consumer client, it is common to have a pre-rendered version ready for immediate display, particularly for simplistic clients. More sophisticated clients may still do on the fly rendering to support specific client needs, or to present reports in a locally consistent format preferred by the specific user despite the reports coming from disparate sources.

This specification will describe here:

- support for narrative text in FHIR resources
- the rendering of Narrative text for each of the key Resources in the Imaging Diagnostic Report Information Model (See [IHE RAD TF-3:6.7.3](volume-3.html#673-fhir-resource-encodings-idr))
- how that text is most commonly organized in terms of sections (See [IHE RAD TF-1:56.4.1.2.1](volume-1.html#564121-sections) for report section concepts)
- how the overall Report Narrative is assembled
- where the rendered Report Narrative is made available (DiagnosticReport.text, DiagnosticReport.composition, DiagnosticReport.presentedForm)

##### 6.7.3.b.1 Resources.text

Every FHIR Resource, being a child of the DomainResource, includes an
optional .text attribute which, if present, contains a text summary of
that resource instance for human interpretation. 
Per the [FHIR guidance for .text narrative attributes](https://www.hl7.org/fhir/narrative.html#Narrative), the .text narrative should support human-consumption as a fallback from parsing the resource and should include all information of importance to human readers from the structured data.

In the context of the imaging diagnostic report, these .text attributes are useful components for the
construction of the human-readable form of the entire report.
For example, each ImagingStudy resource referenced in DiagnosticReport.comparison
could have a one-line description of the study in ImagingStudy.text.

Many of these pieces of narrative text are good
candidates to be generated automatically from the coded content of the
resource itself. Report consumer applications may sometimes find
the .text attributes to be a useful source of text for purposes such
as presenting a specific component of the report, or populating part of
an HL7 V2 message segment.

The .text.status is required to be present and contains codes that
describe the extent to which the semantic content of .text covers or
exceeds the coded content of the resource. A value of “additional” indicates that the narrative may contain additional information not found in the structured data. See
<https://www.hl7.org/fhir/R5/valueset-narrative-status.html>

For resources, such as Patient, that are used widely beyond the scope of
the diagnostic report, it the content of .text may or may not be well
suited to direct copying or concatenation without some processing.

TODO Explain here (and possibly also in a few specific places above) that to be a proper representation of the resource, the .text in each Observation (and ImagingStudy and ServiceRequest and Procedure etc) will re-iterate information such as the Patient which will be duplicative if one were to simply concatenate a set of ImagingStudy.texts or Observation.texts. (Or does it? The examples for narrative, for say Condition has .text that just says there's a history of Asthma, without noting the patient.  That said, the spec does imply including and notes that "referenced resources may be updated without updating referencing resources, so the proportion of content of a referenced resource included in a referencing resource should be limited.")
The concatenator/compiler will need to be prudent about such redundancies.
Q. Would it be helpful to use div tags or something in the XHTML to indicate what has been pulled in from referenced resources? If the ImagingStudy pulls the Patient.text to go into ImagingStudy.text, or if it composes the Patient summary from elements, could it wrap that in a div tag, perhaps with the Patient resource identifier, to facilitate not replicating the information when it is the same entity.

TODO Say something about going with simple text if coded Resources (Patient, ServiceRequest, Procedure, ...)

##### 6.7.3.b.1 Patient Narrative

Narrative text from the Patient Resource (DiagnosticReport.subject) typically includes the patient name (from Patient.name) and medical record number (from Patient.identifier).  It may sometimes include the patient sex (Patient.gender), age and/or date of birth (from Patient.birthDate).

The Patient resource usually originates in the EHR and is very widely shared, and so the summary narrative in Patient.text may or may not match the needs of the imaging diagnostic report. The Creator may freshly generate Patient Narrative text from the resource elements for use in the Report Narrative.

The Patient Narrative is most commonly included in the header section of the report. The patient age and sex are sometimes rendered into a section titled Indications or Patient History.

##### 6.7.3.b.2 Order Narrative

Narrative text from the ServiceRequest Resource (DiagnosticReport.basedOn) typically includes the name of the ordered procedure (from ServiceRequest.code).  It may sometimes include the accession number (from ServiceRequest.identifier) and/or the name of the ordering physician (from ServiceRequest.requester).

The ServiceRequest resource usually originates in the EHR and is widely shared, so the summary narrative in ServiceRequest.text may or may not match the needs of the imaging diagnostic report. The Creator may freshly generate Order Narrative text from the resource elements for use in the Report Narrative.

Occasionally, the Creator may need to deal with a report that fulfills several ServiceRequests and to combine that information into the Order Narrative.

The Order Narrative is most commonly included in the header section of the report. The indications and clinical questions (from ServiceRequest.reason) are sometimes rendered into the History Narrative section, and sometimes rendered in the header with a label such as "Indications".

> Note: The Procedure Narrative is rendered from the imaging Procedure Resource (which is what was performed based on patient needs and may be described using clinical terms and codes) rather than the imaging ServiceRequest (which is what was ordered, is sometimes driven by billing requirements, and maybe described using orderable terms and codes). The two do not always exactly match. Sometimes there is an effort to update the order/ServiceRequest to match the actual performed Procedure; ideally if that does happen, it is best done before image interpretation to avoid the possibility that the ServiceRequest resource bundled with the DiagnosticReport is does not match the referenced master copy of the ServiceRequest. Sometimes the original order is cancelled and replaced by a new one in which case the Order reference/link is broken (but it is clear that something has changed). Resolving such issues is a workflow topic that is out of scope for this profile.

##### 6.7.3.b.3 History Narrative

Narrative text from the referenced patient history (PHX) Resources (DiagnosticReport.supportingInfo) may include high-level summaries of the referenced Observations, Conditions, Procedures, and FamilyMemberHistory. The History Narrative text in the report is typically very terse and condensed. It serves to communicate the relevant context the radiologist read in, rather than a full medical summary of the patient.

The referenced Resources usually originate in the EHR and are widely shared, so the summary narrative in each Resource.text may or may not match the needs of the imaging diagnostic report. Due to the typically-preferred compressed style, the Creator may freshly generate History Narrative text from the resource elements. The order of PHX references in DiagnosticReport.supportingInfo represents the default order of presentation as selected by the Creator. Consumer systems rendering this clinical content may choose a different order that is driven by their presentation needs. The radiologist might also dictate the History Narrative at the beginning of the report to be directly transcribed and used.

The History Narrative is most commonly included as a History section in the Report Narrative.

As mentioned under Order Narrative (see above), the History narrative can include indications for the exam and clinical questions from the referring physician which are composed from the imaging ServiceRequest (not from .supportingInfo).

##### 6.7.3.b.4 Procedure Narrative

Narrative text from the Procedure Resource (DiagnosticReport.procedure) describes the imaging procedure that was performed (from Procedure.code, although the description might not specifically match the text in the code). Details usually include the modality and procedure description, and may include details such as technique, patient positioning, pulse sequences, and generated images/views.

Contrast information might appear in the Procedure Narrative, or might included in the header section of the Report narrative with a label such as "Contrast:". If imaging contrast material was used, narrative text will typically describe the contrast type and administration details. These details might be obtained from sources including ImagingStudy, Procedure, and/or MedicationAdministration Resources, DICOM Image headers, DICOM SR objects, or dicatated by the radiologist. If contrast material was not used, this is also sometimes explicitly stated in the narrative text.

The Procedure Narrative might also include details about the creation and processing (such as what kind of views were generated) of the resulting study data, which is drawn from the ImagingStudy (DiagnosticReport.study) and potentially the DICOM Objects themselves.

The Procedure Narrative might also mention patient allergies that were known and taken into consideration in the performance of the imaging procedure.

During the diagnostic imaging procedure, it is possible that complications, such as allergic reactions to contrast, might occur. As part of clinical care documentation during the imaging procedure, these may be encoded in Procedure.complication, and/or AdverseEvent resources, and/or new or updated AllergyIntolerance resources with appropriate values for verificationStatus to allow management of the patient record. Such patient issues are generally managed long before the creation of the diagnostic report. The DiagnosticReport resource is not the primary record for those clinical care workflows; however, the Procedure section might describe and reference those resources, and the patient impact may also be captured in the Conclusion to bring it to the attention of the referring physician.

The Procedure resource likely originates within imaging based on information from the modality, so the summary narrative in Procedure.text could be populated with text that meets the needs of the imaging diagnostic report. The content of the Procedure resource likely originated from the DICOM image headers, MPPS, RDSR, and performed procedure protocols.
The Creator may freshly generate Procedure Narrative text from the resource elements for use in the Report Narrative.

In the large majority of cases, one report corresponds to one study comprised of one acquisition procedure. Some studies do, however, involve multiple acquisition procedures, e.g. a cardiac stress-rest workup. The Creator shall be prepared to deal with a report that covers several current imaging Procedures and to combine that information into the Procedure Narrative.

The Procedure Narrative is most commonly rendered into a Technique Section in the Report Narrative. It may have alternate section titles such as "Procedure and Materials". Since the title of the report is usually the same as the name of the imaging procedure, and since the effective date/time of the report is usually the same as the start time of the imaging study, and since those are both usually included in the header section of the report (often labelled Exam and Date of Exam), they are usually not replicated in the Procedure Narrative. The performing facility is often included in the header section of the report.

> TODO  Exam Date often in header. In the XHTML, the header may be tagged with the section code for Order, without a visible title.

##### 6.7.3.b.5 Study Narrative

Narrative text from the ImagingStudy Resource (DiagnosticReport.study) describes the imaging data that was interpreted. This may include both imaging data that was acquired and reconstructed, as well as imaging data generated from post-processing such as additional reconstructions, additional slice thicknesses, 3D views, etc.

The Study Narrative is almost always folded into the Procedure Narrative rather than being rendered as a separate section or label in the Report Narrative.

Although the Study Instance UID is a key identifier for the ImagingStudy, it is intended for machine usage and is typically not rendered into the Report Narrative.

##### 6.7.3.b.6 Comparison Narrative

Narrative text from the list of comparison ImagingStudy and DiagnosticReport Resources (DiagnosticReport.comparison) usually includes the modality and procedure type (from ImagingStudy.modality & ImagingStudy.description, or DiagnosticReport.code), and date (from ImagingStudy.started or DiagnosticReport.effectiveDateTime) of each comparison in the list. If the list is empty, a statement to that effect (potentially based on List.text or DiagnosticReport.comparison.emptyReason) is rendered into the Comparison Narrative.

The ImagingStudy resources usually originate in the modality and PACS/VNA, so the summary narrative in ImagingStudy.text might match the needs of the imaging diagnostic report.
DiagnosticReport.text contains a human-readable rendering of the full report so it will not be appropriate for use here. The Creator may freshly generate Comparison Narrative text from the resource elements for use in the Report Narrative. The order of references in DiagnosticReport.comparison represents the default order of presentation (usually chonological) as selected by the Creator. Consumer systems rendering this clinical content may choose a different order that is driven by their presentation needs.

The Comparison Narrative is usually included as a Comparison section in the Report Narrative.

Other content from comparison studies (such as observations) are not encoded in the Comparison Narrative. Individual observations are encoded in DiagnosticReport.result at the discretion of the imaging clinician.

##### 6.7.3.b.7 Findings Narrative

Narrative text from the referenced finding Observation Resources (DiagnosticReport.result) is typically the most complex and variable part of an imaging report. Consider first the narrative for each component Observation, then their assembly into the Findings Narrative.

These Observation resources (and their associated BodyStructure and ImagingSelection resources) mostly originate in the context of the reporting process. As such, the Observation.text can be rendered to contain a summary of the semantics of the observation that suits the needs of the imaging diagnostic report.  There are a variety of acceptable patterns for the creation of such Observation resources in the context of the reporting process. Observation.text might be populated first with a line of text dictated by the radiologist and then the other observation elements might be populated based on the dictated text semantics. Similarly, Observation.text might be populated first from a line of observation text taken from an existing uncoded prior report (such as a PDF), and again observation elements are populated from that. Conversely, the observation elements might be populated first from interacting with a radiologist or an AI tool, and then that coded/structured information is rendered into the Observation.text. In the case of [Unstructured Observations](StructureDefinition-idr-observation-unstructured.html), it is expected that the same unstructured observation text appears in both the Observation.value string and Observation.text.

The Findings Narrative is generally an assembly of the Observation.text from the constituent Observations. The Creator is allowed significant flexibility to meet local needs and preferences.  Findings might be grouped by anatomy or anatomic region. Findings might include hyperlinks to relevant ImagingSelections (See the Interactive Multimedia Reports (IMR) Profile).

It is expected that the Creator will minimize semantic duplication in the Findings Narrative. E.g., while the patient name and observation date might be included in the Observation.text of each observation (to facilitate usage when searching Observations; see TOLINK), that would be omitted from the Findings Narrative since it will be part of a full report that identifies those details in the beginning.

See also TOLINK for information on additional capabilities that may support more advanced presentation elements like graphics, tables, etc.

The Findings Narrative is usually included as a Findings section in the Report Narrative.

##### 6.7.3.b.8 Impression Narrative

The Impression Narrative text represents the referenced conclusion Observation Resources (DiagnosticReport.conclusionCode). The text might be directly dictated by the imaging clinician. Tools also exist that generate a draft of the Impression narrative based on the dictated Findings narrative. If the Impression narrative were built up from the coded Impression, the summary in Observation.text of each referenced Observation resource might be compiled into Impression Narrative text similarly to how the Findings Narrative text is prepared.

While the organization of the Impression Narrative does not vary as much as that of the Findings Narrative, it is not uncommon to use numbered bullets.

The order of references in DiagnosticReport.conclusionCode represents the default order of presentation as determined by the Creator and the radiologist. This is sometimes selected to put the most important items first. As such, consumer systems rendering this clinical content are recommended to persist this order unless they have a strong clinical reason not to.

The Impression narrative shall not contain dictated text which goes beyond the semantics captured in the <u>DiagnosticReport.conclusionCode</u> references since any additional narrative should have been encoded in an [Unstructured Observation](StructureDefinition-idr-observation-unstructured.html) referenced from DiagnosticReport.conclusionCode.

The Impression Narrative is usually included as an Impression section (sometimes also called Conclusion) in the Report Narrative.

In addition to rendering the Impression narrative as a section in the full report in the <u>DiagnosticReport.text</u> attribute, the Report Creator may also render the Impression narrative into <u>DiagnosticReport.conclusion</u> as a markdown field.

##### 6.7.3.b.9 Recommendations Narrative

Narrative text from the referenced ServiceRequest (or other appropriate) Resources (DiagnosticReport.recommendation) usually summarizes the recommended service. The text typically indicates this is a recommendation to the referring physician and may also include conditional statements or guidance. If there are no recommendations, the Recommendations Narrative is typically omitted; text stating that there are no recommendations is not included.

The draft ServiceRequest resources originate in Report Creator, so the summary narrative in ServiceRequest.text may match the needs of the imaging diagnostic report. The order of references in DiagnosticReport.recommendation represents the default order of presentation as selected by the Creator. When multiple ServiceRequests are present, they may represent alternatives, as indicated by the associated text.

A recommendation is often directly associated with a specific impression. This may be expressed in the dictated text by following the impression with a recommendation before moving on to the next impression. The Report Creator is responsible for maintaining the order and relationships between impressions and recommendations.

The narrative form of the Recommendations may be directly dictated by the imaging clinician. Tools also exist that generate a draft of the Recommendation narrative based on the Impressions and associated guidelines.

There is idiosyncratic variation between specialties, regions, and facilities as to whether recommendations are presented in the impressions section or presented separately. Since the underlying encoding of a recommendation differs from an impression, this profile suggests defaulting to rendering the recommendations separately. Implementations may still choose to render the recommendation narrative in the Impression section in the presented form based on configuration and customer preferences.

Thus the Recommendation Narrative is sometimes included as a Recommendation section in the Report Narrative. Some practices may choose to include the Recommendation Narrative (if any recommendations exist) in the Impression section in the Report Narrative.

##### 6.7.3.b.10 Communications Narrative

Narrative text from the referenced Communication Resources (DiagnosticReport.communication) typically includes the date and time (from Communication.sent), the recipient (from Communication.recipient), which might be the patient, referring physician, or their staff, and whether the communication was successful (from Communication.status). It may sometimes include the mode of communication (from Communication.medium) and the nature of the information communicated (from Communication.reason and Communication.about).

The Communication resource usually originates in the Report Creator, so the summary narrative in Communication.text may match the needs of the imaging diagnostic report. The Creator may freshly generate Communications Narrative text from resource elements for use in the Report Narrative.  

Occasionally, the Creator may need to deal with a report that includes several Communications and to combine that information into the Communications Narrative. If there are no communications, the Communications Narrative is typically omitted; text stating that there are no communications is not included. The order of references in DiagnosticReport.communication represents the default order of presentation (usually chonological) as selected by the Creator. Consumer systems rendering this content may choose a different order that is driven by their presentation needs.

There is idiosyncratic variation between specialties, regions, and facilities as to whether communications are presented at the bottom of the impressions section or presented separately. Since the underlying encoding of a communications differs from an impression, this profile suggests defaulting to rendering the communications separately. Implementations may still choose to render the communications narrative in the Impression section in the presented form based on configuration and customer preferences.

Thus the Communications Narrative is sometimes included as a Communications section in the Report Narrative. Some practices may choose to include the Communications Narrative (if any communications exist) in the Impression section in the Report Narrative.

##### 6.7.3.b.11 Signature Narrative

Narrative text for the radiologist signature typically appears as a statement such as \"This report was digitally signed by Dr. X at \<time\> on \<date\>\", or \"Electronically signed by: Dr. X; Dictated: \<date\> \<time\>\".  The named clinician should correspond to DiagnosticReport.resultsInterpreter.

The Signature Narrative is usually included as a footer at the bottom of the Report Narrative.

##### 6.7.3.b.12 Report Narrative

The attributes of the DiagnosticReport resource, and the resources it references, are the primary containers for the coded report information which provides interoperable semantics for machine consumers. The Report Narrative is the fully rendered human-readable form of the diagnostic report. It assembles the Patient Narrative, Order Narrative, History Narrative, Procedure Narrative, Study Narrative, Comparison Narrative, Findings Narrative, Impression Narrative, Recommendations Narrative, Communications Narrative, and Signature Narrative.  As described above, much of that narrative content is presented in titled sections in the Report Narrative (e.g., "Findings"), and some goes into the top "header" part of the Report Narrative, usually with each detail prefixed with a descriptor (e.g., "Patient Name: John Doe").

The Report Narrative SHALL be encoded in the <u>DiagnosticReport.text</u> attribute.

> Note 1. As a Narrative attribute, the content of .text is encoded in XHTML with [additional FHIR constraints](<https://www.hl7.org/fhir/narrative.html#Narrative>).
>
> Note 2. The [IHE Interactive Multimedia Report (IMR) Profile](<https://profiles.ihe.net/RAD/IMR/>) also constrains the content of the diagnostic report.
>
> Note 3. Significant variability is possible in how the Report Narrative is arranged; in particular, how observations in the Findings Narrative are organized (sequenced and grouped). The Report Narrative in DiagnosticReport.text represents the presentation organization chosen by the authoring person and/or system at the time of publication and establishes a robust baseline representation of the human-readable report content. Support for additional organizations and representations are discussed in TOLINK Presented Form.

- Sections SHALL be defined using \<div\> tags.

- Each \<div\> tag SHALL have an ‘id’ attribute with a unique value assigned to the section.

- Each \<div\> tag SHALL have a ‘class’ attribute with a code drawn from Table 6.7.3.b.12-1, and formatted as \<coding system\>\|\<code value\>.
  This class code facilitates extraction of section text by report consumers.

- Each \<div\> section SHOULD contain a human readable title reflecting the code meaning for the section. The title may be localized and/or translated. The title may be enclosed in a header tag.

- Each \<div\> section MAY contain HTML 4.0 Text, List or Table elements to organize content within the section

- Each \<div\> section MAY contain the ‘narrativeLink’ or ‘originalText’ extension to link between data and narrative text. See <https://hl7.org/fhir/R5/narrative.html#linking> for details and an example.

**Table 6.7.3.b.12-1: Section Codes**

| Code Value   | Coding System   | Code Meaning    | Notes  |
|--------------|-----------------|-----------------|--------|
| 55115-0      | LN              | Order           |        |
| 11329-0      | LN              | History         |        |
| 55111-9      | LN              | Procedure       |        |
| 18834-2      | LN              | Comparison      |        |
| 59776-5      | LN              | Findings        |        |
| 19005-8      | LN              | Impression      |        |
| 18783-1      | LN              | Recommendation  |        |
| 73568-8      | LN              | Communication   | *1     |
{: .grid}

> Note 1. LOINC defines this code as communication of critical findings. A more general code may be needed since some communications do not involve critical findings.

Per FHIR guidance, all coded content of the diagnostic report that is relevant to a human reader should be present in the .text rendering.

The .text may also contain additional information which is not yet modelled in the coded form of the report. Some practices include links or references at the bottom of the report to educational material that may be helpful to the patient and/or referring physician to understand the impressions and/or recommendations.

See Figure 6.7.3.b.12-1 for an example of the use of \<div\> tags that shows two sections, one for Finding and one for Impression. The Finding section uses simple paragraph tags \<p\> to separate multiple contents. The Impression section uses an unordered list. This is not an example of a full report.

``` xhtml
"text" : {
"status" : "generated",
"div" : "div xmlns=http://www.w3.org/1999/xhtml"

<div id=111 class=http://loinc.org\|59776-5>
<h2>Findings:</h2>
<p>The imaged portion of a thyroid gland is unremarkable. Prominent or
mildly enlarged mediastinal and bilateral hilar lymph nodes measure up
to 1.2 x 0.8 cm in the right paratracheal station (2:12) , 2.3 x 1.4
cm in the subcarinal station (2:18), and 1.4 x 0.9 cm in the right
hilar stations (2:16). No significant axillary lymphadenopathy is
detected. The esophagus is unremarkable. The thoracic aorta is normal
in caliber with a typical 3 vessel takeoff from the arch. The
pulmonary arterial trunk is normal in caliber. The heart is normal in
size without pericardial effusion.
<p/>
<p>Within the pulmonary parenchyma, there is diffuse peribronchovascular
nodular and ground-glass opacities becoming confluent in the right
middle (601:52) and left upper (601:65) and lower lobes (601:72)
consistent with multifocal pneumonia. There is a small left and trace
right pleural effusion. No pneumothorax is present. There are no
suspicious masses or pleural abnormalities.
<p/>

…

</div>
<div id=222 class=http://loinc.org\|19005-8>
<h2>Impression:</h2>
<ul>
<li>Multifocal pneumonia involving the right middle, left upper and
left lower lobes with small left and trace right pleural
effusions.</li>
<li>Central mediastinal lymphadenopathy is likely reactive.</li>
</ul>
</div>

}
```

**Figure TODO 6.7.3.b.12-1: \<div\> Section Example**

##### 6.7.3.b.13 Presented Forms

To supplement the DiagnosticReport.text described in [Section 6.7.3.b.12](#673b12-report-narrative), the Creator may include additional renderings of the report as Attachments under DiagnosticReport.presentedForm. These attachments might serve different audiences of the report, who have different preferences for what information is highlighted and how it is organized. See [IHE RAD TF-1:56.4.2.3 Use Case \#3: Report Presentation](TOLINK) for a discussion of some of the roles and goals a Creator might address. The attachments might be in formats such as PDF, HTML, or RTF.

Since additional renderings are optional, machine consumers might consider refering to the `.text` rendering first which is required to be present.

The Creator may also choose to reference a Composition resource in `DiagnosticReport.composition` to provide additional arrangements and renderings of the imaging report content. See [IHE RAD TF-1:56.4.1.4](TOLINK) for further discussion of Composition.

Additional renderings may contain graphical embellishments and/or improved formatting for better readability, some of which may be beyond what is possible in the XHTML in `.text`, but the renderings should not introduce clinical semantic content that is not present in the .text rendering.

> Note: Beyond the various renderings provided in the DiagnosticReport, a Report Reader might also provide the ability to render and present information directly from the DiagnosticReport resources and metadata based on user-configurable logic to meet the needs of different users, for example rendering finding Observations grouped by finding site/target entity in a particular sequence. Requiring such capabilities is outside the scope of this Profile.

##### 6.7.3.b.14 Language and Translation

All FHIR resources have an optional `.language` element to communicate the language used for the text content of the resource.

The display text for codes, such as (80891009, SCT, “Heart”) often reflects the local language where the data was encoded. Since the semantics are captured by the code value and the coding system, it is permitted to translate the display text into the equivalent text in the local language when presenting, localizing, or transcoding the information.

FHIR provides several mechanisms to consider when text content is translated, for example to satisfy a clinical need or a legal requirement. See <https://build.fhir.org/languages.html>

Creating Provenance resources may be useful when humans and/or systems create persistent documents that are translations of other documents and attest to the quality or accuracy of the translation.

##### 6.7.3.b.11 Provenance (Digital Signature) TODO Describe Provenance in general then application to Resource at REST and Bundle?

The digital signature of the report shall be encoded as a <u>Provenance</u> resource.

- It is up to the rendering system to ensure the signature line appears in the human readable forms of the report (see 6.7.3.11) before finalizing the Provenance resource; doing it in the opposite order would invalidate the signature.

- Provenance.target shall reference the DiagnosticReport resource. Usually, it will also reference all other clinical resources created or updated as part of creating the report, such as Observations and ImagingSelections.
  - Implementations might consider displaying a presented form of the report that has been rendered from the coded content for review and signature by the imaging clinician as a way to facilitate approval of the coded content and not just dictated narrative.
  - The references are typically version-specific.
  - Since contextual resources, like the Patient and ServiceRequest, existed prior to the report and were not updated, those are not usually referenced here.

- Provenance.signature.type shall have a value of ProofOfApproval.

- Provenance.agent.who and Provenance.signature.who (or
  Provenance.signature.onBehalfOf) shall be compatible with the person
  identified in DiagnosticReport.resultsInterpreter.

Implementations should understand that the process of unpacking the resources in a report bundle to make them available locally may result in the digital signature being broken, particularly if the resources have been reconciled to use local codes or local resources such as the local Patient resource for the subject patient. Similarly, it may not be possible to compose a new report bundle for which the original Provenance digital signature remains valid. For these reasons, deployments may want to consider storing a persistent copy of the received report bundle that keeps the digital signature intact.

While the DiagnosticReport does not reference Provenance resources, such
as the one containing the digital signature, the relevant Provenance
resources may be obtained with a query like:

- GET \[base\]/Provenance?target=DiagnosticReport/12345

Relevant Provenance can also be included in the response bundle when
querying the DiagnosticReport in the first place using \_revinclude:

- GET \[base\]/DiagnosticReport?\[search
  parameters\]&\_revinclude=Provenance:target

  > Note: Some resources include a .relevantHistory element that documents prior clinical states of the resource via references to prior corresponding Provenance resources. The “current” Provenance cannot be so referenced since it cannot exist until after the current version of this “target” resource has been created.

Preliminary (“unsigned”) reports may involve a DiagnosticReport resource
being made available which references a
DiagnosticReport.resultsInterpreter, but is not the target of a
Provenance resource with a .signature.type of ProofOfApproval.

In the unprofiled DiagnosticReport resource, the signature appears to be
implicit. It is left to receivers to presume that if the report status
is final and there is an interpreter listed, that means that
practitioner approved the content of the report at some point in time.

### 6.7.4 FHIR Resource Usage

#### 6.7.4.1 Consumers of Findings TODO

The observation types, relationships, and hierarchical structures described throughout section 6.7.3.6 are intended to provide predictable patterns that will make it easier for systems that consume the DiagnosticReport and Observation resources. Such consumers might choose to “flatten out” the observation tree under DiagnosticReport.result to the extent that suits their needs.

Consumers should also consider that the above patterns might not cover all situations and should be prepared for some residual variability in the ways that Report Creators encode findings.


#### 6.7.4.2 Query Patterns for Findings TODO

The following are example query tasks that might be performed on a collection of observations. These were taken into consideration to confirm that they are reasonably practical given the observation encoding requirements and guidance of this profile.

Most queries will start with something like this:

- GET \[base\]/Observation?subject=Patient/{patient-id}&category=imaging

The rest of these examples will start with … instead of repeating the above.

**Task**: Constrain the results to the last 12 months

- …&date=ge2025-01-29 (choose a date 12 months ago)

**Task**: Obtain observations about a target anatomy of interest (e.g. liver)

- …&reference:BodyStructure.included_structure={anatomy code}
- Considerations:
  - By avoiding pre-coordination of the morphology or measured property, the query can obtain measurements, assessments, and morphological abnormalities with a single query without enumerating all the possible pre-coordinated codes.

**Task**: Anatomical search expansion - more specific results (e.g. liver + any parts of the liver)

- E.g. Specific expansion of a search for Kidney would also return observations for Renal Capsule, Renal Artery, Medulla, etc.

**Task**: Anatomical search expansion - more general results (e.g. liver + things the liver is part of)

- E.g. General expansion of a search for Left Kidney would also return observations for Kidneys, Abdomen and Whole Body.

**Task**: Anatomical search expansion - related results (e.g. liver + things related to the liver)

- E.g. Related expansion of a search for Kidney would also return observations for Adrenal Gland, Ureter, Bladder.

**Task**: Obtain specific property observations of a target anatomy of interest (e.g. volume of liver)

- …&\<see anatomy above\>&code={property code}

Some queries might involve more complex logic to combine multiple factors, potentially across multiple related Observations. This might be handled with more complex query capabilities, or it might be handled by using simpler queries to get the server to return a “manageable” set of results, and then leave additional complex logic to be performed by the client before presenting the final results to the user (also referred to as Client-Side Filtering)

- E.g. Show Subdural hematomas greater than 20mm with midline shift
  

# Annex B - Example Imaging Diagnostic Report Content

These examples were prepared in support of the Imaging Diagnostic Report (IDR) Profile. TOLINK See Section 6.7.3 Imaging Diagnostic Report Encodings for the encoding specifications.

This appendix provides some examples of report content, followed by some examples of encodings. This is a limited set of illustrative examples. Additional examples may be available in IHE Connectathons.

## B.1 Example Semantic Content

### B.1.1 Example Order Semantics

The following bullets provide a sample of content typical of order descriptions in an imaging report.

- CT Sinus w/o Contrast

- MRI Brain with and without Contrast

- MRI Left Shoulder

- MG of the Screening (Bilateral) *\<sic; likely composed using a "MODALITY of the BODY PART" template\>*

- PET/CT of the Skull Base To Mid-Thigh

- US Guided Left Knee Injection

- MRI Right Hip Arthrogram Including Cartigram Study

- XR Chest 1 View

### B.1.2 Example History Semantics

The following bullets provide a sample of content typical to history descriptions in an imaging report.

- Memory loss, 2 weeks history of dysbalance and lethargy

- Right arm weakness; Difficulty expressing thoughts in writing beginning about 4-5 months ago.

- Work related injury on September 21, 2015, assess for traumatic tear left rotator cuff with superior shoulder pain and weakness.

- 24M with stent placement in the left main bronchus presents with right sided chest pain since 9am

- A 52-year-old with hemoptysis. Right middle and lower lung zone consolidation. Please evaluate.

- Spiculated right upper lobe lesion. The patient declined biopsy for follow-up. If increase in size would consent to biopsy.

- Shortness of breath, pulmonary opacity on CXR
- Left knee pain. Semimembranosus bursitis.
- Follow-up pleural effusion
- Sinusitis.

- Routine. *\<for an MG Screening Study; perhaps not an example of good practice\>*

### B.1.3 Examples Procedure Semantics

The following bullets provide a sample of content typical to procedure descriptions in an imaging report.

- Axial PD FS, coronal PD FS and PD, sagittal T1 and PD FS imaging is performed through the left shoulder without contrast.

- Sagittal and axial T1-weighted images, axial FLAIR images, axial diffusion weighted sequences, axial T2-weighted images and coronal gradient echo sequences of the brain were obtained. Following gadolinium administration axial and coronal T1-weighted images were obtained.

- Thin slice axial images through the paranasal sinuses were obtained and reconstructed in the coronal and sagittal planes.

- After intraarticular injection of diluted gadolinium in saline, axial T1 fat-sat, axial PD fat-sat, coronal T1 fat-sat, sagittal T1 fat-sat, axial oblique PD fat-sat, and coronal bilateral PD fat-sat images were obtained. This was followed by multiple acquisitions in the coronal and sagittal plane sequentially carried out with post processing and color mapping performed in order to obtain a T2 mapping cartigram study.

- Agents: F-18 fluorodeoxyglucose. Dose: 17.2 millicuries IV. Prior to the administration of the radiotracer, a fingerstick blood glucose level was drawn, measured as 121 mg/dL. CT images for attenuation correction and anatomic localization followed by PET images from the skull base to the thighs were obtained.

- A PET CT scan was performed from the level of the vertex of the skull to the proximal thighs following the administration of 18.6 mCi of FDG intravenously.

- CT scan of the abdomen and pelvis was obtained with intravenous and without enteric contrast material. Coronal and sagittal reformats were provided. Dose reduction technique: The CT scan was performed using appropriate/available dose optimization/reduction techniques.

- CT angiographic examinations of the head and neck were obtained utilizing 75 cc Isovue 370 intravenous contrast. Multiplanar MIP and 3D reformatted images were also created and reviewed. Stenosis measurements were performed based on NASCET criteria. CT scan performed using appropriate/available dose optimization/reduction techniques.

- Head CT without intravenous contrast. Axial images through the brain were acquired from skull base to the vertex with 5 mm slice thickness. Images were reviewed in brain, subdural and bone window settings.

- Single AP view of the chest

### B.1.4 Example Comparison Semantics

The following bullets provide a sample of content typical to comparison descriptions in an imaging report.

- CXR from mm/dd/yyyy, CT Chest from mm/dd/yyyy (two weeks prior)

- CT-PE of July 18, 2012 and limited CT chest from the declined biopsy of September 10, 2012.

- Left knee ultrasound DATE. Left knee radiographs DATE.

- Multiple, last dated August 8, 2023.

- No previous exams are available for comparison.

- None available.

- None.

### B.1.5 Example Findings Semantics

The following bullets provide a sample of content typical to findings in an imaging report.
Many of these examples are organized as sets of related findings.

- Finding set (MRI Cervical Spine)

  - The cervical cord appears normal in its size and signal characteristics.

  - The C2-3 and C3-4 discs are degenerated.

  - There is some mild bulging of the C3-4 disc. Neither level demonstrates central or neural foraminal narrowing.

  - There has been prior fusion from C4 through C7 in good alignment and position. An anterior screw and plate device is present.

  - At C4-5 and C5-6 there is no recurrent central or neural foraminal narrowing.

  - At C6-7 there is mild bilateral bony neural foraminal narrowing without central canal compromise.

  - The C7-T1 level appears unremarkable.

- Finding Set (PET-CT)

  - A right lower breast mass is seen measuring approximately 6.2 x 1.6 cm in transverse dimension with SUV max measuring up to 4.2. The patient has had prior bilateral axillary node dissections. There is no current adenopathy in the axilla bilaterally by size criteria or metabolic activity. There is no adenopathy in the mediastinum or hilum similarly.

  - No pulmonary nodules or masses are identified. However, moderate right and small left perfusions are seen with low-level metabolism, SUV max measuring up to 3.0.

  - Diffuse thoracic esophageal hypermetabolism is noted.

- There is a non-specific subpleural nodule in the right lower lobe which measures 2mm in diameter (Se 3, Im 72).

- A smaller enhancing extra-axial mass more suggestive of atypical meningioma is seen overlying the right mid temporal lobe measuring 1.3 x 0.6 CM. (Axial series 12 image 26).

- There is no significant end vessel ischemic small vessel disease.

- There is no acute infarct seen. No intracranial hemorrhage is recognized.

- MUSCLES AND TENDONS: The gluteal tendons are intact. The hamstring tendon origins are intact.

- No compressive mass within the carpal tunnel.

- Moderate extensor carpi ulnaris tendinosis. There is fluid reflective of tenosynovitis in the second and third extensor compartments as well along the region of the extensor digitorum tendons.

- Moderate amount of fluid in the radiocarpal and midcarpal wrist compartments.

- Mild dorsal angulation of the distal radius reflective of the fracture.

- Evidence of edema in the central and volar aspect of the ligament. Edema extends into the volar radiocarpal ligaments. The pattern is reflective of a volar injury and partial-thickness tear in this region. There is no complete tear. There is no DISI deformity.

- Solid lesion, left breast, 3-4 o'clock, 5 cm from nipple, 0.6x0.9x0.4cm, Volume 0.15ml, Characteristics: oval, parallel, circumscribed

### B.1.6 Example Impression / Conclusion Semantics

The following bullets provide a sample of content typical to impressions in an imaging report.

In some cases, a set of impressions for a particular type of exam are provided as a group to get a sense of the ordering and grouping patterns. Some impression sentences encompass multiple Conditions. Some impressions are shown broken down into more codable components.

When the imaging clinician has interposed a recommendation amongst the impressions, it has been highlighted here {<u>underlined between braces</u>}.

As an exercise to explore the suitability of the specification, a sample encoding \[shown in square brackets\] is provided for some impressions. Also, the encodings do not always capture 100% of the intended semantics and nuances of the radiologist.

- Findings suggesting left peripheral lung base pulmonary infarct.

  - \[Condition.code = (64662007, SCT, "Pulmonary infarct"),
    .bodyStructure.includedStructure.structure = (10024003, SCT, "Structure of Lung Base"),
    .bodyStructure.includedStructure.laterality = right,
    .bodyStructure.includedStructure.qualifier *=* (14414005,SCT,“Peripheral)*,* .likelihood = may represent\]

- Impression Set (Abdomen US)

  - Fatty infiltration of the liver.

  - Small left pleural effusion.

  - Distended inferior vena cava and hepatic veins, findings consistent with congestive heart failure.

    - \[*code distended veins as observations, code CHF as Condition with the observations referenced from .evidence, and .likelihood is high\]*

- Impression Set (XR Foot, Ankle, Tibia/Fibula, Knee)

  - Acute nondisplaced fractures of the proximal tibia and fibula.

  - Acute fracture of the distal fibular diaphysis.

  - Intact intramedullary nail fixation hardware.

    - *\[TODO Create an <u>observation code of "intact"</u> for application to any given anatomy, device, (or intervention/modification?) Or should this be coded as a set of negations: no loosening, breakage, protrusion or other visible complication of the nail fixation hardware?\]*

- Impression Set (MRI Hip)

  - Moderate right hip osteoarthritis, with labral tearing and para labral cyst formation.

    - \[Condition.code= (396275006, SCT, "Osteoarthritis"),
      .bodyStructure.includedStructure.structure= (24136001, SCT, "Hip joint"),
      .bodyStructure.includedStructure.laterality=right,
      .severity=moderate\]

    - \[Condition.code=(202336002, SCT, "Acetabular labrum tear"),
      .bodyStructure.includedStructure.structure= (182439007, SCT, "Acetabular labrum"),
      .bodyStructure.includedStructure.laterality=right\]

    - \[*Need code for para labral cyst*,
      .bodyStructure.includedStructure.structure= (182439007, SCT, "Acetabular labrum"),
      .bodyStructure.includedStructure.laterality=right\]

  - Chronic partial-thickness tears of the gluteus minimus and medius with small overlying greater trochanteric bursal fluid.

- Impression Set (CT Neck, Chest, Abdomen/Pelvis)

  - No acute abnormality in the neck, chest, abdomen, or pelvis. No pathologically enlarged lymph nodes.

  - Multiple peribronchial bilateral pulmonary nodules, measuring up to 5 mm in the left lower lobe, likely infectious/inflammatory.

    - *\[… (786838002, SCT, "pulmonary nodule (disorder not finding) … how to code size generalization, likely etiology (infections/inflammatory) …\]*

  - No active GI bleed.

  - Mesenteric vessels are patent without evidence of end-organ ischemia.

- Impression Set (MRI Brain, MRI Cervical Spine)

  - No evidence of acute infarction, hemorrhage, or a mass lesion. Chronic changes as described above.

  - A 1.1 cm focus of enhancement within the left parietal bone that does not demonstrate any cortical destruction or any other destructive features. There is a lucency at this site on the previously performed head CT. It is favored to represent a **venous lake**.

  - Congenitally small central canal from C3/C4 down to C5/C6 level.

  - Moderate to severe degenerative changes of the cervical spine as described above and summarized below.

  - At C3/C4, moderate central canal stenosis with flattening of the ventral surface of the cord. Moderate left neural foraminal stenosis.

  - At C4/C5, moderate central canal stenosis with flattening of the ventral surface of the cord. Moderate to severe left neural foraminal stenosis.

  - At C5/C6, moderate bilateral neural foraminal stenosis.

    - See below

  - At C6/C7, moderate right neural foraminal stenosis.

    - \[Condition.code =(371000119109, SCT, "Stenosis of intervertebral foramina"),
      .bodyStructure.includedStructure.structure= (281875002, SCT, "C6/C7 intervertebral foramen"),
      .severity=Moderate,
      .bodyStructure.includedStructure.laterality=right\]

- Impression Set

  - Prominent bilobed paramedial extra-axial **mass** along the convexity centered at the level of the posterior frontal and anterior parietal lobes with prominent posterior dural tail and occlusion of the adjacent superior sagittal sinus. Prominent surrounding reactive edema, left greater than right. Mild lateral shift but no herniation. Smaller extra-axial mass overlying the right mid temporal lobe.

  - \[Prominent bilobed (SHAPE) paramedial extra-axial (LOC) **mass**

    - along the convexity (LOC)

    - centered at the level of the posterior frontal and anterior parietal lobes (LOC)

    - with prominent posterior dural tail (SHAPE)

    - and occlusion of the adjacent superior sagittal sinus (LOC?).

    - Prominent surrounding reactive edema (RELATED CONDITION & LOC), left greater than right (SEVERITY?).

    - Mild lateral shift but

    - no herniation.

    - Smaller extra-axial mass (RELATED CONDITION & SHAPE)

    - overlying the right mid temporal lobe (LOC).\]

  - Atypical meningioma including hemangiopericytoma or variant or malignant subsidence of meningioma. Other less likely considerations include extra-axial dural based metastasis, lymphoma and less likely solitary fibrous tumor.

- Impression Set

  - There is mild supraspinatus **tendinosis** with minimal articular sided **fraying** of the distal tendon and a 3 mm low grade **interstitial tear** at the distal attachment site.

  - There is marrow edema within the distal clavicle. There is a small AC joint effusion with mild pericapsular edema. This may represent mild stress related change of the AC joint versus a grade 1 sprain of the AC joint. There is no elevation or fracture of the distal clavicle.

  - There is no occult fracture or bone contusion. No malalignment of the osseous structures.

  - The age of injury is indeterminate.

- There is a metastasis located within the right temporal lobe surrounded by a moderate size area of vasogenic edema. {<u>Further evaluation with an enhanced MRI examination of the brain is recommended.</u>} There are large confluent right hilar/parahilar and mediastinal metastases located within the chest. There is a complete atelectasis/consolidation of the right upper lobe (drowned lung). There are numerous metastases located within the peripheral portions of both lungs. There are multiple hepatic metastases. Please see report.

- Impression Set

  - Complete full-thickness disruption of the anterior cruciate ligament.

  - Associated osseous contusion of the lateral condylar patellar sulcus: Pivot shift injury.

  - Grade 1 MCL complex injury.

  - No other associated injury identified *\
 TODO <How should we code negation when there is no concrete condition being negated?\>*

- Impression Set

  - Hydrocephalus without evidence of obstructing mass lesion. Acute hydrocephalus cannot be excluded since there are no prior studies available for comparison. Extensive chronic white matter changes may mask transependymal CSF edema. {<u>Correlate with short-term followup to exclude acute hydrocephalus. Correlate with clinical symptoms to exclude normal pressure hydrocephalus.</u>}

  - Chronic white matter changes.

  - Cerebral atherosclerosis.

- Impression Set

  - Markedly abnormal multifocal hypermetabolic predominantly osteosclerotic lesions scattered throughout the axial and proximal appendicular skeleton consistent with wide spread osseous metastases

  - Right lower breast mass that appears hypermetabolic. {<u>Please correlate with mammography and consider biopsy if indicated.</u>} Recurrent disease is a consideration.

  - Indeterminate bilateral pleural effusions and ascites with low-level metabolism. Consider thoracentesis and evaluation of fluid for malignancy if clinically indicated.

  - Diffuse thoracic esophageal uptake. This pattern can be seen in patients with esophagitis. Please correlate clinically.

- Spiculated mass within the posterior segment of the right upper lobe has increased minimally in size from September 2012, now with maximal dimension of 2cm versus 1.6cm previously. Radiographic staging of this presumed malignancy is T1a N0. No new pulmonary nodules and no findings of metastatic disease.

- Impression Set (CTA Chest)

  - Moderate pericardial effusion with apparent mass effect on the right ventricle, leftward bowing of the intraventricular septum, a contrast level within the IVC, and severe reflux of contrast into the hepatic veins and right lobe parenchyma are highly suggestive of tamponade physiology. Pericardial enhancement suggests pericarditis as etiology.

  - No aortic dissection or intramural hematoma.

- Impression Set (Lung Cancer screening Chest CT)

  - Lung-RADS CATEGORY: 2/S. Multiple pulmonary nodules. The dominant solid nodule is located in the right middle lobe and has a mean size of 5 mm (series 3, image 285). The category-determining solid nodule has a very low likelihood of becoming a clinically active cancer, due to size and/or lack of growth.

  - There are potentially significant incidental finding(s): thyroid lesion, incompletely characterized by CT

    - *\[how to code "incompletely characterized by CT"? Or is that narrative limitations of study and coding is less important?\]*

  - {<u>RECOMMENDATIONS: Continue annual Lung Cancer Screening Chest CT examination if patient meets eligibility criteria.</u>}

  - {<u>RECOMMENDATION FOR POTENTIALLY SIGNIFICANT INCIDENTAL FINDING: Thyroid ultrasound, unless recently obtained</u>}

  - Explanation of the Lung-RADS CATEGORIES CAN BE FOUND AT: <http://healthcare.partners.org/lung/rads.pdf>

  - A clinically significant result was communicated on 2/--/202x 10:08 PM, Message ID ------.

- Unremarkable CT evaluation of the paranasal sinuses. No obstructive pathology is seen.

- (Chest X-ray) No acute cardiopulmonary process.

- (MRI Brain) No acute or subacute infarct, mass effect, or acute intracranial hemorrhage.

- Impression Set (CT Head)

  - No acute intracranial findings.

  - Mild left parietal scalp swelling and contusion. No acute calvarial fracture.

- Impression Set (Screening Mammogram)

  - No mammographic evidence of malignancy in either breast.

  - {<u>Annual screening mammography is recommended.</u>}

  - BI-RADS 1 NEGATIVE \[(397140005, SCT, "Mammography assessment (Category 1) – Negative")\]

    - *\[This is an example of the rare case where .conclusionCode fits well. Should we also allow .conclusionCode and make consumers look in more places all the time? Or model it as an Observation?\]*

  - The patient will be notified of the results and recommendations.

    - *\[Look into coding intended, not attempted/completed, communications\]*

- Impression Set (OB US)

  - 24 y.o. G3P2 at 21 weeks by 18 week ultrasound with reassuring fetal anatomic survey. Ms. X has a significant psychiatric history and is maintained on Lithium with good effect; she reports her mood is stable and she is in close contact with her psychiatrist. We reviewed the plan for a fetal echocardiogram and a referral was placed.

    - *\[much of the above likely should be in other sections\]*

  - Worksheet finished by ---- -----, sonographer on 1/--/202- 1:2-:5- PM.

    - *\[Such workflow/provenance probably belongs in Procedure?\]*

- No evidence of acetabular labral tear or detachment. There is no high-grade chondral loss or delamination.

- Very dense breasts without comparison studies limiting sensitivity. Comparison to previous mammograms would be helpful to assure stability of dense parenchymal pattern.

- No active disease in the chest.

### B.1.7 Example Recommendation Semantics

The following bullets provide a sample of content typical to recommendations in an imaging report.

- Referral to the DAP service is recommended. The lesion is amenable to CT guided biopsy.

- Further evaluation with an enhanced MRI examination of the brain is recommended.

- Recommend further evaluation with dedicated breast imaging at XXX Breast Imaging Center by calling xxx-xxx-xxxx to schedule an appointment.

- Please correlate with mammography and consider biopsy if indicated.

- Annual screening mammography is recommended.

- Correlate with short-term followup to exclude acute hydrocephalus. Correlate with clinical symptoms to exclude normal pressure hydrocephalus.

- Continue annual Lung Cancer Screening Chest CT examination if patient meets eligibility criteria

- Recommendation for potentially significant incidental finding: Thyroid ultrasound, unless recently obtained

- Recommend discussion of X with the patient.

### B.1.8 Example Communication Content

The following bullets provide a sample of content typical to descriptions of communications in an imaging report.

- Findings discussed with Dr. REFERRING at 1630 hrs

- Telephone message was left at Dr. DAVID LIVESEY office at the time of dictation.

- A clinically significant result was communicated on 2/19/2024 10:08 PM

## B.2 Example Usage

### B.2.1 Presenting Comparison Studies

A report viewer might offer to display studies used as comparisons in the report.

- GET [baseURL]/DiagnosticReport/X?$elements=comparison
- (Parse returned ImagingStudy references; Select; Invoke display)

### B.2.2 Ordering Recommended Followup

A clinical workstation might help the referring physican to place an order for the followup PET scan recommended in the report by the radiologist.

- GET [baseURL]/DiagnosticReport/X?$elements=recommendation
- (Receive ServiceRequest references; invoke ordering tool to finalize and place)
- Help the referring physician select one or more of the recommended ServiceRequests and complete additional details

### B.2.3 Applying Relevant Clinical Guidelines

A clinical workstation might help the referring physician to identify current clinical guidelines applicable to the conclusions identified in the report.

- GET [baseURL]/DiagnosticReport/X?$elements=conclusionCode
- (Receive Condition & Observation references)

## B.3 Example Finding Encoding Patterns

The following table provides example observation encodings of various types of findings. It is intended to span a range of modalities, specialties, pathologies, anatomies, characteristics, and styles of expression and specificity.

The values shown in cells represent the semantics; it is left to the reader to map those to corresponding codes. Recommended strategies include reviewing CID Tables in DICOM PS3.16, which include many codes from SNOMED for body parts and some codes from LOINC for measured properties or assessed characteristics. The SNOMED code browser is accessible at <https://browser.ihtsdotools.org/> and LOINC at <https://search.loinc.org/>.  See also RAD TF-1:56.4.1.3.

The table only addresses a specific subset of interest of  observation elements. Full guidance on Observation Resource metadata elements is provided in RAD TF-3:6.7.3.6.

Table B.3-1 reflects the pattern defined in TOlink 6.7.3.6 of post-coordinating measured properties and assessed characteristics with the anatomic, pathologic, or physical entity observed. This is intended to allow implementations to flexibly handle new observations by logical extension without having to obtain new pre-coordinated codes. This also allows consumers of the data (for queries, or trigger logic) to handle similar observations using elemental or Boolean expressions instead of maintaining very long lists of related pre-coordinated codes and periodically being presented with new pre-coordinated codes they do not understand and thus cannot handle.

Observations that are simple statements of a single property or characteristic can be readily represented in a single Observation resource. Others that are more complex, requiring multiple Observation resources related using one of the patterns described in IHE RAD TF-3:6.7.3.6.3. Several rows of the table (e.g. the description of a splenic hypodensity) demonstrate suggested patterns for organizing observation text statements (e.g. as might be dictated by a radiologist) that include multiple properties or characteristics into a collection of related Observation resources.  

<h3 id="table-b.3-1-example-observation-encoding-patterns">Table B.3-1 Example Observation Encoding Patterns</h3>
<table border="1">
<colgroup>
<col style="width: 21%" />
<col style="width: 16%" />
<col style="width: 10%" />
<col style="width: 17%" />
<col style="width: 19%" />
<col style="width: 14%" />
</colgroup>
<thead>
<tr>
<th rowspan="2"><strong>Observation.text (often as dictated)</strong></th>
<th colspan="3" style="text-align: center;"><strong>Observation.bodyStructure.includedStructure</strong></th>
<th rowspan="2"><strong>Observation<br />
.code</strong></th>
<th rowspan="2"><strong>Observation<br />
.value</strong></th>
</tr>
<tr>
<th><strong>.structure</strong></th>
<th><strong>.laterality</strong></th>
<th><strong>.morphology</strong></th>
</tr>
</thead>
<tbody>
<tr>
<th>Pancreatic duct diameter is 2mm</th>
<td>Pancreatic Duct</td>
<td></td>
<td></td>
<td>Diameter</td>
<td>2 mm</td>
</tr>
<tr>
<th>Left cerebral ventricle frontal horn width is 30 mm</th>
<td>Cerebral ventricle frontal horn</td>
<td>Left</td>
<td></td>
<td>Width</td>
<td>30 mm</td>
</tr>
<tr>
<th rowspan="2">Bladder wall thickness is 3 mm when distended (normal)</th>
<td>Bladder wall</td>
<td></td>
<td></td>
<td>Thickness</td>
<td>3 mm</td>
</tr>
<tr>
<td colspan="5">Observation.context=Distended</td>
</tr>
<tr>
<th>Homogenous liver attenuation</th>
<td>Liver</td>
<td></td>
<td></td>
<td>Attenuation</td>
<td>Homogenous</td>
</tr>
<tr>
<th>Liver contour is smooth</th>
<td>Liver</td>
<td></td>
<td></td>
<td>Contour</td>
<td>Smooth</td>
</tr>
<tr>
<th>Pulmonary arterial trunk is normal in caliber</th>
<td>Pulmonary arterial trunk</td>
<td></td>
<td></td>
<td>Diameter</td>
<td>Normal</td>
</tr>
<tr>
<th>Aorta is tortuous</th>
<td>Aorta</td>
<td></td>
<td></td>
<td>Shape</td>
<td>Tortuous</td>
</tr>
<tr>
<th>Echotexture of the spleen is normal.</th>
<td>Spleen</td>
<td></td>
<td></td>
<td>Echotexture</td>
<td>Normal</td>
</tr>
<tr>
<th rowspan="2">Uterus is anteverted and homogeneous</th>
<td>Uterus</td>
<td></td>
<td></td>
<td>Orientation</td>
<td>Anteverted</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Texture</td>
<td>Homogenous</td>
</tr>
<tr>
<th rowspan="2">Spiculated lesion in the lower lobe of the left lung</th>
<td>Lung lower lobe</td>
<td>Left</td>
<td>Lesion</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Shape</td>
<td>Spiculated</td>
</tr>
<tr>
<th rowspan="2">200 mm3 lesion in the Liver</th>
<td>Liver</td>
<td></td>
<td>Lesion</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Volume</td>
<td>200 mm3</td>
</tr>
<tr>
<th rowspan="2">Distal radius fracture displaced 4 mm dorsally</th>
<td>Distal radius</td>
<td></td>
<td>Fracture</td>
<td>Displacement distance</td>
<td>4 mm</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Displacement direction</td>
<td>Dorsally</td>
</tr>
<tr>
<th>Mild coronary calcifications</th>
<td>Coronary arteries</td>
<td></td>
<td>Calcification</td>
<td>Severity</td>
<td>Mild</td>
</tr>
<tr>
<th>Gallbladder wall is not thickened</th>
<td>Gallbladder wall</td>
<td></td>
<td>Thickening</td>
<td>Presence</td>
<td>Not Detected</td>
</tr>
<tr>
<th>Kidneys enhance symmetrically</th>
<td>Kidney</td>
<td>Bilateral</td>
<td></td>
<td>Enhancement</td>
<td>Symmetric</td>
</tr>
<tr>
<th rowspan="2">Adrenal glands are normal in morphology</th>
<td>Adrenal gland</td>
<td>Bilateral</td>
<td></td>
<td>Size</td>
<td>Normal</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Shape</td>
<td>Normal</td>
</tr>
<tr>
<th>Free gas cannot be ruled out</th>
<td>Abdomen</td>
<td></td>
<td>Free gas</td>
<td>Presence</td>
<td>Indeterminate</td>
</tr>
<tr>
<th rowspan="2">No evidence of TMJ dislocation (Exam is insensitive)</th>
<td>Temporo-mandibular Joint</td>
<td></td>
<td>Dislocation</td>
<td>Presence</td>
<td>No evidence</td>
</tr>
<tr>
<td colspan="5">Observation.note=Radiographs have limited sensitivity for TMJ dislocation</td>
</tr>
<tr>
<th rowspan="2">Mild cardiomegaly</th>
<td>Heart</td>
<td></td>
<td>Cardiomegaly</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Severity</td>
<td>Mild</td>
</tr>
<tr>
<th rowspan="2">Left ventricle internal diameter at diastole is 4.2cm</th>
<td>Left ventricle (See Note 1)</td>
<td></td>
<td></td>
<td>Diameter</td>
<td>4.2cm</td>
</tr>
<tr>
<td colspan="5">Observation.context=Diastole</td>
</tr>
<tr>
<th rowspan="2">Worsening Left pleural effusion</th>
<td>Lung</td>
<td>Left</td>
<td>Pleural Effusion</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Severity Change</td>
<td>Worsening</td>
</tr>
<tr>
<th>Lungs are clear</th>
<td>Lung</td>
<td>Bilateral</td>
<td>Abnormal Opacity</td>
<td>Presence</td>
<td>Not detected</td>
</tr>
<tr>
<th>Consolidation in the right lower lobe</th>
<td>Lung lower lobe</td>
<td>Right</td>
<td>Consolidation</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<th>Gallbladder is surgically absent</th>
<td>Gallbladder</td>
<td></td>
<td></td>
<td>Normality</td>
<td>Surgically acquired absence</td>
</tr>
<tr>
<th rowspan="5">0.9 x 0.9cm splenic hypodensity, not well characterized without iv contrast</th>
<td>Spleen</td>
<td></td>
<td>Hypodensity</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Major Axis Length</td>
<td>0.9 cm</td>
</tr>
<tr>
<td colspan="5">Observation.note=Splenic hypodensity not well characterized without IV contrast</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Minor Axis Length</td>
<td>0.9 cm</td>
</tr>
<tr>
<td colspan="5">.note=Splenic hypodensity not well characterized without IV contrast</td>
</tr>
<tr>
<th>Atheromatous plaque noted in the aorta</th>
<td>Aorta</td>
<td></td>
<td>Atheromatous plaque</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<th rowspan="2">Head circumference of Fetus 1 is 2.8cm</th>
<td>Head</td>
<td></td>
<td></td>
<td>Circumference</td>
<td>27.5 cm</td>
</tr>
<tr>
<td colspan="5">Observation.focus=fetus1; since .focus is present, BodyStructure is that of the .focus, not that of .subject</td>
</tr>
<tr>
<th rowspan="2">Mitral valve annulus e' is 8 cm/s</th>
<td>Mitral valve annulus</td>
<td></td>
<td></td>
<td>Velocity</td>
<td>8 cm/s</td>
</tr>
<tr>
<td colspan="5">Observation.context = early diastole; doppler mode; apical 4-chamber view</td>
</tr>
<tr>
<th rowspan="2">Mitral E-wave is 72 cm/s</th>
<td>Mitral valve</td>
<td></td>
<td>Blood</td>
<td>Velocity</td>
<td>72 cm/s</td>
</tr>
<tr>
<td colspan="5">Observation.context = early diastole; doppler mode; apical 4-chamber view</td>
</tr>
<tr>
<th></th>
<td></td>
<td></td>
<td></td>
<td></td>
<td></td>
</tr>
<tr>
<th>Right nephrostomy tube is in appropriate position</th>
<td>Renal pelvis</td>
<td>Right</td>
<td>Nephrostomy tube</td>
<td>Position</td>
<td>Normal</td>
</tr>
<tr>
<th>No lesions observed (in the chest)</th>
<td>Chest</td>
<td></td>
<td>Lesion</td>
<td>Presence</td>
<td>Not detected</td>
</tr>
<tr>
<th rowspan="12">[CDE Set: Pulmonary Nodule] .hasMember …</th>
<td>Upper lobe of lung</td>
<td>Left</td>
<td>Nodule</td>
<td>RDES195 - Pulmonary Nodule</td>
<td></td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Presence</td>
<td>Detected</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Composition</td>
<td>Solid</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Size</td>
<td>35.0 mm</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Morphology</td>
<td>Smooth</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Plurality</td>
<td>Single</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Microcystic Component</td>
<td>Absent</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Volume</td>
<td>18662 mm3</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Change from priors</td>
<td>Larger than prior</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Suspicious</td>
<td>Yes</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Min density</td>
<td>45 HU</td>
</tr>
<tr>
<td colspan="3" style="text-align: center;">“</td>
<td>Max density</td>
<td>62 HU</td>
</tr>
</tbody>
</table>


> Note 1. Most cardiac features are not paired structures as they are not bilaterally symmetric. See DICOM PS3.16 Table L-5 <https://dicom.nema.org/medical/dicom/current/output/chtml/part16/chapter_L.html#table_L-5>

# Annex C – Guidance on Related Specifications

Several other specifications that relate to imaging reports have been published. This section provides some comparisons and transcoding guidance from the perspective of the IDR Profile.

## C.1 HL7 ORU Messages

HL7 ORU messages are widely used to convey order results, such as diagnostic reports, within a hospital. The report content can be included in an OBX segment in the ORU message as a block of ASCII text, as XML, or even as a PDF. See RAD-128 for further details.

When communicating reports to such legacy HL7 ORU systems, the content of a DiagnosticReport resource could be rendered into such OBX segments, perhaps based on the content of DiagnosticReport.text, or DiagnosticReport.presentedForm. A Report Creator might even prepare a rendering specifically intended for ORU encapsulation as one of the entries in DiagnosticReport.presentedForm. This is not required or further specified by the IDR Profile.

## C.2 US Core Diagnostic Report Note IG (2017-25)

<https://build.fhir.org/ig/HL7/US-Core/branches/master/StructureDefinition-us-core-diagnosticreport-note.html>

This IG (now in version 9) profiles the use of a DiagnosticReport Resource for various diagnostic reports and notes including labs, ECGs, pathology, and radiology. Based on the radiology example in the IG:

- DiagnosticReport.text contains a (generated) rendering of the full report in XHTML.
- DiagnosticReport.result contains an Observation with a .code value for Finding and a .value string containing the full findings narrative text, and a second Observation with a .code value for Impression and a .value string containing the full impression narrative.
  - Inclusion of discrete data Observations is demonstrated in a DEXA example.
- DiagnosticReport.category distinguishes radiology, cardiology, and pathology reports.
- DiagnosticReport.code identifies the specific type of report.
- DiagnosticReport.presentedForm contains an alternate XHTML rendering, or a PDF.
- DiagnosticReport.media references a jpeg image.

The goal of the IG appears to be to facilitate wrapping the content of reports in HL7 ORU messages into FHIR Resources for storage in a FHIR Server.

In principle, it should be possible to downgrade reports that are conformant with the IHE Imaging Diagnostic Report Profile to fit into a US Core Diagnostic Report Note.

Some points of caution to consider include:

- IDR uses .basedOn to reference ServiceRequest and/or Accession Number, linking the report to the order. IDR uses .encounter to reference the imaging encounter. US Core is somewhat ambiguous on the use of .encounter.
- IDR uses .media strictly for graphical media included in the report, such as diagrams. IDR uses .study to reference ImagingStudy for access to the managed diagnostic images via mechanisms such as DICOMweb. US Core promotes converting the diagnostic images into JPEG files, discarding the diagnostic metadata and PACS management, and accessing the JPEGs via .media references. US Core does permit the use of .study.

## C.3 Japan - JP Core DiagnosticReport Radiology Profile (2022-2025)

<https://jpfhir.jp/fhir/core/1.2.0/StructureDefinition-jp-diagnosticreport-radiology.html>

This IG (now in version 1.2.0) profiles the use of a DiagnosticReport resource in a FHIR R4 environment. It takes a similar approach to the US Core by primarily wrapping narrative text in a FHIR resource.

## C.4 IHE Imaging Diagnostic Report – Phase I Public Comment (2024)

The IDR Phase I IG profiled the use of a DiagnosticReport Resource for various diagnostic reports in radiology. It was based on FHIR R5 and focused on the content most relevant to a referring physician. This current IDR document is based on the IDR Phase I IG but makes numerous revisions and supersedes it.

## C.5 DICOM SR to FHIR Resource Mapping IG (2024-2025)

<https://build.fhir.org/ig/HL7/dicom-sr/en/>

// FUTURE Update and Summarize content
This IG (now in version 9) profiles the use of a DiagnosticReport Resource for various reports including imaging/radiology.

- Avoid being too conflicting. (Simplification and subsetting is OK)
- Note that SR is about captured data/information NOT about DiagnosticReport encoding
- SR data is inherently more “verbose” which can be a concern if “imported” into the Report.
- Need to be able to refer to the “source” SR that provided an Observation in DR.

## C.6 HL7 Europe Imaging Report IG (2025-2026)

<https://build.fhir.org/ig/hl7-eu/imaging-r5/en/index.html>

This IG (now in version 9) profiles the use of a DiagnosticReport Resource for various reports including imaging/radiology. Based on the radiology example in the IG:

TODO LATER if time permits, Summarize content
