//TODO Kinson - do we use this anywhere?

Profile:        ReportKeyImages
Parent:         ImagingSelection
Id:             idr-report-key-images
Title:          "IDR ImagingSelection"
Description:    "ImagingSelection for key images associated with an Observation"

* status = #available

* subject only Reference(Patient)

* derivedFrom only Reference(ImagingStudy)