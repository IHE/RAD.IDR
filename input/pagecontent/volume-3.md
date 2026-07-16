#### 4.3.2.Z Codes for the IDR Profile

The following codes have been defined for the IDR Profile and extensions. They are shown here as part of the IHE coding system and should be used for Trial Implementation. IHE Radiology intends to migrate these codes, and the templates they are used in, to the DICOM Standard prior to advancing the IDR Profile to Final Text.

**Table 4.3.2.Z-1: IDR Codes**

<table>
<colgroup>
<col style="width: 15%" />
<col style="width: 15%" />
<col style="width: 20%" />
<col style="width: 35%" />
<col style="width: 15%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><blockquote>
<p><strong>Code</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>codeScheme</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Code Meaning</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Definition</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Reference</strong></p>
</blockquote></th></tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;">IDR01</td>
<td style="text-align: center;">99IHE</td>
<td>Unstructured Observation</td>
<td>RAD TF-3: 6.7.3.6.2.8</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">IDR02</td>
<td style="text-align: center;">99IHE</td>
<td>Unstructured Feature</td>
<td>RAD TF-3: 6.7.3.6.2.8</td>
<td></td>
</tr><tr>
<td style="text-align: center;">IDR03</td>
<td style="text-align: center;">99IHE</td>
<td>Procedure Radiation Dose Summary Text</td>
<td>RAD TF-3: 6.7.3.4</td>
<td></td>
</tr>
</tbody>
</table>

## 6.7 Imaging Diagnostic Report Content

### 6.7.1 Scope

This IHE Radiology Content Specification defines standard encodings for diagnostic reports on imaging procedures. It is specifically intended to cover the output of reporting systems following the interpretation performed by an imaging clinician such as a radiologist.

Refer to [IHE RAD TF-1:56.4.1.2](volume-1.html#56412-purpose-and-structure) for real world expectations in the various report sections.

Pathology and Interventional procedures are not specifically addressed.

### 6.7.2 Referenced Standards

- DICOM: Digital Imaging and Communications in Medicine. <https://dicomstandard.org/>
- FHIR-R4: [HL7 FHIR Release 4.0](https://www.hl7.org/FHIR/R4)
- FHIR-R5: [HL7 FHIR Release 5.0](https://www.hl7.org/FHIR/R5)
- FHIR R6: [HL7 FHIR R6ballot4 (current build)](https://build.fhir.org/)
- LOINC: Logical Observation Identifiers Names and Codes. <https://loinc.org/>
- RadLex: A Lexicon for Uniform Indexing and Retrieval of Radiology Information Resources. <https://www.radlex.org/>
- SCT: SNOMED CT (Systematized Nomenclature of Medicine—Clinical Terms). <https://www.snomed.org/>

#### 6.7.2.1 FHIR Versions and Extensions

This Profile/IG is written in terms of FHIR R6 resources.

> Note 1. FHIR R6 (and R5) introduced specific elements to address key details of coded imaging diagnostic reports.
> Note 2. This work expects that HL7 FHIR R6 will be published as normative in 2027. Some prerequisites for this profile/IG to become Final Text include: HL7 FHIR R6 being published as normative, and the IHE Radiology Technical Committee reviewing any relevant changes to FHIR R6 during the HL7 ballot resolution process.

Implementations are permitted to be based directly on FHIR R6, or to be based on FHIR R4 and/or FHIR R5 resources with the incorporation of HL7 FHIR cross-version packages (See <https://build.fhir.org/versions.html#extensions>) as needed to provide the elements and behaviors specified in this Profile/IG.

### 6.7.3 Imaging Diagnostic Report Encodings

This content definition makes normative profiling changes to the following FHIR Resources:

- [DiagnosticReport](StructureDefinition-imaging-diagnosticreport.html)

- [ServiceRequest](StructureDefinition-idr-imaging-service-request.html) (Order)
- [ServiceRequest](StructureDefinition-idr-recommendation-service-request.html) (Recommendation)

- [Procedure](StructureDefinition-idr-imaging-procedure.html) (Imaging Procedure)
  
- [ImagingStudy](StructureDefinition-idr-imaging-study.html) (Reported or Comparison Study) - DICOM Study UID & text

- [Observation](StructureDefinition-idr-observation.html) (Findings) (Impression)
- [Observation](StructureDefinition-idr-patient-history-observation.html) (History)

- [Condition](StructureDefinition-idr-patient-history-condition.html) (History)
- [Condition](StructureDefinition-idr-impression-condition.html) (Impression)

- [Communication](StructureDefinition-idr-communication.html)
  
This content definition makes only usage clarifications to the following FHIR Resources: TODO

This content definition uses without change the following FHIR Resources:

- [Patient](StructureDefinition-idr-patient.html) (Subject) except guidance on Patient.text?
- [FamilyMemberHistory](StructureDefinition-idr-patient-history-family-member-history.html) except .text
- [Procedure](StructureDefinition-idr-patient-history-procedure.html) (History) except .text
- [Encounter](https://www.hl7.org/fhir/R5/encounter.html) (Imaging Encounter)

- Provenance TODO

- [Practitioner](https://www.hl7.org/fhir/R5/practitioner.html)

The Report Creator is expected to populate much of the contextual metadata (e.g., patient demographics, patient identifiers and issuers, study accession number, etc.) in the imaging diagnostic report resources based on values in the medical imaging data being processed, and/or the reporting worklist entry.

This content definition does not presume that all semantics in the report that are potentially codeable are actually coded in this resource. Profiles will likely identify some specific details which are required to be coded to conform to that profile; however, systems processing diagnostic reports should generally assume that there may be details in the narrative which are not also encoded. See also TOLINK RAD TF-1: 56.4.1.6 Narrative vs Encoded Content and Structure.

> Note: This profile changes the cardinality from 0.. to 1.. for some FHIR resource attributes. This is done when absence of the attribute would break interoperability. It is not done to enforce the presence of information that is simply desirable or convenient.

A Creator shall be capable of encoding imaging diagnostic reports as described in this section. 

This section describes how the necessary structure and content of
an imaging diagnostic report, as described in IHE RAD TF-1:56.4.1.2,
is encoded in FHIR.

> Note 1. The IG form of this specification may create a profile for each constrained resource and provide a value which the Creator MAY use to set the meta.profile element for the resource. This facilitates validation of received resources.
> Note 2. A Creator MAY choose not to set meta.profile to a specific profile, or MAY set it to multiple profiles.

#### 6.7.3.0 Diagnostic Report

DiagnosticReport.text contains the fully rendered human-readable form of the diagnostic report as described in 6.7.3.11. TOLINK  TODO did the missing sentence here already go into fsh? (And don't use Component) ("It is often a compilation of the .text elements of resources that are components of the report as described in their component sections and in 6.7.3.11.2 Resources.text.")

PTODO DECIDE if we have a top level DR requirement and all the element requirements are bullets, or drop the bullets and all requirements are simple paragraphs. And how much of this just goes into the resource .fsh files.

- DiagnosticReport.code: The code SHOULD communicate the type of imaging report, typically addressing the modality used, the body part scanned, and perhaps some details about the procedure, e.g. (24866-6, LN, “CT Pelvis W contrast IV”). It is not uncommon for this to correspond closely to the description of the imaging procedure reported. As such, the RadLex Playbook codes available in LOINC are a suggested example code set.
- DiagnosticReport.category SHOULD contain a general code like (<http://terminology.hl7.org/CodeSystem/v2-0074>, RAD, “Radiology) or (<http://terminology.hl7.org/CodeSystem/v2-0074>, IMG, “Diagnostic Imaging). This distinguishes imaging reports from lab, pathology, or other diagnostic reports.
  - Additional codes can be included to support site needs. It is recommended to include an additional code to indicate the service/department that performed the imaging. The value may be copied from ServiceRequest.category of the order referenced in .basedOn. This is expected to correspond to the Organization referenced in .performer, if any.
  - Potential codes may be drawn from DICOM [PS3.16 CID 7030](https://dicom.nema.org/medical/dicom/current/output/chtml/part16/sect_CID_7030.html) \"Institutional Department/Unit/Service\" and the HL7 terminology code set referenced in FHIR.

TODO LOTSA Edits here to resolve.

**Language and Translation**

All FHIR resources have an optional .language element to communicate the language used for the text content of the resource.

The display text for codes, such as (80891009, SCT, “Heart”) often reflects the local language where the data was encoded. Since the semantics are captured by the code value and the coding system, it is permitted to translate the display text into the equivalent text in the local language when presenting, localizing, or transcoding the information.

FHIR provides several mechanisms to consider when text content is translated, for example to satisfy a clinical need or a legal requirement. See <https://build.fhir.org/languages.html>

Creating Provenance resources may be useful when systems creating persistent documents that are translations of other documents, and/or humans attest to the quality or accuracy of the translation.

##### 6.7.3.0.1 Query Pattern[KO17.1]s for DiagnosticReport

The following are example query tasks that might be performed to obtain diagnostic reports.

The most common is expected to be a patient-level query, such as:

- GET \[base\]/DiagnosticReport?patient=Patient/{patient-id}&category=radiology

Often such a search will be constrained by date, such as:

- …&date=ge2025-01-29 (for reports since Jan 29, 2025)

Such searches will return a set of responses for presentation to a human user. A key element to display in such a list will be the DiagnosticReport.code which pre-coordinates a variety of details such as one or more body parts, one or more modalities, and other procedure details. E.g. TODO

It should be noted that details like modality or body part, are attributes of the ImagingStudy (and the Procedure) rather than the DiagnosticReport itself. As such a chained query like the following would be used to specifically query for those:

- GET \[base\]/DiagnosticReport?patient=Patient/{patient-id} TODO Check this formats OK
  &study:ImagingStudy.modality={modality code}
  &study:ImagingStudy.body-structure={anatomy code}

Similarly, a search for reports containing particular types of Observations would start by querying directly for Observations of interest (See RAD TF-3:6.7.3.6.y) and then getting the report(s) containing a specific Observation:

- GET \[base\]/DiagnosticReport?result=Observation/{observation-id}

To search for a report corresponding to an order (ServiceRequest or Accession #), either match for .basedOn reference to ServiceRequest, or match for .identifier of Accession #. If a Report has multiple accession numbers and/or ServiceRequests, it will be matched if it includes the one being searched for.

#### 6.7.3.1 Patient

Narrative text in the patient section of the diagnostic report is a good
candidate for auto-generation based on a subset of the coded content in
the Patient resource, such as the sex and age of the patient. The name
and medical record number are typically rendered into the top of the
report as well.

- The Patient resource has a Patient.text attribute which can contain a
  one-line description of the Patient, although since the Patient
  resource is widely shared, the summary text may or may not match the
  needs of the imaging diagnostic report, so the Human-Readable Form in
  DiagnosticReport.text may be freshly generated.

#### 6.7.3.2 Order

Narrative text in the order section of the diagnostic report is a good
candidate for auto-generation based on a subset of the coded content in
the ServiceRequest resource. The ordered exam in ServiceRequest.code is
usually rendered as a single line, perhaps based on the display value of
the CodeableConcept. The Accession \# and the ordering physician may
also be rendered into the top of the report.

- Each referenced ServiceRequest resource has a ServiceRequest.text
  attribute which can contain a one-line description of the order.

TODO See if this spaced note pair formats better than those above
> Note 1. The Indications and Clinical Questions, while captured at the time of the order and conveyed to the Report Creator in the referenced ServiceRequest, are typically rendered into the narrative in the History section of the report.
>
> Note 2. The details in the Procedure section are pulled from the imaging Procedure Resource (which is what was performed based on patient needs) rather than the imaging ServiceRequest (which is what was ordered and sometimes driven by billing requirements) since the two do not always exactly match. Sometimes there is an effort to update the order to match the actual procedure; ideally if that does happen, it is best to do it before image interpretation to avoid the possibility that the ServiceRequest resource bundled with the DiagnosticReport is out of date with respect to the master copy of the reference. Sometimes the original order is cancelled and replaced by a new one in which case the Order reference/link is broken (but it is clear that something has changed). Resolving such issues is a workflow topic that is out of scope for this profile.

#### 6.7.3.3 History

Patient **History** shall be encoded as references to resource items in the
<u>DiagnosticReport.supportingInfo</u> attribute.

> Note 1. While the specification requires the ability to include coded history information, it does not specify how much history information is in coded form. The Patient History may be entirely text (See 6.7.3.6.2.8 Unstructured Observation).
> Note 2. Reports do not include the entire medical history available but rather include history details determined to be relevant to the study, usually by the imaging clinician. This might include medical, surgical, social, and family history, as well as risk factors and allergies. Also, the details are as known to the imaging clinician at the time of interpretation; different information may be available when any given reader reads the report, but the report will reflect what was known at interpretation.
> Note 3. Often this history will include details that also serve as indication(s) for the imaging study. The information coded in the ServiceRequest.reason (See 6.7.3.2 Order) is the explicit record of the indications, even if they are also duplicated here.

TODO Check the bullet formatting with and without blank lines

- DiagnosticReport.supportingInfo.type shall use the code for PHX to indicate Patient History.
- <u>Condition</u> resources shall be used when conditions being tracked (and possibly treated) are encoded.
  - Condition.clinicalStatus indicates whether the condition is currently active or inactive.
- <u>Observation</u> resources shall be used when relevant observations are encoded. E.g., those from the referring physician, nursing notes, past care, and past diagnostics such as anatomic histopathology or clinical laboratory result values.
  - This may include recorded observations of the presence or absence of a condition at a particular point in time.
  - An unstructured observation (see 6.7.3.6.2.8) can be a pragmatic way to include a block of narrative patient history if the implementation is unable to create corresponding coded entries.
- AllergyIntolerance shall be used when patient allergies or intolerances are encoded.

- <u>Procedure</u> shall be used when past procedures performed on the patient are encoded. E.g., knee surgery, an appendectomy, or spinal fusion.

- <u>FamilyMemberHistory</u> shall be used when history from a relative of the patient is encoded. E.g., demographics, known conditions or procedures.

Narrative text in the history section of the diagnostic report is a good
candidate for auto-generation based on a subset of the coded content in the
referenced resources, however the process of selecting the relevant
subset will likely require input from the imaging clinician or a
sophisticated algorithm.

- This narrative can include indications for the exam (if provided) and clinical questions from the referring physician. That text will be composed based on the imaging ServiceRequest referenced in the .basedOn attribute rather than resources referenced in the .supportingInfo attribute.

- Each referenced Condition, Observation, Procedure, and
  FamilyMemberHistory has a .text attribute which can contain a brief
  description which may be assembled into the narrative text for the
  History section.
- The order of references in .supportingInfo represents the default order of presentation as selected by the Report Creator. Systems rendering this clinical content may choose a different order that is driven by their presentation needs.
- The order of references in .supportingInfo (and permission to choose a different order driven by presentation needs) may also apply if .text is re-rendered by Report Creators to reflect updates to the resource content.

- See also the discussion of .text usage in Section 6.7.3.11.1 Resources.text.

#### 6.7.3.4 Procedure

**Procedure** and Materials information shall be encoded in Procedure
resource(s) referenced in <u>DiagnosticReport.procedure</u> and an ImagingStudy resource.

Notes: The DiagnosticReport.procedure attribute mirrors the
.specimen attribute to describe how the data being reported was obtained
and prepared.

- Only .status and .subject are required elements in the Procedure resource.
- Procedure.status will typically be “completed” when the report is being created.
- Procedure.subject is expected to be the same as DiagnosticReport.subject.

The study being interpreted shall be referenced in DiagnosticReport.study. This may be in the form of a reference to an ImagingStudy resource or, in the event that such a resource does not yet exist, by populating DiagnosticReport.study.identifier with the StudyUID (from the reviewed images).

- ImagingStudy.note may be updated during reporting to contain an Annotation describing any limitations of the imaging data which might impact reporting, such as image artifacts, incomplete scan range, or inadequate contrast.
  - Annotation.author is expected to be the reading radiologist, either as a PractitionerRole or Practitioner reference.
  - In extreme cases, the radiologist might determine that the study quality is non-diagnostic, perhaps due to motion blur, resulting in a report with no findings and the statement in both the Procedure and Conclusion sections that the study quality was non-diagnostic.
  - Observation-specific limitations might also be recorded in the corresponding Observation resource.

Procedure resources describe a procedure that was performed. They
provide details about technique and execution using clinical imaging
language and codes and are created using information from the modality.
In contrast, the ServiceRequest resource describes the order using
orderable language and codes, which are typically more general and
billing-oriented, and is created using information from the order
placer. The ImagingStudy resource describes and provides links
for the actual **Study** data produced during or after the procedure(s).

In the large majority of cases, one report will correspond to one study
comprised of one procedure. Some studies do involve multiple procedures,
e.g. a cardiac stress-rest workup, so systems shall be prepared to
handle multiple procedures.

Procedure likely needs more profiling for imaging workflow and
record-keeping, however that is out of scope for this Diagnostic Report
Profile, and would be better addressed in concert with profiling imaging
ServiceRequest. Until it is fully profiled, the current practice of
user-generated text in the Procedure section of the
DiagnosticReport.presentedForm will need to serve.

Narrative text in the procedure section of the diagnostic report is a
good candidate for auto-generation, since it involves little to no
interpretation. The text may be available in <u>Procedure.text</u> and ImagingStudy.text,
which in turn would be based on a subset of the coded content in the
referenced resource(s), usually the modality, date, time, procedure type, performing facility and
details such as technique, patient positioning, pulse sequences, contrast usage, radiation
dose, and generated images/views. The text might also mention patient allergies,
to the extent they were noted and the procedure performed in a way that took them
into consideration. The content of the Procedure resource
likely originated from the image header, MPPS, RDSR, and performed
procedure protocols.

Recent FHIR IG work allows the Dose Reporter to provide the Report Creator with a formatted, locally-conformant block of text that assembles the correct subset of dose details for the specific procedure type for insertion into the report (typically to comply with local regulations).

During the diagnostic imaging procedure, it is possible that complications, such as allergic reactions to contrast, might occur. As part of clinical care documentation during the imaging procedure, these may be encoded in Procedure.complication, and/or AdverseEvent resources, and/or new or updated AllergyIntolerance resources with appropriate values for verificationStatus to allow management of the patient record. Such patient issues are generally managed long before the creation of the diagnostic report. The DiagnosticReport resource is not the primary record for those clinical care workflows; however, the Procedure section might describe and reference those resources, and the patient impact may also be captured in the Conclusion to bring it to the attention of the referring physician.

Procedure.outcome may include a reference to an Observation that contains the text block describing the radiation dose summary. It is recommended to set Observation.code to (IDR03, 99IHE, ”Procedure Radiation Dose Summary Text”). This information is sometimes included in the report to meet certain regulations. Applications which need more than summary information are referred to the detailed dose data that is commonly encoded and stored in the Imaging Study as DICOM Radiation Dose Structured Report objects.

During the imaging procedure, Observations might be created to capture
things like nursing notes or technologist observations. Those would be
associated with the Encounter for the imaging Procedure. Conveying those
to the radiologist as inputs for interpretation is not addressed here
since this profile is about encoding the resulting report. Future work
on reporting workflow and managing inputs to the radiologist could
address this.

#### 6.7.3.5 Comparison

**Comparison** studies shall be encoded in <u>ImagingStudy</u> resources
referenced in a List which is referenced from the <u>DiagnosticReport.comparison</u> attribute.

Comparison reports shall be encoded in DiagnosticReport or DocumentReference resources also referenced in the same list referenced from the DiagnosticReport.comparison attribute.

- List.emptyreason shall be used with a code for “unavailable” to indicate that no previous exams were available for comparison, in which case List.text will be populated with similar text.
- List.mode shall use the code for snapshot (since the list represents the point in time reporting took place and the list content is not maintained)

This serves as the "library" of studies the imaging clinician took into
consideration. Actual comparison observations are encoded in DiagnosticReport.result (see 6.7.3.6), and may include both new comparative statements and cited old statements from the prior study.

Narrative text in the comparison section of the diagnostic report is a
good candidate for auto-generation based on enumerating the coded
content in the referenced resources, usually the modality, date, and
procedure type.

- Each referenced ImagingStudy resource has a .text
  attribute which can contain a brief description of the study which may be assembled into the narrative text for the Comparison section.
- The order of references in .comparison represents the default order of presentation as selected by the Report Creator. Systems rendering this clinical content may choose a different order that is driven by their presentation needs.
- The order of references in .comparison (and permission to choose a different order driven by presentation needs) may also apply if .text is re-rendered by Report Creators to reflect updates to the resource content.

#### 6.7.3.6 Findings

Implementations shall be capable of
creating at least one Finding encoded as an Observation and referencing
it from <u>DiagnosticReport.result</u>. Implementations are permitted to create reports where none of the findings in the narrative are encoded.
> Note 1. Some Observations might not be referenced directly from .results, but rather might be referenced from .derivedFrom or .hasMember elements in another Observation which is part of a tree that is rooted in a reference from .results.
> Note 2. Some Observations referenced from DiagnosticReport.result might also be referenced from DiagnosticReport.conclusionCode, particularly if they have high clinical significance, such as actionable findings.  Such resources are not duplicated; rather their Resource.id is referenced from both locations.

The scope and complexity of report findings can vary significantly. See RAD TF-1:56.4.1.7 and 56.4.1.8 for terminology and concepts that will be helpful when reading this section.

Narrative text in the finding section of the diagnostic report will potentially include text directly dictated by the reading radiologist and text generated from coded Observations.

- Each referenced Observation resource has an Observation.text attribute which contains a text representation of the semantics of that Observation. These Observation.text strings may be assembled into narrative text for the Findings section.
- In Structured Observations, Observation.text might contain the original dictated text from which the structured content was created or it might contain text generated from the structured content.
- In Unstructured Observations, unstructured observation text (see 6.7.3.6.2.8) in the Observation.value string is copied into Observation.text.
- Given the potential for findings to be organized (sequenced and grouped) for presentation in more than one way, DiagnosticReport.text represents the presentation organization chosen by the authoring person and/or system at the time of publication. DiagnosticReport.composition can be used to encode another organization pattern. Similarly, DiagnosticReport.presentedForm can contain multiple additional organizations, as considered useful to potential consumers of the report. How Report Reader systems make use of Observation metadata and user configurable logic to meet the needs of different users, for example grouping observations by finding site in a particular sequence, is outside the scope of this Profile.

##### 6.7.3.6.1 General Observation Metadata

The following general metadata shall be populated in the Observation.
>Note 1. Some information that can be included in Observation metadata replicates information available in the DiagnosticReport metadata. It is recommended that Observation elements needed to facilitate usage of the Observation resources beyond the direct context of the parent DiagnosticReport, for example to perform Observation-level queries, be replicated in each Observation resource. Conversely, it is recommended that elements that might sometimes be of interest for provenance, but are not normally used for searching or processing, be omitted from each Observation resource since corresponding information is typically available in the DiagnosticReport resource from which they are referenced. These elements include details like .basedOn, .encounter, .issued, .performer, .device, and .partOf.
> Note 2. Several of the following bullets specify “if present”. This reflects elements for which the FHIR cardinality permits zero (i.e. that the element is permitted to be absent) and this Profile is specifying constraints on the content but is not changing the cardinality (i.e. not requiring that they be present).

- <u>Observation.subject</u> shall reference the imaged <u>Patient</u>.
- <u>Observation.category</u> shall use the value "imaging" ( <http://terminology.hl7.org/CodeSystem/observation-category#imaging> ).
  - Implementations may include additional relevant values.
- <u>Observation.status</u> shall use "final" (<http://hl7.org/fhir/ValueSet/observation-status#final>) for observations in the initial final report.
  - Other values from the observation status valueset, such as "amended" and "entered-in-error", may be used as appropriate for amended reports.
- Observation.effective shall contain a datetime corresponding to the acquisition of the image(s) on which this observation is made.
  - Since different images within a study are often acquired at different time points which can be clinically significant, this value is expected to be as precise and specific as practical. In the case of a measurement made on a specific frame, this would be the exact frame time. In the case of an observation the radiologist made without indicating a specific image, this might be a series datetime or the overall study datetime.
  - For Observations from comparison imaging studies (i.e. priors) that are included in a current report, either by referencing existing Observation resources or creating new Observation resources based on prior report text, the .effective datetime corresponds to the acquisition of the image in the comparison study.
- Observation.identifier may include an observationUID as described in the DICOM SR to FHIR Resource Mapping IG. (<http://hl7.org/fhir/uv/dicom-sr/StructureDefinition/imaging-measurement-group>)
- Observation.text shall contain a text summary of the observation for human interpretation (per FHIR DomainResource). The population of .text and the other observation elements might depend on how the observation was obtained and composed. For example. Observation.text might be populated first with a line of dictated text and then the other observation elements might be populated based on the dictated text semantics. Similarly, Observation.text might be populated first from a line of observation text taken from an existing uncoded prior report, and again observation elements are populated from that. Conversely, the observation elements might be populated first from interacting with a radiologist or an AI tool, and then Observation.text is rendered from that coded/structured information.
- Observation.note, if present, may describe caveats about the reliability of this observation, such as limitations imposed by the nature or quality of the imaging. General statements about limitations of the study that are not specific to this observation may be described in the Procedure. An implementation might also choose to encode a separate Observation specifically about quality issues where .focus=ImagingStudy and .code and .value are populated with codes drawn from DICOM PS3.16 or the IHE Reject Analysis & Monitoring (RAM) Profile.
- <u>Observation.basedOn</u>, if present, shall include a reference to the order for the imaging procedure that produced the data from which the observation is derived.
- <u>Observation.encounter</u>, if present, shall reference the <u>Encounter</u> during which the imaging procedure took place.
- <u>Observation.partOf</u>, if present, shall reference the DiagnosticReport. The interpreted <u>ImagingStudy</u> is not typically referenced from each Observation since it is referenced from the DiagnosticReport.
- Observation.derivedFrom typically does not reference the ImagingStudy since that can be found via the DiagnosticReport that contains this Observation. ImagingSelection may be referenced from .derivedFrom as described in 6.7.3.6.2.
- Observation.performer, if present, shall reference the person or organization responsible for the validity of the observation content.
- Observation.device, if present, may reference the software Device (such as an AI model or clinical application) that generated the observation content.
  - This is not the device that produced the study image(s) unless that system also produced this observation.
- Observation.triggeredBy is recommended to be absent in diagnostic imaging observations.
  - It is primarily for lab observations. It should not be used to reference the ServiceRequest (which appears in .basedOn), or to include the reason for exam (which appears in the referenced ServiceRequest).
- Observation.interpretation is recommended to be absent.
  - Radiologist interpretations (findings based on the assessment of one or more observations) are captured in separate Observation resources rather than being included as .interpretation elements.
    - For example, a qualitative breast density assessment of “very dense” is an assessed characteristic observation (see 6.7.3.6.2.5). A quantitative breast density could also be provided on its own and would be encoded as a measured property observation (see 6.7.3.6.2.4).  It would be disruptive if, when both are provided, the qualitative assessment sometimes appeared in the .interpretation of the measured property. That would require consumer applications to handle two different encoding patterns to find the qualitative information. It is simpler to generate two observations.

Details about the reporting process, such as what AI models were or were not run, and what AI
findings were not included in the report, may be documented by
associated systems in relevant logs, but are out of scope of this profile and will not appear directly in
the report itself unless the radiologist chooses to include such
details, for example by describing that in the Procedure/Technique section.

##### 6.7.3.6.2 Observation Type-specific Metadata

The following specifications address Observation details that vary depending on the type of observation. See RAD-TF-1:56.4.1.8.1 for discussion of observation types.

See Table B.3-1 for examples of the following encoding specifications and for guidance on how to organize dictated observations into one or more Observation Resources.

###### 6.7.3.6.2.1 Observation Finding Site (Anatomic Entity)

For an observation with a target that is an anatomic entity, i.e., a body part:

- <u>Observation.bodyStructure.includedStructure.structure</u> shall identify the anatomic entity that is target of the observation. The code shall be fully pre-coordinated except for the laterality.
  - For example, if the volume of the caudate lobe of the liver is being measured, the structure will use a code for the caudate lobe, not the entire liver. See also Table B.3-1 Example Observation Encoding Patterns.
  - It is recommended that an observation on multiple structures be encoded as multiple observations on individual structures, each with a separate bodyStructure resource. In the case of 6.7.3.6.3.8 Compound Observation, a compound statement is required to be encoded in separate Observations.
- <u>Observation.bodyStructure.includedStructure.laterality</u> shall identify the laterality if .structure is a paired structure. See DICOM PS3.16 Table L-5. Pairedness of Anatomic Concepts. E.g., the left ventricle is not a paired structure.
- <u>Observation.bodyStructure.includedStructure.qualifier</u> may be used if a pre-coordinated code for .structure that incorporates the qualifier semantics, such as (41879009, SCT, “Distal Right Coronary Artery”), is not available.
- <u>Observation.bodyStructure.excludedStructure</u> is not typically used when encoding observations.

###### 6.7.3.6.2.2 Observation Finding Site (Pathologic Entity)

For an observation with a target that is a pathologic entity, i.e., a morphologic abnormality:

- <u>Observation.bodyStructure.includedStructure.morphology</u> shall identify the type of morphologic abnormality that is the target of the observation. The code shall not pre-coordinate the associated anatomy if an appropriate code is available that is not anatomy-specific. E.g. Codes for pleural effusion or cardiomegaly are acceptable even though they do pre-coordinate some anatomical context because there is not a useful more general code.
- <u>Observation.bodyStructure.includedStructure.structure</u> shall identify the anatomy associated with the morphologic abnormality identified in .morphology. The code shall be fully pre-coordinated except for the laterality.
  - Typically, only a single structure will be referenced. It is permitted to reference multiple structures if needed to describe a single morphologic abnormality that affects multiple structures (e.g. an advanced lung lesion that involves the pleura and thoracic wall), or when the position of a morphologic abnormality is described relative to multiple landmarks.
- <u>Observation.bodyStructure.includedStructure.laterality</u> shall identify the laterality if .structure is a paired structure.
- <u>Observation.bodyStructure.includedStructure.qualifier</u> may be used if a pre-coordinated code for .structure that incorporates the qualifier semantics, such as (41879009, SCT, “Distal Right Coronary Artery”), is not available.
- Different Observation resources should reference the same BodyStructure resource when they are describing the same pathologic entity, particularly within a single DiagnosticReport. When multiple DiagnosticReports describe the same pathologic entity, they may or may not have access to, or be able to correlate or share, the same BodyStructure resource.  In such cases, a Tracking UID may be used in the BodyStructure.identifier to correlate multiple observations on the same entity (e.g. a given lung nodule) or to distinguish between multiple observations on different similar entities (e.g. several lung nodules).
  - <u>BodyStructure.identifier.type</u> shall use the value (112039, DCM, “Tracking Identifier”) when encoding a DICOM Tracking Identifier. BodyStructure.identifier.type shall use the value (112040, DCM, “Tracking UID”) when encoding a DICOM Tracking UID.
  - It is possible that correlation might happen after the subsequent BodyStructure resources are created, in which case the matching Tracking UID might be added as a later entry to BodyStructure.identifier to relate the matched entities.
  - A morphological abnormality might be reclassified over time, such as a lesion that is elevated to a tumor in a subsequent study. Consider creating a new BodyStructure with the new .morphology value that shares the same Tracking UID as the prior BodyStructure resource.
  - Two tumors might subsequently merge, perhaps while growing. Consider creating a new BodyStructure which includes the Tracking UIDs of the two old BodyStructures.
  - A tumor might subsequently split into two disjoint entities, perhaps while shrinking. Consider creating two new BodyStructure resources to reference in the new report with new Tracking UIDs. The database managing the original BodyStructure might add references from it to the new BodyStructures. While the original BodyStructure could be modified to describe multiple disjoint entities, there would be no way to assign new measurements to the appropriate disjoint entity.

###### 6.7.3.6.2.3 Observation Finding Site (Physical Object Entity)

For an observation with a target that is a physical object (such as a piece of shrapnel, or a stent):

- <u>Observation.bodyStructure.includedStructure.morphology</u> shall identify the type of physical object that is the target of the observation; preferably using an appropriate morphologic abnormality code from SNOMED, such as (840294004, SCT, “Retained metallic foreign body”). The code shall not pre-coordinate the associated anatomy if an appropriate code is available that is not anatomy-specific. E.g. use (65818007, SCT, “Stent”) rather than (705643001, SCT, “Coronary artery stent”); the anatomic location will be captured in includedStructure.structure.
  - In this context, more precise codes (such as a code for coronary artery stent) MAY be used to indicate that the object has been determined to be of a specific type (e.g., a stent designed for insertion into coronary arteries) not to just indicate the location where it has been used.  Clinicians can choose to deploy objects like coronary artery stents in other parts of the body.
  - Appropriate codes for physical object entities includes SNOMED codes that have the morphologic abnormality semantic tag and represent non-biological entities such as (840294004, SCT, “Retained metallic foreign body”), and codes that have the physical object semantic tag and may be found inside the body such as (65818007, SCT, “Stent”).
- <u>Observation.bodyStructure.includedStructure.structure</u>, if present, shall identify the anatomy associated with the physical object. The code shall be fully pre-coordinated except for the laterality.  E.g. the coronary artery in which the stent is located.
- <u>Observation.bodyStructure.includedStructure.laterality</u> shall identify the laterality if .structure is a paired structure.
- <u>Observation.bodyStructure.includedStructure.qualifier</u> may be used if a pre-coordinated code for .structure that incorporates the qualifier semantics, such as (41879009, SCT, “Distal Right Coronary Artery”), is not available.

###### 6.7.3.6.2.4 Measured Property

For an observation of a property or feature in the image that is quantitative (typically determined using a measurement tool or application, although they could be estimated):

- <u>Observation.code</u> shall identify the property measured. The code shall not pre-coordinate the associated anatomy.
  - Observation.bodyStructure identifies the associated anatomy where the measurement is taken and what entity is being measured.
  - Observation.code will sometimes need to distinguish between related properties of the measured entity or location. For example, one observation at the mitral valve using doppler ultrasound might use a code to indicate blood velocity is the property measured, while a second observation at the same location might use a different code to indicate tissue velocity is the property measured.
- <u>Observation.value</u> shall record the measured quantity. If the measurement is not unitless, the units shall be recorded.
  - Two different Observations might have the same .code but use different units in .value. Sites and observers may prefer different scales.
  - Comparative measurements such as volume change might be expressed in absolute terms (e.g. -22 mm3) or relative terms (e.g. -25%).
- <u>Observation.interpretationContext</u> may be used to record details of how the property was measured, e.g., for a left ventricle diameter measurement, this element might contain three codes, one for end diastole, one for apical 4-chamber view, and one for ultrasound B-mode.
  - As an alternative to recording codes, Observation.interpretationContext also permits referencing another Observation that provides context. This alternative may be useful when a concept-value pair (e.g. Observation.code=Cardiac Phase and Observation.value=End Diastole) would provide more clarity than a code by itself. Such a context Observation can be referenced from multiple measurement Observations when applicable.
- <u>Observation.derivedFrom</u> may reference a corresponding ImagingSelection that might include the specific coordinates and caliper shape used for the measurement. E.g. line coordinates in the ImagingSelection from which the diameter value in the Observation was derived.
  - The ImagingSelection coordinates are in the Frame of Reference of the Image on which they are placed.
  - DICOM Frame of Reference UID (0020,0052) uniquely identifies a spatial frame of reference for an image, but the origin and axes of the corresponding coordinate space are defined by the associated imaging data and metadata.
  - If ImagingSelection.bodySite is present, it is expected that the value be consistent with Observation.bodyStructure. Since the ImagingSelection should be considered supportive not primary, in the event the values are different, the value in Observation takes precedence when interpreting the Observation.  E.g. the Observation.bodyStructure might identify a left breast mass for which a diameter is observed, while the ImagingSelection.bodySite might do the same, or might identify that it’s coordinates are in the 5 o’clock region of the left breast.
  - Similarly, values of Observation.subject and Observation.focus take precedence over corresponding values (if present) in a referenced ImagingSelection.  

When a property is computed from other measurements, instead of being measured directly, the base measurements can be encoded as described here and the computed property can be encoded as described in 6.7.3.6.3.4. For measurements that are taken using a caliper or other measurement tool, although some computation is involved, that is still considered a direct measurement.

When a property that is measurable is assessed qualitatively instead, it can be encoded as an assessed characteristic (see 6.7.3.6.2.5). E.g., instead of capturing that the main pancreatic duct width is 5 mm, in the absence of a measurement, the observation that the main pancreatic duct width is dilated. Similarly, an adrenal gland size might be recorded as being enlarged.

###### 6.7.3.6.2.5 Assessed Characteristic

For an observation of a characteristic or feature in the image that is assessed qualitatively:

- <u>Observation.code shall identify the characteristic assessed. The code shall not pre-coordinate the associated anatomy.
- <u>Observation.value</u> shall record the assessment.
- <u>Observation.interpretationContext</u> may be used to record details of how the assessment was performed, e.g., codes indicating the timing of the measurement, the guideline/criteria used.
- <u>Observation.derivedFrom</u> may, when the observation is localized to a particular image or spatial location, reference an ImagingSelection that includes the relevant image, frame, region, volume, and/or coordinates of the assessed feature.

###### 6.7.3.6.2.6 Condition Presence

For an observation of the presence or absence of a condition (i.e. a pathologic entity):

- <u>Observation.bodyStructure</u> shall identify the pathologic entity and its anatomical location as described in 6.7.3.6.2.2.
- <u>Observation.code</u> shall be (705057003, SCT, “Presence”).
- <u>Observation.value</u> shall record the assessment as a code. Recommended values are (52101004, SCT, “Present”), (272519000, SCT, “Absent”) or (82334004, SCT, “Indeterminate”)

> Note 1. (52101004, SCT, “Present”) and (272519000, SCT, “Absent”) are considered to mean that within the capabilities of the equipment and the observer to do so, the condition has been determined to be present/absent, and thus when used here the codes are semantically equivalent to (260373001, SCT, “Detected”) and (260415000, SCT, “Not detected”).
> Note 2. Some conditions that are absent represent pertinent negatives.
> Note 3. Some conditions that are present here in the Findings might not appear in Impression if they are minor and judged to have insufficient clinical significance.

###### 6.7.3.6.2.7 Normality Assessment

For an observation of the normality of an anatomic entity:

- <u>Observation.bodyStructure</u> shall identify the anatomic entity as described in 6.7.3.6.2.1.
- <u>Observation.code</u> shall be (276800000, SCT, “Normality”).
- <u>Observation.value</u> shall record the assessment as a code. Recommended values are (263654008, SCT, “Abnormal”), (17621005, SCT, “Normal/Unremarkable”), or (82334004, SCT, “Indeterminate”) 
> Note 1. “Lungs are unremarkable”, “Lungs are normal”, and “No pulmonary abnormality” are considered semantically equivalent renderings of Normality=Unremarkable for BodyStructure=Lungs.
> Note 2. For an anatomic entity observed as "Abnormal", details about the nature of an abnormality, including  situations where the anatomic entity is surgically absent or congenitally absent, are coded as an additional observation. An Assessed Characteristic observation (Section 6.7.3.6.2.5) or a Condition Presence observation (Section 6.7.3.6.2.6) may be appropriate.

###### 6.7.3.6.2.8 Unstructured Observation

For an observation that is fully unstructured narrative:

- <u>Observation.bodyStructure</u> shall be absent.
- <u>Observation.code</u> shall use the code (IDR01, 99IHE, “Unstructured Observation”).
- <u>Observation.value</u> shall contain valueString text that describes the target image entity, the image feature and the observation result. The text is permitted to describe multiple observations, although it is not intended to contain an entire section or report. To the extent that it is practical, it is recommended to split multiple unstructured observations into multiple Observation resources. This recommendation is further supported by the fact that valueString is not supposed to contain formatting characters, and any markdown characters are treated as literal, not formatting.
- Unstructured observations might be particularly useful for complex sentences with advanced semantics that are challenging to encode.

For an observation that is unstructured narrative, but the finding site has been determined:

- <u>Observation.bodyStructure</u> shall encode the observation finding site as described above.
- <u>Observation.code</u> shall use the code (IDR02, 99IHE, “Unstructured Feature”).
- <u>Observation.value</u> shall contain text that describes the image feature and the observation result. The text may or may not reiterate the finding site. The text is permitted to describe  multiple features and observation results. To the extent that it is practical, it is recommended to split multiple unstructured features into multiple Observation resources.

If both the observation finding site and the image feature can be coded and only the value is unstructured, it is recommended to encode it as an assessed characteristic (see above) and use a private code or a text value.

##### 6.7.3.6.3 Observation Relationship Encoding

The following specifications address encoding relationships between Observations. See RAD-TF-1:56.4.1.8.2 for discussion of observation relationship patterns.

The following patterns are intended to illustrate how the relevant FHIR elements should be used to address the cases in RAD-TF-1:56.4.1.8.2. Implementations that need to address other cases may need to adopt additional patterns but are encouraged to be as consistent with the patterns here as possible.

###### 6.7.3.6.3.1 Finding Set

For an observation that is part of a set of observations that collectively represent an assessment of a particular feature or pathology:

- The root finding shall be encoded in an Observation. The associated observations shall each be encoded in a separate Observation.
- Observation.code of the root finding shall identify the root of the finding set.
  - When encoding CDE Sets from radelement.org, it is preferred to use the CDE Set code here, such as (RDES195, RadElement, “Pulmonary Nodule”).
  - Observation.value of the root finding shall not have a value. The presence of the pathology is represented in the first associated observation.
- Observation.hasMember of the root finding shall reference the associated observations.
  - Associated observations are expected to follow the specifications for the CDE Set on radelement.org.
  - The first associated observation shall be a Condition Presence observation (see 6.7.3.6.2.6).
  - Since FHIR discourages bi-directional references, the associated observations do not typically reference the root finding. Given an associated observation, the root finding is found via a FHIR reverse chaining search.
  - The use of .hasMember is intended to carry a subtle implication here that subsequent viewers of this data may be interested in seeing the associated observations presented alongside the root finding. This differs slightly from .derivedFrom Observations which are less likely to be initially viewed unless there is a need to confirm the provenance of the referencing observation.
- Observation.organizer shall be absent or set to FALSE, since setting it to TRUE is only for grouping a subset and prohibits the parent observation from having a value.

See <https://www.radelement.org> for a large collection of Finding Sets.

For elements like Observation.device or Observation.derivedFrom, the associated observations may have different values from each other as appropriate (e.g. if observations were obtained from different pieces of software, or observations were made on different frames or pixels as recorded via ImagingSelections).

>Note 1. Observation.component is not used here as FHIR limits it to observations that are not useful on their own, giving the example that a BMI Observation “… should not contain components for height and weight because they are clinically relevant observations on their own and should be represented by separate Observation resources.” Further, “Components should only be used when there is only one method, one observation, one performer, one device, and one time.” The use of component also has the potential to significantly complicate queries.

###### 6.7.3.6.3.2 Summary/Derived Observation

For an observation that summarizes other observations:

- The summary observation shall be encoded in an Observation. The sub-observations shall each be encoded in separate Observations.
- Observation.code of the summary observation shall identify the summary finding.
  - For *-RADS, this is a code for the top-level score, such as (146611000146107, SCT, “BIRADS Assessment Category”) and an Observation.value like (39714307,SCT,”3 – Probably Benign”).
- Observation.derivedFrom of the summary observation shall reference the underlying sub-observations from which the summary was derived. It is permitted to include all the observations that were a part of the summary assessment procedure, even if specific observations did not factor into the final summary value.
  - The associated observations do not reference the root finding. Given an associated observation, the root finding is found via a FHIR reverse chaining search.  

###### 6.7.3.6.3.3 Multi-factor Score

For an observation that is a score totaled from a set of contributing factors (e.g. Balthazar Score or CT Severity Index for pancreatitis):

- The score finding shall be encoded in an Observation. The associated factors from which the score is totaled shall each be encoded in a separate component.
- Observation.code of the score finding shall identify the score concept.
- Observation.component.code of the score observation shall identify a factor of the multi-factor score.

A key distinction between a Multi-factor Score and a Summary Observation, is that the components, such as “pancreatic necrosis = 4 points”, of a Multi-factor Score do not make sense as an observation outside the context of the Multi-factor Score, while the child Observations, such as “nodule is growing”, of a Summary Observation do make sense as observations even outside the context of the Summary Observation.

###### 6.7.3.6.3.4 Computed Property

For an observation that is computed from other observations, see Section 6.7.3.6.2.4 Measured Property.

- Observation.code shall identify the computed property. The code shall not pre-coordinate the associated anatomy.
- Observation.value shall record the computed quantity. If the measurement is not unitless, the units shall be recorded.
- Observation.derivedFrom shall reference the observations from which the property was computed. (There is no need to reference them from .hasMember). Any corresponding ImagingSelection(s) would be referenced from those other observations, not this one.

> Note 1. The computation is not required to be strictly numerical. It might also involve Boolean or other logic.

###### 6.7.3.6.3.5 Temporal Comparison

For an observation that captures the difference between observations of the same property of the same entity at different points in time, treat this as:

- a computed property (See Section 6.7.3.6.3.4 Computed Property) for quantitative comparisons, or
- a summary/derived observation (See Section 6.7.3.6.3.2 Summary/Derived Observation) for qualitative comparisons, such as Increased/Decreased/Unchanged or Worsened/Improved/Unchanged.

###### 6.7.3.6.3.6 Hierarchical Target Entity

For an observation on a target entity that has hierarchical structure:

- The observations shall be organized as a Finding Set (see above).
- The root finding will relate to the “coarse end” of the hierarchical structure. The associated observations may be more specific in the anatomy or morphology of their BodyStructure as needed.  

For example, a pulmonary nodule with observations of the presence and volumes of a solid part and a non-solid part could have:

- a root observation with
  - Observation.bodyStructure.includedStructure.structure is the anatomic site
  - Observation.bodyStructure.includedStructure.morphology indicates a nodule
  - Observation.code is (705057003, SCT, “Presence”)
  - Observation.value is (260373001, SCT, “Detected”) TODO Review Absent vs Not detected
  - Observation.hasMember references sub-observation A and B
- a sub-observation A with
  - Observation.bodyStructure.includedStructure.structure is the same anatomic site
  - Observation.bodyStructure.includedStructure.morphology indicates a nodule solid part
  - Observation.code is (705057003, SCT, “Presence”)
  - Observation.value is (260373001, SCT, “Detected”)
- a similar sub-observation B with the .morphology indicating the non-solid part.
- sub-observation A and sub-observation B each have a .hasMember sub-sub-observation (A1 and B1) with .code = volume and referencing the same BodyStructure to provide the corresponding volume measurements of the solid part and non-solid part.

Note that while the hierarchy provides potentially useful structure to present and navigate the observations, each observation can still be parsed and understood all on its own.

This construction should be used judiciously. Medical concepts of anatomy are inherently hierarchical, but this pattern is not intended to be used to capture that. For example, observations on lobes of the liver are not intended to be organized under a parent observation of the entire liver just because there is an anatomical hierarchy.

Narrative text in Observation.text of each of the sub-observations reflect the semantics of that particular sub-observation. Observation.text of the root observation will reflect the combined semantics of the hierarchical set, which may or may not elide some details of the sub-observations based on clinical convention and preferences.

###### 6.7.3.6.3.7 SR Measurement Group

For a set of observations that correspond to a DICOM Measurement Group, but do not fit any of the other relationship patterns in this section:

- The observation group shall be encoded in an Observation. The associated observations shall each be encoded in an Observation.
- Observation.organizer of the observation group shall be set to true.
- Observation.code of the observation group shall identify the nature of the observation group. In some cases, the source object might not provide any information, in which case it might simply be (125007, DCM, “Measurement Group”).
- Observation.hasMember of the observation group shall reference the associated observations.
- Per FHIR, Observation.value is absent for the observation group, and Observation.organizer may be absent or set to false for the associated observations.

###### 6.7.3.6.3.8 Compound Statement

For a set of observations that were expressed as a compound statement:

- The observations shall each be encoded in separate Observations.
  - E.g. “The lungs are well expanded and clear. No focal consolidation, pleural effusion, or pneumothorax.” The first sentence produces two observations and the second sentence produces three more observations. For all of them, the BodyStructure is lungs, bilateral.
  - E.g. “Liver, gallbladder, pancreas, and spleen are unremarkable.” The sentence produces four observations.
  - E.g. “A 0.5 x 1.2 cm lesion in the bladder”. The sentence produces two observations. It is recommended to use different property codes, such as major axis and minor axis, so the two observations do not appear to be a repeated measurement of a single diameter property.

If there is a need to persist the compound rendering, i.e. present a compound statement based on the atomic observations, coding similar to the SR Measurement Group may be used.

- A compound statement grouper observation may be created where,
  - Observation.code may use a code for “Compound Statement”.
  - Observation.hasMember shall reference the associated observations.
  - Observation.organization shall be set to true.
  - Observation.value is absent, per FHIR.
  - Observation.text shall contain the compound statement text.

Even if the compound rendering is persisted, clients are still permitted to present alternate formatting, such as atomic observation bullets, based on user preferences.

###### 6.7.3.6.3.9 Conclusion Support

For an observation identified as supporting evidence for the observed presence or absence of a condition:

- Observation.derivedFrom shall reference the Observation.
  - This evidence is not necessarily conclusive. This may be used to express relations like “\<observed\> TODO FIX ANGLE BRACKET USAGE HERE AND BELOW FOR EXAMPLE BY BACKSLASH ESCAPE opacity suggestive of infection \<condition\>” where the Observation that infection might be present is (partially) derived from the Observation that an opacity is present.
  - This evidence is not necessarily complete. There may be other evidence considered that is not referenced here, and might not be coded in a machine readable form.

###### 6.7.3.6.3.10 Causal Relationship

For an observation on an entity whose existence or state is, at least in part, the result of another observed entity or state.

TODO LATER – There is currently no etiology mechanism in FHIR Core. Discuss with FHIR Patient Care WG and Orders & Observations WG.  Two observations that share a common cause is a related form of this kind of relationship.
<https://build.fhir.org/ig/HL7/fhir-extensions/StructureDefinition-condition-dueTo.html>

##### 6.7.3.6.z Consumers of Findings TODO FIX NUMBERING

The observation types, relationships, and hierarchical structures described throughout section 6.7.3.6 are intended to provide predictable patterns that will make it easier for systems that consume the DiagnosticReport and Observation resources. Such consumers might choose to “flatten out” the observation tree under DiagnosticReport.result to the extent that suits their needs.

Consumers should also consider that the above patterns might not cover all situations and should be prepared for some residual variability in the ways that Report Creators encode findings.

##### 6.7.3.6.y Query Patterns for Findings

The following are example query tasks that might be performed on a collection of observations. These were taken into consideration to confirm that they are reasonably practical given the observation encoding requirements and guidance of this profile.

Most queries will start with something like this: TODO CHECK SQUARE BRACKET USAGE

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

##### 6.7.3.6.x Other Coding Guidance TODO FIX NUM

The following are recommendations, but not normative requirements for the profile.

For paired anatomy, when an observation or finding applies to both, SNOMED recommends coding two observations, one for left one for right.

For coding the presence of a disorder, SNOMED recommends using values of Detected/Not detected rather than Present/Absent. This is a more accurate description of the situation in the imaging context. It is conceivable for something to be present but not visualized.

For coding interpretive concepts for a measurement, SNOMED recommends using values like above/within/below reference range rather than high/normal/low.

For pneumonia, SNOMED recommends reserving that code for infectious processes. When it is not clearly an infectious process, use pneumonitis.

For pulmonary embolisms, SNOMED recommends that the recorded finding site be a pulmonary artery rather than a region of the lung organ.  

#### 6.7.3.7 Impression / Conclusion

Implementations shall be able to create at least one Observation and reference it in the
<u>DiagnosticReport.conclusionCode</u>. Observations referenced from DiagnosticReport.conclusionCode shall include the code <http://terminology.hl7.org/7.1.0/CodeSystem-condition-category.html#condition-category-diagnostic-report-impression> in Observation.category.
FIX NOTES (PRIOR UNCLOSED ENTITY?)
>Note 1. The imaging clinician might choose to omit from the Impression certain Observation resources referenced in DiagnosticReport.results that record the presence of conditions that the imaging clinician feels are not clinically significant. E.g., minor renal cysts. DiagnosticReport.conclusionCode would not reference those observations.
>Note 2. The imaging clinician might choose to include in the Impression certain Observation resources referenced in DiagnosticReport.results that record the absence of conditions the imaging clinician feels represent pertinent negatives. E.g., conditions in the reason for exam. DiagnosticReport.conclusionCode would reference those observations.

The Report Creator is responsible for distinguishing and encoding dictated impressions, recommendations, and communications. This is intended to facilitate workflow and clinical pathway automation, such as agentic tools, to support the referring physician tracking critical findings, accessing and applying relevant clinical guidelines and other forms of clinical decision support.

- An unstructured observation (see 6.7.3.6.2.8) is a pragmatic way to include a block of narrative impression if the system is unable to create corresponding coded entries.

Observations in the impression section which represent actionable findings, whether incidental or within the scope of the reason for exam, can be individually highlighted in the report at the discretion of the imaging clinician using the Observation.category.

- Observation.category SHOULD, if such information is readily available, include a code to indicate the degree to which the Impression finding is actionable. Such information can be tremendously useful to downstream care management. Codes may be drawn from the RadLex codes for the ACR Actionable Finding Categories described in IHE Results Distribution (RD):

  - (RID49480, RadLex, "Cat 1 Emergent Actionable Finding") defined as
    requiring immediate medical attention within minutes.

  - (RID49481, RadLex, "Cat 2 Urgent Actionable Finding") defined as
    requiring medical attention within hours.

  - (RID49482, RadLex, "Cat 3 Non-critical Actionable Finding") defined
    as requiring medical attention within days to months.

TODO REPLICATE THE SPACE BETWEEN NOTES FOR READABILITY?

> Note 1. While the presence of a Recommendation for a given impression is an implicit indication that it is actionable. Having an explicit code can help with subsequent tracking and follow-up.
>
> Note 2. Conversely, actionable findings do not always have a corresponding Recommendation. For example, an identified pneumothorax is a well-known entity to the referring clinician with standard actions to address it. The imaging clinician would be unlikely to re-iterate those actions in the report.
>
> Note 3. Category 1 and Category 2 codes constitute "critical findings" which often result in direct Communications (see Section 6.7.3.9) due to the clinical urgency.
>
> Note 4. The presence of actionability codes might support, or directly trigger, the creation of Flag resources by the referring physician, consuming systems, or even the radiologist. Such behaviors are described in IHE RAD TF-1:56.4.2.4.1.3 but are not a requirement in this profile.

The narrative form of the Impression section is often directly dictated
by the imaging clinician. Tools also exist that generate a draft of the
Impression narrative based on the dictated Findings narrative. If the
Impression narrative were built up from the coded Impression, the
summary in Observation.text of each referenced Observation resource might be
compiled into impression bullets.

- The order of references in .conclusionCode represents the default order of presentation as selected by the Report Creator. Systems rendering this clinical content may choose a different order that is driven by their presentation needs.
- The order of references in . conclusionCode (and permission to choose a different order driven by presentation needs) may also apply if .text is re-rendered by Report Creators to reflect updates to the resource content.

In addition to rendering the Impression narrative as a section in the
full report in the <u>DiagnosticReport.text</u> attribute, the Report
Creator may also render the Impression narrative into
<u>DiagnosticReport.conclusion</u> as a markdown field. The
Impression narrative shall not contain dictated text which goes beyond the
semantics captured in the <u>DiagnosticReport.conclusionCode</u>
references since any additional narrative can be encoded in an unstructured Observation referenced from DiagnosticReport.conclusionCode.

If/when one of these Observations provides the basis for a referring physician to create or update a Condition resource (e.g. to add pneumonia to the problem list, or update the clinical status of a pneumothorax to resolved), Condition.evidence in that Condition resource managed by the referring physician may be updated to include a reference to the Observation resource. Such operations on Condition resources are performed by clinical management systems outside the scope of this profile.

#### 6.7.3.8 Recommendations

**Recommendations**, if any, shall referenced from the <u>DiagnosticReport.recommendation</u> attribute.

Recommendations for subsequent imaging or lab tests would be encoded as new draft ServiceRequests. Recommendations for formal specialist consultations could also be encoded as new draft ServiceRequests while simpler communications could be encoded as draft CommunicationRequests. In the event an imaging clinician chose to recommend a specific care plan in the report, that would be encoded as a draft CarePlan.

Machine-readable recommendations are intended to facilitate workflow and clinical pathway automation, such as agentic tools, to support the referring physician doing things like placing orders based on the recommendations. If necessary, non-machine-readable text recommendations can be provided in DiagnosticReport.recommendation.concept.text entries since the .recommendation element is a CodeableReference.  Similarly, a partially machine-readable ServiceRequest can populate ServiceRequest.code.concept.text with descriptive text.

These draft ServiceRequests and CommunicationRequests, when created, may
omit various details that the imaging clinician would not know or would
not be responsible for choosing. They are intended to serve as a
skeleton that facilitates the referring provider adding any needed
details and activating it as an order.

- <u>serviceRequest.status</u> shall use the value draft ("The request
  has been created but is not yet complete or ready for action.")

  - This reflects the fact that it is ultimately up to the referring
    physician whether or not to act on one or more recommendations in
    the report. Also, the request will be sparsely encoded and things
    like procedure codes might not be locally correct so completion of
    details and code re-mapping might be needed before the request can
    be activated.

- <u>serviceRequest.intent</u> shall use the value proposal (to leave it
  up to the referring physician) or plan (if the imaging clinician feels
  it would be inappropriate if the recommended action does not take
  place)

- <u>serviceRequest.reason</u> may reference a Condition resource in the
  Impression when the recommendation was motivated by that specific
  impression. This serves both to justify the recommendation, and to
  associate the recommendation with the impression which can influence
  their presentation.

> Note: To capture specific clinical/practice guidelines or literature citations that were applied in making the recommendation (e.g., the Fleischner Criteria for lung nodule follow-up), those can also be referenced from ServiceRequest.reason. In HL7 v2, the IHE Results Distribution (RD) Profile encoded this in OBX-15. Since there is not currently a PracticeGuideline resource, it would be necessary to create a DocumentReference resource for the relevant policy or guideline document.

- <u>ServiceRequest.occurrence</u> supports encoding a Period, i.e., a
  time range. Per FHIR, the context of use will make it clear that one
  value from the period applies. To encode a recommendation that a
  follow-up scan take place 6-9 months from now, the Report Creator
  calculates a start date 6 months from the current date, and an end
  date 9 months from the current date.

- <u>ServiceRequest.performerType</u> can be used to encode a referral
  to a particular type of specialist.

- <u>ServiceRequest.orderDetail</u> can be used to further specify
  protocol parameters, acquisition technique, desired views, patient
  preparation, etc., as appropriate. Detailed guidance on this is beyond
  the scope of this profile.

- The order of references in .recommendation represents the default order of presentation as selected by the Report Creator. Systems rendering this clinical content may choose a different order that is driven by their presentation needs.
- The order of references in . recommendation (and permission to choose a different order driven by presentation needs) may also apply if .text is re-rendered by Report Creators to reflect updates to the resource content.

> Note 1. The presence of recommendations might support, or directly trigger, the creation of Flag resources by the referring physician, consuming systems, or even the radiologist. Such behaviors are described in IHE RAD TF-1:56.4.2.4.1.3 but are not a requirement in this profile.

There is idiosyncratic variation between specialties, regions, and
facilities as to whether recommendations are presented in the
impressions section or presented separately. Since the underlying
encoding of a recommendation differs from an impression, this profile
separates the two. Implementations may still choose to group the two
together in the presented form based on configuration and customer
preferences.

A recommendation is often directly associated with a specific
impression. This may be expressed in the dictated text by following the
impression with a recommendation before moving on to the next
impression. The Report Creator is responsible for maintaining the order
and relationships between impressions and recommendations.

The narrative form of the Recommendations may be directly dictated by
the imaging clinician. Tools also exist that generate a draft of the
Recommendation narrative based on the Impressions and associated
guidelines. If the Recommendation narrative is built up from the coded
Recommendation, the summary in <u>ServiceRequest.text</u> of each
referenced ServiceRequest resource might be compiled into recommendation
bullets.

Although this Profile facilitates machine-readable encoding of the
potential ServiceRequests, the narrative Recommendation text may also
include conditional logic, e.g., if A is true then procedure X is
recommended; if B is true then procedure Y is recommended; else
procedure Z is recommended. This profile does not yet model this logic
in the coded recommendations; as a placeholder, the condition text could
be included in <u>ServiceRequest.note</u>, but this does not support
automated tooling. In this example scenario, all three procedures would
be included as referenced ServiceRequest resources (with status = draft,
as described above) and the referring physician would apply the logic in
the narrative to decide which to activate (by setting the status to
active), if any.

#### 6.7.3.9 Communications

**Communications**, if any, shall be encoded as Communication resources referenced from the DiagnosticReport.communication attribute.

This information is included in the body of the report, in part for
medicolegal purposes. If future HIT infrastructure handles tracking such
communications directly in the EMR, the practice of using the diagnostic
report to implement such accountability and tracking might change, but
for now it is expected to persist.

This information may also facilitate performance metrics such as the speed
with which the Referring Physician is notified of key clinical results
or other conformance to best practices for patient safety and quality of
care.

- Communication.text shall contain the narrative text describing the communication.
  - A minimal unstructured Communication resource can be created with just .status and .text populated.
- Communication.reason, if present, can reference particular Observations that motivated the communication.

The corresponding section narrative text may be created by concatenating
the .text contents for each of the referenced Communication resources.
This narrative often appears at the bottom of the report under the
Impressions and Recommendations. The narrative text often includes the date and time, the recipient (referring, patient, etc.), the mode of communication, the urgency, whether the communication was successful, and the nature of the information communicated.

- The order of references in .communication represents the default order of presentation as selected by the Report Creator. Systems rendering this clinical content may choose a different order that is driven by their presentation needs.
- The order of references in . communication (and permission to choose a different order driven by presentation needs) may also apply if .text is re-rendered by Report Creators to reflect updates to the resource content.

#### 6.7.3.10 Signature

**Signature** of the report is typically rendered as a line of text at the bottom of the report.

The digital signature of the report shall be encoded as a <u>Provenance</u> resource.

- It is up to the rendering system to ensure the signature line appears in the human readable forms of the report (see 6.7.3.11) before finalizing the Provenance resource; doing it in the opposite order would invalidate the signature.
- Provenance.target shall reference the DiagnosticReport resource. Usually, it will also reference all other clinical resources created or updated as part of creating the report, such as Observations and ImagingSelections.
  - Implementations might consider displaying a presented form of the report that has been rendered from the coded content for review and signature by the imaging clinician as a way to facilitate approval of the coded content and not just dictated narrative.
  - The references are typically version-specific.
  - Since contextual resources, like the Patient and ServiceRequest, existed prior to the report and were not updated, those are not usually referenced here.
- Provenance.signature.type shall have a value of ProofOfApproval.
- Provenance.agent.who and Provenance.signature.who (or
  Provenance.signature.onBehalfOf) shall be compatible with the person
  identified in DiagnosticReport.resultsInterpreter. See also Section
  6.7.3.0.

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

Narrative text for the signature typically appears at the bottom of the
report text with a statement in a form similar to "This report was
digitally signed by Dr. X at \<time\> on \<date\>".

Preliminary (“unsigned”) reports may involve a DiagnosticReport resource
being made available which references a
DiagnosticReport.resultsInterpreter, but is not the target of a
Provenance resource with a .signature.type of ProofOfApproval.

In the unprofiled DiagnosticReport resource, the signature appears to be
implicit. It is left to receivers to presume that if the report status
is final and there is an interpreter listed, that means that
practitioner approved the content of the report at some point in time.

#### 6.7.3.11 Human-Readable Form

The fully rendered human-readable form of the diagnostic report shall be
encoded in the <u>DiagnosticReport.text</u> attribute. 

As described in RAD TF-1:56.4.1.6, the attributes of the DiagnosticReport resource, and the resources it references, are the primary containers for the coded report information which provides interoperable semantics. The DiagnosticReport.text attribute establishes a robust baseline representation of the report content in rendered human-readable form.
Additional optional representations are described in 6.7.3.11.1.

Per the [FHIR guidance for .text narrative
attributes](https://www.hl7.org/fhir/narrative.html#Narrative), the
.text narrative should support human-consumption as a fallback from
parsing the resource; structured data should not generally contain
information of importance to human readers that is omitted from the
narrative. Accordingly, to the extent that the DiagnosticReport
attributes described in Sections 6.7.3.2 through 6.7.3.9 are present
with content, corresponding sections shall be present in the .text
narrative.

> Note 1. As a Narrative attribute, the content of .text is encoded in XHTML with [additional FHIR constraints](https://www.hl7.org/fhir/narrative.html#Narrative).
>
> Note 2. The [IHE Interactive Multimedia Report (IMR) Profile](https://profiles.ihe.net/RAD/IMR/) also constrains the content of the diagnostic report.

- Sections shall be defined using \<div\> tags.

- Each \<div\> tag shall have an ‘id’ attribute with a unique value
  assigned to the section.

- Each \<div\> tag shall have a ‘class’ attribute with a code drawn from
  Table 6.7.3.11-1, and formatted as \<coding system\>\|\<code value\>.
  This class code facilitates extraction of section text by report
  consumers.

- Each \<div\> section shall contain a human readable title reflecting
  the code meaning for the section. The title may be localized and/or
  translated. The title may be enclosed in a header tag.

- Each \<div\> section may contain HTML 4.0 Text, List or Table elements
  to organize content within the section

- Each \<div\> section may contain the ‘narrativeLink’ or ‘originalText’
  extension to link between data and narrative text. See
  https://hl7.org/fhir/R5/narrative.html#linking for details and an
  example.

See Figure 6.7.3.11-1 for an example of the use of \<div\> tags that
shows two sections, one for Finding and one for Impression. The Finding
section uses simple paragraph tags \<p\> to separate multiple contents.
The Impression section uses an unordered list. This is not an example of
a full report.

``` xhtml
"text" : {
"status" : "generated",
"div" : "\<div xmlns=\\http://www.w3.org/1999/xhtml\\\>

\<div id=\\111\\ class=\\http://loinc.org\|59776-5\\\>
\<h2\>Findings:\</h2\>
The imaged portion of a thyroid gland is unremarkable. Prominent or
mildly enlarged mediastinal and bilateral hilar lymph nodes measure up
to 1.2 x 0.8 cm in the right paratracheal station (2:12) , 2.3 x 1.4
cm in the subcarinal station (2:18), and 1.4 x 0.9 cm in the right
hilar stations (2:16). No significant axillary lymphadenopathy is
detected. The esophagus is unremarkable. The thoracic aorta is normal
in caliber with a typical 3 vessel takeoff from the arch. The
pulmonary arterial trunk is normal in caliber. The heart is normal in
size without pericardial effusion.
\<p/\>
Within the pulmonary parenchyma, there is diffuse peribronchovascular
nodular and ground-glass opacities becoming confluent in the right
middle (601:52) and left upper (601:65) and lower lobes (601:72)
consistent with multifocal pneumonia. There is a small left and trace
right pleural effusion. No pneumothorax is present. There are no
suspicious masses or pleural abnormalities.
\<p/\>

…

\</div\>
\<div id=\\222\\ class=\\http://loinc.org\|19005-8\\\>
\<h2\>Impression:\</h2\>
\<ul\>
\<li\>Multifocal pneumonia involving the right middle, left upper and
left lower lobes with small left and trace right pleural
effusions.\</li\>
\<li\>Central mediastinal lymphadenopathy is likely reactive.\</li\>
\</ul\>
\</div\>
\</div\>"
},
```

**Figure 6.7.3.11-1: \<div\> Section Example**

Per FHIR guidance, all coded content of the diagnostic report that is
relevant to a human reader should be present in the .text rendering.

The .text may also contain additional information which is not yet
modelled in the coded form of the report. Some practices include links
or references at the bottom of the report to educational material that
may be helpful to the patient and/or referring physician to understand
the impressions and/or recommendations.

**Table 6.7.3.11-1: Section Codes**

<table>
<colgroup>
<col style="width: 12%" />
<col style="width: 11%" />
<col style="width: 21%" />
<col style="width: 54%" />
</colgroup>
<thead>
<tr>
<th style="text-align: center;"><blockquote>
<p><strong>Code Value</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Coding System</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Code Meaning</strong></p>
</blockquote></th>
<th style="text-align: center;"><blockquote>
<p><strong>Notes</strong></p>
</blockquote></th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align: center;">55115-0</td>
<td style="text-align: center;">LN</td>
<td>Order</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">11329-0</td>
<td style="text-align: center;">LN</td>
<td>History</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">55111-9</td>
<td style="text-align: center;">LN</td>
<td>Procedure</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">18834-2</td>
<td style="text-align: center;">LN</td>
<td>Comparison</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">59776-5</td>
<td style="text-align: center;">LN</td>
<td>Findings</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">19005-8</td>
<td style="text-align: center;">LN</td>
<td>Impression</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">18783-1</td>
<td style="text-align: center;">LN</td>
<td>Recommendation</td>
<td></td>
</tr>
<tr>
<td style="text-align: center;">73568-8</td>
<td style="text-align: center;">LN</td>
<td>Communication</td>
<td>This code is defined as communication of critical findings. A more
general code may be needed since some communications do not involve
critical findings.</td>
</tr>
</tbody>
</table>

##### 6.7.3.11.1 Presented Form

To supplement the DiagnosticReport.text described in Section 6.7.3.11, additional renderings of the report in other formats such as PDF, HTML,
or RTF, may be included as Attachments under <u>.presentedForm</u>. The
<u>.presentedForm.contentType</u> shall contain a MIME code indicating
the format of the content.

Since additional renderings are optional, DiagnosticReport consumers may
wish to refer to the `.text` rendering first. If present, renderings in
`.presentedForm` are typically targeted at the human readers (physicians,
patients), and the Report Creator may generate and include them to
address some of the different roles and goals described in RAD TF-1:
56.4.2.3 Use Case \#3: Report Presentation. A `.presentedForm` may also be
encoded in HTML, which may permit more sophisticated renderings than
what is in `.text`, which is more constrained by its XHTML content type.

The additional renderings may contain graphical embellishments and/or
improved formatting for better readability, but should not introduce
clinical semantic content that is not present in the .text rendering.

It is recommended that the `Attachment.title` for each presented form
attachment be populated to facilitate the recipient being able to
distinguish between multiple presented forms and select an appropriate
one. Attachment.language may also help labelling and selecting an appropriate form.

In addition to the rendered report in .text, and the presented form in
.presentedForm, the Report Creator may choose to reference Composition
resources in <u>DiagnosticReport.composition</u> to provide additional
arrangements and renderings of the imaging report content. See RAD TF-1:
56.4.1.4 for further discussion of Composition.

##### 6.7.3.11.2 Resources.text

Every FHIR Resource, being a child of the DomainResource, includes an
optional .text attribute which, if present, contains a text summary of
that resource instance for human interpretation. In the context of the
imaging diagnostic report, these can be useful components for the
construction of the human-readable form of the entire report.

Each ImagingStudy resource referenced in DiagnosticReport.comparison
could have a one-line description of the study in ImagingStudy.text.
Each Observation resource referenced in DiagnosticReport.results could
have a brief text rendering of the observation in Observation.text.

As noted above, many of these pieces of narrative text are good
candidates to be generated automatically from the coded content of the
resource itself. Some report consumer applications will sometimes find
the .text attributes a useful source of text for certain purposes, such
as presenting a specific component of the report, or populating part of
an HL7 V2 message segment.

The .text.status is required to be present and contains codes that
describe the extent to which the semantic content of .text covers or
exceeds the coded content of the resource. A value of “additional” indicates that the narrative may contain additional information not found in the structured data. See
<https://www.hl7.org/fhir/R5/valueset-narrative-status.html>

For resources, such as Patient, that are used widely beyond the scope of
the diagnostic report, it the content of .text may or may not be well
suited to direct copying or concatenation without some processing.

TODO Add x.12 for Addendum or fix numbering

#### 6.7.3.13 Bundle Resource Usage

The DiagnosticReport resource, like most FHIR resources, encodes
references to other associated resources. Handling collections of
related FHIR resources is typically done with the Bundle resource using one
of several bundle types and handling patterns.

Resources referenced from the DiagnosticReport fall into one of several categories:

- Fundamental Resources came into existence to capture information originated during the reporting process. This includes resources such as Observations, ImagingSelections, BodyStructures, and the DiagnosticReport itself. This may also include presentedForm Attachments, proposed ServiceRequests and new Communication resources. At the time of reporting, these resources do not exist anywhere else, and the Report Creator is the initial source-of-truth for this information but might not persist them internally for a significant amount of time, making it important to convey them in full fidelity when first stored. A subsequent system acting as a repository will become the persistent source-of-truth. In later transfers from the repository to other systems, these resources typically represent the key information the receiving system might not otherwise have access to.
- Context Resources represent information that provides clinical context for the report. This includes resources such as the Patient, ServiceRequest, Procedure, and ImagingStudy being reported on in the DiagnosticReport, the prior DiagnosticReport, Observation, BodyStructure, and ImagingSelection resources incorporated as comparison, as well as AllergyIntolerance, and Condition resources. These resources typically exist prior to the reporting process. The source-of-truth for these resources are infrastructure systems such as the EMR or PACS, not the reporting system. The copies of these resources in the Bundle represent a snapshot of the context as known to the imaging clinician at the time the report was created and as such these copies can be important to persist but they are not necessarily authoritative. The fidelity, detail, and completeness with which they are included in the bundle should be appropriate to that purpose.
- Identity Resources establish the identity of entities that are related to the diagnostic report but do not typically contain information that informs the clinical content of the report. This includes resources such as Practitioner or PractitionerRole (for the ordering or reading physician), Encounter (during which the imaging was ordered and/or performed), and Organization (associated with the order, the imaging, or the reporting). These resources are typically originated and managed elsewhere and the detail of the copies in the bundle are mostly needed to correctly establish the identity of the corresponding entity.

As shown in the RAD-141 (Store Multimedia Report) transaction, when the
report is initially created and stored, a transaction bundle
(Bundle.type=transaction) is used to POST the newly created Fundamental resources
(DiagnosticReport, ImagingSelection, etc) as an integral set to be
processed together and created on the server.

When Context Resources or Identity Resources have been “backfilled” by
the Report Creator. In such cases, they may be included in the
transaction bundle to be created conditionally as indicated by the
Bundle.entry.request.ifNoneExist element.

When creating a bundle, an implementation might also take into consideration the types of resources supported by the recipient system. If that system does not support some of the included resources, encoding them inline in the resource that references them might facilitate more complete storage.

As shown in the RAD-143 (Find Multimedia Report) transaction, when
querying for a report, a searchset bundle (Bundle.type=searchset) is
returned from the query. By default, the bundle contains matching
DiagnosticReport resources and no referenced resources. The \_include
and \_revinclude parameters can be used to have the searchset bundle in
the response also contain other referenced resources. (See
<https://hl7.org/fhir/search.html#include>).

Although out of scope for this profile, a future Export Imaging
Diagnostic Report transaction may be created to handle the need to send
DiagnosticReport resources to systems that will not necessarily have
access to all the resources referenced in the DiagnosticReport (e.g.,
because the recipient is outside the IT boundary of the sender). That
transaction will describe a push transaction that includes a “full set”
of referenced resources in the message bundle.

See RAD TF-2:4.Y1 Store Imaging Diagnostic Report for further discussion of the formation of bundles containing an imaging DiagnosticReport and associated resources.

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

  - Explanation of the Lung-RADS CATEGORIES CAN BE FOUND AT: HTTP://healthcare.partners.org/lung/rads.pdf

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

Table B.3-1 reflects the pattern defined in 6.7.3.6 of post-coordinating measured properties and assessed characteristics with the anatomic, pathologic, or physical entity observed. This is intended to allow implementations to flexibly handle new observations by logical extension without having to obtain new pre-coordinated codes. This also allows consumers of the data (for queries, or trigger logic) to handle similar observations using elemental or Boolean expressions instead of maintaining very long lists of related pre-coordinated codes and periodically being presented with new pre-coordinated codes they do not understand and thus cannot handle.

Observations that are simple statements of a single property or characteristic can be readily represented in a single Observation resource. Others that are more complex, requiring multiple Observation resources related using one of the patterns described in IHE RAD TF-3:6.7.3.6.3. Several rows of the table (e.g. the description of a splenic hypodensity) demonstrate suggested patterns for organizing observation text statements (e.g. as might be dictated by a radiologist) that include multiple properties or characteristics into a collection of related Observation resources.  

PTODO Convert or Transcribe the table into markdown

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

TODO LATER if time permits, Summarize content
This IG (now in version 9) profiles the use of a DiagnosticReport Resource for various reports including imaging/radiology. 
•	Avoid being too conflicting. (Simplification and subsetting is OK)
•	Note that SR is about captured data/information NOT about DiagnosticReport encoding
•	SR data is inherently more “verbose” which can be a concern if “imported” into the Report. 
•	Need to be able to refer to the “source” SR that provided an Observation in DR.

## C.6 HL7 Europe Imaging Report IG (2025-2026)

<https://build.fhir.org/ig/hl7-eu/imaging-r5/en/index.html>

This IG (now in version 9) profiles the use of a DiagnosticReport Resource for various reports including imaging/radiology. Based on the radiology example in the IG:

TODO LATER if time permits, Summarize content
