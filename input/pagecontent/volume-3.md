## 6.7 Imaging Diagnostic Report Content

### 6.7.1 Scope

This IHE Radiology Content Specification defines standard encodings for diagnostic reports on imaging procedures. It is specifically intended to cover the output of reporting systems following the interpretation performed by an imaging clinician such as a radiologist.

Refer to [IHE RAD TF-1:56.4.1.2](volume-1.html#x412-purpose-and-structure) for real world expectations in the various report sections.

Pathology and Interventional procedures are not specifically addressed.

### 6.7.2 Referenced Standards

- FHIR-R4: [HL7 FHIR Release 4.0](http://www.hl7.org/FHIR/R4)

- FHIR-R5: [HL7 FHIR Release 5.0](http://www.hl7.org/FHIR/R5)

- FHIR R6

- FHIR ImagingSelection: ImagingSelection

- LATER – Reference other FHIR Resources

#### 6.7.2.1 FHIR Versions and Extensions

Implementations shall support the use of FHIR R4 resources.

Implementations may also be configurable to support the use of FHIR R5 and/or FHIR R6 resources.

This profile depends on a number of extensions introduced in FHIR R5 and FHIR R6 to address key details for coded imaging diagnostic reports.

When encoding or parsing FHIR R4 resources, implementations shall support the additional elements specified in this Profile as extensions in the manner described here: <https://build.fhir.org/versions.html#extensions>

Implementers may find one or more “FHIR extension packs” available to
facilitate the support of elements introduced in FHIR R5 (and/or
eventually FHIR R6).

### 6.7.3 Imaging Diagnostic Report Encodings

Creators of imaging diagnostic reports shall be capable of encoding them
as described in this section.

The encoding makes use of the following FHIR Resources:

- Patient

- ServiceRequest

- Encounter

- Procedure

- ImagingStudy

- DiagnosticReport

- Observation

- Condition

- Communication

- Provenance

- Practitioner

The Report Creator is expected to populate much of the contextual metadata (e.g., patient demographics, patient identifiers and issuers, study accession number, etc.) in the imaging diagnostic report resources based on values in the medical imaging data being processed, and/or the reporting worklist entry.

> Note: This profile changes the cardinality from 0.. to 1.. for some FHIR resource attributes. This is done when absence of the attribute would break interoperability. It is not done to enforce the presence of information that is simply desirable or convenient.

This section describes requirements that are also represented in a companion [IDR FHIR IG](https://build.fhir.org/ig/IHE/RAD.IDR/branches/public-comment/index.html) (Implementation Guide). Some of these requirements involve extensions to the FHIR Resources.

TODO: Since there is the risk that reiterated/duplicated content could diverge, any remaining content here will likely be reframed as informative and moved to Concepts, to an Informative Annex, to an IG Resource page, or dropped if all the discussion can be conveniently captured in the IG.

In IMR, there is no Vol 3 Content Definition; the IMR Transactions
reference directly to Profiled Resource pages in the IG. Finding a way
to splice FHIR IGs into Content Definitions might be another option.
Discuss with Lynn/ITI.

This profile adds extension attributes (marked as "\<new\>") to several
existing resources.

The following text describes how the necessary structure and content of
an imaging diagnostic report, as described in IHE RAD TF-1:56.4.1.2,
would be encoded in FHIR.

#### 6.7.3.0 Diagnostic Report

Each instance of an imaging diagnostic report shall be encoded as a
single <u>DiagnosticReport</u> resource. The following document sections
here describe how various report sections and details are addressed and
encoded within the DiagnosticReport and other referenced resources.

Note: A subsequent addendum would result in an additional
DiagnosticReport instance, however that workflow is not yet fully
documented in this Profile.

This content definition does not presume that all semantics in the
report that are potentially codeable are actually coded in this
resource. Profiles will likely identify some specific details which are
required to be coded to conform to that profile; however, systems
processing diagnostic reports should generally assume that there may be
details in the narrative which are not also encoded. See also RAD TF-1:
56.4.1.6 Narrative vs Encoded Content and Structure.

**Status** shall be encoded in <u>DiagnosticReport.status</u>.
Specifically, imaging reports in this profile shall use the preliminary
and final states when their conventional meaning applies. The registered
state may be used while the report is being composed during the
interpretation process. For addenda, a status of amended shall be used.
.

Note: Other FHIR status values such as modified, corrected, or appended
are not profiled here. They may be addressed in a reporting workflow
profile.

**Accession Number** shall be encoded as an item in
<u>DiagnosticReport.identifier</u>, if known. *TODO Update to match
recent ImagingStudy pattern.*

Note: This accession number is expected to match those in the
ImagingStudy and ServiceRequest. In some urgent or encounter-based
scenarios, a ServiceRequest might not exist at the time of reporting.

**ImagingStudy** for the study being read shall be referenced from
<u>DiagnosticReport.study</u> unless no such ImagingStudy resource
exists.

Note: It is expected that there will always be a relevant ImagingStudy
resource, created by another system more integrated with image
management, such as the PACS, VNA, or the EMR in response to messaging
from the PACS or VNA. Report Creators are not the Source of Truth for
imaging study management. In the absence of an ImagingStudy, the
ServiceRequest and Accession Number will serve to provide basic linkages
between the images and the report.

<u>DiagnosticReport.category</u> shall record the diagnostic service
that performed the study. This may be copied from the originating
<u>ServiceRequest.category</u>. Potential codes may be drawn from DICOM
[PS3.16 CID
7030](https://dicom.nema.org/medical/dicom/current/output/html/part16.html#sect_CID_7030)
"Institutional Department/Unit/Service" and the HL7 terminology code set
referenced in FHIR. It is recommended that this attribute focus on the
service/department, not the specific modality since that is reflected in
DiagnosticReport.code.

<u>DiagnosticReport.code</u> shall record the name/title/type of the
report. Imaging report titles are frequently site specific, but commonly
communicate the modality, body part, and/or clinical focus of the
performed imaging procedure.

Note: Since report titles often mirror the name of the ordered imaging
procedure, the codes from the RSNA Radlex Playbook provide a useful
example codeset. (Visit https:\\search.loinc.org and use the search term
“playbook”)

<u>DiagnosticReport.resultsInterpreter</u> shall reference a
<u>Practitioner</u> resource for the primary result interpreter, aka
Reported By.

- Practitioner resources for additional report authors may also be
  referenced from DiagnosticReport.resultsInterpreter using
  PractitionerRole resources to record residents, collaborating
  clinicians, and similar use cases and the role they played.

- DiagnosticReport.performer references the organization or diagnostic
  service responsible for the report.

<u>DiagnosticReport.text</u> contains the <u>fully rendered
human-readable form of the diagnostic report as described in
6.7.3.11.</u>

> <u>DiagnosticReport.note</u>: Statements about significant, unexpected
> or unreliable result values appear as needed in the Procedure,
> Findings, or Impressions sections, not in .note. Other potential
> imaging usage was not identified.
>
> <u>DiagnosticReport.media</u>: The interpreted study is referenced by
> DiagnosticReport.study. Images are accessible as RESTful resources via
> DICOMweb (which includes parameterized renderings using the /rendered
> DICOMweb endpoint) and selected parts or points of those images are
> encoded as ImagingSelection. Comparison studies are referenced from
> DiagnosticReport.comparison. Graphical elements such as charts and
> icons that appear in the presentedForm of the report may go in
> DiagnosticReport.media if they cannot be included inline in the format
> used (PDF, etc.).

#### 6.7.3.1 Patient

**Patient** information encoding shall reference a <u>Patient</u>
resource in <u>DiagnosticReport.subject</u>. This profile places no
constraints on the enterprise Patient resources that the
DiagnosticReport is permitted to reference.

Note: Report Creators do not create patient resources. It is expected
that there will always be a relevant Patient resource, even if only a
John Doe, created by another system more integrated with patient
management. Imaging systems are not the Source of Truth for patient
demographics and management; directly creating/modifying patient
resources would be disruptive. If a patient reference is a pre-requisite
to publish an imaging DiagnosticReport resource, the local
infrastructure will arrange for appropriate Patient resources for the
Report Creator to use.

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

**Order** information encoding shall reference <u>ServiceRequest</u> resources in <u>DiagnosticReport.basedOn</u>.

> Note 1. The DiagnosticReport.basedOn attributes are always intended to reference the request being fulfilled by the current resource; i.e. basedOn references the authorization not the input data. So DiagnosticReport.basedOn references the imaging ServiceRequest, not the ImagingStudy.

> Note 2. Report Creators do not create Order resources. It is expected that there will usually be a relevant ServiceRequest resource which may have been created by another system more integrated with order management. The hospital may be originating orders as ServiceRequest resources, or may be creating them based on HL7 v2 ORM or OMG messages. In either case, reporting systems are not the Source of Truth for order management; directly creating/modifying order resources would be disruptive.

> Note 3. In the large majority of cases, one report will correspond to one order (ServiceRequest) comprised of one study. Some reports do cover multiple orders, e.g., "group cases" where a single instance of a single report satisfies multiple ServiceRequests, so systems should be prepared to handle multiple ServiceRequests.

- For emergency cases, DiagnosticReport.basedOn may be empty if an order
  has not yet been backfilled.

- For "group cases" DiagnosticReport.basedOn may contain multiple
  references, however for billing and other workflow reasons some sites
  will prefer to create multiple DiagnosticReports, each referencing a
  single ServiceRequest, even if the narrative content of the reports
  are largely the same.

> Note: Some workflows may involve the creation of local accession numbers in the imaging workflow which are later replaced by accession numbers assigned in enterprise systems. When such replacement takes place, it is important to consider the potential presence of the local accession number in the narrative text, or in rendered PDF documents, as well as in resource attributes.

- **Exam Type** shall be encoded in <u>ServiceRequest.code</u> using an
  "orderable" code. Some sites may use LOINC Playbook codes, or some
  other standard. Others will invent local code sets.

- **Indications** shall be encoded with references to resources in
  <u>ServiceRequest.reason</u>. These may include <u>Observation,</u>
  <u>Condition, and potentially prior Procedure instances, Medications,
  or Family History.</u> Indications are increasingly provided in the
  form of ICD-10 codes which may appear in the v2 order messages or
  originating ServiceRequest resource.

> Note: A Condition referenced as an indication might have a .verificationStatus of Provisional or Unconfirmed.

- **Clinical Questions** from the referring physician to the imaging
  clinician shall be encoded in a ServiceRequest.reason item using the
  .concept.text element. The presence of clinical questions and other
  reasons for exam are intended to trigger their presentation to the
  imaging clinician during protocoling and reporting, and result in text
  in the body of the diagnostic report that specifically addresses the
  question(s).

> Note: In lab orders, ServiceRequest.supportingInfo is used for "ask at order entry questions" (aka AOEs), but those are prospective answers from the requester (referring physician) at order time to questions asked by the performer (lab clinician), rather than questions asked by the requester (referring) and answered by the performer (imaging clinician) at reporting time.

- <u>ServiceRequest.encounter</u>, per FHIR, records the "health care
  event when the test ordered". The encounter where the imaging was
  performed is recorded in <u>Procedure.encounter</u>. In the case of
  encounter-based imaging, the two encounters might be the same if a
  corresponding ServiceRequest is created. Whether a ServiceRequest is
  created for encounter-based imaging and if it is, how it is populated,
  are left for future workflow profiling.

- <u>ServiceRequest.orderDetail</u> may be used to specify details about
  how the ordered procedure is to be performed, such as imaging
  parameters to use or views to be obtained. Typically, however, such
  details are left to the imaging department.

Narrative text in the order section of the diagnostic report is a good
candidate for auto-generation based on a subset of the coded content in
the ServiceRequest resource. The ordered exam in ServiceRequest.code is
usually rendered as a single line, perhaps based on the display value of
the CodeableConcept. The Accession \# and the ordering physician may
also be rendered into the top of the report.

- Each referenced ServiceRequest resource has a ServiceRequest.text
  attribute which can contain a one-line description of the order.

> Note 1. The Indications and Clinical Questions, while captured at the time of the order and conveyed to the Report Creator in the referenced ServiceRequest, are typically rendered into the narrative in the History section of the report.

> Note 2. The details in the Procedure section are pulled from the imaging Procedure Resource (which is what was performed based on patient needs) rather than the imaging ServiceRequest (which is what was ordered and sometimes driven by billing requirements) since the two do not always exactly match. Sometimes there is an effort to update the order to match the actual procedure; ideally if that does happen, it is best to do it before image interpretation to avoid the possibility that the ServiceRequest resource bundled with the DiagnosticReport is out of date with respect to the master copy of the reference. Sometimes the original order is cancelled and replaced by a new one in which case the Order reference/link is broken (but it is clear that something has changed). Resolving such issues is a workflow topic that is out of scope for this profile.

##### 6.7.3.2.1 Examples for Order

The following bullets provide a sample of content typical to this
section of the report.

- CT Sinus w/o Contrast

- MRI Brain with and without Contrast

- MRI Left Shoulder

- MG of the Screening (Bilateral) *\<sic; likely "MODALITY of the BODY
  PART" template\>*

- PET/CT of the Skull Base To Mid-Thigh

- US Guided Left Knee Injection

- MRI Right Hip Arthrogram Including Cartigram Study

- XR Chest 1 View

#### 6.7.3.3 History

**History** shall reference resource items in \<new\>
<u>DiagnosticReport.patientHistory</u>.

Notes: 1. While the specification requires the ability to include coded
history information, it does not specify which or how much history
information is encoded. Reports do not include the entire medical
history available but rather include history details determined to be
relevant to the study, usually by the imaging clinician,. Also, the
details are coded as known to the imaging clinician at the time of
interpretation; different information may be available when any given
reader reads the report, but the report will reflect what was known at
interpretation.

2\. Often this history will include key details that also serve as the
indication(s) for the imaging study. The information coded in the
ServiceRequest.reason (See 6.7.3.2 Order) the definitive record in the
indications, even if they are also duplicated here.

- <u>Condition</u> shall be used to encode past diagnoses.

- <u>Observation</u> shall be used to record relevant observations from
  the referring physician, nursing notes, past care, and past
  diagnostics such as anatomic histopathology or clinical laboratory
  result values.

- <u>Procedure</u> shall be used to record past procedures performed on
  the patient such as knee surgery, an appendectomy, or spinal fusion.

- <u>FamilyMemberHistory</u> shall be used to record a person's
  relationship to the patient, along with the persons demographics,
  known conditions and procedures.

Narrative text in the history section of the diagnostic report is a good
candidate for auto-generation based on the coded content in the
referenced resources, however the process of selecting the relevant
subset will likely require input from the imaging clinician or a
sophisticated algorithm.

- This narrative is where indications for the exam (if any) and clinical
  questions from the referring are included. Information for those two
  items will be accessed via the imaging ServiceRequest referenced in
  the .basedOn attribute rather than this .history attribute.

- Each referenced Condition, Observation, Procedure, and
  FamilyMemberHistory has a .text attribute which can contain a brief
  description which may be assembled into the narrative text for the
  History section.

- See also the discussion of .text usage in Section 6.7.3.11.1
  Resources.text.

##### 6.7.3.3.1 Examples for History

The following bullets provide a sample of content typical to this
section of the report.

- Memory loss, 2 weeks history of dysbalance and lethargy

- Right arm weakness; Difficulty expressing thoughts in writing
  beginning about 4-5 months ago.

- Work related injury on September 21, 2015, assess for traumatic tear
  left rotator cuff with superior shoulder pain and weakness.

- 24M with stent placement in the left main bronchus presents with right
  sided chest pain since 9am

- A 52-year-old with hemoptysis. Right middle and lower lung zone
  consolidation. Please evaluate.

- Spiculated right upper lobe lesion. The patient declined biopsy for
  follow-up. If increase in size would consent to biopsy.

- Shortness of breath, pulmonary opacity on CXR

- Left knee pain. Semimembranosus bursitis.

- Follow-up pleural effusion

- Sinusitis.

- Routine. *\<for an MG Screening Study; perhaps not an example of good
  practice\>*

#### 6.7.3.4 Procedure

**Procedure** and Materials information shall be encoded in Procedure
resource(s) referenced in a \<new\> <u>DiagnosticReport.procedure</u>
attribute.

Notes: The <u>DiagnosticReport.procedure</u> attribute mirrors the
.specimen attribute to describe how the data being reported was obtained
and prepared.

- <u>Procedure.complication</u> may reference Condition(s) caused by the
  procedure, including adverse events and reactions

Note: Events during the imaging Procedure may also result in
AllergyIntolerance and/or AdverseEvent resources being added to the
patient record, however that is not driven by the diagnostic report and
is outside the scope of this profile.

- <u>Procedure.note</u> may reference Annotations which the Technologist
  might create to record comments such as patient motion, or other
  details. This information is presented to the imaging clinician, but
  does not directly appear in the report unless dictated/selected by the
  imaging clinician.

Procedure resources describe a procedure that was performed. They
provide details about technique and execution using clinical imaging
language and codes and are created using information from the modality.
In contrast, the ServiceRequest resource describes the order using
orderable language and codes, which are typically more general and
billing-oriented, and is created using information from the order
placer. Further, the ImagingStudy resource describes and provides links
for the actual **Study** data produced by the procedure(s), and is
referenced from <u>DiagnosticReport.study</u>.

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
interpretation. The text may be available in <u>Procedure.text</u>,
which in turn would be based on a subset of the coded content in the
referenced resource(s), usually the modality, date, procedure type, and
details such as technique, pulse sequences, contrast usage, radiation
dose, and generated images/views. The content of the Procedure resource
likely originated from the image header, MPPS, RDSR, and performed
procedure protocols.

- Recent FHIR IG work allows the Dose Reporter to provide the Report
  Creator with a formatted, locally-conformant block of text that
  assembles the correct subset of dose details for the specific
  procedure type for insertion into the report (typically to comply with
  local regulations).

During the imaging procedure, Observations might be created to capture
things like nursing notes or technologist observations. Those would be
associated with the Encounter for the imaging Procedure. Conveying those
to the radiologist as inputs for interpretation is not addressed here
since this profile is about encoding the resulting report. Future work
on reporting workflow and managing inputs to the radiologist could
address this.

##### 6.7.3.4.1 Examples for Procedure

The following bullets provide a sample of content typical to this
section of the report.

- Axial PD FS, coronal PD FS and PD, sagittal T1 and PD FS imaging is
  performed through the left shoulder without contrast.

- Sagittal and axial T1-weighted images, axial FLAIR images, axial
  diffusion weighted sequences, axial T2-weighted images and coronal
  gradient echo sequences of the brain were obtained. Following
  gadolinium administration axial and coronal T1-weighted images were
  obtained.

- Thin slice axial images through the paranasal sinuses were obtained
  and reconstructed in the coronal and sagittal planes.

- After intraarticular injection of diluted gadolinium in saline, axial
  T1 fat-sat, axial PD fat-sat, coronal T1 fat-sat, sagittal T1 fat-sat,
  axial oblique PD fat-sat, and coronal bilateral PD fat-sat images were
  obtained. This was followed by multiple acquisitions in the coronal
  and sagittal plane sequentially carried out with post processing and
  color mapping performed in order to obtain a T2 mapping cartigram
  study.

- Agents: F-18 fluorodeoxyglucose. Dose: 17.2 millicuries IV. Prior to
  the administration of the radiotracer, a fingerstick blood glucose
  level was drawn, measured as 121 mg/dL. CT images for attenuation
  correction and anatomic localization followed by PET images from the
  skull base to the thighs were obtained.

- A PET CT scan was performed from the level of the vertex of the skull
  to the proximal thighs following the administration of 18.6 mCi of FDG
  intravenously.

- CT scan of the abdomen and pelvis was obtained with intravenous and
  without enteric contrast material. Coronal and sagittal reformats were
  provided. Dose reduction technique: The CT scan was performed using
  appropriate/available dose optimization/reduction techniques.

- CT angiographic examinations of the head and neck were obtained
  utilizing 75 cc Isovue 370 intravenous contrast. Multiplanar MIP and
  3D reformatted images were also created and reviewed. Stenosis
  measurements were performed based on NASCET criteria. CT scan
  performed using appropriate/available dose optimization/reduction
  techniques.

- Head CT without intravenous contrast. Axial images through the brain
  were acquired from skull base to the vertex with 5 mm slice thickness.
  Images were reviewed in brain, subdural and bone window settings.

- Single AP view of the chest

#### 6.7.3.5 Comparison

**Comparison** studies shall be encoded in <u>ImagingStudy</u> resources
referenced from a \<new\> <u>DiagnosticReport.comparison</u> attribute.

This serves as the "library" of studies the imaging clinician took into
consideration. Actual comparison observations, both new comparative
statements and cited old statements from the prior study, are encoded
below with the findings.

Narrative text in the comparison section of the diagnostic report is a
good candidate for auto-generation based on enumerating the coded
content in the referenced resources, usually the modality, date, and
procedure type.

- Each referenced ImagingStudy resource has an <u>ImagingStudy.text</u>
  attribute which can contain a one-line description of the study.

##### 6.7.3.5.1 Examples for Comparison

The following bullets provide a sample of content typical to this
section of the report.

- CXR from mm/dd/yyyy, CT Chest from mm/dd/yyyy (two weeks prior)

- CT-PE of July 18, 2012 and limited CT chest from the declined biopsy
  of September 10, 2012.

- Left knee ultrasound DATE. Left knee radiographs DATE.

- Multiple, last dated August 8, 2023.

- No previous exams are available for comparison.

- None available.

- None.

#### 6.7.3.6 Findings

Implementations are permitted to create reports where none of the
findings in the narrative are encoded. **Findings** that are encoded
shall use <u>Observation</u> resources referenced from
<u>DiagnosticReport.result</u>. Implementations shall be capable of
creating at least one Finding encoded as an Observation and referencing
it from DiagnosticReport.result.

The following metadata shall be populated in the Observation (despite
being referenced, or implicit, in the DiagnosticReport). One reason for
this is to facilitate usage of the Observation resources beyond the
direct context of the parent DiagnosticReport. For example, to perform
Observation-level queries.

- <u>Observation.subject</u> shall reference the imaged <u>Patient</u>.

- <u>Observation.basedOn</u> shall reference the imaging
  <u>ServiceRequest</u>

- <u>Observation.encounter</u>, if present, shall reference the imaging
  procedure <u>Encounter</u>.

- <u>Observation.partOf</u> shall reference the interpreted
  <u>ImagingStudy</u>

- <u>Observation.category</u> shall use the value "imaging"

- <u>Observation.status</u> shall use "final" for observations in the
  final report.

The scope and complexity of report findings can vary significantly.

NOTE TO IMPLEMENTERS: Further profiling of the Findings section is
deferred to future work.

As a strategic scoping decision of this profile, the use cases focus on
subsequent usage of imaging reports by referring physicians and
patients, and clinical pathway automation such as recommendation
follow-up, critical finding tracking, and clinical decision support for
referring physicians. Those use cases depend primarily on the Impression
and Recommendation sections which are the primary interest for referring
clinicians. The imaging clinician has summarized all the most important
clinical information in the Impression section where all conclusions and
actionable findings should be represented.

Addressing the enormous range and variety of imaging findings will be a
significant undertaking. One significant avenue for bringing structure
to the problem will be exploring the use of CDE Sets, which are defined
groups of common data elements (and values) for describing specific
imaging findings.

Future work on Finding encoding will consider use cases centered on the
interpretation process that leads to the report. This may bring together
AI result review and transcoding, the IRA profile, selecting findings
from prior reports for inclusion in the current report, using LLM
technologies to compose and process blocks of text, and other automation
functions for the imaging clinician. Such use cases will be helpful
concrete drivers in resolving the many expected complexities. Such work
will likely manifest in the form of a Findings Option to this Profile to
avoid disrupting any existing implementations and data from this Trial
Implementation draft of the IDR Profile.

Findings that the radiologist chose to include in the report, but which
originated from AI models, will likely include related details in the
metadata and/or provenance of that finding. Such details will be
accessible to recipients of the report. Conversely, details about the
reporting process, such as what AI models were or were not run, and what
findings were not included in the report, may be documented by
associated systems in relevant logs, but will not appear in directly in
the report itself unless the radiologist chooses to include such
details, for example by describing that in the Procedure/Technique
section.

##### 6.7.3.6.1 Examples for Findings

The following bullets provide a sample of content typical to this
section of the report.

- Finding set (MRI Cervical Spine)

  - The cervical cord appears normal in its size and signal
    characteristics.

  - The C2-3 and C3-4 discs are degenerated.

  - There is some mild bulging of the C3-4 disc. Neither level
    demonstrates central or neural foraminal narrowing.

  - There has been prior fusion from C4 through C7 in good alignment and
    position. An anterior screw and plate device is present.

  - At C4-5 and C5-6 there is no recurrent central or neural foraminal
    narrowing.

  - At C6-7 there is mild bilateral bony neural foraminal narrowing
    without central canal compromise.

  - The C7-T1 level appears unremarkable.

- Finding Set (PET-CT)

  - A right lower breast mass is seen measuring approximately 6.2 x 1.6
    cm in transverse dimension with SUV max measuring up to 4.2. The
    patient has had prior bilateral axillary node dissections. There is
    no current adenopathy in the axilla bilaterally by size criteria or
    metabolic activity. There is no adenopathy in the mediastinum or
    hilum similarly.

  - No pulmonary nodules or masses are identified. However, moderate
    right and small left perfusions are seen with low-level metabolism,
    SUV max measuring up to 3.0.

  - Diffuse thoracic esophageal hypermetabolism is noted.

- There is a non-specific subpleural nodule in the right lower lobe
  which measures 2mm in diameter (Se 3, Im 72).

- A smaller enhancing extra-axial mass more suggestive of atypical
  meningioma is seen overlying the right mid temporal lobe measuring 1.3
  x 0.6 CM. (Axial series 12 image 26).

- There is no significant end vessel ischemic small vessel disease.

- There is no acute infarct seen. No intracranial hemorrhage is
  recognized.

- MUSCLES AND TENDONS: The gluteal tendons are intact. The hamstring
  tendon origins are intact.

- No compressive mass within the carpal tunnel.

- Moderate extensor carpi ulnaris tendinosis. There is fluid reflective
  of tenosynovitis in the second and third extensor compartments as well
  along the region of the extensor digitorum tendons.

- Moderate amount of fluid in the radiocarpal and midcarpal wrist
  compartments.

- Mild dorsal angulation of the distal radius reflective of the
  fracture.

- Evidence of edema in the central and volar aspect of the ligament.
  Edema extends into the volar radiocarpal ligaments. The pattern is
  reflective of a volar injury and partial-thickness tear in this
  region. There is no complete tear. There is no DISI deformity.

#### 6.7.3.7 Impression

**Impressions** shall be encoded in <u>Condition</u> and/or
<u>Observation</u> resources referenced from the
<u>DiagnosticReport.conclusionCode</u> attribute. Implementations shall
be able to create at least one Condition and reference it in the
DiagnosticReport.conclusionCode.

Notes: 1. In the presentedForm (PDF, HTML, etc.), the section titled
impression frequently contains not just impressions, but also
recommendations, and communications. This profile provides specific
encodings for recommendations and communications in the next two
sections.

2\. Condition is used here as a proxy for a diagnosis or problem that is
not yet determined, per its FHIR documentation.

The following bullets focus on impression statements as structured coded
data. The Report Creator is responsible for distinguishing and encoding
dictated impressions, recommendations, and communications.

- <u>Condition.category</u> shall use the value
  **diagnostic-report-impression**

- <u>Condition.verificationStatus</u> shall be populated. Typical values
  are **unconfirmed \| provisional \|** **differential** \|
  **confirmed** \| refuted

  - "confirmed" would not be used unless the radiology report is the
    definitive source of such a diagnosis.

  - Per <https://www.hl7.org/fhir/R5/condition.html#9.2.4.5> "refuted"
    is used for subsequent disproof of a previously asserted condition
    so it would not be used unless the condition was previously
    asserted, the radiology report is negative and is definitive for
    such an assertion. Other negative assertions are handled as
    observations.

- <u>Condition.code</u> shall record the condition or "disorder"
  described by the imaging clinician. Codes may be drawn from SNOMED or
  similar coding system.

- <u>Condition.severity</u> shall record the severity of the condition,
  if specified by the imaging clinician.

Note: Severity does not map directly to patient risk. A mild stroke
might present a greater risk than a severe ingrown toenail.

- <u>Condition.stage</u> and its subordinate attributes shall record the
  assessed stage of the condition, if specified by the imaging clinician
  for conditions that have formal (disease-specific) staging concepts.

- <u>Condition.bodyStructure</u> shall record the anatomic structure
  where the condition manifests. The
  BodyStructure.includedStructure.structure may contain codes drawn from
  SNOMED or similar coding system. BodyStructure.laterality shall record
  laterality if the bodyStructure is a paired structure.

Note: When a condition spans multiple structures, .includedStructure may
include multiple items.  
TODO TCQ should we include guidance on when to use fine
grained/pre-coordinated structure codes vs the .qualifier element?

- <u>Condition.likelihood</u> \<new\> shall record the likelihood of the
  condition, if expressed by the imaging clinician. (See Open Issue
  about adoption of a coding system) TODO

Note: "Consistent with" in the narrative form of an impression typically
implies strong imaging support for an existing (tentative) diagnosis in
place beforehand. Most other impressions represent conditions put
forward by the imaging clinician. If the Condition resource for the
existing diagnosis is known, consider referencing that instance and
adding information to Condition.evidence.

- <u>Condition.clinicalStatus</u> is required to be present by the
  Condition resource. It will frequently be "unknown" in diagnostic
  reports, but the other defined values may be used when appropriate.

- <u>Condition.asserter</u> shall be present and reference the imaging
  clinician.

- <u>Condition.evidence</u> may contain a reference to the
  DiagnosticReport and/or references to Observation resources in the
  Findings and/or Impression sections, or references to other
  information elsewhere that contributed to the impression. .

- <u>Condition.actionable</u> \<new\> shall, if present, contain a code
  to indicate the degree to which the Impression finding is actionable.
  Codes may be drawn from the RadLex codes for the ACR Actionable
  Finding Categories described in IHE Results Distribution (RD):

  - (RID49480, RadLex, "Cat 1 Emergent Actionable Finding") defined as
    requiring immediate medical attention within minutes.

  - (RID49481, RadLex, "Cat 2 Urgent Actionable Finding") defined as
    requiring medical attention within hours.

  - (RID49482, RadLex, "Cat 3 Non-critical Actionable Finding") defined
    as requiring medical attention within days to months.

  - (RID50261, RadLex, "Non-actionable") defined as not requiring
    follow-up actions.

Note: The presence of a Recommendation for a given impression is an
implicit indication that it is actionable. Having an explicit code can
help with subsequent tracking and follow-up.

Note: Conversely, actionable findings do not always have a corresponding
Recommendation. For example, an identified pneumothorax is a well-known
entity to the referring clinician with standard actions to address it.
The imaging clinician would be unlikely to re-iterate those actions in
the report.

Note: Category 1 and Category 2 codes constitute "critical findings"
which often result in direct Communications (see Section 6.7.3.9) due to
the clinical urgency.

A .conclusionCode item, being a CodeableReference, may also contain an
individual code instead of a reference when a code exists that
encompasses the conclusion or impression.

An impression drawn from a \*-RADS System, such as BI-RADS, is encoded
as a .conclusionCode item containing the corresponding code. For
example, (397143007, SCT, "Mammography assessment (Category 3) -
Probably benign finding, short interval follow-up").

Note: \*-RADS codes correspond to the result of a composite assessment,
and the conclusion may represent a point on a diagnostic pathway, which
encompasses both a differential diagnosis and protocolized follow-up
actions.

The narrative form of the Impression section is often directly dictated
by the imaging clinician. Tools also exist that generate a draft of the
Impression narrative based on the dictated Findings narrative. If the
Impression narrative were built up from the coded Impression, the
summary in Condition.text of each referenced Condition resource might be
compiled into impression bullets sequenced according to the
Condition.order.

In addition to rendering the Impression narrative as a section in the
full report in the <u>DiagnosticReport.text</u> attribute, the Report
Creator may also render the Impression narrative into
<u>DiagnosticReport.conclusion</u> as a single markdown field. The
Impression narrative may contain dictated text which goes beyond the
semantics captured in the <u>DiagnosticReport.conclusionCode</u>
references.

If/when one of these Conditions is added to the patient Problem List,
either by the referring physician or because the
Condition.verificationStatus is confirmed, that would likely create a
new Condition resource that might point to the Impression Condition
instance as Condition.evidence (or maybe the biopsy result instead).
While the Problem List Condition instance would be updated over time,
for example when the condition is abated, the Impression Condition
persists as a medicolegal snapshot that is an integral component of the
Report. If the Report is exported, that bundle would contain the
Impression Condition at the time of the report, not any "current"
version.

##### 6.7.3.7.1 Examples for Impression

The following bullets provide a sample of content typical to this
section of the report.

In some cases, a set of impressions for a particular type of exam are
provided as a group to get a sense of the ordering and grouping
patterns. Some impression sentences encompass multiple Conditions. Some
impressions are shown broken down into more codable components.

When the imaging clinician has interposed a recommendation amongst the
impressions, it has been highlighted here {<u>underlined between
braces</u>}.

As an exercise to explore the suitability of the specification, a sample
encoding \[shown in square brackets\] is provided for some impressions.
Also, the encodings do not always capture 100% of the intended semantics
and nuances of the radiologist.

- Findings suggesting left peripheral lung base pulmonary infarct.

  - \[Condition.code = (64662007, SCT, "Pulmonary infarct"),
    .bodyStructure.includedStructure.structure = (10024003, SCT,
    "Structure of Lung Base"),
    .bodyStructure.includedStructure.laterality = right,
    .bodyStructure.includedStructure.qualifier *=* (14414005,SCT,
    “Peripheral)*,* .likelihood = may represent\]

- Impression Set (Abdomen US)

  - Fatty infiltration of the liver.

  - Small left pleural effusion.

  - Distended inferior vena cava and hepatic veins, findings consistent
    with congestive heart failure.

    - \[*code distended veins as observations, code CHF as Condition
      with the observations referenced from .evidence, and .likelihood
      is high\]*

- Impression Set (XR Foot, Ankle, Tibia/Fibula, Knee)

  - Acute nondisplaced fractures of the proximal tibia and fibula.

  - Acute fracture of the distal fibular diaphysis.

  - Intact intramedullary nail fixation hardware.

    - *\[TODO Create an <u>observation code of "intact"</u> for
      application to any given anatomy, device, (or
      intervention/modification?) Or should this be coded as a set of
      negations: no loosening, breakage, protrusion or other visible
      complication of the nail fixation hardware?\]*

- Impression Set (MRI Hip)

  - Moderate right hip osteoarthritis, with labral tearing and para
    labral cyst formation.

    - \[Condition.code= (396275006, SCT, "Osteoarthritis"),
      .bodyStructure.includedStructure.structure= (24136001, SCT, "Hip
      joint"), .bodyStructure.includedStructure.laterality=right,
      .severity=moderate\]

    - \[Condition.code=(202336002, SCT, "Acetabular labrum tear"),
      .bodyStructure.includedStructure.structure= (182439007, SCT,
      "Acetabular labrum"),
      .bodyStructure.includedStructure.laterality=right\]

    - \[*Need code for para labral cyst*,
      .bodyStructure.includedStructure.structure= (182439007, SCT,
      "Acetabular labrum"),
      .bodyStructure.includedStructure.laterality=right\]

  - Chronic partial-thickness tears of the gluteus minimus and medius
    with small overlying greater trochanteric bursal fluid.

- Impression Set (CT Neck, Chest, Abdomen/Pelvis)

  - No acute abnormality in the neck, chest, abdomen, or pelvis. No
    pathologically enlarged lymph nodes.

  - Multiple peribronchial bilateral pulmonary nodules, measuring up to
    5 mm in the left lower lobe, likely infectious/inflammatory.

    - *\[… (786838002, SCT, "pulmonary nodule (disorder not finding) …
      how to code size generalization, likely etiology
      (infections/inflammatory) …\]*

  - No active GI bleed.

  - Mesenteric vessels are patent without evidence of end-organ
    ischemia.

- Impression Set (MRI Brain, MRI Cervical Spine)

  - No evidence of acute infarction, hemorrhage, or a mass lesion.
    Chronic changes as described above.

  - A 1.1 cm focus of enhancement within the left parietal bone that
    does not demonstrate any cortical destruction or any other
    destructive features. There is a lucency at this site on the
    previously performed head CT. It is favored to represent a **venous
    lake**.

  - Congenitally small central canal from C3/C4 down to C5/C6 level.

  - Moderate to severe degenerative changes of the cervical spine as
    described above and summarized below.

  - At C3/C4, moderate central canal stenosis with flattening of the
    ventral surface of the cord. Moderate left neural foraminal
    stenosis.

  - At C4/C5, moderate central canal stenosis with flattening of the
    ventral surface of the cord. Moderate to severe left neural
    foraminal stenosis.

  - At C5/C6, moderate bilateral neural foraminal stenosis.

    - See below

  - At C6/C7, moderate right neural foraminal stenosis.

    - \[Condition.code =(371000119109, SCT, "Stenosis of intervertebral
      foramina"), .bodyStructure.includedStructure.structure=
      (281875002, SCT, "C6/C7 intervertebral foramen"),
      .severity=Moderate,
      .bodyStructure.includedStructure.laterality=right\]

- Impression Set

  - Prominent bilobed paramedial extra-axial **mass** along the
    convexity centered at the level of the posterior frontal and
    anterior parietal lobes with prominent posterior dural tail and
    occlusion of the adjacent superior sagittal sinus. Prominent
    surrounding reactive edema, left greater than right. Mild lateral
    shift but no herniation. Smaller extra-axial mass overlying the
    right mid temporal lobe.

  - \[Prominent bilobed (SHAPE) paramedial extra-axial (LOC) **mass**

    - along the convexity (LOC)

    - centered at the level of the posterior frontal and anterior
      parietal lobes (LOC)

    - with prominent posterior dural tail (SHAPE)

    - and occlusion of the adjacent superior sagittal sinus (LOC?).

    - Prominent surrounding reactive edema (RELATED CONDITION & LOC),
      left greater than right (SEVERITY?).

    - Mild lateral shift but

    - no herniation.

    - Smaller extra-axial mass (RELATED CONDITION & SHAPE)

    - overlying the right mid temporal lobe (LOC).\]

  - Atypical meningioma including hemangiopericytoma or variant or
    malignant subsidence of meningioma. Other less likely considerations
    include extra-axial dural based metastasis, lymphoma and less likely
    solitary fibrous tumor.

- Impression Set

  - There is mild supraspinatus **tendinosis** with minimal articular
    sided **fraying** of the distal tendon and a 3 mm low grade
    **interstitial tear** at the distal attachment site.

  - There is marrow edema within the distal clavicle. There is a small
    AC joint effusion with mild pericapsular edema. This may represent
    mild stress related change of the AC joint versus a grade 1 sprain
    of the AC joint. There is no elevation or fracture of the distal
    clavicle.

  - There is no occult fracture or bone contusion. No malalignment of
    the osseous structures.

  - The age of injury is indeterminate.

- There is a metastasis located within the right temporal lobe
  surrounded by a moderate size area of vasogenic edema. {<u>Further
  evaluation with an enhanced MRI examination of the brain is
  recommended.</u>} There are large confluent right hilar/parahilar and
  mediastinal metastases located within the chest. There is a complete
  atelectasis/consolidation of the right upper lobe (drowned lung).
  There are numerous metastases located within the peripheral portions
  of both lungs. There are multiple hepatic metastases. Please see
  report.

- Impression Set

  - Complete full-thickness disruption of the anterior cruciate
    ligament.

  - Associated osseous contusion of the lateral condylar patellar
    sulcus: Pivot shift injury.

  - Grade 1 MCL complex injury.

  - No other associated injury identified *\<How should we code negation
    when there is no concrete condition being negated?\>*

- Impression Set

  - Hydrocephalus without evidence of obstructing mass lesion. Acute
    hydrocephalus cannot be excluded since there are no prior studies
    available for comparison. Extensive chronic white matter changes may
    mask transependymal CSF edema. {<u>Correlate with short-term
    followup to exclude acute hydrocephalus. Correlate with clinical
    symptoms to exclude normal pressure hydrocephalus.</u>}

  - Chronic white matter changes.

  - Cerebral atherosclerosis.

- Impression Set

  - Markedly abnormal multifocal hypermetabolic predominantly
    osteosclerotic lesions scattered throughout the axial and proximal
    appendicular skeleton consistent with wide spread osseous metastases

  - Right lower breast mass that appears hypermetabolic. {<u>Please
    correlate with mammography and consider biopsy if indicated.</u>}
    Recurrent disease is a consideration.

  - Indeterminate bilateral pleural effusions and ascites with low-level
    metabolism. Consider thoracentesis and evaluation of fluid for
    malignancy if clinically indicated.

  - Diffuse thoracic esophageal uptake. This pattern can be seen in
    patients with esophagitis. Please correlate clinically.

- Spiculated mass within the posterior segment of the right upper lobe
  has increased minimally in size from September 2012, now with maximal
  dimension of 2cm versus 1.6cm previously. Radiographic staging of this
  presumed malignancy is T1a N0. No new pulmonary nodules and no
  findings of metastatic disease.

- Impression Set (CTA Chest)

  - Moderate pericardial effusion with apparent mass effect on the right
    ventricle, leftward bowing of the intraventricular septum, a
    contrast level within the IVC, and severe reflux of contrast into
    the hepatic veins and right lobe parenchyma are highly suggestive of
    tamponade physiology. Pericardial enhancement suggests pericarditis
    as etiology.

  - No aortic dissection or intramural hematoma.

- Impression Set (Lung Cancer screening Chest CT)

  - Lung-RADS CATEGORY: 2/S. Multiple pulmonary nodules. The dominant
    solid nodule is located in the right middle lobe and has a mean size
    of 5 mm (series 3, image 285). The category-determining solid nodule
    has a very low likelihood of becoming a clinically active cancer,
    due to size and/or lack of growth.

  - There are potentially significant incidental finding(s): thyroid
    lesion, incompletely characterized by CT

    - *\[how to code "incompletely characterized by CT"? Or is that
      narrative limitations of study and coding is less important?\]*

  - {<u>RECOMMENDATIONS: Continue annual Lung Cancer Screening Chest CT
    examination if patient meets eligibility criteria.</u>}

  - {<u>RECOMMENDATION FOR POTENTIALLY SIGNIFICANT INCIDENTAL FINDING:
    Thyroid ultrasound, unless recently obtained</u>}

  - Explanation of the Lung-RADS CATEGORIES CAN BE FOUND AT:
    HTTP://healthcare.partners.org/lung/rads.pdf

  - A clinically significant result was communicated on 2/--/202x 10:08
    PM, Message ID ------.

- Unremarkable CT evaluation of the paranasal sinuses. No obstructive
  pathology is seen.

- (Chest X-ray) No acute cardiopulmonary process.

- (MRI Brain) No acute or subacute infarct, mass effect, or acute
  intracranial hemorrhage.

- Impression Set (CT Head)

  - No acute intracranial findings.

  - Mild left parietal scalp swelling and contusion. No acute calvarial
    fracture.

- Impression Set (Screening Mammogram)

  - No mammographic evidence of malignancy in either breast.

  - {<u>Annual screening mammography is recommended.</u>}

  - BI-RADS 1 NEGATIVE \[(397140005, SCT, "Mammography assessment
    (Category 1) – Negative")\]

    - *\[This is an example of the rare case where .conclusionCode fits
      well. Should we also allow .conclusionCode and make consumers look
      in more places all the time? Or model it as an Observation?\]*

  - The patient will be notified of the results and recommendations.

    - *\[Look into coding intended, not attempted/completed,
      communications\]*

- Impression Set (OB US)

  - 24 y.o. G3P2 at 21 weeks by 18 week ultrasound with reassuring fetal
    anatomic survey. Ms. X has a significant psychiatric history and is
    maintained on Lithium with good effect; she reports her mood is
    stable and she is in close contact with her psychiatrist. We
    reviewed the plan for a fetal echocardiogram and a referral was
    placed.

    - *\[much of the above likely should be in other sections\]*

  - Worksheet finished by ---- -----, sonographer on 1/--/202- 1:2-:5-
    PM.

    - *\[Such workflow/provenance probably belongs in Procedure?\]*

- No evidence of acetabular labral tear or detachment. There is no
  high-grade chondral loss or delamination.

- Very dense breasts without comparison studies limiting sensitivity.
  Comparison to previous mammograms would be helpful to assure stability
  of dense parenchymal pattern.

- No active disease in the chest.

#### 6.7.3.8 Recommendations

**Recommendations**, if any, shall be encoded as <u>ServiceRequest,</u>
<u>CommunicationRequest, or CarePlan</u> resources referenced from the
<u>DiagnosticReport.recommendation</u> attribute.

Recommendations for subsequent imaging, lab tests, or specialist
consultations would be encoded as draft ServiceRequests. Recommendations
for simpler communications would be encoded as draft
CommunicationRequests.

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

Note: To capture specific clinical/practice guidelines or literature
citations that were applied in making the recommendation (e.g., the
Fleischner Criteria for lung nodule follow-up), those can also be
referenced from ServiceRequest.reason. In HL7 v2, the IHE Results
Distribution (RD) Profile encoded this in OBX-15. Since there is not
currently a PracticeGuideline resource, it would be necessary to create
a DocumentReference resource for the relevant policy or guideline
document.

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

##### 6.7.3.8.1 Examples for Recommendation

The following bullets provide a sample of content typical to this
section of the report.

- Referral to the DAP service is recommended. The lesion is amenable to
  CT guided biopsy.

- Further evaluation with an enhanced MRI examination of the brain is
  recommended.

- Recommend further evaluation with dedicated breast imaging at XXX
  Breast Imaging Center by calling xxx-xxx-xxxx to schedule an
  appointment.

- Please correlate with mammography and consider biopsy if indicated.

- Annual screening mammography is recommended.

- Correlate with short-term followup to exclude acute hydrocephalus.
  Correlate with clinical symptoms to exclude normal pressure
  hydrocephalus.

- Continue annual Lung Cancer Screening Chest CT examination if patient
  meets eligibility criteria

- Recommendation for potentially significant incidental finding: Thyroid
  ultrasound, unless recently obtained

- Recommend discussion of X with the patient.

#### 6.7.3.9 Communications

**Communications**, if any, shall be encoded as <u>Communication</u>
resources referenced from the <u>DiagnosticReport.communication</u>
attribute.

These communications are limited to those initiated during the
generation of the DiagnosticReport by members of the organization
fulfilling that order. E.g. direct communication of time critical
results by the radiologist to the referring physician. Communications
that follow publication of the report (e.g. between the referring
physician and the patient or a subsequent specialist) are not referenced
here.

- <u>Communication.partOf</u> shall reference the DiagnosticReport
  resource.

- <u>Communication.subject</u> shall reference the Patient that is the
  subject of the report and thus the subject of the communication.

- <u>Communication.topic</u> may contain the code for "summary-report".
  Sites may wish to use a code for critical findings.

- <u>Communication.reason</u> may reference one or more of the specific
  impression Conditions or recommendation ServiceRequests that prompted
  the communication.

- <u>Communication.about</u> may reference any or all of the specific
  impression Conditions or recommendation ServiceRequests discussed if
  such information is made available to the encoding system.

- <u>Communication.encounter</u> shall reference the encounter for the
  imaging procedure, or be absent.

- <u>Communication.status</u> should be COMPLETED in many cases. When
  documenting attempted communications, the status might have another
  value.

- <u>Communication.medium</u> will typically be PHONE, or in the case of
  leaving a voicemail message, DICTATE.

- <u>Communication.sender</u> should be the imaging clinician in most
  cases but may be their staff.

- <u>Communication.recipient</u> should be the patient or the referring
  clinician in most cases, but may be their staff.

- <u>Communication.sent</u> shall be present. Due to the nature of phone
  communications, <u>Communication.received</u> will typically be the
  same time or may be absent.

- <u>Communication.text</u> shall contain a summary sentence describing
  the communication, as currently appears in report narratives.

- <u>Communication.basedOn</u> is often absent unless there was a
  specific request for the communication.

This information is included in the body of the report, in part for
medicolegal purposes. If future HIT infrastructure handles tracking such
communications directly in the EMR, the practice of using the diagnostic
report to implement such accountability and tracking might change, but
for now it is expected to persist.

This information may also support performance metrics such as the speed
with which the Referring Physician is notified of key clinical results
or other conformance to best practices for patient safety and quality of
care.

The corresponding section narrative text may be created by concatenating
the .text contents for each of the referenced Communication resources.
This narrative often appears at the bottom of the report under the
Impressions and Recommendations.

Communication resources where the .status is not COMPLETED may trigger
subsequent follow-up workflows, but the management of such follow-up is
not reflected in the diagnostic report.

In some reporting workflows, such communications may be included in an
Addendum to the report (e.g. when the report is distributed prior to the
communication being successfully completed).

##### 6.7.3.9.1 Examples for Communications

The following bullets provide a sample of content typical to this
section of the report.

- Findings discussed with Dr. REFERRING at 1630 hrs

- Telephone message was left at Dr. DAVID LIVESEY office at the time of
  dictation.

- A clinically significant result was communicated on 2/19/2024 10:08 PM

#### 6.7.3.10 Signature

**Signature** of the report shall be encoded as a <u>Provenance</u>
resource.

- Provenance.target shall reference the DiagnosticReport resource. (TODO
  should it reference all the resources that would go in the bundle, or
  is there a more efficient way to do this? Need to list the other
  resources that were created as “components” of the report, but not
  everything that goes in the bundle. So the observations and
  conclusions would be referenced, but not the patient or
  servicerequest)

- Provenance.signature.type shall have a value of ProofOfApproval.

- Provenance.agent.who and Provenance.signature.who (or
  Provenance.signature.onBehalfOf) shall be compatible with the person
  identified in DiagnosticReport.resultsInterpreter. See also Section
  6.7.3.0.

While the DiagnosticReport does not reference Provenance resources, such
as the one containing the digital signature, the relevant Provenance
resources may be obtained with a query like:

- GET \[base\]/Provenance?target=DiagnosticReport/12345

Relevant Provenance can also be included in the response bundle when
querying the DiagnosticReport in the first place using \_revinclude:

- GET \[base\]/DiagnosticReport?\[search
  parameters\]&\_revinclude=Provenance:target

Note: Some resources include a .relevantHistory element that documents
prior clinical states of the resource via references to prior
corresponding Provenance resources. The “current” Provenance cannot be
so referenced since it cannot exist until after the current version of
this “target” resource has been created.

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
encoded in the <u>DiagnosticReport.text</u> attribute. This attribute
establishes a robust baseline representation of the report content.
Additional optional representations are described in 6.7.3.11.1.

Per the [FHIR guidance for .text narrative
attributes](https://www.hl7.org/fhir/narrative.html#Narrative), the
.text narrative should support human-consumption as a fallback from
parsing the resource; structured data should not generally contain
information of importance to human readers that is omitted from the
narrative. Accordingly, to the extent that the DiagnosticReport
attributes described in Sections 6.7.3.2 through 6.7.3.9 are present
with content, corresponding sections shall be present in the .text
narrative. Notes: 1. As a Narrative attribute, the content of .text is
encoded in XHTML with [additional FHIR
constraints](https://www.hl7.org/fhir/narrative.html#Narrative).

2\. The [IHE Interactive Multimedia Report (IMR)
Profile](https://profiles.ihe.net/RAD/IMR/) also constrains the content
of the diagnostic report.

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

Figure 6.7.3.11-1: \<div\> Section Example

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

Additional renderings of the report in other formats such as PDF, HTML,
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
what is in `.text`, which is more constrained.

The additional renderings may contain graphical embellishments and/or
improved formatting for better readability, but should not introduce
clinical semantic content that is not present in the .text rendering.

It is recommended that the `Attachment.title` for each presented form
attachment be populated to facilitate the recipient being able to
distinguish between multiple presented forms and select an appropriate
one.

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
exceeds the coded content of the resource. See
<https://www.hl7.org/fhir/R5/valueset-narrative-status.html>

For resources, such as Patient, that are used widely beyond the scope of
the diagnostic report, it the content of .text may or may not be well
suited to direct copying or concatenation without some processing.

#### 6.7.3.13 Bundle Resource Usage

The DiagnosticReport resource, like most FHIR resources, encodes
references to other associated resources. Handling collections of
related resources is typically done with the Bundle resource using one
of several bundle types and handling patterns.

As shown in the RAD-141 (Store Multimedia Report) transaction, when the
report is initially created and stored, a transaction bundle
(Bundle.type=transaction) is used to POST the newly created resources
(DiagnosticReport, ImagingSelection, etc) as an integral set to be
processed together and created on the server. For these new reporting
resources, the Report Creator is typically the “source of truth”; i.e.
the information it provides is definitive. Other resources are
referenced by the DiagnosticReport but already existed prior to
reporting; for example, the Patient that is the .subject, or the
Practitioner that is the .resultsInterpreter. These are not expected to
be in the transaction bundle during creation since they do not need to
be created and other systems are the source of truth for those
resources. Some resources, such as the ServiceRequest referenced in
.basedOn and the ImagingStudy referenced in .study, are in a grey zone
where they might typically be expected to exist prior to creation of the
report but there may be situations where they are being “backfilled” by
the Report Creator. In such cases, they may be included in the
transaction bundle to be created conditionally as indicated by the
Bundle.entry.request.ifNoneExist element.

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
