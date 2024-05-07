Profile:        ImagingStudyEndpoint
Parent:         Endpoint
Id:             imaging-study-endpoint
Title:          "ImagingStudy Endpoint"
Description:    "Endpoint used for an imaging study."

* connectionType from ImagingStudyEndpointConnectionTypeVS (required)

* payload 1..1
* payload.type from ImagingStudyEndpointPayloadTypeVS (extensible)

ValueSet: ImagingStudyEndpointConnectionTypeVS
Id: imaging-study-endpoint-connectiontype-vs
Title: "Imaging Study Endpoint ConnectionType Value Set"
Description: "Codes representing the applicable endpoint connectionType to retrieve a study."
* FHIREndpoint#ihe-iid "IHE IDD"
* FHIREndpoint#dicom-wado-rs "DICOM WADO-RS"


ValueSet: ImagingStudyEndpointPayloadTypeVS
Id: imaging-study-endpoint-payloadtype-vs
Title: "Imaging Study Endpoint PayloadType Value Set"
Description: "Codes representing the applicable endpoint payloadType to retrieve a study."
* DICOM#113014 "Study"