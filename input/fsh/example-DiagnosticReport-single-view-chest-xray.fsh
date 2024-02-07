Instance: example-DiagnosticReport-single-view-chest-xray
InstanceOf: ImagingDiagnosticReport
Title: "Simple XR Chest Report"
Description: """
--- SAMPLE REPORT ---
EXAM:
XR Chest 1 View

HISTORY:
Follow-up pleural effusion

TECHNIQUE:
Single AP view of the chest

COMPARISON:
None

FINDINGS:
The lungs are clear. No pleural effusion or pneumothorax.
The cardiomediastinal silhouette is within normal limits.
No significant osseous abnormalities.
Support lines and tubes: None.

IMPRESSION:
No active disease in the chest
"""
Usage: #example
/*
* text.status = FHIRNarrativeStatus#additional "Additional"
* text.div = "<div xmlns=\"http://www.w3.org/1999/xhtml\">
<div>
<h2>EXAM:</h2>
XR Chest 1 View
<p/>
<h2>HISTORY:</h2>
Follow-up pleural effusion
<p/>
<h2>TECHNIQUE:</h2>
Single AP view of the chest
<p/>
<h2>COMPARISON:</h2>
None
<p/>
<h2>FINDINGS:</h2>
The lungs are clear. No pleural effusion or pneumothorax.
The cardiomediastinal silhouette is within normal limits.
No significant osseous abnormalities.
Support lines and tubes: None.
<p/>
<h2>IMPRESSION:</h2>
No active disease in the chest
</div>"
*/

* basedOn[serviceRequest] = Reference(ServiceRequest/example-ServiceRequest-single-view-chest-xray)
* status = FHIRDiagnosticReportStatus#final "Final"

* subject = Reference(Patient/example-Patient)

/* Should this be CPT code or LOINC code? */
* code = LOINC#36554-4 "XR Chest Single View"
* issued = 2020-12-31T23:55:50-05:00

* performer = Reference(Organization/example-Organization)
* resultsInterpreter = Reference(Practitioner/example-Practitioner)

* study = Reference(ImagingStudy/example-ImagingStudy)

* extension[patientHistory].valueReference = Reference(Observation/example-Observation-PatientHistory)

* extension[procedure].valueReference = Reference(Procedure/example-procedure-single-view-chest-xray)

* conclusion = "No active disease in the chest"


Instance: example-Organization
InstanceOf: Organization
Title: "Organization example"
Description: "Simple Organization to be used in DiagnosticReport"
Usage: #example
* name = "YourHospital"


Instance: example-Practitioner
InstanceOf: Practitioner
Title: "Practitioner example"
Description: "Simple Practitioner to be used in DiagnosticReport"
Usage: #example
* name.family = "Guy"
* name.given = "Funny"