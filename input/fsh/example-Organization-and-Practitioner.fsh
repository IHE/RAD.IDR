Instance: example-Organization
InstanceOf: Organization
Title: "Organization: Imaging practice"
Description: "Simple Organization to be used in DiagnosticReport"
Usage: #example
* name = "Mercy Hospital"


Instance: example-Practitioner-Radiologist
InstanceOf: Practitioner
Title: "Practitioner: Radiologist"
Description: "Simple Practitioner to be used in DiagnosticReport"
Usage: #example
* name.family = "Roentgen"
* name.given = "Roger"


Instance: example-Practitioner-Referring
InstanceOf: Practitioner
Title: "Practitioner: Referring"
Description: "Simple Practitioner to be used in DiagnosticReport"
Usage: #example
* name.family = "Welby"
* name.given = "Marcus"
