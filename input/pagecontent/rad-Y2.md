## 2:4.Y2 Query Imaging Diagnostic Report

<div markdown="1" class="stu-note">
**NOTE TO READERS**: Transactions RAD-Y1, RAD-Y2 and RAD-Y3 are placeholders.

Both this profile (IDR) and IHE Interactive Multimedia Reports (IMR) have transactions to store and query/retrieve reports based on FHIR DiagnosticReport.

The intention is for IDR to become the base profile for reports. The IMR profile would be restructured to add its hyperlink details and behaviors either as a profile with IDR as a pre-requisite, or as named Options in IDR.

The process will involve IDR will "adopting" the IMR transactions, generalizing the names, adding any general requirements (e.g. more query details), and factoring out any multimedia content back into IMR.
</div>

### 2:4.Y2.1 Scope

This transaction is used to query for imaging diagnostic report instances.

The structure of the bundle and other constraints are specified in the Content Definition LATER.

Considerations include:

- See the Find Multimedia Report [RAD-143] transaction: https://profiles.ihe.net/RAD/IMR/RAD-143.html

TODO Fold in these example query scenarios and patterns (more in PC draft?) 6.7.3.0.1 Query Patterns for DiagnosticReport

The following are example query tasks that might be performed to obtain diagnostic reports.

The most common is expected to be a patient-level query, such as:

- GET \[base\]/DiagnosticReport?patient=Patient/{patient-id}&category=radiology

Often such a search will be constrained by date, such as:

- …&date=ge2025-01-29 (for reports since Jan 29, 2025)

Such searches will return a set of responses for presentation to a human user. A key element to display in such a list will be the DiagnosticReport.code which pre-coordinates a variety of details such as one or more body parts, one or more modalities, and other procedure details. E.g. TODO

It should be noted that details like modality or body part, are attributes of the ImagingStudy (and the Procedure) rather than the DiagnosticReport itself. As such a chained query like the following would be used to specifically query for those:

- GET \[base\]/DiagnosticReport?patient=Patient/{patient-id}  
  &study:ImagingStudy.modality={modality code}  
  &study:ImagingStudy.body-structure={anatomy code}

Similarly, a search for reports containing particular types of Observations would start by querying directly for Observations of interest (See RAD TF-3:6.7.3.6.5) and then getting the report(s) containing a specific Observation:

- GET \[base\]/DiagnosticReport?result=Observation/{observation-id}

To search for a report corresponding to an order (ServiceRequest or Accession #), either match for .basedOn reference to ServiceRequest, or match for .identifier of Accession #. If a Report has multiple accession numbers and/or ServiceRequests, it will be matched if it includes the one being searched for.

### 2:4.Y2.2 Actors Roles

**Table 2:4.Y2.2-1: Actor Roles**

| Role      | Description                                 | Actor(s)                           |
|-----------|---------------------------------------------|------------------------------------|
| Requester | Request imaging reports that match a filter | Report Reader <br> Report Consumer |
| Responder | Returns matching imaging reports            | Report Repository                  |
{: .grid}

### 2:4.Y2.3 Referenced Standards

### 2:4.Y2.4 Messages

**Figure 2:4.Y2.4-1: Interaction Diagram**

### 2:4.Y2.5 Security Considerations

The patient and clinical details provided in the imaging diagnostic report constitute personal health information.

#### 2:4.Y2.5.1 Security Audit Considerations

Requesters and Responders that support the ATNA Profile shall audit this transaction.

This transaction corresponds to a Query Information ATNA Event Trigger.
