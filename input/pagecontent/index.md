The Imaging Diagnostic Report Profile describes a machine-readable format for reports on diagnostic procedures of common radiology specialties using common modalities. It defines a FHIR-based encoding of the report, specifically addressing standard imaging report sections, including order, history, procedure/technique, comparison, findings/observations, impression/conclusion, recommendations, and signatures. 

<div markdown="1" class="stu-note">
**IMPORTANT**: IDR is NOT yet recommended for production use.

Profiles released for Trial Implementation by IHE Radiology typically ARE expected to be stable enough for production use; however, this release of IDR is intended for experimental implementation and feedback.  

See [Significant Changes, Open and Closed Issues](issues.html)
</div>

### Organization of This Guide

1. Volume 1: Integration Profile 
   1. [Introduction](volume-1.html)
   2. [Actors and Transactions](volume-1.html#561-idr-actors-transactions-and-content-modules)
      1. [Report Creator](volume-1.html#56111-idr-report-creator)
      2. [Report Repository](volume-1.html#56112-idr-report-repository)
      3. [Report Reader](volume-1.html#56113-idr-report-reader)
      4. [Report Consumer](volume-1.html#56114-idr-report-consumer)
   3. [Actor Options](volume-1.html#562-idr-actor-options)
   4. [Actor Required Groupings](volume-1.html#563-idr-required-actor-groupings)
   5. [Overview](volume-1.html#564-idr-overview)
      1. [Concepts](volume-1.html#5641-idr-concepts)
      2. [Use Cases](volume-1.html#5642-use-cases)
         1. [Use Case #1: Report Creation](volume-1.html#56421-idr-use-case-1-report-creation)
         2. [Use Case #2: Report Storage & Distribution](volume-1.html#56422-idr-use-case-2-report-storage--distribution)
         3. [Use Case #3: Report Presentation](volume-1.html#56423-idr-use-case-3-report-presentation)
         4. [Use Case #4: Report Processing](volume-1.html#56424-idr-use-case-3-report-processing)
   6. [Security Considerations](volume-1.html#565-idr-security-considerations)
   7. [Cross Profile Considerations](volume-1.html#566-idr-cross-profile-considerations)

2. Volume 2: Transaction Detail
   1. [Store Imaging Diagnostic Report [RAD-Y1]](RAD-Y1.html)
   2. [Query Imaging Diagnostic Report [RAD-Y2]](RAD-Y2.html)
   3. [Retrieve Imaging Diagnostic Report [RAD-Y3]](RAD-Y3.html)

3. Volume 3: Content Definitions
   1. [Imaging Diagnostic Report Overview](volume-3.html)
   2. [Imaging Diagnostic Report](StructureDefinition-imaging-diagnosticreport.html) (top level resource) which references:
      1. [Patient](StructureDefinition-idr-patient.html) (Subject)
      2. [ServiceRequest](StructureDefinition-imaging-service-request.html) (Order)
      3. Patient History
         1. [Condition](StructureDefinition-idr-patient-history-condition.html)
         2. [Observation](StructureDefinition-idr-patient-history-observation.html)
         3. [Procedure](StructureDefinition-idr-patient-history-procedure.html)
         4. [FamilyMemberHistory](StructureDefinition-idr-patient-history-family-member-history.html)
      4. [Procedure](StructureDefinition-idr-procedure.html)
      5. [ImagingStudy](StructureDefinition-idr-imaging-study-in-imaging-report.html)
      6. [Comparison](StructureDefinition-idr-comparison-study.html)
      7. [Findings](StructureDefinition-idr-observation.html)
      8. Impression / Conclusion
         1. [Condition](StructureDefinition-idr-impression-condition.html)
         2. [Observation](StructureDefinition-idr-observation.html)
      9. [ServiceRequest](StructureDefinition-idr-recommendation-service-request.html) (Recommendation)
      10. [Communication](StructureDefinition-idr-communication.html)
  
4. Volume 4: National Extensions
   1. [National Extension for IHE United States - IDR](volume-4.html#TODO)

5. Other
   1. [Changes to Other IHE Specifications](other.html)
   2. [Download and Analysis](download.html)
   3. [Test Plan](testplan.html)

See also the [Table of Contents](toc.html) and the index of [Artifacts](artifacts.html) defined as part of this implementation guide.

### Conformance Expectations

IHE uses the normative words: Shall, Should, and May according to [standards conventions](https://profiles.ihe.net/GeneralIntro/ch-E.html).

#### Must Support

The use of ```mustSupport``` in StructureDefinition profiles is equivalent to the IHE use of **R2** as defined in [Appendix Z](https://profiles.ihe.net/ITI/TF/Volume2/ch-Z.html#z.10-profiling-conventions-for-constraints-on-fhir).
- The source actor shall populate the element if the concept is supported by the actor, a value exists, and security and consent rules permit.
- The consuming actors should handle these elements being populated or being absent/empty.
> Note: mustSupport of true only has meaning on elements with minimal cardinality of zero (0) but sometimes will appear on elements with a minimal cardinality greater than zero (0) due to inheritance from a less constrained profile.
