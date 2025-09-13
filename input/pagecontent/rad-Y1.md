## 2:4.Y1 Store Imaging Diagnostic Report

<div markdown="1" class="stu-note">
**NOTE TO READERS**: Transactions RAD-Y1, RAD-Y2 and RAD-Y3 are placeholders.

Both this profile (IDR) and IHE Interactive Multimedia Reports (IMR) have transactions to store and query/retrieve reports based on FHIR DiagnosticReport.

The intention is for IDR to become the base profile for reports. The IMR profile would be restructured to add its hyperlink details and behaviors either as a profile with IDR as a pre-requisite, or as named Options in IDR.

In Phase II of IDR, IDR will "adopt" the IMR transactions, generalize the names, add any general requirements (e.g. more query details), and factor out any multimedia content back into IMR.
</div>

### 2:4.Y1.1 Scope

This transaction is used to transfer an imaging diagnostic report in the form of a bundle of FHIR resources. The structure of the bundle and other constraints are specified in the Content Definition LATER.

Considerations include:

- For a "local" store, should the receiver be assumed to have access to pre-existing resources referenced in the report (e.g. the Patient that is the .subject) so those are not included in the bundle. (The newly created subresources of the report, like Observations, would be included in the bundle.)
- Should a different transaction (perhaps Export Imaging Diagnostic Report) be created that would not make that assumption and thus would include copies of all significant referenced resources in the bundle.
- In IMR RAD-141 Store Multimedia Report (https://profiles.ihe.net/RAD/IMR/RAD-141.html), the Bundle.type=transaction; it requires DiagnosticReport, optionally 0 or more ServiceRequest, ImagingStudy, ImagingSelection. NEED to extend with IDR reqs/opts

### 2:4.Y1.2 Actors Roles

**Table 2:4.Y1.2-1: Actor Roles**

| Role | Description | Actor(s) |
|------|-------------|----------|
| Sender | Sends imaging reports | Report Creator |
| Receiver | Receives and handles imaging reports | Report Repository |
{: .grid}

### 2:4.Y1.3 Referenced Standards

### 2:4.Y1.4 Messages

<div>
{%include rad-Y1-seq.svg%}
</div>

<div style="clear: left"/>

**Figure 2:4.Y1.4-1: Interaction Diagram**

### 2:4.Y1.5 Security Considerations

The patient and clinical details provided in the imaging diagnostic report constitute personal health information.

#### 2:4.Y1.5.1 Security Audit Considerations

Senders and Receivers that support the ATNA Profile shall audit this transaction.

This transaction corresponds to a TODO ATNA Trigger Event.
