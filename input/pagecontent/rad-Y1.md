## 2:4.Y1 Store Imaging Diagnostic Report

<div markdown="1" class="stu-note">
**NOTE TO READERS**:

Both this profile (IDR) and IHE Interactive Multimedia Reports (IMR) have transactions to store and query/retrieve reports based on FHIR DiagnosticReport.

The intention is for IDR to become the base profile for reports. The IMR profile would be restructured to add its hyperlink details and behaviors either as a profile with IDR as a pre-requisite, or as named Options in IDR.

An Export Imaging Diagnostic Report transaction which requires more complete inclusion of Context Resources and Identity Resources in the bundle might be introduced later to support exporting reports to other institutions (where the presence and fidelity of instances of those Context and Identity Resources might be unknown).
</div>

### 2:4.Y1.1 Scope

This transaction is used to send newly created imaging diagnostic reports.

The report is encoded as a bundle of FHIR resources anchored by the DiagnosticReport Resource.

### 2:4.Y1.2 Actors Roles

**Table 2:4.Y1.2-1: Actor Roles**

| Role     | Description                                              | Actor(s)          |
|----------|----------------------------------------------------------|-------------------|
| Sender   | Sends an imaging diagnostic report instance.             | Report Creator    |
| Receiver | Receives and stores imaging diagnostic report instances. | Report Repository |
{: .grid}

Transaction text specifies behavior for each role. The behavior of specific actors may also be specified when it goes beyond that of the general role.

### 2:4.Y1.3 Referenced Standards

- FHIR R6

### 2:4.Y1.4 Messages

<figure style="width:25%;">
{%include Y1-interactiondiagram.svg%}
<figcaption style="text-align: center;"><b>Figure 4.Y1.4-1: Interaction Diagram</b></figcaption>
</figure>

#### 2:4.Y1.4.1 Store Request Message

The Sender sends an imaging diagnostic report to the Receiver.

The Receiver SHALL support handling such messages from more than one Sender. The Sender SHALL support making requests to more than one Receiver.

##### 2:4.Y1.4.1.1 Trigger Events

A user or an automated function on the Sender determines that an imaging diagnostic report should be sent to the Receiver.

This might occur when the report is initially created or during subsequent distribution steps.

##### 2:4.Y1.4.1.2 Message Semantics

The message is an HTTP POST that initiates a FHIR “transaction” using a “create” action. The Sender is the User Agent. The Receiver is the Original Server.

The payload is a FHIR Bundle that SHALL conform to the specifications and guidance in 4.Y1.4.1.2.1.

The media type of the HTTP body SHALL be either application/fhir+json or application/fhir+xml.

See <http://hl7.org/fhir/http.html#transaction> for complete requirements of a FHIR transaction. See <http://hl7.org/fhir/bundle-transaction.html> for an example of a transaction bundle.

The Sender SHALL send the message to the base URL as defined in FHIR. See <http://hl7.org/fhir/R4/http.html> for the definition of “HTTP” access methods and “base”.

###### 2:4.Y1.4.1.2.1 Imaging Diagnostic Report Bundle Specifications and Guidance

For information on constructing a FHIR Bundle Resource, see <http://hl7.org/fhir/bundle.html>.

The Sender SHALL set the Bundle.type to transaction.

The Sender SHALL include in the bundle the DiagnosticReport resource for the imaging diagnostic report being submitted.

From the tree of resources referenced (directly or indirectly) by the DiagnosticReport resource:

- Resources created as part of the DiagnosticReport (i.e. “Fundamental Resources” as described in RAD TF-3:6.7.3.13) SHALL be included in the Bundle by the Sender. The Sender SHALL include all available elements in the resource.
- Resources received from elsewhere and referenced as context in the DiagnosticReport (i.e. “Context Resources” as described in RAD TF-3:6.7.3.13) SHALL be included in the Bundle by the Sender if it cannot safely determine that those resources are already available to the Receiver.
  - Even if the Sender can determine such resources are available to the Receiver, it may choose, or be configured, to include them in the Bundle for purposes such as providing an accurate snapshot of the information available at the time the report was created.
  - The Sender MAY choose to limit the elements included in the Bundle copy of the resource to those needed to provide a meaningful summary and capture details relevant to interpretations in the report.
- Resources received from elsewhere and used primarily to identify entities related to the DiagnosticReport (i.e. “Identity Resources” as described in RAD TF-3:6.7.3.13) SHALL be included by the Sender if it cannot safely determine that those resources are already available to the Receiver. The Sender MAY choose to omit elements not needed to establish the identity of the described entity.

The Sender SHALL bundle included resources as instances rather than contained resources (see <http://hl7.org/fhir/references.html#contained>).

Additional discussion on bundling diagnostic report-related Resources is found in RAD TF-3:6.7.3.13.

##### 2:4.Y1.4.1.3 Expected Actions

The Receiver SHALL accept both media types: application/fhir+json and application/fhir+xml.

On receipt of the request message, the Receiver SHALL validate the resources and respond with one of the HTTP codes defined in the response Message Semantics.

The Receiver SHALL process the transaction bundle atomically as specified in <http://hl7.org/fhir/http.html#transaction>.

> Note: Local policy might reject bundles containing resources such as Patient, Organization, Practitioner, etc. referenced that are unknown to the Receiver. Therefore, the actual behavior is at the discretion of the Receiver Actor policy.

The Receiver SHALL retrieve any Resources referenced by absolute URLs in the FHIR Bundle Resource.

The Receiver SHALL validate the bundle first against the FHIR specification. Guidance on what FHIR considers a valid Resource can be found at <http://hl7.org/fhir/validation.html>.

Once the bundle is validated, the Receiver SHALL store the Fundamental resources (see RAD TF-3:6.7.3.13).

The Receiver MAY choose to either:

- store the Context Resources and Identity Resources (see RAD TF-3:6.7.3.13), or
- use the summary information to match them to equivalent local resources and update the corresponding references in stored resources as appropriate
The Receiver SHALL NOT send a success response until the report is completely processed and persisted as appropriate to the Receiver configuration.

If the Receiver encounters any errors or if any validation fails, the Receiver SHALL return an appropriate error. The Receiver MAY choose to retain the Bundle for purposes such as provenance and for use when composing Bundles to send to other systems.

#### 2:4.Y1.4.2 Store Response Message

The Receiver sends a response message describing the message outcome to the Sender.

##### 2:4.Y1.4.2.1 Trigger Events

The Receiver receives a Store Request message.

##### 2:4.Y1.4.2.2 Message Semantics

This message is an HTTP POST response. The Sender is the User Agent. The Receiver is the Origin Server.

The Receiver returns an HTTP Status code appropriate to the processing outcome, conforming to the transaction specification requirements in <http://hl7.org/fhir/http.html#trules> to the Sender. This enables the Sender to know the outcome of processing the FHIR transaction, and the identities assigned to the resources by the Receiver.

The Receiver SHALL construct a Bundle, with type set to transaction-response, that contains one entry for each entry in the request, in the same order as received, with the Bundle.entry.response.outcome indicating the results of processing the entry warnings such as PartialFolderContentNotProcessed. The Receiver SHALL comply with FHIR <http://hl7.org/fhir/bundle.html#transaction-response> and <http://hl7.org/fhir/http.html#transaction-response>.

To indicate success, the Receiver SHALL return an HTTP status 200. The Receiver SHALL include in the HTTP response header the location element, and the etag element if the Receiver supports FHIR resource versioning.

The Bundle.entry.response.status SHALL be 201 to indicate the Resource has been created.

If the Receiver cannot find any referenced resources in the bundle, then the Receiver SHALL return an HTTP status ‘404 Not Found’.

If the Receiver cannot handle the method for each resource in the bundle, then the Receiver SHALL return an HTTP status ‘405 Method Not Allowed’.

If the Sender is not authorized to store the bundle, then the Receiver SHALL return an HTTP status either ‘401 Unauthorized’ or ‘403 Forbidden’.

For other request related errors, the Receiver SHALL return an HTTP status ‘400 Bad Request’. For other Receiver processing related errors, the Receiver SHALL return an appropriate 5xx HTTP status.

##### 2:4.Y1.4.2.3 Expected Actions

If the Receiver returns an HTTP redirect response (HTTP status codes 301, 302, 303, or 307), the Sender SHALL follow the redirect, but MAY stop processing if it detects a loop. See RFC7231 Section 6.4 Redirection 352.

The Sender processes the results according to application-defined rules.

### 2:4.Y1.5 Security Considerations

The FHIR Resources conveyed typically constitute personal health information.

The Sender MAY use external URLs in presentedForm.url. In this case, the Receiver SHOULD consider validating the URL to ensure that it is a valid URL referencing a known legitimate host to avoid phishing attack.

#### 2:4.Y1.5.1 Security Audit Considerations

This transaction is associated with a 'Patient-record-event' ATNA Trigger Event on both the Sender and the Receiver. See ITI TF-2: 3.20.4.1.1.1.
