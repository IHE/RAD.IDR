
# 56 Imaging Diagnostic Report (IDR)

The Imaging Diagnostic Report Profile describes a machine-readable format for reports on diagnostic procedures of common radiology specialties using common modalities. It defines a FHIR-based encoding of the report, specifically addressing standard imaging report sections, including order, history, procedure/technique, comparison, findings/observations, impression/conclusion, recommendations, and signatures.

Specific attention is given to the impression and recommendation content as being of primary interest to the main consumers of diagnostic reports. Machine-readable coding of this content facilitates machine support such as placing orders for recommended followups or clinical decision support driven by report impression content.

Specific attention is given to findings content as being of particular interest to the subsequent radiologist using the report as a prior. Machine-readable coding of this content facilitates machine support with report generation, AI findings integration, clinical decision support and information management, and more.

Driven by European Health Data Space (EHDS) activities, HL7 Europe has developed a separate Imaging Report IG. It was created with the intention of being compatible with the existing 2024 edition of this IHE IDR Profile and work on the 2026 edition specifically engaged HL7 EU Imaging Report Working Group participants to collaborate on further harmonization of the specifications with the goal of a core global specification with (hopefully minimal) national/regional extensions to simplify implementations and promote interoperability. A standardized, uniform, encoding/format for imaging reports is, of course, highly desirable for systems that receive, display, process, database, and implement automations based on those reports. Creating and distributing reports with encoding variations increases implementation effort and reduces interoperability.

**Out of Scope:**

This Profile does not address all imaging specialties; specifically, cardiology, pathology, dentistry, ophthalmology and interventional radiology are not specifically considered. Much of the specification here might be useful in those specialties, but that would need to be confirmed, and it is highly likely each would require additional capabilities not considered here.

This Profile does not address the reporting workflow used to compose the content that is ultimately encoded as described in this Profile, nor does it address integration of tools during that workflow. See X.6 for some discussion of other Profiles which may be relevant.

## 56.1 IDR Actors, Transactions, and Content Modules

This section defines the actors, transactions, and/or content modules in this profile. General definitions of actors are given in the Technical Frameworks General Introduction [Appendix A](https://profiles.ihe.net/GeneralIntro/ch-A.html).
IHE Transactions can be found in the Technical Frameworks General Introduction [Appendix B](https://profiles.ihe.net/GeneralIntro/ch-B.html).
Both appendices are located at <https://profiles.ihe.net/GeneralIntro/>.

Figure 56.1-1 shows the actors directly involved in the IDR Profile and the relevant transactions between them. If needed for context, other actors that may be indirectly involved due to their participation in other related profiles are shown in dotted lines. Actors which have a required grouping are shown in conjoined boxes (see [Section 1:56.3](#563-idr-required-actor-groupings)).

<figure style="width:100; text-align: center;">
{%include ActorsAndTransactions.svg%}
<figcaption style="text-align: center;"><b>Figure 56.1-1: IDR Actor Diagram</b></figcaption>
</figure>

Table 56.1-1 lists the transactions for each actor directly involved in the IMR Profile. To claim compliance with this profile, an actor SHALL support all required transactions (labeled “R”) and may support the optional transactions (labeled “O”).

**Table 56.1-1: IDR Profile - Actors and Transactions**

<table class="grid">
  <thead>
    <tr>
      <th>Actors</th>
      <th>Transactions</th>
      <th>Initiator or Responder</th>
      <th>Optionality</th>
      <th>Reference</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td><a href="volume-1.html#56111-report-creator">Report Creator</a></td>
      <td>Store Imaging Diagnostic Report [RAD-Y1]</td>
      <td>Initiator</td>
      <td>R</td>
      <td><a href="rad-Y1.html">RAD TF-2: 4.Y1</a></td>
    </tr>
    <tr>
      <td rowspan=3><a href="volume-1.html#56112-report-repository">Report Repository</a></td>
      <td>Store Imaging Diagnostic Report [RAD-Y1]</td>
      <td>Responder</td>
      <td>R</td>
      <td><a href="rad-Y1.html">RAD TF-2: 4.Y1</a></td>
    </tr>
    <tr>
      <td>Query Imaging Diagnostic Report [RAD-Y2]</td>
      <td>Responder</td>
      <td>R</td>
      <td><a href="rad-Y2.html">RAD TF-2: 4.Y2</a></td>
    </tr>
    <tr>
      <td>Retrieve Imaging Diagnostic Report [RAD-Y3]</td>
      <td>Responder</td>
      <td>R</td>
      <td><a href="rad-Y3.html">RAD TF-2: 4.Y3</a></td>
    </tr>
    <tr>
      <td rowspan=2><a href="volume-1.html#56114-report-consumer">Report Consumer</a></td>
      <td>Query Imaging Diagnostic Report [RAD-Y2]</td>
      <td>Initiator</td>
      <td>R</td>
      <td><a href="rad-Y2.html">RAD TF-2: 4.Y2</a></td>
    </tr>
    <tr>
      <td>Retrieve Imaging Diagnostic Report [RAD-Y3]</td>
      <td>Initiator</td>
      <td>R</td>
      <td><a href="rad-Y3.html">RAD TF-2: 4.Y3</a></td>
    </tr>
  </tbody>
</table>

### 56.1.1 Actor Descriptions and Actor Profile Requirements

Most requirements are documented in RAD TF-2: Transactions. This section
documents any additional requirements on profile’s actors.

#### 56.1.1.1 Report Creator

A Report Creator coordinates the creation, assembly, and recording of the content of an
imaging diagnostic report.

A Report Creator encodes diagnostic reports using FHIR DiagnosticReport
resources. Systems that might implement this actor include traditional
reporting products. It is also conceivable that a broker product might
be able to take reports in some other format and compose an equivalent
report encoded according to this profile.

Each resulting DiagnosticReport resource also includes at least one
rendered report in HTML format in the same DiagnosticReport resource,
either as base64 encoded binary, or by reference using a URL.

#### 56.1.1.2 Report Repository

A Report Repository stores reports received from Report Creators and
makes the reports available for other consumers through query/retrieve.

A Report Repository may modify how referenced resources are made
available for subsequent access by systems that retrieve the report.
This may be done to improve accessibility to consumer systems outside
the local network, or may be done to improve efficiency of retrieval.
For example, a Report Repository may adjust an internal URL to an
externally accessible URL, or it may retrieve the rendered report
referenced by a URL and embed it directly, base64 encoded, in the
DiagnosticReport resource in a query response.

#### 56.1.1.3 Report Reader

> Note: The Report Reader is not yet formally part of this Profile. It will be added when baseline display requirements have been formally specified.

A Report Reader accesses reports from the Report Repository for
presentation to a user.

Report Readers will be expected to be able to present the XHTML content of
DiagnosticReport.text. Report Readers will be expected to be able to present PDFs
referenced in DiagnosticReport.presentedForm, if any are present. Report
Readers may choose to render coded content from the report, or present
additional pre-rendered versions contained or referenced in the
.presentedForm, or some combination of that.

Systems that might implement this actor include EMRs, enterprise
viewers, and patient portals. A reporting workstation might also
implement this actor to access and present prior reports, in whole or in
part, to the imaging clinician.

#### 56.1.1.4 Report Consumer

A Report Consumer accesses reports from the Report Repository for processing.

The capabilities to process those reports are not otherwise constrained here. Some Report Consumers will likely take advantage of the coded content in the FHIR resources, others might be limited to processing just the text or HTML renderings.

Systems that might implement this actor include clinical decision support (CDS) systems, workflow automation tools, and clinical registries. A reporting workstation might also implement this
actor to access and incorporate content from prior reports into the
current report (see 56.4.2.5 Use Case #5).

## 56.2 IDR Actor Options

Options that may be selected for each actor in this profile, if any, are
listed in the Table 56.2-1. Dependencies between options, when
applicable, are specified in notes.

**Table 56.2-1: Imaging Diagnostic Report – Actors and Options**

<table class="grid">
  <thead>
    <tr>
      <th>Actor</th>
      <th>Option Name</th>
      <th>Reference</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>Report Creator</td>
        <td>No options defined</td>
        <td>--</td>
    </tr>
    <tr>
        <td>Report Repository</td>
        <td>No options defined</td>
        <td>--</td>
    </tr>
    <tr>
        <td>Report Consumer</td>
        <td>No options defined</td>
        <td>--</td>
    </tr>
  </tbody>
</table>

## 56.3 IDR Required Actor Groupings

An actor from this profile (Column 1) shall implement all of the
required transactions and/or content modules in this profile ***in
addition to*** ***<u>all</u>*** of the requirements for the grouped
actor (Column 2).

Section 56.5 describes some optional groupings that may be of interest
for security considerations and Section 56.6 describes some optional
groupings in other related profiles.

**Table 56.3-1: Imaging Diagnostic Report – Required Actor Groupings**

<table class="grid">
  <thead>
    <tr>
      <th>IDR Actor</th>
      <th>Actor(s) to be grouped with</th>
      <th>Reference</th>
      <th>Content Bindings Reference</th>
    </tr>
  </thead>
  <tbody>
    <tr>
        <td>Report Creator</td>
        <td>ITI CT / Time Client</td>
        <td><a href="https://profiles.ihe.net/ITI/TF/Volume1/ch-7.html"><span>ITI TF-1: 7.1</span></a></td>
        <td>--</td>
    </tr>
    <tr>
        <td>Report Repository</td>
        <td>None</td>
        <td>--</td>
        <td>--</td>
    </tr>
    <tr>
        <td>Report Consumer</td>
        <td>None</td>
        <td>--</td>
        <td>--</td>
    </tr>
  </tbody>
</table>

## 56.4 IDR Overview

### 56.4.1 Concepts

This section presents concepts and considerations that may be helpful to
better understand, implement, and deploy this profile. This material is
informative; there are no conformance requirements in this section.

For brevity, this section will sometimes refer to imaging diagnostic
reports simply as "reports".

#### 56.4.1.1 Report Formats: ORU, PDF, SR, CDA, FHIR

The proposed FHIR DiagnosticReport format would take its place among a
number of existing report formats in use, to varying degrees, in
existing hospital systems. This profile does not mandate specific
transcoding capabilities, but since that will likely be part of
successful product implementations, some guidance is provided here.

**HL7 V2 ORU** messages containing formatted or unformatted text are, as
of the early 2020's, still a very common format for distributing reports.
The primary advantage of continuing to use this format is its compatibility
with the large install base of V2 systems, in particular when including
the report in HL7 V2-driven electronic medical record systems. While the
inclusion of OBX segments in the ORU message can provide some coded
information, this is still poorly adopted and not well standardized. As
a result, the machine-readability is quite low and the underlying
mechanisms are not well suited to significant improvement of that.

See Annex C.0 for a discussion of transcoding between ORU messages and FHIR DiagnosticReport.

**PDF** renderings of full reports are also popular due to being able to
capture and reproduce well-formatted human-readable presentations of the
content. However, PDF documents lack machine-readable coding of the
content which undercuts the ability to support functions like clinical
decision support, workflow automation, and clinical databases.

Transcoding PDF renderings can make direct use of the ability to include
PDF documents in the DiagnosticReport.presentedForm. Report Creators
that provide PDFs in created DiagnosticReports will facilitate
consumption by simpler downstream systems.

**DICOM Structured Report (SR)** introduced mechanisms for fully coded
clinical information contained in persistent documents with robust
management. In practice this encoding has been predominantly used for
objects created within the imaging department to capture measurements
(echocardiography, fetal ultrasound, CT/MR oncology, etc.), radiation
dose (x-ray RDSR, radiopharmaceutical RRDSR), contrast administration,
computer-aided detection and diagnosis (CAD) results (mammography, chest
radiography, etc.), and general procedure logs. While the SR format was
also designed to support coded diagnostic reports, lack of format
support where the reports are viewed, outside the imaging department,
was an obstacle. When HL7 CDA was subsequently introduced, DICOM
prepared a mapping and guidance for the use of CDA-based imaging
diagnostic reports (See DICOM PS3.20).

Transcoding SR components, such as individual measurements and
observations, addressed in part by activities in the joint DICOM
WG-20/HL7 II Working Group. That work is directly relevant to coding SR
components into the Findings section of a FHIR report. (See [WG20
IG](https://build.fhir.org/ig/HL7/dicom-sr/)). Some of that guidance is
relevant here, but it should be noted that this IDR Profile is scoped to
first address the distribution and basic clinical consumption of imaging
diagnostic reports and is thus focused most strongly on the Conclusions
and Recommendations sections. Important subsequent IHE work will address
the report creation process and more advanced consumption, which will
delve deeper into the encoding of the Findings section, integration of
AI inputs, research, incorporation of prior findings, etc., and make
more use of the WG20 work.

**HL7 Clinical Document Architecture (CDA)** defines XML encodings for
persistent clinical documents that can contain coded and uncoded
content. CDA defines three levels of semantic interoperability
(<https://www.ncbi.nlm.nih.gov/pmc/articles/PMC130066/>):

- Level 1 – xml-wrapped text
- Level 2 – xml-wrapped text with section headers
- Level 3 – xml-wrapped text with section headers and structured and
  coded data

where “Level 3” data constructs (called “entries”) enable individual
structured and coded results.

When adopted, CDA usage is often closely associated with the IHE XD\*
family of profiles, however cross-enterprise sharing of machine-readable
data is still limited.

Transcoding CDA diagnostic reports will benefit from much of the
information in DICOM PS3.20 as described above.

Since CDA and FHIR are both HL7 defined encodings, several pieces of
work within FHIR provide guidance on transcoding between CDA and FHIR
resources in general:

- <https://www.hl7.org/fhir/comparison-cda.html>
- <https://build.fhir.org/ig/HL7/ccda-on-fhir/mappingGuidance.html>

The IHE Results Distribution (RD) Profile also provides relevant
guidance on best practices when using ORU, PDF, SR and CDA for
distributing imaging diagnostic report content.

**HL7 FHIR DiagnosticReport Resources** have the potential to permit
sophisticated levels of machine-readable data while also providing
human-friendly presentations of the report, all within a FHIR-based HIT
environment. Those are some of the key motivations for this profile.
Details on encoding imaging diagnostic reports based on the FHIR
DiagnosticReport resource are provided in RAD TF-3:6.7 Imaging
Diagnostic Report Content.

#### 56.4.1.2 Purpose and Structure

The imaging diagnostic report is a part of the patient’s medical record
and is the definitive documentation of the results of an imaging
examination or procedure. It includes the observations, measurements,
and findings from the imaging examination. Importantly, it is also
expected to include a summarization, interpretation (sometimes in the
form of a differential diagnosis with probabilities), and management
recommendations that draw from the patient’s full clinical history.

The report will have several types of readers. The referring physician
will consider the differential diagnosis available in the report in the
context of other information such as symptoms, physical examination, and
past medical history to refine the likelihood of a certain disease and
to guide next steps in management. He may use qualitative and
quantitative data within the report to assess disease progression and
treatment response. He may also review management recommendations within
the report to guide further diagnostics, treatment, or referral to other
providers. The report will also be read as a "prior" for comparison by
radiologists who are reviewing the patient’s follow-up exams to focus
attention on areas of concern and to further refine diagnosis and
management recommendations. Finally, the report is often read by the
patient and caregivers, often in conjunction with the referring
physician, but also frequently on their own, to educate and support
informed consent for next steps in management.

Machine-based consumers of reports will often be interested in specific
individual data elements, such as a recommendation, a primary
conclusion, or an actionable incidental finding (See subcases in Section
56.4.2.4 Use Case \#4: Report Processing). Such qualitative and
quantitative data may be used for a variety of purposes, including
clinical decision support tools and trend analysis. Human readers of
reports may be interested in the report as a whole, or may also focus on
specific elements (See Section 56.4.2.3 Report Presentation).
Presentation features involving hyperlinked report elements are
addressed in the IHE Interactive Multimedia Report (IMR) Profile.

##### 56.4.1.2.1 Sections

An important feature of imaging diagnostic reports is the organization
of the content into sections intended to more efficiently and
effectively communicate the information. The semantics of the sections
are important. The same observation has different implications when
present in the order, in the patient history, in the family history, or
in the findings section of the report. "Flatlisting" into an
undifferentiated collection of items can make the information more
difficult to work with.

The content and ordering of the sections reflect organization of the
content, not the dictation process. Some imaging clinicians may dictate
content in different orders, or replace dictation of some content with
the use of tools to populate parts of the report.

The American College of Radiology provides specific guidance in the [ACR
Practice Parameter for Communication of Diagnostic Imaging
Findings](https://www.acr.org/-/media/ACR/Files/Practice-Parameters/communicationdiag.pdf?la=en)
on recommended report sections and content. While the titles may vary
and the section groupings may differ slightly from practice to practice
and from country to country, the approach of medical imaging clinicians
to organizing report content is broadly consistent.

> Note 1: **Words are bolded** to call attention to key details.
>
> Note 2: Report sections and format are not formally standardized at some sites.
>
> Note 3: When there is no content for a section in a given report, the section is sometimes omitted from the narrative and/or presentation.

- **Patient** information such as **name**, age, gender, birthdate, and
  **medical record number** is typically provided first.
  
  The Patient and Order information are often presented at the top of
  the report in a pre-defined "header" section with formatted fields for
  a number of the key details. Typically, this information is populated
  automatically, not dictated by the imaging clinician.

- **Order** information such as the **accession#**, the identity of the
  referring physician or organization, the indication for examination,
  and, ideally, additional patient context and specific **clinical
  questions** provided by the referring physician. Clinical questions
  are sometimes of the form "Follow-up X", where X is an existing known
  finding (perhaps from a previous exam), or "Rule out X", where X is a
  condition for which imaging input is requested on whether or not it is
  present. **Indications** are also, hopefully, provided to provide
  important clinical context to the imaging clinician, and to support
  assessment of the appropriateness of the order and/or billing. If
  indications are not present, they are sometimes sought out by imaging
  staff.

  > Note: "Rule out X", while somewhat helpful for the imaging clinician, can be problematic for billing since the symptoms that suggest the possible presence of the condition and establish the medical necessity of the imaging exam are implied, but not captured. Site practices increasingly deprecate such wording.

- **History:** This section includes patient history and other prior
  clinical details deemed relevant to the imaging study by the imaging
  clinician. Some information may be provided by the referring physician
  in the order, and more is extracted from the medical record by imaging
  staff, automated tools, or by the radiologist themselves. This
  information provides background for the imaging clinician, context for
  the contents of the report, and is sometimes relevant to billing and
  clinical guidelines. Potential sources include impressions or
  summaries of the clinical notes from the encounter where the imaging
  order was placed.

- **Procedure and Materials:** This section contains information such as   the **procedure type**, the anatomy imaged, the **date** and time of the imaging examination, and the facility that performed it.
  
  Also called Imaging **technique**, this section may describe the parameters that were used, details of any **contrast** media and/or radiopharmaceuticals administered, including concentration, volume, and route of administration, and any medications, and catheters or devices used.
  
  The section can also describe preparation of the **data produced** by the procedure: Views, image sets, recons, reformats and post processing.
  
  **Radiation dose** may also be described here; the text content and metrics may be constrained/formatted to meet local regulations.
  
  The information in this section is typically more detailed than what is listed as the Order, and in fact may differ from the ordered exam based on the needs of the patient and the judgment of the imaging clinician.
  
  Any deficiencies of the study may also be described here, such as whether the imaging was incomplete or if there were quality issues that prevented interpretation of some part of the study or otherwise compromise the sensitivity and specificity of the examination. In the event that a patient was unable to undergo imaging, for example due to claustrophobia or a seizure, a report might still be produced and this section would note that the exam was not performed and provide a reason.
  
  While the actual instructions given to the patient are not typically  listed in the report, some mention the fact that instructions were given, and perhaps that risks were discussed, and consent was obtained. Procedure notes from the technologist are typically captured elsewhere, but significant details such as adverse patient reactions, or things that may affect the quality of the study, may be included here.
  
  Procedure details that may be required for billing are sometimes included here as well.

- **Comparison:** This section is a list of other studies that were
  considered relevant by the imaging clinician. They are typically
  identified by type (**modality,** anatomy, exam type) and **date**.
  Findings from these studies and comparisons with the current study are
  typically woven into the next section (e.g. indicating no change,
  differentiating descriptions and/or measurements), although some of
  these studies may not be specifically mentioned in the findings. It is
  typically presumed that both the images and the report for each
  comparison study were available to the imaging clinician, however in
  some cases, such as for external priors, only the report or only the
  images were available, in which case that may be noted here.

- **Findings**: This section provides a detailed description of the
  findings on the imaging examination. The findings should be described
  in a clear and concise manner, using standardized anatomic,
  pathologic, and radiologic terminology whenever possible.
  
  When there are significant numbers of findings, the imaging clinician will typically organize them into groups, typically by anatomy. Reporting templates for particular procedure types (such as those at radreport.org) often demonstrate such organization of findings.
  
  An important distinction between Findings and Impressions is that Findings capture what the imaging clinician saw in the image, while Impressions capture what they inferred/concluded. For example, the findings might record a radiolucency, while the impression records a fracture. There are some cases where the two overlap, but generally imaging clinicians try to capture in the Findings what the significant image features are and strive in the Impressions to communicate to the referring physician what they think those represent in clinical terms. All conclusions and actionable findings, i.e. the clinical information that is most important for the referring physician, will appear in the Impression section.

- **Impression**, sometimes also called Conclusion or Diagnosis,
  provides the radiologist's **overall interpretation** of the findings,
  a specific diagnosis and/or **differential diagnosis** (when possible),
  **responses to any clinical questions** posed by the referring
  physician, and any **recommendations** for further management and/or
  confirmation, as appropriate.
  
  Recommendations most often cover subsequent diagnostic imaging or other diagnostic procedures such as biopsies or lab tests. They may also include suggestions to correlate the imaging result with other clinical information to improve the confidence of the diagnosis, referrals to specialists, or less commonly, therapeutic procedures. The recommendations may cite specific guidelines applied, particularly when the referring physician might be less familiar with the current guidelines for certain findings than the imaging clinician. The imaging clinician may take into account the expertise of the referring physician when composing recommendations; for an unusual cancer, a family physician might find follow-up recommendations more helpful than an oncology specialist would.
  
  Since referring physicians may specifically focus their attention on this section, the imaging clinician may choose particularly important details such as key findings or any adverse events, to re-iterate and summarize here.
  
  The order of items in the impression is often significant, in that imaging clinicians frequently put the most critical, most actionable, most significant items first in the impression section to minimize the chance of them being overlooked. In the case of differential diagnosis, the multiple possible diagnoses are typically presented in order from the most likely to the least likely. Impression items may also be numbered to facilitate verbal referencing or linking to communications.
  
  Some items in the impression may be clinically significant but were not associated with the indications or reason for exam; for example, a lung nodule deemed to be suspicious on a chest exam for trauma. These are often referred to as "incidental findings".
  
  Some items in the impression may be considered actionable, in that some follow-up action or communication is advisable. The recommendations may or may not include a specific corresponding follow-up action. A corresponding communication to relevant persons may or may not have taken place during the reporting process and be noted in the report.
  
  Some items in the impression may be critical, in that they represent the potential for severe negative clinical impact to the patient if appropriate action is not taken promptly. The presence of such items almost always results in a communication with care staff and/or the patient.
  
  There is strong interest in tooling to facilitate communicating critical results clearly and rapidly with the appropriate people, confirming that follow-up of actionable findings takes place, and making sure that incidental findings do not "fall through the cracks".

- **Communications** are records in the report about attempted and/or
  successful communications of some content of the report to the
  referring physician, the patient, or other appropriate person. These
  communications are initiated during the generation of the
  DiagnosticReport by members of the organization fulfilling that order.
  E.g. direct communication of time critical results by the radiologist
  to the referring physician.  

  Communication is not listed as a separate section in the ACR guidance,
  but codes for a communication section do exist. It is common practice
  to present communication records at the bottom of the report, just
  below the impressions, since they are often driven by specific items
  in the impression and occur at the end of the report creation process.
  Such communication records support medico-legal usage and the review
  and improvement of conformance to best practices for patient safety
  and quality of care.
  
  The communication entry typically records the date, time, and method of communication, the person/organization contacted, and may summarize the content communicated.

- **Signature**, makes clear the identity and credentials of the author
  of the report and records their approval of the semantic content of
  the report as written.

- **Addendum**, contains report information recorded subsequent to the
  report being distributed as final. Addenda may contain corrections,
  such as typographical or transcription errors, new findings that have
  come to the attention of the imaging clinician, additional procedure
  details needed to support billing or QA, additional observations
  requested by the referring physician, or re-interpretation of findings
  in light of additional clinical context.
  
  There may be multiple addenda to a given report. Addenda can be authored by clinicians other than the original author of the report.
  
  An addendum may contain just the supplementary information. Some systems present the addendum in a corresponding text box next to the original report. Based on local policies and practices, the addendum may also contain a complete "replacement" report. In either case, the original final report is always retained for medicolegal purposes. It can also serve as an effective way to resolve references.
  
  It is important for addenda to be distributed promptly to all systems that received the original final report.

Note that ACR implies that for a brief report, some sections might not
be specifically called out.

In general, it is left to the Report Creator implementers to address
issues like interleaving content that is automatically generated and
content provided by clinician dictation or input, or avoiding
duplication of the same content in different sections, or ensuring the
full content of the report is approved by the imaging clinician.

The Royal College of Radiologists (RCR) also provides guidance on
communication with the referrer in [Standards for interpretation and
reporting of imaging
investigations](https://www.rcr.ac.uk/system/files/publication/field_publication_files/bfcr181_standards_for_interpretation_reporting_0.pdf).

- The purpose of the report is to provide a timely answer to the clinical questions posed, together with a holistic assessment of all the images for relevant and/or unexpected findings. The written report should be clear, and written in a way appropriate to the referrer’s expected level of familiarity with the imaging abnormalities detected, the implications for the patient and the referrer’s access to requesting further investigations. The wording of the report is likely to differ when it is written to a general practitioner (GP) who may be unfamiliar with a relatively rare condition, compared with a specialist in that particular field.
  
- The report should be actionable and should therefore convey a knowledgeable and reasoned assessment of the examination and its contribution to the overall management of the patient.

The Key Performance Indicators identified by the RCR are:

- The report should answer the clinical question: target 100%.

- When an abnormality is described a tentative or differential diagnosis
  should be provided: target 100%

- Not all reports will have advice on the next step. However, where
  advice is given, the advice should be appropriate: target 100%.

#### 56.4.1.3 Codes and Codesets

While this profile does not mandate the use of particular codesets for
many of the details that are coded, agreeing within the local site or
organization on common codesets will be a key prerequisite of effective
deployment of this profile. This is necessary to facilitate automated
functions such as those described in Section 56.4.2.4.1. Further, since
reports are typically circulated to other organizations, the use of
codes from widely adopted standards will be particularly important to
realize the full potential of coded reports.

Many of the examples in this profile demonstrate the use of SNOMED codes (indicated by an SCT
coding system value). SNOMED has agreements with DICOM and FHIR that
identify a very large set of codes which can be used free of charge in
DICOM and FHIR implementations anywhere in the world, independent of
national licensing. This profile permits implementations to use
alternate coding systems, for example if they need to use codes outside
of the aforementioned sets in countries that do not have SNOMED
licensing agreements.

LOINC has a significant collection of codes for measurements that could
be of significant value in coding Findings. DICOM includes many such codes in Context Groups (such as CID 12304 Echo Measured Property) in DICOM PS3.16.

LOINC is also the source of the section codes in RAD TF-3: 6.7.3.0.1, which were drawn from the two panels defined in (81220-6, LN, Diagnostic imaging report – recommended
C-CDA R2.0 and R2.1 sections) and (87416-4, LN, Diagnostic imaging
report - recommended DICOM PS3.20 sections).

Implementers are encouraged to consider the Playbook set of procedure codes.  The codes may be found by searching for “playbook” within LOINC and were originally developed by the RadLex initiative. RadLex (radlex.org) also provides anatomy and observation codes to supplement SNOMED and LOINC.

When cataloging findings from prior reports (see RAD TF-1:56.4.2.4.1.x), it is likely they will span multiple institutions which may have chosen different coding conventions, resulting in significant challenges. This profile encourages post-coordination of anatomy, morphology, and observed characteristics and properties (see RAD TF-3.6.7.3.6) which may make it more likely that different sites are at least partially aligned, and may make it easier to maintain mapping tables and perform transcoding.  

Many FHIR elements use a datatype of CodeableConcept (or CodeableReference which has a .concept element of type CodeableConcept). Two specific mechanisms provided by those datatypes may be useful to implementors of Report Creators and/or Report Consumers.

- \<element\>.text allows a simple text string to be provided instead of a code.
- \<element\>.coding may contain multiple entries which represent equivalent codes. E.g. (80891009, SCT, “Heart”), (LP191607-3, LN, “Heart”), and (RID1385, RadLex, “Heart”).

#### 56.4.1.4 Relevant FHIR Resources

This section briefly introduces FHIR resources relevant to imaging
diagnostic reports, and outlines their intended purpose, usage, and main
details. The **maturity level** at the time this specification was published is shown in (parentheses).

Guidance on using these for encoding reports is provided in RAD TF-3:
6.7 (Imaging Diagnostic Report Content)

> Note: Some of the relationships between these Resources are described in the [Diagnostic Medicine Module](https://hl7.org/fhir/diagnostics-module.html#org-dr-obs).

The [**Patient**](https://www.hl7.org/fhir/R5/patient.html) Resource (N)
encodes demographics and administrative information about an individual
or animal receiving care. The resource appears fully adequate for
imaging purposes and no need for imaging-specific modifications has been
identified.

The [**ServiceRequest**](https://www.hl7.org/fhir/R5/servicerequest.html)
Resource (N) encodes an order for, in our case, a diagnostic imaging
procedure. Instances of this resource are used to represent the imaging
request being fulfilled by this report, and any draft requests for
subsequent services recommended by the reporting physician. More
profiling may be necessary to fully satisfy the workflow and
record-keeping requirements of imaging procedures, but that is out of
scope for this profile.

The [**Encounter**](https://www.hl7.org/fhir/R5/encounter.html) Resource
(N) describes an interaction between a patient and healthcare
provider(s). Encounters can reference each other in a hierarchical
structure; for example, an encounter with the imaging department might
be a child of an encounter representing a hospital admission. Modelling
and profiling encounters to represent imaging scenarios such as
interventional procedures, outpatient imaging, pre-imaging preparation
such as radiopharmaceutical injection, multi-stage imaging, etc. is out
of scope for this profile. Instances of this resource may be used to
represent the encounter where the imaging was performed, and possibly
the encounter where the imaging was ordered.

> Note: Resources that represent the basic information about a patient and a clinical encounter can be found in the Administration Module.

The [**Procedure**](https://www.hl7.org/fhir/R5/procedure.html) Resource
(N) encodes an action that was performed on a patient, such as a
diagnostic imaging procedure, in our case in response to a
ServiceRequest. The imaging Procedure is performed in the context of an
imaging Encounter. Like ServiceRequest, more profiling of this resource
may be required to fully satisfy the workflow and record-keeping
requirements of imaging procedures, but that is out of scope for this
profile.

The [**ImagingStudy**](https://www.hl7.org/fhir/R5/imagingstudy.html)
Resource (N) represents the content produced in a DICOM imaging study.
This is the primary output of one or more diagnostic imaging Procedures,
typically in response to an imaging ServiceRequest. Instances of this
resource are used to represent the imaging study being reported on,
comparison studies available to the reporting physician, and possibly
other studies to which they referred.

The
[**DiagnosticReport**](https://www.hl7.org/fhir/R5/diagnosticreport.html)
Resource (N) encodes findings and interpretation of diagnostic tests
performed, in our case, on patients. The resource contains information
about the test and the subject. It references a variety of other
resources, including the Patient, ServiceRequest, Procedure,
ImagingStudy, and Observations and Conditions identified in the imaging,
or as part of the relevant patient history.

> Note: FHIR notes that DiagnosticReport "is not intended to support
> cumulative result presentation (tabular presentation of past and present
> results in the resource)." This profile does not rule out the inclusion
> of prior results, such as measurements for oncology, cardiology, or
> obstetrics, which might usefully be presented in a table format;
> however, it is acknowledged that the "source of truth" of those prior
> measurements is the prior report, not the current one.

The DiagnosticReport resource has also been profiled by the [IHE IMR
Profile](https://profiles.ihe.net/RAD/IMR/).

The [**ImagingSelection**](https://www.hl7.org/fhir/R5/imagingselection.html)
Resource (N) encodes a selection of a specific portion of an imaging
study to permit linkage to Observation and other resources that describe
such a specific subset. The selection starts at the level of specific
DICOM SOP instances and/or frames within a single Study and Series. It
may include additional specifics such as an image region, an Observation
UID or a Segmentation Number. One of its intended applications is to
support encoding the spatial details of findings and impressions in
diagnostic imaging reports.

The [**Observation**](https://www.hl7.org/fhir/R5/observation.html)
Resource (N) encodes individual observed details such as those that
appear in the findings and impressions of imaging diagnostic reports.
Observation supports nesting and other relationship mechanisms to
capture groups of associated observations. The observed (or suspected)
presence or absence of a condition are encoded as Observation
resources.

The [**Condition**](https://www.hl7.org/fhir/r5/condition.html) Resource
(N) encodes a clinical condition, problem, or diagnosis that is being clinically
monitored and/or managed. Such resources may appear in the study
indications or relevant history of the patient or their family.

The [**Bundle**](https://www.hl7.org/fhir/R5/bundle.html) Resource (N)
is a container for a set of related resources. It can be used for a
variety of purposes related to data organization, storage, and
messaging. Instances of this resource are used to collect the set of
resources that together comprise an imaging diagnostic report for
transmission as a semantically complete report.

The [**Composition**](https://www.hl7.org/fhir/R5/composition.html)
Resource (N) represents a document in the sense of a specific
presentation of a specific collection of referenced resources. The
composition does not affect the meaning of the referenced resources, but
rather arranges them to optimize consumption by a particular type of
consumer or use case. Different compositions may be created that
reference the same resources for different consumers, e.g., to highlight
clinical vs operational content. In some ways, compositions are
analogous to DICOM Presentation States. Additional metadata captures the
subject (patient), document type, author, title, creation date, status
(prelim, final), and confidentiality. A composition can be
signed/attested. Like instances, they are intended to be immutable once
created. Changes require a new "version". Instances of this resource may
be referenced inside a DiagnosticReport to encode different
presentations of the content (potentially as an alternative to providing
different presentedForms).

> Note 1: The FHIR Breast Radiology IG in R4 opted to use Composition
> <u>instead of</u> DiagnosticReport, reportedly in the belief that
> DiagnosticReport would be dropped. US Core opted to use DiagnosticReport
> instead of Composition. FHIR advises "If you have a highly structured
> report, then use DiagnosticReport – it has data and workflow support.",
> which is the approach taken in this profile. See also RAD TF-4: 5.2.
>
> Note 2: FHIR says "Composition may also be used to organize observations and
> diagnostic reports, but that is only for purpose of readability, not to
> record critical relationships for interpretations."

The
[**DocumentReference**](https://www.hl7.org/fhir/R5/documentreference.html)
Resource (N) is basically a pointer to a document, such as a diagnostic
report, serving as an index entry and possibly providing access path
information. It replicates organizational metadata like the document
type, format (Composition, PDF, CDA, SR), creation date, author, status,
and signatures. The resource apparently may also include the document as
inline base64 encoded data rather than providing a reference pointer
(which raises a variety of implications).

> Note 1: FHIR says "a DocumentReference typically reflects a non-FHIR
> object that is not a FHIR Document (e.g., an existing C-CDA document, a
> scan of a driver’s license, or narrative note)."
>
> Note 2: FHIR also says "This resource is able to contain medical images in a
> DICOM format." while also noting that ImagingStudy and WADO-RS are the
> preferred method for indexing and accessing images. It will be left to
> future profiling work to determine whether this use of DocumentReference
> is introducing potential interoperability issues with how images are
> managed, indexed, exchanged, and presented in different scenarios.

There are also some FHIR data types that are useful to highlight and
differentiate.

**CodeableConcept** includes a coding element and a text element, both
of which are optional. It is permitted to have just a code, or just a
text string, or both. It is also permitted to have multiple (synonym)
codes.

**CodeableReference**, in a similar fashion, includes a resource
instance reference and a CodeableConcept, both of which are optional.
When a CodeableReference element is constrained to a list of Resource
types, that constrains what may be referenced in the .reference element,
but the .concept element is not constrained.

#### 56.4.1.5 Preliminary Reports, Final Reports, and Addendums

This profile does not address the workflow involved in arriving at a
final report (which can be quite complex and involve interactions
between multiple clinicians and staff including attending, resident, and
overreading physicians), but it does address the metadata inside a
published report that identifies the "state" of the encoded content.

This profile describes the content and encoding of a report that has
reached the point of being suitable for "publishing" for use in patient
care. While the relevant resources may exist in a partially populated
form during the preceding report composition process, that is not
addressed here.

Publishable reports may be preliminary, meaning that they are accessible
to clinicians who may need initial information urgently, but at least
one review and approval remains before the report is considered final.

Publishable reports will typically become final, meaning that they have
been approved and signed, and should be distributed according to local
practices.

Once made final, any amendments to the report are handled as an
addendum.

Once a final report is published, preliminary reports are typically
sequestered or removed from the medical record. In the case of an
addendum, however, the corresponding final report is always retained for
medicolegal reasons.

Since multiple instances of a given report may exist over time
reflecting the above states, systems that handle imaging reports should,
thus, expect to encounter multiple "copies" of a report that differ, or
to encounter a retrieved current report that has different content than
when retrieved previously. The metadata described in RAD TF-3: 6.7.3
Imaging Diagnostic Report Encodings will help systems understand and
deal with such situations.

#### 56.4.1.6 Narrative vs Encoded Content and Structure

Historically, reports have been entirely narrative with a small amount
of coded metadata for management. For example, when communicated in an
HL7 V2 ORU message, the narrative may be prefixed by just the encoded
patient name, MRN, Accession \#, and date/time of the exam.

Providing report details as coded content makes that information
machine-readable which opens the door to automated and semi-automated
functions in systems that receive and process the diagnostic reports.
Coded content is also typically more uniform, making it easier to database than narrative content, which varies with individual preferences.

Given that coding the entire content of the
diagnostic report will be an enormous piece of work, identifying the
functions that would provide the most value and utility also helps
prioritize which parts of the report product implementations and site deployments should consider coding first. For additional discussion, see Section 56.4.2.4.1 Report Processing Use Case.

The target of this profile is to capture today's narrative text reports
in a FHIR encoding that includes metadata for intelligent handling and
starts coding key pieces of content to facilitate automated workflows. This is intended to
start the transition to FHIR-based reports. Some principles
the committee has discussed include:

- All significant clinical details present in the report in coded form are also visible in
  the rendered .text (and typically in .presentedForms, if present).

  - Some coded metadata details do not normally appear in the conventional narrative and would clutter the text. Those might not be rendered in text.

- Some data generated for/during the reporting process is stored in DICOM objects in the
  study, not embedded into the report. i.e., Report is not the transport for
  additional data that isn't "in the report".

  - E.g., AI analysis might results in a conclusion that appears in the report, but the AI analysis data itself might be stored in the imaging study.

- Some elements in the report are there to support billing and
  administrative processes, not clinical processes.

- It is expected that in the future semantics visible in the narrative (i.e., in .text) will increasingly be available in the report in coded form.  Eventually, all narrative semantics might be available in coded form.

- Clinical and administrative use cases will be key drivers for refinement and expansion of specifications for coded report content.

Briefly, the interoperable semantics are encoded in the structured resources which are fully machine readable. DiagnosticReport.text is the (required) definitive form for human consumption. Its XHTML content can also be parsed by machines for advanced presentation. The other presented forms (.composition and .presentedForm) are optional, supporting fixed PDF presentations or HTML presentations that leverage features not available in the .text XHTML. All are intended to be nominally semantically equivalent, although when preparing presented forms for targeted audiences, different details may be highlighted or suppressed, and may be grouped/organized differently, etc.

#### 56.4.1.7 Terminology for Findings and Observations

Terms like “finding” and “observation” may be understood differently by different readers. Within the scope of this imaging-oriented profile, the following concepts are used (heavily influenced by modelling in SNOMED and DICOM).

**Body Structure** encompasses both anatomical structures (like the brain or the apex of the heart) and morphologic abnormalities (like a lesion, cyst, inflammation, aneurysm, fracture or abscess). Anatomy that is paired has **laterality** (left, right, both); unpaired anatomy does not.

**(Imaging) Observation** refers to a feature or characteristic that is visible in an image. An observation may serve as the basis for determination that a finding is present and/or it may further characterize a finding (e.g. describing size or texture details). Imaging observations may be encoded in FHIR Observation Resources.

**(Clinical) Finding** refers to the determination that a clinical entity is present or absent, or the assessment that a clinical entity is normal or abnormal. Clinical Findings may be observed directly or inferred from other observations. The determinations and assessments may be made with varying degrees of certainty. Clinical findings appear in the Findings section of the report. Some findings, typically the most significant, also appear in the Impression/Conclusion section of the report.

In a report, the section titled Findings generally contains both clinical findings and imaging observations. E.g. the presence of a tumor is a finding, a recorded diameter of the tumor is an observation, the rate of growth of the tumor is an observation, a determination that the tumor is benign is a finding, the presence of gallstones is a finding, signs such as the Mercedes Benz sign and the shadow sign (which may be caused by said gallstones) are observations.

Observations are often grouped or related in some way. See Section 56.4.1.8.2 for further discussion of the types of relationships and groupings.

#### 56.4.1.8 Findings Encoding Framework

Some metadata in the Observation resources included in the DiagnosticReport applies similarly to most findings. That encoding is described in IHE RAD TF-3: 6.7.3.6.1. Other metadata will vary based on the finding concepts described here. That encoding is described in other subsections of IHE RAD TF-3: 6.7.3.6.

##### 56.4.1.8.1 Observation Types

Types of observations are proposed here to bring some structure to the significant breadth across the many pathologies and other details that may be observed in various specialties and imaging modalities.

> Note:	These are image-based observations. “Liver is normal” means the appearance of the liver in this image is normal; due to limitations of the modality, there may be aspects of the liver that cannot be visualized in this image which are not normal.  This is one reason observations are categorized as imaging results.

**Anatomic Entities, Pathologic Entities, and Physical Object Entities (Image Entities)**

The target of an observation (sometimes referred to as a finding site or a target entity) is typically either an anatomic image entity, a pathologic image entity, or a physical object image entity. An anatomic image entity is a specific piece of anatomy visible in the image, such as the left adrenal gland, or the caudate lobe of the liver. A pathologic image entity is a specific pathologic process or piece of tissue visible in the image, such as swelling or a lesion. Pathologic entities are almost always associated with an anatomic location (e.g., consolidation in the lower lobe of the right lung). A physical object image entity is an artificial object visible in the image, such as a piece of shrapnel, a stent, or a screw. Physical objects that are the target of an observation are almost always inside, and associated with, the patient anatomy. Physical objects that are outside the patient, like ECG leads or patient supports, are visible in the images, but less commonly the target of observations.

**Measurements and Assessments (Image Features)**

The content of an observation is typically either a measurement or an assessment of the target of the observation. A measurement records a numeric value for a measurable feature, such as a diameter or a flow rate (e.g., pancreatic duct diameter is 2 mm). An assessment records a coded value for an assessed characteristic, such as shape or texture. (e.g., liver contour is smooth).

Sometimes, instead of a specific characteristic, an assessment may assess the overall normality of an anatomic entity (e.g., adrenal glands are normal) or the simple presence/absence of a pathologic entity (e.g. no bladder wall thickening). Such overall present/absent or normal/abnormal observations are sometimes referred to as Clinical Findings.

**Unstructured Observation**

Despite the goal to structure and code as much report content as possible, as modeled above, some unstructured observations may be expected to occur in reports.

Structured, coded data reduces variabilities and removes ambiguities present in natural language and improves the machine readability, facilitating automation and other data-driven features.  However, developing specifications, code sets and software that covers the breadth of information that can be expressed in an imaging report will be an ongoing process. In the meantime, capturing unstructured narrative observations in the DiagnosticReport resource is necessary.

##### 56.4.1.8.2 Observation Relationships (i.e. Organization and Groupings)

Some findings are individual “standalone” observations. It is, however, quite common to have observations that are grouped together, potentially at multiple levels. And even individual findings/observations may have semantic relationships with other findings/ observations. This section describes such relationships and groupings.

**Finding Set**

Some groups of observations are anchored by a root finding, such as the presence of a lung nodule, with a set of associated observations that contain further measurements, assessments, and characterizations, such as the morphology, diameter, and composition of the nodule. Many such finding sets are listed as CDE Sets at <https://radelement.org>. The associated observations are semantically related to the root finding in that they provide further detail.

**Summary/Derived Observation**

Somewhat similar to a Finding Set, a number of reporting systems have been developed that involve a summary score or assessment that is derived from a collection of more detailed specific sub-observations. For example, the LungRads Score is derived from the grading of one or more lung nodules which in turn are derived from observed characteristics of each nodule.

In contrast to the root finding of a Finding Set, which is typically observed first and is supplemented by the associated observations, the summary observation is created last as it is derived from the associated observations, usually via a specific algorithm.

**Hierarchical Target Entity**

The target entity may have a hierarchical structure, for example a pulmonary nodule may have a solid part and a non-solid part. Observations on the different characteristics of the different parts of the structure are semantically related by all being part of the larger target entity.

**Compound Statement**

Physicians may dictate compound statements, such as “the liver, gallbladder, pancreas, and spleen are unremarkable.” These are encoded as individual observations about each of the anatomic entities that do not depend on having an inherent semantic relationship.  
This is frequently used as a convenient shortcut to record a cluster of observations, particularly for a set of anatomic entities that are normal or unremarkable, or for a set of pathologic entities that are absent (pertinent negatives). E.g.,

- “No abnormalities in the chest”
- “Liver, gallbladder, pancreas, and spleen are unremarkable.” 
- “The C2-3 and C3-4 discs are degenerated.”
- “Moderate amount of fluid in the radiocarpal and midcarpal wrist compartments.”
- “Ventricles and cisterns are normal in size and configuration.”
- “Bones and joints are intact without fracture or dislocation.”

The cluster of observations is typically based on anatomic proximity, symmetric paired structures, related biological function, or shared imaging characteristics (e.g. lungs and pleural spaces). In these cases, the semantic relationship is more about standard anatomical relationships than inherent relationships between the observations.

The viewer of the report, such as the referring physician, may have preferences about how all the observations are grouped for presentation, e.g. by anatomy or anatomical region. Addressing such rendering preferences in the report viewer will typically be more effective than getting all the report creators to create presented forms for all the different viewer preference patterns.

**SR Measurement Group**

Some observations are related because they have been transcoded from a DICOM SR instance and were encoded together in a Measurement Group container.

**Derived Observation**

Some observations are directly derived, usually mathematically, from one or more other observations. Examples include ratios, calculated areas or volumes, normalized indices like BMI, mean values derived from multiple sample measurements, etc. It can be useful for provenance and validation purposes to maintain the semantic relationship between the derived observation and its sources. For example, a prostate volume observation of 30 cc might be estimated from dimension observations of 4.2 × 3.8 × 3.6 cm along three axes.

**Temporal Comparison**

Change over time, or lack thereof, can both provide significant diagnostic information. It is very common for a given anatomic or pathologic entity to be observed in a current study and that observation compared to other observations of the same entity at one or more time points in the past. This can result in derived observations about the entity, such as it being unchanged, or having a measured rate of growth or size doubling time.  This may also be referred to as a trend observation.

Temporal comparisons can differ from simple derived observations by typically spanning multiple exams and duplicating a copy of the prior observation(s) into the current report, while more typical derived observations involve the source observations all originating in the current exam.

If the entity appears in a prior exam but the specific observation was not reported in the prior exam, the current physician may perform and include a new observation on the prior exam in the current exam report (appropriately labeled, of course). Even if the observation existed in the prior report, the current physician may sometimes still create a new observation on the prior exam for improved consistency.

It is useful to be able to determine in which prior exams/reports the entity in question appeared. This is facilitated by the use of longitudinal tracking IDs for such entities, but that also requires matching and mapping to be performed to be effective.

**Conclusion Support**

Observations may be associated with a report conclusion, for example when the observation is suggestive of, or definitively proves, a particular diagnosis. This includes the case of suggesting, or definitively proving, the absence of a particular condition.

**Causal Relationship**

Observations may have a semantic relationship because one is causing the other. For example, an observed cerebral hemorrhage may also be the (likely) cause of an observed herniation or displacement of anatomical structures, such as a midline shift or compression of a ventricle.

One causation pattern involves a process, such as a pneumonia infection, which manifests entities such as pleural effusion or consolidation in the lungs. Another causation pattern involves a procedure or treatment, such as surgery or a course of drugs, which can result in both intended effects and/or unintended complications.  

In some cases, both the cause and the effect are visibly observable in the images. Alternatively, one may be recorded as inferred from the presence of the other. Report language such as “X is consistent with Y” may be used to record the observed presence of X and the inference that Y may be present.

**Common Cause**

An expansion of the causal relationship involves multiple “independent” observables that share a common cause. A pathologic entity might manifest in multiple ways.  A known traumatic impact might cause multiple observable conditions.

Conversely, the observables may contribute evidence for a conclusion that a causal pathology is present. An infection might manifest in inflammation and swelling in multiple locations. Diverticulitis might be expected to present a focal area of inflammation at a location in the bowel wall (perhaps a specific diverticula), perforations at one or more locations, abscesses or fluid collection at one or more locations, and/or a vessiculocolonic fistula (communication between bladder and colon). A report might rule out diverticulitis in the presence of some of these due to the absence of others, or might include a conclusion of diverticulitis despite the lack of one of these observables. The nature of these related findings might support a severity assessment of mild/moderate/severe.

#### 56.4.1.9 Environmental Assumptions

Hybrid environments (mixing FHIR and HL7 V2 messaging) are inevitable.
If FHIR is the primary stored representation of the report, it will
inevitably need to be sent to a text/V2 based environment. This will be
an important part of making deployment practical in existing hospitals.

HL7 is working on general guidance for conversion of content that is
encoded in HL7 v2 Messages into roughly equivalent FHIR resources
(<https://hl7.org/fhir/uv/v2mappings/ImplementationGuide/hl7.fhir.uv.v2mappings>)

Future revisions of this document might provide guidance specific to
imaging diagnostic reports and related resources.

#### 56.4.1.10 Imaging Workflow, Reporting Workflow, and Reports

The scope of this profile is focused on imaging diagnostic reports which makes it predominantly a Content Profile. The reports are the output of Reporting Workflow, which in turn is a component of Imaging Workflow.\

Reporting Workflow is centered on the diagnostic interpretation process during which an imaging clinician reviews the current imaging study along with relevant data from the patient’s medical record, including prior imaging studies. Other components of the Reporting Workflow may include reporting worklists, clinical analysis and other reporting tools (AI-based or conventional), assembly of the semantic content of the report, and reporting QA.

Imaging Workflow begins with initial placement of the order, and encompasses scheduling, protocoling, acquisition, quality assurance, post-processing, data routing, the Reporting Workflow, and delivery and handling of the resulting report.

The Imaging Workflow and the Reporting Workflow are outside the scope of this profile. Some parts are addressed in other IHE Profiles. See 56.6 Cross-profile Considerations.

That said, there are overlaps. Some FHIR Resources that might be created in those workflows, such as the ServiceRequest that represents the initial order, or the ImagingStudy that represents the acquired and processed data, might later be referenced in the imaging report. Implementations in those workflows might find it useful to consider the Resource specifications here.

Conversely, there will be data created (in DICOM and FHIR formats) that are not referenced in the imaging report but are still persisted in the DICOM Study or elsewhere in the patient’s medical record. For example, there may be AI results created in the course of the reporting process that might be stored in the Imaging Study, but not explicitly included or referenced in the resulting DiagnosticReport.  The DiagnosticReport is not a container for intermediate data produced over the course of the Imaging or Reporting Workflow. The Imaging Study is the primary container for all persisted data from the imaging procedure.

Similarly, a given imaging study might trigger the execution of a large number of opportunistic screening AI algorithms, many of which are unrelated to the indicated reason for the exam. Typically, most or all of them will return negative results.  The discretion of the radiologist will determine which are sufficiently relevant and/or significant to be present in the report. The rest of the result data might or might not be retained as imaging study data based on local policies and/or radiologist determination.

Another common example is ultrasound measurements made during obstetric studies. The sonographer routinely makes many measurements which are stored in DICOM Structured Report (SR) instances in the DICOM Study. Some, but typically not all, of those are mirrored in the report while the rest are commonly retained as study data.

For another example, a radiologist might note that the image quality of the study was not optimal. The radiologist could create a DICOM KOS containing a quality assessment of the images that would drive subsequent imaging department quality improvement processes. The radiologist could dictate an assessment of the image quality into the diagnostic report content to communicate potential limitations of the interpretation.  Or they could do both or neither.

### 56.4.2 Use Cases

#### 56.4.2.1 Use Case \#1: Report Creation

A Report Creator encodes the report content.

##### 56.4.2.1.1 Report Creation Use Case Description

The focus here is on encoding the collection of information at the end
of the interpretation process into a DiagnosticReport-based format.

Marshalling the constellation of input data and interacting with that
data during the interpretation process and assembling the report content
is briefly discussed and shown here for context.

> Note 1: Other profiles that touch on report creation and data handling (See Section 56.6 Cross Profile Considerations) include:
>
> - Integrated Reporting Applications (IRA)
> - AI Results (AIR)
> - Remote Radiology Reporting Workflow (RRR-WF)
> - Management of Radiology Reporting Templates (MRRT)
>
> Note 2: Collating and using finding data from prior reports is discussed in Use Case 5 (See Section 56.4.2.5.1)

The Report Creator receives report content from multiple sources.
Traditionally, the bulk of the content comes directly from the
interpreting clinician via a dictation system. Some content, such as
procedure, technique, and dose information, may be automatically
extracted from the study instances and/or HL7 order artifacts.
Additional content may be generated by clinical software (conventional
or AI-based) in the form of proposed measurements, segmentations, image
features, and other data analysis. The methods used by the Report
Creator to arrive at encoded content that is approved by the reporting
clinician is not constrained by this profile. For example, the Report
Creator might use a Large Language Model (LLM) to extract coded elements
from the dictated narrative, or it might provide an interface for the
clinician to quickly select coded elements. The Report Creator might
have the referring clinician approve the entire report content at the
end, or might get piecewise approval during composition.

A report may be circulated when it is created in a preliminary state and
again later when it has been signed and updated to a final state, and
potentially again if it is updated again with an addendum to the report.
That status is captured in the encoding (TOLINK See RAD TF-3: 6.7.3.0) but
managing that transition and handling of multiple versions of the report
is left to subsequent reporting workflow profile work.

The created report is expected to include both narrative and coded
content. See Section 56.4.1.6 for a discussion of the balance and overlap
between the two.

##### 56.4.2.1.2 Report Creation Process Flow

<figure style="width:50%;">
{%include usecase1-processflow.svg%}
<figcaption style="text-align: center;"><b>Figure 56.4.2.1.2-1: Report Creation Process Flow</b></figcaption>
</figure>

#### 56.4.2.2 Use Case \#2: Report Storage & Distribution

A Report Creator provides encoded reports to a Repository (push), which
then makes the reports (and the associated component resources)
available for routing and/or retrieval (pull).

##### 56.4.2.2.1 Report Storage & Distribution Use Case Description

This diagram shows the Report Creator sending the report directly to the
Report Repository that serves as the storage server for subsequent query
and retrieve transactions. Alternatively, the Report Creator might send
the report to a Report Manager which handles short term workflows and
dataflows and later migrates the report to the Report Repository for
archiving.

This diagram shows the Report Consumer querying the Report Repository to
identify a report of interest. Alternatively, the Report Consumer might
be Report Reader in an EMR terminal where the referring physician has
found a reference to the report (perhaps in the patient's folder or
perhaps attached to recently placed orders) which allows a retrieval
based on that reference, skipping the query.

It is also important to note that some Report Consumers may do
resource-level queries on some of the components of the report, e.g.,
the Observations, Conditions, and Service Requests that make up the
Findings, Impressions, and Recommendations. For more detail, see Section
56.4.2.4 Report Processing.

Not shown in the diagram, some sites may configure Report Creators
and/or Report Repositories and/or a special report router to push copies
of all/most reports to additional destinations, such as a regional
health information exchange, or patient portal system. The use case
where specific reports are routed to particular destinations based on
certain conditions and particular metadata values is framed as a report
processing use case and is discussed in Section 56.4.2.4.1.5 Smart
Routing of Reports.

The EMR (Electronic Medical Record), in the role of either Report Reader
or Report Repository, will likely index reports for browsing, in
addition to using the query/retrieve model. The imaging study would
appear as an entry in the medical record with an associated datetime,
body part, and modality or exam type. The report may appear in a list of
patient documents, also with an associated datetime, body part, and
modality or exam type. The originating order will appear in the medical
record, but references go from the DiagnosticReport and ImagingStudy
resources to the ServiceRequest resource, not the other way around. So
going from the ServiceRequest to the report involves a query for the
matching Accession Number, or ServiceRequest reference, rather than
navigating the reference from the ServiceRequest.

The European eHealth Network (eHN) has published “Guidelines on Medical imaging studies and reports” that is intended to support making them available in a cross-border context to a requesting health professional to support clinical decision making, consultation and continuity of care.

The intended distribution pattern involves a clinician in country A asking its National Contact Point (NCP) for clinical content about the patient. The NCP of Country A contacts the NCP of Country B, which retrieves clinical information from its national infrastructure (e.g. IHE-MHD based systems) and returns it. The NCP of Country A provides the records to the Clinician, potentially having translated it into the local language.

###### 56.4.2.2.1.1 Report Query Patterns

A significant requirement is the ability to identify relevant studies and reports in a manner similar to local access based on key metadata such as time period, modality, body part, or procedure type. Query patterns will vary by practice and workflow.

Normative requirements on the technical query capabilities of initiators and responders are specified in the Query Imaging Diagnostic Report \[RAD-Y2\] transaction.

This section presents typical query patterns for primary clinical usage as a way of setting general expectations. A technical description of how such a query might be executed in FHIR is also provided to establish a common baseline understanding among implementers.

- Patient-based – find reports for a certain Patient

  - For a given Patient, find reports that reference it as .subject

    - Constrain to a given time range, and/or body part, and/or
      modality, and/or procedure

- Query by surgery department for images and reports for patients
  scheduled for surgery to do pre-surgical planning by each surgeon

- Query by admin staff for recent reports and images for a given patient
  to prepare for data export in support of a patient transfer or
  referral for care in a different institution.

  - "Recent" involves searching for reports in a time range up to the
    present. The size of the range is likely a local configuration or
    user choice.

- Order-based – find reports created for a certain Order.

  - For a given ServiceRequest, find reports that reference it as
    .basedOn

  - For a given Accession \#, find the corresponding ServiceRequest,
    then find report

  - For a given Practitioner, find ServiceRequests that reference them
    as .requester, then find reports for those ServiceRequests

- Query by a referring for ordered report based on accession number,
  patient, study datetime, body part, and possibly modality or procedure

- Query by referring staff for reports from all procedures ordered
  recently their referring name/ID/practice to prepare for daily review
  and preparation

- Study-based – find reports on a certain Study

  - For a given ImagingStudy, find reports that reference it as .study

- Query by a reading radiologist for <u>priors</u> based on patient,
  datetime range, body part/region, modality, procedure type, and
  possibly impressions or finding values. Might need free text matching
  in the report body using NLP (could be client-side or server-side)

- Query by a tumor board for reports, key images, and cross-indexed lab
  and anatomical histopathology results, for the list of scheduled
  patients/cases

  - Some may specifically target those with resections from the past
    week (and see if the pathology results match), others focus on
    multi-disciplinary cases

Less common patterns (which also cover administrative and research use
cases) may include:

- Author-based – find reports certain contributors contributed to (to
  see how many studies of a certain type, or go back and find a report
  from today to check on).

  - For a given Practitioner, find reports that reference it as
    .resultsInterpreter

- Query by reading radiologist for reports authored by them (or perhaps
  their attending for a resident) with a particular impression or
  finding to see "how did I describe that last time".

  - Note that the workflow (especially for residents) may involve
    multiple authors and the relevant author to search for may shift
    over time, or depend on who is doing the query

- Prior-based – find reports that cite a certain prior (perhaps there
  was a quality issue)

  - For a given ImagingStudy, find reports that reference it as
    .comparison

- Cohort-based – find reports with certain clinical or demographic factors

  - For a given observed Condition, find reports that reference it as .impression

  - For a given demographic, find Patients that match, then find reports
    for those .subjects

  - For a given modality, find ImagingStudy with a matching
    .series.modality, then find reports for those

- Query by researcher for studies with certain patient characteristics,
  indications, impression/conclusions to prepare research/paper

  - A similar query might be used by a reading clinician to find reports
    with similar diagnoses to the current study to review/compare those
    findings and images.

- Observation-based – find observations that were created as findings,
  without necessarily considering the entire report.

  - For a given Patient and DiagnosticReport, find Observations with
    particular observation codes and/or bodyPart or bodyStructures, etc.

  <!-- -->

  - Caveat: due to pre-post coordination variations, actually making
    Observation queries functional might be a challenge.

  - Caveat: some observations might not have been coded.

  - Caveat: if diagnoses are coded under .conclusionCodes rather than
    Condition resources under .impressions, they would not be available
    as separate Resources for query.

<!-- -->

- Query by CDS agent for specific observations and observation values
  that are the basis for clinical guidelines to be applied to the
  patient/case.

  - Caveat: it is not yet clear whether it would be simpler to retrieve
    the current (and perhaps recent) reports and operate on that
    collection of observations rather than do queries on the entire FHIR
    store.

One could also imagine many of the above queries coming from another
institution. Dealing with the associated code mapping, patient matching,
access permissions and other privacy and security details are not
addressed in this profile.

##### 56.4.2.2.2 Report Storage & Distribution Process Flow

<figure style="width:55%;">
{%include usecase2-processflow.svg%}
<figcaption style="text-align: center;"><b>Figure 56.4.2.2.2-1: Report Storage & Distribution Process Flow</b></figcaption>
</figure>

#### 56.4.2.3 Use Case \#3: Report Presentation

A Report Reader presents the content of the diagnostic report to users
performing clinical tasks.

##### 56.4.2.3.1 Report Presentation Use Case Description

The most basic form of presentation will be the full display of the
entire report, as provided in DiagnosticReport.text as XHTML. Additional
presentations may be present in DiagnosticReport.presentedForm, which
might be a PDF, HTML, or formatted text. Report Readers will rely
heavily on the .text (and presentedForm, if present) until key parts of
the semantic content of the report is in coded form.

Some Report Reader implementations may serve the needs of users with
specific roles and goals by providing more advanced functions, such as
highlighting key elements relevant to the users task/interest,
re-ordering or collapsing and expanding sections based on user focus, or
providing summarizations.

Some roles and goals to consider include:

- Referring Clinician

  - Finding the answer to their clinical question in the recent order
    for their patient (this might involve initially presenting the
    impression and recommendations)

- Surgeon

  - Understanding the patient's condition and disease to plan a surgical
    procedure (this might involve focusing on details related to
    specific anatomy and presentation of key images or 3D renderings)

- Oncologist

  - Understanding the patient's condition and disease as part of
    planning treatment (this might involve compiling details from the
    current report and prior reports for presentation in tabular or
    graphical form to better visualize progression or response.)

- Emergency Physician

  - Understanding the patient's condition and disease as part of
    stabilizing and admitting (this might involve focusing first on the
    most urgent impression items and auto-staging orders based on report
    recommendations or clinical decision support, e.g. anti-coagulation
    medications for identified deep vein thrombosis, or a vascular
    surgeon consult for an abdominal aortic aneurysm above a certain
    size. See also smart infrastructure behaviors in Use Case \#4:
    Report Processing.)

- Radiologist

  - Understanding the main findings and impressions from a prior report
    in the context of a current read.

- Patient

  - Understanding the impressions, recommendations, and other report
    content, as part of providing informed consent for a subsequent
    treatment procedure (this might involve re-wording the impressions
    and other parts of the report to match the patient’s education level
    and preferred language)

    - Consider the scenario of a report being provided directly to the
      patient, before review of the content with the referring
      physician. Some diagnoses provoke emotional reactions and patients
      benefit from corresponding education. Tools that "translate and
      contextualize the content" could provide significant value.
      Tooling that can mediate release of reports with certain findings
      until after physician consultation, while immediately releasing
      others, might be of interest in some practices.

  - It can be especially useful to engage patients in tracking
    incidental findings and long-term follow-up recommendations.

- Registrar (of a registry; public health, cancer, etc.)

  - Reviewing a submitted case as part of the curation process

Report Readers will need to pay particular attention to addenda (if any)
to the report, as these can contain information that is critical to
patient care. In some systems, an addendum is presented together with
the impression since the impression is the section that gets the most
attention.

Support for hyperlinks in the report body to trigger presentation of
associated images and measurements is addressed in the Interactive
Multimedia Report (IMR) Profile.

##### 56.4.2.3.2 Report Presentation Process Flow

<figure style="width:20%;">
{%include usecase3-processflow.svg%}
<figcaption style="text-align: center;"><b>Figure 56.4.2.3.2-1: Report Presentation Process Flow</b></figcaption>
</figure>

#### 56.4.2.4 Use Case \#4: Report Processing

A Report Consumer extracts and processes relevant details from the
diagnostic report.

##### 56.4.2.4.1 Report Processing Use Case Description

This Use Case focuses on the extraction and processing of information
from the Imaging Report and the other Resources with which it is
encoded. The query and retrieves that make up the transactional part of
this use case are described in Section 56.4.2.2 Report Storage and
Distribution.

It is worth highlighting that many of the potential Report Consumers may
have very specific tasks to perform and correspondingly may be focused
on certain details (e.g. the impressions and recommendations) rather
than the report as a whole. Several examples are described here.

It is also important to note that some Report Consumers may do
resource-level queries on some of the components of the report, e.g.,
the Conditions, Service Requests, and Observations that make up the
Impressions, Recommendations, and Findings.

The following subsections describe some specific examples of report
processing.

###### 56.4.2.4.1.1 Ordering Support for Recommendations

Upon receiving an imaging diagnostic report, the referring physician may
often want to place an order for follow-up studies recommended by the
imaging clinician in the report.

The software used by the referring physician could start by extracting
the ServiceRequest resources referenced in the DiagnosticReport
recommendations. These already contain details such as the type of
imaging procedure and suggested time frame which could be presented to
the referring physician to select those they want to order now. The
software might fill in additional details based on its configuration and
local information, and ask the referring for the remaining details, if
any. The software might also be able to interact with payer pre-approval
systems.

The software might also be able to facilitate recommendations for
non-imaging services such as biopsies, additional lab tests, referrals
to other providers, etc. Some of those services might be related to the
imaging recommendations (e.g. check for renal function and thyroid
function before contrast administration). See Section 4.2.4.1.3.

###### 56.4.2.4.1.2 Clinical Decision Support for the Referring Physician

Clinical Decision Support (CDS) systems analyze information from the
health record to improve the efficiency or accuracy of care provider
activities, such as subsequent patient care steps. CDS functions may be
based on qualitative and quantitative data like the impressions and
findings in the diagnostic report potentially combined with guidelines
and other details from the medical record.

CDS outputs may take the form of computerized alerts and reminders,
integration with clinical guidelines, diagnostic support, and/or
execution of condition-specific order sets in the electronic medical
record. In particular, the ACR \*-RADS categories frequently have
specific follow-up actions associated with them.

The CDS software used by the referring physician may have access to
prior reports or clinical information that was not available to the
imaging clinician.

###### 56.4.2.4.1.3 Actionable Finding and Recommendation Follow-up

A specific goal of this profile is to allow imaging clinicians to tag
impression items that constitute actionable findings and indicate the
rough time horizon of urgency. (See the text on Observation.category in
RAD TF-3: 6.7.3.7).

Failure to notice and/or effectively follow-up on actionable findings
(particularly non-critical actionable findings which are important but
allow for a longer time horizon) is a known problem. The IHE Results
Distribution (RD) Profile specifically included HL7 v2 mechanisms to address this.

The software used by the referring physician could trigger off the
actionability code in Observation.category for impressions in the DiagnosticReport and
highlight or otherwise ensure that the referring physician is made aware
of them. The patient portal software could similarly provide
notifications and reminders to the patient. Some regions have regulations requiring notifications to the patient about certain findings within a certain time window.

The FHIR Flag resource is likely a useful mechanism to improve report-related follow-ups described here. Although not mandated by this Profile, systems might automatically, or with user interaction, create Flag resources for recommendations and/or actionable findings. Flag.subject would reference the Patient. Flag.supportingInfo would reference the relevant Observation(s), ServiceRequest(s), and/or the DiagnosticReport as a whole. Flag.code would include a code or text providing a sense of what needs to be addressed. This might replicate the Observation.text or ServiceRequest.text in the referenced resource, such as for a pulmonary embolism or a follow-up MRI. Flag.category would contain one or more codes to facilitate presenting the flag to the appropriate audience in the appropriate context. Flag.status would likely be initially set to “active” and later updated to “inactive” when the underlying issue has been subsequently dealt with.  Flag.period, if present, might indicate the time the Flag was set as the start of the period. Per FHIR, the end of the period should be unspecified until the status has changed to inactive.  

> Note 1. This mechanism may be formally profiled in a subsequent Profile. The Flag resource is driven by Diagnostic Report content but is part of associated workflow, not inherently part of the Diagnostic Report.
>
> Note 2. Always referencing the DiagnosticReport from the Flag would facilitate a search that identifies reports which have Flags and presenting those Flags in the context of that report or providing indicators that a report has associated active Flags.
>
> Note 3. Such Flags are not referenced by the DiagnosticReport and thus are typically not part of the associated report document Bundle.

The ACR has reported that "Up to 10% of all radiology reports contain
follow-up recommendations, and approximately half of the recommended
follow-up exams are never performed. Lung nodules represent about half
of all imaging follow-up recommendations, and noncompliance with
radiology lung nodule follow-up places patients at risk for delayed
diagnosis of lung cancer."

Patient and referring physician software could review all
recommendation ServiceRequests and check the clinical records to see if
an actual ServiceRequest manifested and was performed within the
suggested time frame. Alternatively, this might be done as a two-step
process. First an algorithm could extract and assess all recommendations
in every report. Those determined to be significant (and/or likely to be
overlooked) would be forwarded to an intelligent tracking and
notification system.

> Note: It is important to be careful of false positives to avoid alert fatigue. Recommendations might not have been performed because the condition was not met, or an alternative procedure was performed.

The imaging clinician may also use software to track
follow-up of actionable findings and recommendations. Based on personal
choice, local practice guidelines, or regional regulations, the imaging
clinician may wish to be notified or provided a dashboard when certain
time thresholds have passed without follow-up, or they may wish to
review the results when follow-ups take place.

In addition to using Flags to directly drive improved patient care processes, imaging clinicians might also make use of Flags for professional development and radiology quality processes. This might include flagging an observation such as a suspicious lesion and monitoring the subsequent availability of a corresponding report (such as that described in the IHE PALM Radiology-Pathology Concordance (RPC) Profile - <https://www.ihe.net/uploadedFiles/Documents/PaLM/IHE_PaLM_Suppl_RPC.pdf>) and reviewing the content. [

###### 56.4.2.4.1.4 Clinical Registry Submissions

Registries are systems that collect data from multiple practice settings
to improve the understanding of clinical conditions, other systems, and
processes. Examples include the ACR Lung Cancer Screening Registry or
the Pediatric Echo Registry. Since many submission processes are manual,
the scale of submissions is quite restricted.

Submission software could start by extracting details from the report
such as coded indications of certain diagnoses, and related information
from the EMR. The software could vet reports to see if they meet the
registry criteria, extract necessary details for submission, and perform
any required anonymizations.

Because such registries might have specific code set transcoding
requirements and other constraints, it is likely this use case would
involve making reports available to a submission software rather than,
for example, the software used by the referring physicians doing it
directly.

###### 56.4.2.4.1.5 Smart Notifications & Routing of Reports

Other functions that could benefit from improved machine readability of
imaging report impressions and recommendations are automated
notification and routing algorithms.

First, speed of awareness and access can be improved when there are
critical urgent results in the impressions, such as pulmonary emboli,
intra-cranial hemorrhages, or unstable aneurysms. The imaging clinician
will also be trying to communicate with the primary responsible
physician directly, but there are often other members of the care team
that would benefit from being informed, and sometimes electronic
notifications and report routing can outpace telephone tag. Given the
identity of the referring physician in the ServiceRequest, the routing
system may have access to more up to date contact details than the
imaging clinicians reporting workstation. Note also the special case
where the patient has self-referred.

Second, particular things in the impressions and/or recommendations will
be of interest to particular stakeholders such as the referring
physician, ward nurse, emergency department, intensive care unit,
surgeon, oncologist, other specialist, and the patient themselves.

###### 56.4.2.4.1.6 QA and Safety Processes

Qualitative and quantitative data in the report could support a variety
of QA processes at organizational and national levels.

To assess performance, findings present (or absent) in the report can be
compared to data from other systems that are running in parallel within
the facility, such as interpretive AI systems designed to detect
specified patient conditions.

Observations in the report of poor image quality can be identified (for example, from the content of DiagnosticReport.note, Observation.note, or Observations with .focus=ImagingStudy as described in RAD TF-3:6.7.3.4 and 6.7.3.6.1) and trigger creation of quality logs (see IHE Reject Analysis and Monitoring Profile). Analysis of such data can determine if issues are occurring
systematically, which can be an indicator of equipment malfunction or
equipment operator neglect.

###### 56.4.2.4.1.7 Other Workflow Automation

The software used by the referring physician could also facilitate
interacting with other EMR structures such as the Problem List and
Allergies (contrast) based on information provided in and extracted from
the DiagnosticReport. This will likely involve some selection by the
referring physician and some intelligence and sophistication from the
software to judiciously suggest updates to the master lists. They might choose to add conditions definitively observed by the radiologist to the Problem List or mark their .verificationStatus as confirmed. The observed conditions suspected by the radiologist might be added to a differential diagnosis. It is also important to consider removal of entries from those lists when
appropriate to help combat "note bloat". Observations of pertinent negatives might trigger removal of the Condition from the Problem List or from a differential diagnosis. Sometimes such an outcome is the intended reason for the imaging study in the first place (“Rule out X”).

Similarly, intelligent extraction of key details from the
DiagnosticReport for inclusion in discharge notes, referral letters, and
patient instructions could save time and energy.

Technique and finding information from prior reports could be used to intelligently protocol the current exam. Technique and reconstruction could be selected to closely match the prior images, and scan range could be selected to facilitate effective follow-up of pertinent “problem list” items (see also 56.4.2.5 Use Case #5: Prior Finding Catalog).

Another useful workflow function that could be enabled is the
often-discussed radiology-pathology correlation feedback. Many
radiologists would appreciate a dashboard that collects certain
impression entries, like nodules or masses that are suspicious for
cancer, and tracks subsequent anatomical histopathology reports to
extract information on which were malignant and which benign.

##### 56.4.2.4.2 Report Processing Process Flow

<figure style="width:20%;">
{%include usecase4-processflow.svg%}
<figcaption style="text-align: center;"><b>Figure 56.4.2.4.2-1: Report Processing Process Flow</b></figcaption>
</figure>

#### 56.4.2.5 Use Case #5: Prior Finding Catalog

A Report Consumer processes the content of multiple prior reports to create a catalog of prior findings for use by the imaging clinician during the interpretation of the current study.

##### 56.4.2.5.1 Prior Finding Catalog Use Case Description

During the creation of a radiology report for a current study, the content of relevant prior reports can be very useful to the reading radiologist. This is sometimes conceptualized as an “imaging problem list” (IPL) which are the findings (and conclusions) of a collection of prior imaging reports collated into a construct that facilitates navigation, comprehension, and analysis by the radiologist, typically in the context of preparing a new Current Report.

> Note: The IPL is not the patient Problem List, which is a collection of problems (conditions) being managed by the care team responsible for the patient. Typically, conditions are added to, and removed from, the patient Problem List at the discretion of the physician directly providing care to the patient.

The software used by the radiologist could support the current reading activity by performing functions such as the following (likely subject to configurability):
> Note: This is more detailed than a typical Use Case Description in the hope of exercising the Finding encoding specifications.

- Retrieve multiple relevant prior reports (both local and remote)
- Extract (all) <u>findings and conclusions</u> from each report
- Correlate/index the findings into a catalog
- Support browsing through the (organized) content, e.g.
  - Prepare a concise summary of the patients imaging history
    - Potentially organize by body region, head/neck, thorax, abdomen/pelvis and then by organ/system
  - Create a finding summary with each noted condition listed as present or absent
  - Characterize each current finding as new, stable, improving, or worsening
  - Create a single composite report with timestamps on details (as an Imaging Problem List representation not a storage artifact)?
- Support queries for particular details or types of content, e.g.
  - Present prior observations (positive/negative) about given anatomy or pathology
    - E.g. unexpected lytic lesion in a chest study might trigger a query to present any cancer or hematologic malignancy findings of which the lesion might be a metastasis. If many results are available, grouping observations by occurrence, then summarizing its history/trajectory could help. Note: studies well outside the current “field of view” become relevant in this scenario.
  - Identify any prior observations “related to” this current observation
- Provide reporting support and automation features, e.g.,
  - Highlight details present in the history/catalog that the radiologist has not (yet) commented on (to facilitate completeness)
  - Identify, and/or automatically perform, current measurements to mirror prior ones
    - Support selection of measurements in the “workspace” to go into the report, or selection of auto-populated measurements in the report to be removed (or revised)
  - Plot/present trends over time for given measurements or observations
  - Identify proposed matches between entities (e.g., nodules) in prior studies and the current study. Support tracking UIDs and/or references to registration objects.
  - Display side-by-side frames from two or more studies for correlated findings/ entities (and label them).
  - Generate a markdown file for feeding into an LLM as context.
- Provide Clinical Decision Support for the Radiologist, e.g.,
  - Suggest follow-up recommendations based on changes between prior and current and corresponding from input guidelines.
  - Based on selected/key findings, provide differential diagnosis and/or possible etiology for consideration by the radiologist and/or inclusion in the Impression.

> Note 1. Whether the software generates such a catalog on the fly from currently available priors, or whether it maintains catalog data and updates that content as needed is left to implementers.
>
> Note 2. This profile specifies an encoding (with the implied information model) for a single report. The information model for a multi-report catalog is out of scope and is left to implementers.
>
> Note 3. This profile is intended to facilitate interoperable encoding of content and index fields. Prescribing the business logic or algorithms for the above features, such as how to determine relevancy or perform spatial matching, is out of scope.
>
> Note 4. Selected details from this catalog might be incorporated into the history section and/or the finding section of the current imaging report at the discretion of the reading physician, but it is not expected that the entire catalog, or even large parts of it, would be so incorporated.
>
> Note 5. Although this use case focuses on prior imaging findings, many clinical scenarios will depend on information from the patients broader medical record, including labs, medications, social history, etc., which is not described here.

A distinction of this Use Case is that while the preceding four focus on the content of a single study, and a single report, this Use Case considers organizing data from multiple studies into a larger information model.

##### 56.4.2.5.2 Prior Finding Catalog Process Flow

<figure style="width:40%;">
{%include usecase5-processflow.svg%}
<figcaption style="text-align: center;"><b>Figure 56.4.2.5.2-1: Prior Finding Catalog Process Flow</b></figcaption>
</figure>

## 56.5 IDR Security Considerations

Imaging diagnostic reports contain personal health information (PHI)
such as demographics, findings, and other clinical information. It is
appropriate for products implementing the Imaging Diagnostic Report
(IDR) Profile to include PHI security controls. Specifying such general
mechanisms and features is outside the scope of this profile.

Similarly, products implementing the IDR Profile might implement general
mechanisms and features for tamper-proofing, repudiation, and digital
signatures, but specifying those is also outside the scope of this
profile.

Attached files in the .presentedForm, such as PDF, can be susceptible to
infection by viruses, and URLs included in the report and referenced
resources can introduce security risks. While implementations should
consider these, specifying those is outside the scope of this profile.

## 56.6 IDR Cross Profile Considerations

<b>IMR – Interactive Multimedia Report</b>

A Report Creator in IMR might be grouped with a Report Creator to
incorporate multimedia hyperlinks in the created reports.

A Report Reader and/or a Rendered Report Reader in IMR might be grouped
with a Report Reader to present, and allow the user to invoke,
multimedia hyperlinks in the created reports.

<b>IRA – Integrated Reporting Applications</b>

A Report Creator in IRA might be grouped with a Report Creator to
interact with other reporting applications during the interpretation and
report composition process.

<b>AIR – AI Results Profile</b>

An Imaging Document Consumer in AIR might be grouped with a Report
Creator to incorporate AI Result data in the interpretation and report
composition process.

<b>RRR-WF – Radiology Remote Reading Workflow</b>

A Task Performer in RRR-WF might be grouped with a Report Creator to
drive the reporting process from a reading worklist.

<b>MRRT – Management of Radiology Reporting Templates</b>

A Report Creator in MRRT might be grouped with a Report Creator to use
report authoring templates to facilitate composition of findings and
other report content by the imaging clinician.

<b>AIW-I – AI Workflow for Imaging Profile</b>

AIW-I manages AI processing. A reporting workflow manager might be
directly involved in that workflow, but the Report Creator would not. It
would interact with the resulting data objects in the imaging study.

<b>RD – Results Distribution</b>

A Report Creator in RD might be grouped with a Report Creator, Report
Repository, or Report Consumer to initiate ORU-driven behaviors such as
follow-up for critical findings.

<b>SOLE – Standardized Operational Log of Events Profile</b>

An Event Reporter in SOLE might be grouped with a Report Creator to log
reporting events.

<b>ATNA – Audit Trail and Node Authentication</b> (with the Radiology Option)

A Secure Node in ATNA is recommended to be grouped with all IDR actors
to secure the communication of, and record audit trails for, diagnostic
reports.

<b>WIA – Web-based Image Access</b>

An Imaging Document Consumer in WIA might be grouped with a Report
Reader to use DICOMweb to access and display images referenced in the
ImagingStudy Resource which is referenced in DiagnosticReport.study.

<b>XDS-I.b – Cross-Enterprise Document Sharing for Imaging</b>

The XD\* family of protocols facilitate sharing clinical documents in a
variety of formats such as PDFs or CDA. This Profile (and other ITI
Profiles) profile the use of FHIR as a format for encoding a variety of
clinical documents. Describing how FHIR documents are exchanged in an
XD\* environment is a task for the IHE IT Infrastructure Domain and is
outside the scope of this Profile.

That said, it is worth noting that for the purpose of accessing
referenced images, the information in the ImagingStudy Resource (UIDs
for Study, Series, and instances) closely mirrors the information
contained in the Manifest described in XDS-I.b.
