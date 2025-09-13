
## 2:4.Y3 Retrieve Imaging Diagnostic Report

<div markdown="1" class="stu-note">
**NOTE TO READERS**: Transactions RAD-Y1, RAD-Y2 and RAD-Y3 are placeholders.

Both this profile (IDR) and IHE Interactive Multimedia Reports (IMR) have transactions to store and query/retrieve reports based on FHIR DiagnosticReport.

The intention is for IDR to become the base profile for reports. The IMR profile would be restructured to add its hyperlink details and behaviors either as a profile with IDR as a pre-requisite, or as named Options in IDR.

In Phase II of IDR, IDR will "adopt" the IMR transactions, generalize the names, add any general requirements (e.g. more query details), and factor out any multimedia content back into IMR.
</div>

### 2:4.Y3.1 Scope

This transaction is used to retrieve imaging diagnostic report instances.

The structure of the bundle and other constraints are specified in the Content Definition LATER.

Considerations include:

- Pull example query scenarios and patterns from the IDR Public Comment draft
- See the Find Multimedia Report [RAD-143] transaction: https://profiles.ihe.net/RAD/IMR/RAD-143.html

### 2:4.Y3.2 Actors Roles

**Table 2:4.Y3.2-1: Actor Roles**

| Role | Description | Actor(s) |
|------|-------------|----------|
| Requester | Request an imaging report | Report Reader <br> Report Consumer |
| Responder | Return the imaging report | Report Repository |
{: .grid}

### 2:4.Y3.3 Referenced Standards

### 2:4.Y3.4 Messages

<div>
{%include rad-Y3-seq.svg%}
</div>

<div style="clear: left"/>

**Figure 2:4.Y3.4-1: Interaction Diagram**

### 2:4.Y3.5 Security Considerations

The patient and clinical details provided in the imaging diagnostic report constitute personal health information.

#### 2:4.Y3.5.1 Security Audit Considerations

Requesters and Responders that support the ATNA Profile shall audit this transaction.

This transaction corresponds to a TODO ATNA Trigger Event.
