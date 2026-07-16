Profile:        IDRPatientHistoryProcedure
Parent:         Procedure
Id:             idr-patient-history-procedure
Title:          "IDR Patient History Procedure"
Description:    "A patient history entry describing a past procedure performed on them."

* text MS


Profile:        IDRImagingProcedure
Parent:         Procedure
Id:             idr-imaging-procedure
Title:          "IDR Reported Imaging Procedure"
Description:    "Procedure information, such as technique, materials, and processing, for the imaging procedure being reported."

* ^purpose = """
For examples of the content to be encoded, see TOLINK RAD TF-3:B.TODO.Procedure
"""
// TODO2 consider if we should de-emphasize processing (like 3D) since that may have been driven by billing, not clinical?
// TODO Add details for Rad Dose

* text MS

* complication MS
* complication ^comment = """
Condition(s) caused by the procedure, including adverse events and reactions, may be referenced here.

Note: Events during the imaging Procedure may also result in AllergyIntolerance and/or AdverseEvent resources being added to the patient record, however that is not driven by the diagnostic report and is outside the scope of the IDR profile.
"""

* note MS
* note ^comment = """
Annotations which the Technologist might create to record comments such as patient motion, or other details may be referenced here. This information should be presented or made available to the imaging clinician, but does not directly appear in the report unless dictated/selected by the imaging clinician."
"""