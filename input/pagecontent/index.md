<div markdown="1" class="stu-note">
**NOTE TO REVIEWERS**: This Imaging Diagnostic Report (IDR) Implementation Guide is work-in-progress. The PDF published at [IHE](https://profiles.ihe.net/RAD) is the authoritative Public Comment draft. The reosurce profiles here for convenience only. There may be discrepancies between Section 6.Z in the PDF and this implementation guide.

The resource profiles defined in this implementation guide are light on description. Please refer to the PDF for detailed description, use context, constraints and additional implementation considerations.

There are no examples of a full DiagnosticReport using this profile yet.

This IDR Implementation Guide is intended to become complete and authoritative when IDR is published as Trial Implementation.


| [Significant Changes, Open and Closed Issues](issues.html) |
{: .grid}

</div>

### Organization of This Guide

The top level resource is the [Imaging Diagnostic Report](StructureDefinition-imaging-diagnosticreport.html). It references the following resource:

- [Patient](StructureDefinition-idr-patient.html)
- [Order](StructureDefinition-imaging-service-request.html)
- Patient History
   - [Condition](StructureDefinition-idr-patient-history-condition.html)
   - [Observation](StructureDefinition-idr-patient-history-observation.html)
   - [Procedure](StructureDefinition-idr-patient-history-procedure.html)
   - [FamilyMemberHistory](StructureDefinition-idr-patient-history-family-member-history.html)
- [Procedure](StructureDefinition-idr-procedure.html)
- [Imaging Study](StructureDefinition-idr-imaging-study-in-imaging-report.html)
- [Comparison](StructureDefinition-idr-comparison-study.html)
- [Findings](StructureDefinition-idr-observation.html)
- Impression
   - [Condition](StructureDefinition-idr-impression-condition.html)
   - [Observation](StructureDefinition-idr-observation.html)
- [Recommendation](StructureDefinition-idr-recommendation-service-request.html)
- [Communication](StructureDefinition-idr-communication.html)
- [Signature](StructureDefinition-idr-signature-provenance.html)



<!-- This guide is organized into the following sections:

5. Other
   1. [Test Plan](testplan.html)
   1. [Changes to Other IHE Specifications](other.html)
   1. [Download and Analysis](download.html) -->

See also the [Table of Contents](toc.html) and the index of [Artifacts](artifacts.html) defined as part of this implementation guide.

### Conformance Expectations

IHE uses the normative words: Shall, Should, and May according to [standards conventions](https://profiles.ihe.net/GeneralIntro/ch-E.html).

#### Must Support

The use of ```mustSupport``` in StructureDefinition profiles equivalent to the IHE use of **R2** as defined in [Appendix Z](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.10-profiling-conventions-for-constraints-on-fhir).

mustSupport of true - only has a meaning on items that are minimal cardinality of zero (0), and applies only to the source actor populating the data. The source actor shall populate the elements marked with MustSupport, if the concept is supported by the actor, a value exists, and security and consent rules permit.
The consuming actors should handle these elements being populated or being absent/empty.
Note that sometimes mustSupport will appear on elements with a minimal cardinality greater than zero (0), this is due to inheritance from a less constrained profile.
