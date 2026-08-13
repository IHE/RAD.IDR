Profile:        IDRComparisonList
Parent:         List
Id:             idr-comparison-list
Title:          "IDR Comparison List"
Description:    "A list of ImagingStudies and/or DiagnosticReports available for comparison during reporting."

* mode = #snapshot
* mode ^comment = "The comparison list is a snapshot of what was available to the reporting physician at the time of reporting. It is not updated later."

* status = #retired
/*
TRACK JIRA-58217 submitted to request new code/clarification
Retired: The list is "old" and should no longer be considered accurate or relevant. [too harsh. It is accurate and relevant but it's not current]

Note mode #snapshot: "This list was prepared as a snapshot. It should not be assumed to be current."
*/

* entry.item only Reference(ImagingStudy or DiagnosticReport or DocumentReference)

* emptyReason 0..1 MS
* emptyReason ^comment = """
"""

/*
TRACK JIRA-58218 submitted to request new code for https://hl7.org/fhir/6.0.0-ballot5/valueset-list-empty-reason.html
Flavors of null.  Need the machine equivalent of nilknown.
*/ 
