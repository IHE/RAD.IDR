Instance: example-ImagingStudy
InstanceOf: ImagingStudyInImagingReport
Title: "IMR ImagingStudy example"
Description: "Simple IMR ImagingStudy to be used in DiagnosticReport"
Usage: #example
* identifier[studyUID].system = DICOMUID
* identifier[studyUID].value = "urn:oid:1.2.3.4.5"
* status = FHIRImagingStudyStatus#available
* modality = DICOM#CR "Computed Radiography"
* subject = Reference(Patient/example-Patient)
* started = 2020-12-31T23:30:50-05:00
* endpoint = Reference(Endpoint/example-ImagingStudyEndpoint-Study)
* procedure.concept.coding = CPT#71045 "RADIOLOGIC EXAMINATION, CHEST; SINGLE VIEW"
* series.uid = "1.2.3.4.5.1"
* series.modality = DICOM#CR "Computed Radiography"


Instance: example-ImagingStudy-Comparison
InstanceOf: ImagingStudyInImagingReport
Title: "IMR ImagingStudy example"
Description: "Simple IMR ImagingStudy to be used as a comparison study in DiagnosticReport"
Usage: #example
* identifier[studyUID].system = DICOMUID
* identifier[studyUID].value = "urn:oid:5.6.7.8.9"
* status = FHIRImagingStudyStatus#available
* modality = DICOM#CR "Computed Radiography"
* subject = Reference(Patient/example-Patient)
* started = 2020-01-01T23:30:50-05:00
* endpoint = Reference(Endpoint/example-ImagingStudyEndpoint-Study)
* procedure.concept.coding = CPT#71045 "RADIOLOGIC EXAMINATION, CHEST; SINGLE VIEW"
* series.uid = "5.6.7.8.9.1"
* series.modality = DICOM#CR "Computed Radiography"