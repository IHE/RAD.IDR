Profile:        IDRCommunication
Parent:         Communication
Id:             idr-communication
Title:          "Communications for Imaging Diagnostic Reports"
Description:    "Communications for Imaging Diagnostic Reports."

* text MS

* partOf 1..1 MS
* partOf only Reference(ImagingDiagnosticReport)

* subject 1..1 MS
* subject only Reference(IDRPatient)

* topic MS

* reason MS
* reason only CodeableReference(IDRImpressionCondition or IDRRecommendationServiceRequest)

* about MS
* about only Reference(IDRImpressionCondition or IDRRecommendationServiceRequest)

* medium MS

* sender MS

* recipient MS

* sent 1..1 MS