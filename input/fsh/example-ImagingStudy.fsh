Instance: example-ImagingStudy-chest-xray
InstanceOf: IDRImagingStudy
Title: "ImagingStudy: Chest XRay"
Description: "Chest Xray ImagingStudy being read"
Usage: #example
* identifier[studyUID].system = $DICOMUID
* identifier[studyUID].value = "urn:oid:1.2.3.4.5"
* status = $FHIRImagingStudyStatus#available
* modality = $DCM#CR "Computed Radiography"
* subject = Reference(Patient/example-Patient)
* started = 2020-11-11T10:20:50-05:00
* endpoint = Reference(Endpoint/example-ImagingStudyEndpoint-Study)
* procedure = Reference(Procedure/example-Procedure-chest-xray)
* series.uid = "1.2.3.4.5.1"
* series.modality = $DCM#CR "Computed Radiography"


Instance: example-List-chest-xray-priors
InstanceOf: IDRComparisonList
Title: "List: Chest Xray Priors"
Description: "Chest Xray Comparison Study List"
Usage: #example
* status = #retired
* mode = #snapshot
* entry.item = Reference(ImagingStudy/example-ImagingStudy-chest-xray-comparison)
* title = "List of Priors"


Instance: example-ImagingStudy-chest-xray-comparison
InstanceOf: IDRImagingStudy
Title: "ImagingStudy: Comparison Chest XRay"
Description: "Chest Xray ImagingStudy to be used as a prior/comparison study"
Usage: #example
* identifier[studyUID].system = $DICOMUID
* identifier[studyUID].value = "urn:oid:5.6.7.8.9"
* status = $FHIRImagingStudyStatus#available
* modality = $DCM#CR "Computed Radiography"
* subject = Reference(Patient/example-Patient)
* started = 2020-01-05T23:30:50-05:00
* endpoint = Reference(Endpoint/example-ImagingStudyEndpoint-Study)
* procedure = Reference(Procedure/example-Procedure-chest-xray-comparison)
* series.uid = "5.6.7.8.9.1"
* series.modality = $DCM#CR "Computed Radiography"