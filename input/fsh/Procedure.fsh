Profile:        IDRImagingProcedure
Parent:         Procedure
Id:             idr-imaging-procedure
Title:          "IDR Reported Imaging Procedure"
Description:    "Procedure information, such as technique, materials, and processing, for the imaging procedure being reported."

* ^purpose = """
For examples of the content to be encoded, see TOLINK RAD TF-3:B.TODO.Procedure
"""
// TODO2 consider if we should de-emphasize processing (like 3D) since that may have been driven by billing, not clinical?

* text MS

* status ^comment = """
Status will typically be “completed” when the report on the procedure is being created.
"""

* complication MS
* complication ^comment = """
Condition(s) caused by the procedure, including adverse events and reactions, may be referenced here.

Note: Events during the imaging Procedure may also result in AllergyIntolerance and/or AdverseEvent resources being added to the patient record, however that is not driven by the diagnostic report and is outside the scope of the IDR profile.
"""

* note MS
* note ^comment = """
The Technologist might create Annotations which may be referenced here to record comments about procedure issues such as patient motion, or contrast irregularities. This information should be presented or made available to the imaging clinician, but does not directly appear in the report unless dictated/selected by the imaging clinician.
"""

* outcome ^comment = """
May include a reference to an Observation that contains the text block describing the radiation dose summary. 
"""
* outcome ^slicing.discriminator.type = #pattern
* outcome ^slicing.discriminator.path = "$this"
* outcome ^slicing.rules = #open

* outcome contains doseSummary 0..1
* outcome[doseSummary] only CodeableReference(IDRRadiationDoseSummary)
* outcome[doseSummary] ^short = "Radiation Dose Summary Text"

Profile:        IDRRadiationDoseSummary
Parent:         Observation
Id:             idr-radiation-dose-summary
Title:          "IDR Radiation Dose Summary Text Observation"
Description:    "A block of text summarizing the radiation dose attributed to an imaging procedure, typically to satisfy legal or regulatory requirements.  Applications which need more than summary text information are referred to the detailed dose data that is commonly encoded and stored in the Imaging Study as DICOM Radiation Dose Structured Report (RDSR) objects.
"

* code = $99IHEIDR#IDR03 "Procedure Radiation Dose Summary Text"

* value[x] only string
* value[x] ^comment = """
Recent FHIR IG work allows the Dose Reporter to provide the Report Creator with a formatted, locally-conformant block of text that assembles the correct subset of dose details for the specific procedure type for insertion into the report (typically to comply with local regulations). That block of text can be stored here as an observed Procedure outcome and used in the diagnostic report.
"""