Profile:        IDRSignatureProvenance
Parent:         Provenance
Id:             idr-signature-provenance
Title:          "Signature"
Description:    "Signature for Imaging Diagnostic Reports."

* text MS

* signature 1..1 MS
* signature.type 1..1 MS
* signature.type = FHIRProvenanceSignatureType#ProofOfapproval
* signature.who only Reference(Practitioner or PractitionerRole)
* signature.onBehalfOf only Reference(Practitioner or PractitionerRole)