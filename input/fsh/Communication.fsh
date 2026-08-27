Profile:        IDRCommunication
Parent:         Communication
Id:             idr-communication
Title:          "IDR Communication"
Description:    "Communication of impressions, critical results and/or actionable findings in Imaging Diagnostic Reports."

* text 1..1 MS
* text ^definition = """
A summary sentence describing the communication, as currently appears in report narratives.

The most minimal unstructured Communication resource might have just .status and .text populated.
"""

* basedOn ^comment = """
This is often absent unless there was a specific request for the communication that can be referenced.  See communication.reason for communications triggered by specific findings.
"""

//Dropped partOf to remove the bidirectional reference. DiagnosticReport references the Communication. Can find report by reverse search (or dates and subject, etc) 

* status ^comment = """
The value will often be COMPLETED to reflect communications completed before the report was finalized and signed. When documenting attempted communications, the status might have another value.

Communication resources where the .status is not COMPLETED may trigger subsequent follow-up workflows, but the management of such follow-up is not reflected in the diagnostic report.

In some reporting workflows, follow-up communications may be included in an Addendum to the report (e.g. when the report is distributed prior to the communication being successfully completed).
"""

* medium MS
* medium ^comment = """
The value will typically be PHONE, or in the case of leaving a voicemail message, DICTATE.
"""

* subject 1..1 MS
* subject only Reference(Patient)

* topic MS
* topic ^comment = """
May contain the code for \"summary-report\". Sites may also choose to use a code for critical findings. 
"""

* about MS
* about ^comment = """
The value can include any or all of the specific impression Conditions or recommendation ServiceRequests discussed during the communication if such information is made available to the encoding system. 
"""

* encounter ^comment = """
Should either reference the encounter for the imaging procedure, or be absent.
"""

* sent 1..1 MS

* received MS
* received ^comment = """
For phone communications, this value will typically be the same time as Communication.sent. In the case of leaving a message, this will likely be be absent since it won't be known and the resource is not expected to be updated.
"""

* sender MS
* sender ^comment = """
The value will be the imaging clinician in most cases but may be their staff.
"""

* recipient MS
* recipient ^comment = """
The value will be the patient or the referring clinician in most cases, but may be their staff or proxy.
"""

* reason MS
* reason ^comment = """
In most cases, .reason can reference the particular impression Observations and/or recommendation ServiceRequests that motivated the communication.

Textual reasons can be captured using reason.concept.text.
"""
