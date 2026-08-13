Profile:        IDRObservation
Parent:         Observation
Id:             idr-observation
Title:          "IDR Imaging Observation"
Description:    "Findings and/or impressions in imaging reports"

// TODO note that implementation is permitted to not follow the child profiles if they are unable to represent the semantics. (Be prepared to defend that at Connectathon)

* text MS

* identifier ^comment = """
MAY include an observationUID as described in the DICOM SR to FHIR Resource Mapping IG. (<http://hl7.org/fhir/uv/dicom-sr/StructureDefinition/imaging-measurement-group>)
"""

// MAY include a reference to the imaging ServiceRequest(s) reported
* basedOn 0..* MS

* basedOn ^slicing.discriminator.type = #type
* basedOn ^slicing.discriminator.path = resolve()
* basedOn ^slicing.rules = #open
* basedOn ^slicing.description = "Slice based on the basedOn reference type"

* basedOn contains serviceRequest 0..*
* basedOn[serviceRequest] only Reference(IDRImagingServiceRequest)
* basedOn[serviceRequest] ^comment = """
The associated ServiceRequest is not necessarily replicated in each Observation since it is not commonly needed for search or processing purposes.  
For provenance purposes, it is available in the DiagnosticReport from which the Observation referenced.
"""

// Shall reference one Patient
* subject 1..1
* subject only Reference(Patient)
* subject ^short = "The imaged patient"

* encounter 0..1 MS
* encounter ^short = "The imaging procedure encounter"
* encounter ^definition = "The encounter during which the imaging procedure took place on which this observation was made."
* encounter ^comment = """
The associated encounter is not necessarily replicated in each Observation since it is not commonly needed for search or processing purposes.  
For provenance purposes, it is available in the DiagnosticReport from which the Observation referenced.
"""

* partOf ^comment = """
The associated ImagingStudy is not necessarily replicated in each Observation since it is not commonly needed for search or processing purposes.  
For provenance purposes, it is available in the DiagnosticReport from which the Observation referenced.
The associated DiagnosticReport is not necessarily replicated in each Observation since the DiagnosticReport references the Observation and can thus be found via reverse search.
"""

// Include "imaging" in category values and permit ACR actionability codes
* category ^slicing.discriminator.type = #pattern
* category ^slicing.discriminator.path = "$this"
* category ^slicing.rules = #open
* category contains imaging 1..1 and actionability 0..1 MS

* category[imaging] = $FHIRObservationCategory#imaging
* category[imaging] ^short = "Categorize this as an imaging observation"
* category[imaging] ^comment = "This can be useful when searching or filtering for imaging observations"

* category[actionability].coding.system = $RADLEX
* category[actionability] from IDRACRActionableFindingCategoryVS (preferred)
* category[actionability] ^short = "Categorize this as an actionable observation"
* category[actionability] ^comment = """
Observations which represent actionable findings (see ACR Code definitions), including both incidental findings and findings within the scope of the reason for exam, can be individually highlighted in the report at the discretion of the imaging clinician using the Observation.category. Actionable findings are almost always referenced in the Impression of the Diagnostic Report (See TODO). Not all Impression findings are necessarily actionable. 

Observation.category SHOULD, if such information is readily available, include a code to indicate the degree to which a finding is actionable. Such information can be tremendously useful to downstream care management. Codes may be drawn from the RadLex codes for the ACR Actionable Finding Categories described in IHE Results Distribution (RD).

> Note 1. While the presence of a Recommendation for a given impression is an implicit indication that it is actionable. Having an explicit code can help with subsequent tracking and follow-up.
>
> Note 2. Conversely, actionable findings do not always have a corresponding Recommendation. For example, an identified pneumothorax is a well-known entity to the referring clinician with standard actions to address it. The imaging clinician would be unlikely to re-iterate those actions in the report.
>
> Note 3. Category 1 and Category 2 codes constitute "critical findings" which often result in direct Communications (see Section 6.7.3.9) due to the clinical urgency.
>
> Note 4. The presence of actionability codes might support, or directly trigger, the creation of Flag resources by the referring physician, consuming systems, or even the radiologist. Such behaviors are described in IHE RAD TF-1:56.4.2.4.1.3 but are not a requirement in this profile.
"""

* status MS
* status ^comment = """
Typically set to http://hl7.org/fhir/ValueSet/observation-status#final for observations in the initial final report. 
Other values from the observation status valueset, such as amended and entered-in-error, may be used as appropriate for amended reports.
"""

* effective[x] 1..1 MS
* effective[x] ^short = "Image acquisition datetime"
* effective[x] ^definition = "Datetime corresponding to the acquisition of the image(s) on which this observation is made"
* effective[x] ^comment = """
Since different images within a study are often acquired at different time points which can be clinically significant, this value is expected to be as precise and specific as practical. In the case of a measurement made on a specific frame, this would be the exact frame time. In the case of an observation the radiologist made without indicating a specific image, this might be a series datetime or the overall study datetime.
For Observations made on a comparison imaging studies (i.e. priors) that are included in a current report, either by referencing existing Observation resources or creating new Observation resources based on prior report text, the .effective datetime corresponds to the acquisition of the image in the comparison study.
For Observations that are a comparative observation between an older image and a more recent image (e.g. an observation that a tumor has shrunk) use the datetime of the more recent image.
"""

* note ^comment = """
If present, may describe caveats about the reliability of this observation, such as limitations imposed by the nature or quality of the imaging. General statements about limitations of the study that are not specific to this observation may be described in the Procedure. An implementation might also choose to encode a separate Observation specifically about quality issues where .focus=ImagingStudy and .code and .value are populated with codes drawn from DICOM PS3.16 or the IHE Reject Analysis & Monitoring (RAM) Profile.
"""

// TODO * context MS once ballot5 is supported

* performer only Reference(Practitioner or PractitionerRole or Organization)
* performer ^comment = """
The performer is not necessarily replicated in each Observation since it is not commonly needed for search or processing purposes.  
For provenance purposes, it is available in the DiagnosticReport from which the Observation referenced.
"""

* device ^short = "Software Device that generated the imaging observation content"
* device ^comment = """
This might be an AI model or clinical application. This is not the device that produced the study image(s) unless that system also produced this observation.
"""

* derivedFrom 0..* MS
* derivedFrom ^definition = "A resource that represents data from which this observation value is derived."
* derivedFrom ^comment = """
This might be pre-cursor observations. E.g. linear tumor dimension observations might be referenced from the derived volume estimation observation.  This can also be used to reference ImagingSelection resources that identify the specific data from which this observation was derived.

This element typically does not reference the ImagingStudy since that is a broad data container and it can be found via the DiagnosticReport that contains this imaging Observation.
"""

* triggeredBy ^comment = """
For imaging observations, it is recommended that this element be absent. 

The triggeredBy concept is primarily for lab observations. It should not be used to reference the ServiceRequest (which appears in .basedOn), or to include the reason for exam (which appears in the referenced ServiceRequest).
"""

* interpretation ^comment = """
For imaging observations, it is recommended that this element be absent.

Radiologist interpretations (findings based on the assessment of one or more observations) are uniformly captured in separate Observation resources rather than sometimes being included as .interpretation elements of other Observations.

For example, a qualitative breast density assessment of “very dense” is an assessed characteristic observation (see RAD TF-3:6.7.3.6.2.5). A quantitative breast density could also be provided on its own and would be encoded as a measured property observation (see RAD TF-3:6.7.3.6.2.4).  It would be disruptive if, when both are provided, the qualitative assessment sometimes appeared in the .interpretation of the measured property. That would require consumer applications to handle two different encoding patterns to find the qualitative information. It is simpler to generate two observations.

This element is historically used for laboratory results (known as 'abnormal flag'), with simpler patterns of interpretation and presentation.
"""

// TODO Keep? Check ImagingSelection Profiling file
* derivedFrom ^slicing.discriminator.type = #type
* derivedFrom ^slicing.discriminator.path = resolve()
* derivedFrom ^slicing.rules = #open
* derivedFrom ^slicing.description = "Slice based on the derivedFrom reference type"

* derivedFrom contains imagingSelection 0..*
* derivedFrom[imagingSelection] only Reference(ImagingSelection)


ValueSet: IDRACRActionableFindingCategoryVS
Id: idr-acr-actionable-finding-category-vs
Title: "IDR ACR Actionable Finding Category Value Set"
Description: "Category Codes indicating the actionability/urgency of a finding as defined by the American College of Radiology (ACR).
Cat 1 is defined as requiring immediate medical attention within minutes.
Cat 2 is defined as requiring medical attention within hours.
Cat 3 is defined as requiring medical attention within days to months.
"
* $RADLEX#RID49480 "Cat 1 Emergent Actionable Finding"
* $RADLEX#RID49481 "Cat 2 Urgent Actionable Finding"
* $RADLEX#RID49483 "Cat 3 Non-critical Actionable Finding"


Profile:        IDRObservationMeasuredProperty
Parent:         IDRObservation
Id:             idr-observation-measured-property
Title:          "IDR Measured Property Observation"
Description:    "A quantitative observation of a property or feature in the image (typically determined using a measurement tool or application, although they could be estimated)

In contrast, a computed property is computed from other measurements instead of being measured directly. Those base measurements can be encoded as described here and the computed property can be encoded as described in TODO Link 6.7.3.6.3.4. 

For measurements that are taken using a caliper or other measurement tool, although some computation is involved, that is still considered a direct property measurement.

When a property that is measurable is instead assessed qualitatively, it can be encoded as an assessed characteristic (See [IDR Assessed Characteristic Observation Profile](StructureDefinition-idr-observation-assessed-characteristic.html)). E.g., in the absence of a measurement capturing that the main pancreatic duct width is 5 mm, an observation that the main pancreatic duct width is dilated might be recorded. Similarly, an adrenal gland size might be recorded as being enlarged.
"

* code ^short = "The property measured"
* code ^definition = "A property or feature in the image that is observed quantitatively (typically using a measurement tool or application, although it could be estimated)"
* code ^comment = """
The code shall not pre-coordinate the associated anatomy. 

Observation.code will sometimes need to distinguish between related properties of the measured entity or location. For example, one observation at the mitral valve using doppler ultrasound might use a code to indicate blood velocity is the property measured, while a second observation at the same location might use a different code to indicate tissue velocity is the property measured.
"""

* bodyStructure ^short = "The entity who's property is being measured"
* bodyStructure only Reference(IDRAnatomicEntity or IDRPathologicEntity or IDRPhysicalObjectEntity)

* value[x] ^short = "The measurement value."
* value[x] 1..1 MS
* value[x] ^comment = """
If the measurement is not unitless, the units shall be recorded.

Two different Observations might have the same .code but use different units in .value. Sites and observers may prefer different scales.

Comparative measurements such as volume change may be expressed in absolute terms (e.g. -22 mm3) or in relative terms (e.g. -25%).
"""

/* TODO uncomment when sushi supports ballot5, or update to interpretationContext when Sushi supports ballot4.
* context ^comment = """
May be used to record details of how the property was measured, e.g., for a diameter measurement of the left ventricle, .context might contain three codes, one for end diastole, one for apical 4-chamber view, and one for ultrasound B-mode.

As an alternative to recording codes, .context also permits referencing another Observation to use a concept-value pair pattern (e.g. Observation.code\=Cardiac Phase and Observation.value\=End Diastole) if that provides more clarity than a code by itself. A single such context Observation can be referenced from multiple measurement Observations to which it applies.
"""
*/

* derivedFrom ^short = "Specific data this measurement was derived from."
* derivedFrom ^definition = "Resources such as Imaging Selections from which this measurement was created."
* derivedFrom ^comment = """
This might reference a corresponding ImagingSelection which could include the specific coordinates and caliper shape used for the measurement. E.g. line coordinates in the ImagingSelection from which the diameter value in the Observation was derived.
- ImagingSelection coordinates are in the Frame of Reference of the Image on which they are placed.
- DICOM Frame of Reference UID (0020,0052) uniquely identifies the existence of a spatial frame of reference for an image. The origin and axes of the corresponding coordinate space are defined by the associated imaging data and metadata.
- If a referenced ImagingSelection.bodySite is present, it is expected that the value be consistent with this Observation.bodyStructure. Since the ImagingSelection is supportive information while the Observation elements are primary, in the event the values are different, the value in Observation takes precedence when interpreting the Observation.  E.g. the Observation.bodyStructure might identify a left breast mass for which a diameter is observed, while the ImagingSelection.bodySite might do the same, or might identify that it's coordinates are in the 5 o'clock region of the left breast.
- Similarly, values of Observation.subject and Observation.focus take precedence over corresponding values (if present) in a referenced ImagingSelection.  
"""

* component 0..0

Profile:        IDRObservationAssessedCharacteristic
Parent:         IDRObservation
Id:             idr-observation-assessed-characteristic
Title:          "IDR Assessed Characteristic Observation"
Description:    "A qualitative assessment of a characteristic or feature in the image.
"

* code ^short = "The characteristic assessed"
* code ^definition = "A characteristic or feature in the image that is assessed qualitatively"
* code ^comment = """
The code shall not pre-coordinate the associated anatomy. 
"""

* bodyStructure ^short = "The entity who's characteristic is being assessed"
* bodyStructure only Reference(IDRAnatomicEntity or IDRPathologicEntity or IDRPhysicalObjectEntity)

* value[x] ^short = "The assessment result."
* value[x] 1..1 MS
* value[x] ^comment = """
TODO
"""

/* TODO uncomment when sushi supports ballot5, or update to interpretationContext when Sushi supports ballot4.
* context ^comment = """
May be used to record details of how the assessment was performed, e.g., codes indicating the timing of the assessment, or the guidelines/criteria used.
"""
*/

* derivedFrom ^short = "Specific data this assessment was derived from."
* derivedFrom ^definition = "Resources such as Imaging Selections from which this assessment was created."
* derivedFrom ^comment = """
This might, when the assessment is localized to a particular image or spatial location, reference an ImagingSelection that includes the relevant image, frame, region, volume, and/or coordinates of the assessed feature.
- If a referenced ImagingSelection.bodySite is present, it is expected that the value be consistent with this Observation.bodyStructure. Since the ImagingSelection is supportive information while the Observation elements are primary, in the event the values are different, the value in Observation takes precedence when interpreting the Observation. 
- Similarly, values of Observation.subject and Observation.focus take precedence over corresponding values (if present) in a referenced ImagingSelection.  
"""

* component 0..0

Profile:        IDRObservationConditionPresence
Parent:         IDRObservation
Id:             idr-observation-condition-presence
Title:          "IDR Condition Presence Observation"
Description:    "An observation of the presence or absence of a condition (i.e. a pathologic entity)"

* code ^short = "An observation of the presence of a condition"
* code ^definition = "An observation of whether or not an identified condition is present or absent."
* code ^comment = """ 
"""
* code = $SCT#705057003 "Presence"

* bodyStructure ^short = "The pathologic entity (condition) and anatomical location being assessed"
* bodyStructure only Reference(IDRPathologicEntity)

* value[x] ^short = "The assessment result."
* value[x] 1..1 MS
* value[x] ^comment = """
Note. $SCT#52101004 “Present” and $SCT#272519000 “Absent” are considered to mean that within the capabilities of the equipment and the observer to do so, the condition has been determined to be present/absent, and thus when used here the codes are semantically equivalent to $SCT#260373001 “Detected” and $SCT#260415000 “Not detected”.
"""
* value[x] only CodeableConcept
* valueCodeableConcept from IDRPresenceVS (preferred)

* component 0..0

ValueSet: IDRPresenceVS
Id: idr-presence-vs
Title: "IDR Presence Value Set"
Description: "Recommended values for reporting whether a finding is present, absent, or its presence could not be determined."
* $SCT#52101004 "Present"
* $SCT#272519000 "Absent"
* $SCT#82334004 "Indeterminate"

Profile:        IDRObservationNormalityAssessment
Parent:         IDRObservation
Id:             idr-observation-normality-assessment
Title:          "IDR Normality Assessment Observation"
Description:    "An observation of the normality an anatomic entity"

* code ^short = "An observation of the normality an anatomic entity"
* code ^definition = "An observation of whether or not an identified anatomic entity is normal or abnormal."
* code ^comment = """ 
"""
* code = $SCT#276800000 "Normality"

* bodyStructure ^short = "The anatomic entity being assessed"
* bodyStructure only Reference(IDRAnatomicEntity)

* value[x] ^short = "The assessment result."
* value[x] 1..1 MS
* value[x] ^comment = """
Note 1. \"Lungs are unremarkable\", \"Lungs are normal\", and \"No pulmonary abnormality\" are considered semantically equivalent renderings of Normality=Unremarkable for BodyStructure=Lungs.

Note 2. For an anatomic entity observed as \"Abnormal\", details about the nature of an abnormality, including  situations where the anatomic entity is surgically absent or congenitally absent, are coded as an additional observation. An Assessed Characteristic observation (See [IDR Assessed Characteristic Observation Profile](StructureDefinition-idr-observation-assessed-characteristic.html)) or a Condition Presence observation (See [IDR Condition Presence Observation Profile](StructureDefinition-idr-observation-condition-presence.html)) may be appropriate.
"""
* value[x] only CodeableConcept
* valueCodeableConcept from IDRNormalityVS (preferred)

* component 0..0

ValueSet: IDRNormalityVS
Id: idr-normality-vs
Title: "IDR Normality Value Set"
Description: "Recommended values for reporting whether an anatomic entity is normal, abnormal, or its normality could not be determined."
* $SCT#263654008 "Abnormal"
* $SCT#17621005 "Normal/Unremarkable"
* $SCT#82334004 "Indeterminate"

Profile:        IDRObservationUnstructured
Parent:         IDRObservation
Id:             idr-observation-unstructured
Title:          "IDR Unstructured Observation"
Description:    "An observation that is fully unstructured.

Unstructured observations might be particularly useful for complex sentences in the report narrative with advanced semantics that are challenging to encode.
"

* code ^short = "An observation consisting of fully unstructured narrative"
* code ^definition = "An observation where the entire finding is unstructured narrative."
* code ^comment = """ 
"""
* code = $99IHEIDR#IDR01 "Unstructured Observation"

* bodyStructure ^short = "The target body structure is not coded."
* bodyStructure 0..0

* value[x] ^short = "The unstructured narrative text."
* value[x] 1..1 MS
* value[x] ^comment = """
The valueString text should describe the target image entity, the image feature and the observation result. The text is permitted to describe multiple observations, although it is not intended to contain an entire section or report. To the extent that it is practical, it is recommended to split multiple unstructured observations into multiple Observation resources. This recommendation is further supported by the fact that valueString is not supposed to contain formatting characters, and any markdown characters are treated as literal, not formatting.
"""
* value[x] only string

* component 0..0

Profile:        IDRObservationUnstructuredFeature
Parent:         IDRObservation
Id:             idr-observation-unstructured-feature
Title:          "IDR Unstructured Feature Observation"
Description:    "An observation that is unstructured narrative describing a coded entity.

If both the observation finding site and the image feature can be coded and only the value is unstructured, it is recommended to instead encode the observation as an assessed characteristic (See [IDR Assessed Characteristic Observation Profile](StructureDefinition-idr-observation-assessed-characteristic.html)) and use a private code or a text value.
"

* code ^short = "An observation with unstructured narrative and coded bodyStructure"
* code ^definition = "An observation with unstructured narrative and coded bodyStructure."
* code ^comment = """ 
"""
* code = $99IHEIDR#IDR02 "Unstructured Feature"

* bodyStructure ^short = "The entity being observed."
* bodyStructure only Reference(IDRAnatomicEntity or IDRPathologicEntity or IDRPhysicalObjectEntity)

* value[x] ^short = "The unstructured narrative text."
* value[x] 1..1 MS
* value[x] ^comment = """
The valueString text should describe the image feature and the observation result. The text may or may not reiterate the finding site (bodyStructure). The text is permitted to describe multiple features and observation results. To the extent that it is practical, it is recommended to split multiple unstructured features into multiple Observation resources. 
"""
* value[x] only string

* component 0..0

Profile:        IDRObservationFindingSet
Parent:         IDRObservation
Id:             idr-observation-finding-set
Title:          "IDR Finding Set Observation"
Description:    "An observation that is the root of a set of observations (Finding Set) that collectively represent an assessment of a particular feature or pathology.

The root finding is encoded as shown here. The associated observations that make up the set SHALL each be encoded in a separate Observation referenced from .hasMember.

See <https://www.radelement.org> for a large collection of Finding Sets.
"

* code ^short = "The root observation of the Finding Set"
* code ^definition = "An observation TODO."
* code ^comment = """
When encoding CDE Sets from radelement.org, it is preferred to use the CDE Set code, such as (RDES195, RadElement, “Pulmonary Nodule”) here.
"""
// TODO consider pointing to CDE as an example binding.

* bodyStructure ^short = "The entity being observed."
* bodyStructure only Reference(IDRAnatomicEntity or IDRPathologicEntity or IDRPhysicalObjectEntity)

* value[x] 0..0
* value[x] ^comment = """
The root finding SHALL NOT have a value. The presence of the pathology is represented in the first associated observation.
"""

* hasMember ^short = "The observations in the Finding Set"
* hasMember ^definition = "The observations that comprise the Finding Set as defined by the code of the root observation"
* hasMember ^comment = """
These associated observations are expected to follow the specifications defined by the code of the root observation (e.g. the CDE Set on radelement.org).

The first associated observation is a Condition Presence observation (See [IDR Condition Presence Observation Profile](StructureDefinition-idr-observation-condition-presence.html)) indicating whether the root pathology is present or absent.

Since FHIR discourages bi-directional references, the associated observations do not typically reference the root finding Observation. Given an associated Observation, the root finding Observation is found via a FHIR reverse chaining search on hasMember.

The use of .hasMember is intended to carry a subtle implication here that subsequent viewers of this data may often be interested in seeing the associated observations presented alongside the root finding. This differs from .derivedFrom Observations which are less likely to be initially viewed with their parent unless there is a need to confirm the provenance of the parent observation.

Observation.component is not used here as FHIR limits it to observations that are not useful on their own, giving the example that a BMI Observation “… should not contain components for height and weight because they are clinically relevant observations on their own and should be represented by separate Observation resources.” Further, “Components should only be used when there is only one method, one observation, one performer, one device, and one time.” The use of component also has the potential to significantly complicate queries.

For elements like Observation.device or Observation.derivedFrom, the associated observations may have different values from each other as appropriate (e.g. if observations were obtained from different pieces of software, or observations were made on different frames or pixels as recorded via ImagingSelections).
"""
* hasMember 1..* MS

// The first member must be a presence observation
* hasMember ^slicing.discriminator.type = #profile
* hasMember ^slicing.discriminator.path = "resolve()"
* hasMember ^slicing.rules = #open
* hasMember ^slicing.ordered = true
* hasMember contains ConditionPresence 1..1 and OtherFindings 0..*
* hasMember[ConditionPresence] only Reference(IDRObservationConditionPresence)
// TODO expand to list the Profiles 
* hasMember[OtherFindings] only Reference(IDRObservation)

* organizer = true
* organizer 1..1

* component 0..0

Profile:        IDRObservationSummary
Parent:         IDRObservation
Id:             idr-observation-summary
Title:          "IDR Summary Observation"
Description:    "An observation that is a summarization or compilation of other observations.

For example, consider the *-RADS scoring systems from ACR (https://www.acr.org/Clinical-Resources/Clinical-Tools-and-Reference/Reporting-and-Data-Systems). The Observation.code would contain the top-level score concept, such as $SCT#146611000146107 “BIRADS Assessment Category” and Observation.value would contain the score value, such as $SCT#39714307 ”3 – Probably Benign”.

The sub-observations from which the score is derived are each encoded in a separate Observation referenced from .derivedFrom. These sub-observations are commonly useful in their own right.

The bodyStructure of this observation reflects the target entity of the summary observation. The bodyStructure of the sub-observations can differ from this and from each other. 

Per the Observation resource semantics, if Observation.organizer is present, it will have a value of false.
"

* code ^short = "The observation concept of the summary"
* code ^definition = "An observation that is a summarization/compilation of subordinate observations, such as a category score like BI-RADS (https://acr.org/birads)."
* code ^comment = """
"""

* value[x] ^short = "The observation value of the summary"

* derivedFrom ^short = "The sub-observations of the summary"
* derivedFrom ^comment = """
The summary observation shall reference the underlying sub-observations from which the summary was derived. It is permitted to include all the observations that were a part of the summary assessment procedure, even if specific observations did not factor into the final summary value.

The referenced sub-observations are expected to follow the specifications defined by the summary observation system (e.g. the BI-RADS Lexicon defines both the overall assessment category score, and the criteria and form of the contributing observations).

Since FHIR discourages bi-directional references, the sub-observations do not typically reference the root finding Observation. Given a sub-Observation, the summary Observation is found via a FHIR reverse chaining search on derivedFrom.
"""
* derivedFrom 1..* MS

* component 0..0

Profile:        IDRObservationScoreTotal
Parent:         IDRObservation
Id:             idr-observation-score-total
Title:          "IDR Score Total Observation"
Description:    "An observation that is a score that is a total of score components.

For example, consider the Balthazar Score or CT Severity Index for Pancreatitis. Each consists of sub-components whos numerical values are totaled to arrive at the observation score.

A key distinction between a Score Total and a Summary Observation, is that the components, such as “pancreatic necrosis = 4 points”, of a Multi-factor Score do not make sense as an observation outside the context of the Multi-factor Score, while the child Observations, such as “nodule is growing”, of a Summary Observation do make sense as observations even outside the context of the Summary Observation.

Per the Observation resource semantics, if Observation.organizer is present, it will have a value of false.
"

* code ^short = "The observation concept of the total score"
* code ^definition = "An observation that is a numerical total of score components, such as the Balthazar Score or CT Severity Index for Pancreatitis."
* code ^comment = """
The code shall not pre-coordinate the associated anatomy. 
"""

* value[x] ^short = "The total score value"

* derivedFrom ^short = "The observations in the Finding Set"
* derivedFrom ^definition = "The observations that comprise the Finding Set as defined by the code of the root observation"
* derivedFrom ^comment = """
The observation may reference an ImagingSelection here if appropriate.

The components of the score are not referenced here. Those may be recorded in Observation.component.
"""

* component 0..* MS
* component ^short = "The score components"
* component ^definition = "The factors that contributed to the total score value of the observation"
* component ^comment = """
The observation is permitted to omit the factors, but they are generally considered helpful to record for provenance purposes. It is recommended that if the factors are captured as components that all factors be captured. 
"""

Profile:        IDRObservationComputedProperty
Parent:         IDRObservation
Id:             idr-observation-computed-property
Title:          "IDR Computed Property Observation"
Description:    "An observation that property computed from other observations."

* code ^short = "The observation concept of the computed property"
* code ^definition = "An observation that is a property computed from subordinate observations, such as a volume computed from one or more diameter observations."
* code ^comment = """
"""

* value[x] ^short = "The computed value."
* value[x] 1..1 MS
* value[x] ^comment = """
If the measurement is not unitless, the units shall be recorded.

Two different Observations might have the same .code but use different units in .value. Sites and observers may prefer different scales.

Note 1. The computation is not required to be strictly numerical. It might also involve Boolean or other logic.
"""

* derivedFrom ^short = "The sub-observations on which the computation was performed"
* derivedFrom ^comment = """
The computed property observation shall reference underlying sub-observations from which it was computed. 

Since FHIR discourages bi-directional references, the sub-observations do not typically reference the computed property Observation. Given a sub-Observation, the computed property Observation is found via a FHIR reverse chaining search on derivedFrom.

Generally, any ImagingSelection(s) are referenced from the sub-observations, not directly from the computed property observation.
"""
* derivedFrom 1..* MS

* component 0..0
* hasMember 0..0

Profile:        IDRObservationSRMeasurementGroup
Parent:         IDRObservation
Id:             idr-observation-sr-measurement-group
Title:          "IDR SR Measurement Group Observation"
Description:    "A set of observations that correspond to a DICOM SR Measurement Group, but do not fit any of the other relationship pattern Profiles.

This includes the use case of transcoding a DICOM SR Measurement Group into FHIR Observations.

The root finding is encoded as shown here. The associated observations that make up the Measurement Group SHALL each be encoded in a separate Observation referenced from .hasMember.

Per FHIR, since Observation.organizer is set to true for the root Measurement Group observation, Observation.value is absent.
"

* code ^short = "The root observation or concept of the Measurement Group"
* code ^definition = "An observation TODO."
* code ^comment = """
The code shall identify the nature of the Measurement Group. In some cases, the source DICOM SR object might not provide any information, in which case this code might simply be (125007, DCM, “Measurement Group”).
"""

* hasMember ^short = "The observations in the Measurement Group"
* hasMember ^definition = "The observations that comprise the Measurement Group defined by the code of this root observation"
* hasMember ^comment = """
"""
* hasMember 1..* MS

* organizer = true
* organizer 1..1

* component 0..0

Profile:        IDRObservationCompoundStatement
Parent:         IDRObservation
Id:             idr-observation-compound-statement
Title:          "IDR Compound Statement Observation"
Description:    "A set of observations that were expressed as a compound statement. E.g. The Liver, gallbladder, pancreas, and spleen are unremarkable.

The compound statement text is in this root observation. The individual observations shall each be encoded in separate Observations referenced from .hasMember.

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

Per FHIR, since Observation.organizer is set to true for the root Measurement Group observation, Observation.value is absent.
"

* code ^short = "The root observation that holds the compound statement"
* code ^definition = "An observation TODO."
* code ^comment = """
Since the detailed semantics are captured in the subordinate observations, may be general, such as \"Compound Statement\".
"""

* hasMember ^short = "The individual observations"
* hasMember ^definition = "The individual observations contained in the compound statement"
* hasMember ^comment = """
"""
* hasMember 1..* MS

* organizer = true
* organizer 1..1

* component 0..0

