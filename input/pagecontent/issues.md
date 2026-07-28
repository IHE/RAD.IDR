
## Significant Changes

### Significant Changes from Revision 0.0.1

Revision 0.0.1 represents the Trial Implementation draft of the first workcycle by the IHE Radiology Technical Committee on the Imaging Diagnostic Report (IDR) Profile. It was posted in 2024 but not formally published since at that point work was planned on a "Phase II" which would introduce significant changes.

This release represents the output of that Phase II activity which includes significant changes:

- JIRAs were submitted against R5 and resolved in R6 to add a number of resource elements and usage clarifications for the DiagnosticReport, Observation, Condition, Procedure, and ServiceRequest resources to better support the structure and content of medical imaging reports.
  - As a result, many details which were extensions in 0.0.1 were adopted by FHIR as core features and are now just profiled
- Phase I work focused on the overall report, and the content most relevant to the referring physician; i.e. the Impression and Recommendation content.
- Phase II included extensive information modelling and profiling how to encode finding observation content.

## Caveats

- This IHE Profile IG is writen in terms of FHIR R6.  It is intended that implementations based on R4 or R5 do so based on the FHIR cross-version packages. Those packages are still maturing.
  
### Deferred to Future Work

Work is planned to generate an increasing number of examples of finding encodings, and full diagnostic reports using this profile yet.

## Issues

### Submit an Issue

- Issues may be submitted as Change Proposals to the IHE Radiology Technical Committee:
  - See IHE Change Proposal Process: <https://wiki.ihe.net/index.php/Category:CPs>
  - Email: <radiology@ihe.net>

### Open Issues

- All declared "Open Issues" are closed as part of the Trial Implementation preparation process.
- New comments are handled as Change Proposals / JIRAs (see above)

### Closed Issues

The following issues were closed as described during the IHE Radiology Public Comment and TI Drafting process.  This record does not preclude re-opening issues that have previously been closed, but does call for introducing new information or a gap in the provided rationale.

- Q: How should we package the PC Draft for Phase II?
  - A: Use Word
  - Easier document for change tracking and to focus on new content. Include links to IG. Can do some updates in a revised IG when simpler.

- Q: Should Observation.code contain the observed property or also pre-coordinate the anatomy?
  - A: Property.
  - Duplicating .bodyStructure information into .code via pre-coordination could get messy.

- Q: Can Observation.derivedFrom be used for semantic derivation, not just mathematical?
  - A: Yes.

- Q: Should Composition be used to encode semantics and relationships between Observations?
  - A: No.
  - FHIR says "Composition may also be used to organize observations and diagnostic reports, but that is only for purpose of readability, not to record critical relationships for interpretations."

- Q: Are changes to DiagnosticReport.status required?
  - A: No.
  - IHE IDR .status comment: “Values of preliminary and final shall be used when their conventional meaning for imaging reports applies. A value of registered statemay be used while the report is being composed during the interpretation process. For addenda, a value of amended shall be used. . Note: Other FHIR status values such as modified, corrected, or appended are not profiled here. They may be addressed in a reporting workflow profile.”
  - Removed normative restrictions on the valueset.
  - EU only shares Final. Preliminary may exist but not part of the use case. EU might stay silent or not prohibit Preliminary.
  - Note (per Ignacio comment) this is the status of the Report resource, which is influenced by, but is not the primary record of, the business status of the reporting workflow.

- Q. Do patient record transfer scenarios need any profiling?
  - A: No.
  - E.g. trauma patient is transferred to an advanced center. Ideally, imaging report is pushed ahead or with the patient, but might be preliminary report and local copy is finalized and/or amended later.
  - Ultimately this is a general patient record sharing challenge that will need to be addressed generally for FHIR. It is not specific to imaging reports.

- Q: Are changes for radiation dose text required?
  - A: No.
  - Agree that in the report, dose is an optional text block, recommended in the text describing the procedure/technique. Its presence and content is driven by local reporting requirements. Diagnostic Reports are not a good dose database. Actual dose management should be based on detailed data in DICOM.  

- Q. Have we overlooked any report content/details needed for billing and administration?
  - A: No. (Not that we can think of)
  - The technical details to address report content needed for billing use cases are present (i.e. the procedure, order, reason for exam in Procedure and ServiceRequest and evidence of professional interpretation in Report.impression)

- Q: Are changes to DiagnosticReport.media required?
  - A: No.
  - Agree that media is for graphical elements like bullseye charts, vein diagrams, etc. Agree that acquired diagnostic data (which includes patient-taken photos) do not belong here. Also, the interpreted images are referenced from .study, not here. Comparison images are referenced from .comparison, not here.

- Q: Is it a problem if the EU IG refers to the Report Consumer actor as Report Processor?
  - A: Probably not.
  - Just explain that the EU Report Processor is called Report Consumer in IHE Rad Profiles. EU is considering to go with Report Consumer… Check later.

- Q: Are targeted codes for List.emptyreason and List.status needed for .comparison usage?
  - A: Not now.
  - Once usage is more clear in the future, might identify some helpful distinctions/codes to request, but for now the existing ones seem adequate. <https://build.fhir.org/valueset-list-empty-reason.html>

- Q: Where should the radiologist assessment of the quality and limitations of the study go?
  - A: For study level assessments use ImagingStudy.note to reference an Annotation; for caveats on specific observations put text in Observation.note.
  - Ultimately, it is an assessment by the radiologist of the quality of the study data in the context of the reason for the exam. Limitations may arise from how the data was handled, how the acquisition was performed, or even the (in)appropriateness of the ordered exam given the indications.
  - Chose not to get into the logistics of cross-mapping between KOS-encoded quality issue flags in this profile.
  - If there is a need to get general text into the Findings or Conclusion section, could consider profiling an Observation with .focus=ImagingStudy and .code=study limitations.

- Q. Are there any issues with the recommended post-coordination patterns in Table B.3-1?
  - A: No.
  - Post-coordination is intended to allow the flexibility of logical extension by implementations without having to obtain new pre-coordinated codes, and allows consumers of the data (for queries, or trigger logic) to handle similar situations using elemental or Boolean constructs rather than facing the prospect of not understanding new codes or having to include very long lists of related pre-coordinated codes.

- Q: Would modelling new .morphology codes such as blood be appropriate and useful?
  - A: Try it.
  - FHIR says morphology can encompass both normal and abnormal morphologies. BodyStructure is slightly ambiguous as to whether it identifies a location, or anatomical object. When used with .morphology, it is a location. ”Blood” would serve to distinguish a doppler velocity measurement of the blood at the mitral valve, from the velocity measurement of the mitral valve tissue. The alternative of considering Blood Velocity to be a property of the Mitral Valve seems odd. Precoordinating a Mitral Valve Blood as a structure also seems doo.

- Q. Should we permit an additional fully pre-coordinated value in Observation.code?
  - A: Stay silent.
  - As a CodeableConcept, Observation.code can contain multiple .coding items. These are intended to be alternate codes with the “same semantics”. Given the presence of the post-coordinated property code (as shown in Table B.3-1), the profile could describe an additional coding item that partially or fully pre-coordinates the property with the semantics in .bodyStructure.structure, .laterality, .morphology, and .interpretationContext.
  - SNOMED does model post-coordinated queries in patient records.
  - If used this might be flagged (with a new value) in CodeSystem.concept.property (<https://build.fhir.org/codesystem-concept-properties.html>) although we are dealing with an information model for observations that is not dependent on the use of a particular CodeSystem.
  - Ultimately, since such a pre-coordinated value would reflect the semantics of the Observation resource, but would exceed the semantics of the post-coordinateed .code, it would not be “equivalent” and so this usage is a stretch of 0..n .coding. Stay silent on this.

- Q. Do we want to profile the use of FHIR ObservationDefinition Resources?
  - A: Not now.
  - Might revisit later when common patterns for specific types of observation emerge. Might also see if this would apply to CDE. (Could turn into a lot of work).
  - "When an Observation instantiates an ObservationDefinition, the elements of the Observation resource are expected to inherit their content from the corresponding definitional elements declared in the ObservationDefinition resource listed here.”

- Q. Is it helpful to have a “Presence” value in the parent of a grouped Observation Set?
  - A: No.
  - That would elide the Presence concept code in Observation.code making finding presence code differently when using CDE and not. Better to use CDE as a “container”. Also that is the way the CDE schema does it.

- Q. Should we profile extensibility of Radelement CDE Sets?
  - A: Stay silent.
  - Might call out the possibility of adding sub-observations, but best let RadElement handle prompt updates or users to find workarounds without IHE weighing in.

- Q. Are requirements or guidance needed to support “fuzzy matching” for anatomy?
  - A: No.
  - RAD-Y2 operates at the Report level, where coarse anatomy is the norm and should work reasonably well.  The granularity issues arise at the Observation level.  It is likely a more sophisticated Query Observation transaction will be valuable for scenarios such as the Imaging Problem List.  That transaction is out of scope for this Phase of IDR. When created, that transaction should consider a named option for Sub-Anatomy Matching (SAM?). The following paragraphs capture considerations for that future work.
  - By default, matching is literal. A search for prior Observations on BodyStructure=\<liver\> might return a previous liver volume estimate and an observation it was “enlarged”; but it would not return Observations on the left hepatic duct, the capsule, the portal vein, the hilum, or a cyst in the caudate lobe, because none of those equal “liver”. Neither would it return potentially related findings on the gall bladder or spleen. Sometimes the user wants the narrow focus.  Sometimes the user would like to expand the search.
  - The named option requires the server to implement matching logic when the :below modifier is used in searches on BodyStructure.includedStructure.included. The effect is that the anatomic structure which is the same as the concept provided in the query (e.g. (10200004, SCT, “Liver”) will match, and any anatomic structures that are part of the concept provided in the query will match. This applies the existing FHIR search modifier :below in the way it was intended. (See <https://build.fhir.org/search.html#3.2.1.5.5.2.3>)
  - The rationale is that it is more efficient and consistent to handle such search expansion in the server. The alternative, having the client expand the search and include a very large number of “child” anatomy codes in the query would require more implementations with potentially inconsistent behaviors. The alternative of including more general codes in the coding of the BodyStructure was felt to violate the requirement for such codes to have the same semantics.
  - Further, the Server is more aware of the scope and structure of the database being searched, is better able to manage its content uniformity, and would allow centralized hosting/implementation of the anatomic modelling. It may also choose to pre-index common patterns in its query database. The option would not prescribe how the server determines what the sub-anatomies are. It might query a SNOMED server, it might pre-index anatomy codes, or something else.
  - Granted, the client is more aware of the user task and context. In practical terms the client can provide client-side filtering to manage browse the results if the server-side filtering is able to constrain the results to a “manageable” number of properly annotated results.
  - If the option is found to be useful, future options might be added to match anatomical structures of which the provided code is a part (e.g. a query on a specific lobe could also return observations on the lung as a whole) and/or provide additional parameters. The FHIR :in=\<ValueSet\> modifier might also facilitate some of this kind of thing.

- Q. How should we approach consolidating the IMR and IDR Profiles?
  - A: leave to an IMR focused group
  - Might re-package as an IMR Option in the IDR Profile, or might do IMR.b, but in either case, IDR establishes a context/framework and there has been a lot of technical evolution that IMR should take into account.
  - Would need to consider if we merge RAD-141/RAD-Y1 (Store) and RAD-143/RAD-Y2 (Query). Probably keep RAD-142 (Display) and RAD-144 (Get Rendered Report).

- Q. Do we need to profile specific Provenance Resource usages?
  - A: No.
  - Signing a bundle is already specified. While there could be additional Provenance resources for things like radiologist approval of a set of AI spine measurements while indicating that one was replaced by the radiologists own assessment, that is more part of the workflow/dataflow and associated QA than Diagnostic Report.
