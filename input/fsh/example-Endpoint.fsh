Instance: example-ImagingStudyEndpoint-Series
InstanceOf: ImagingStudyEndpoint
Title: "Imaging Endpoint for Series example"
Description: "Simple Imaging Series Endpoint"
Usage: #example
* connectionType = FHIREndpoint#dicom-wado-rs "DICOM WADO-RS"
* payload.type = DICOM#113015 "Series"
* address = "http://my.example.com/wadors/study/1.2.3.4.5/series/11.22.33.44.55"
* status = FHIREndpointStatus#active


Instance: example-ImagingStudyEndpoint-Study
InstanceOf: ImagingStudyEndpoint
Title: "Imagin Endpoint for Study example"
Description: "Simple Imagin Study Endpoint"
Usage: #example
* connectionType = FHIREndpoint#dicom-wado-rs "DICOM WADO-RS"
* payload.type = DICOM#113014 "Study"
* address = "http://my.example.com/wadors/study/1.2.3.4.5"
* status = FHIREndpointStatus#active


Instance: example-ImagingStudyEndpoint-Study-Comparison
InstanceOf: ImagingStudyEndpoint
Title: "Imaging Endpoint for Study example"
Description: "Simple Imaging Study Endpoint fpr the comparison study"
Usage: #example
* connectionType = FHIREndpoint#dicom-wado-rs "DICOM WADO-RS"
* payload.type = DICOM#113014 "Study"
* address = "http://my.example.com/wadors/study/5.6.7.8.9"
* status = FHIREndpointStatus#active