Instance: example-ImagingStudy
InstanceOf: IDRImagingStudy
Title: "ImagingStudy: IMR example"
Description: "Simple IMR ImagingStudy to be used in DiagnosticReport"
Usage: #example
* identifier[studyUID].system = DICOMUID
* identifier[studyUID].value = "urn:oid:1.2.3.4.5"
* status = FHIRImagingStudyStatus#available
* modality = DICOM#CR "Computed Radiography"
* subject = Reference(Patient/example-Patient)
* started = 2020-11-11T10:20:50-05:00
* endpoint = Reference(Endpoint/example-ImagingStudyEndpoint-Study)
* procedure = Reference(Procedure/example-Procedure-chest-xray)
* series.uid = "1.2.3.4.5.1"
* series.modality = DICOM#CR "Computed Radiography"


Instance: example-ImagingStudy-Comparison
InstanceOf: IDRImagingStudy
Title: "ImagingStudy: IMR Comparison example"
Description: "Simple IMR ImagingStudy to be used as a comparison study in DiagnosticReport"
Usage: #example
* identifier[studyUID].system = DICOMUID
* identifier[studyUID].value = "urn:oid:5.6.7.8.9"
* status = FHIRImagingStudyStatus#available
* modality = DICOM#CR "Computed Radiography"
* subject = Reference(Patient/example-Patient)
* started = 2020-01-05T23:30:50-05:00
* endpoint = Reference(Endpoint/example-ImagingStudyEndpoint-Study)
* procedure = Reference(Procedure/example-Procedure-chest-xray-history)
* series.uid = "5.6.7.8.9.1"
* series.modality = DICOM#CR "Computed Radiography"