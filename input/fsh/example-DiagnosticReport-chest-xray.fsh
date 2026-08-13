Instance: example-IDiagnosticReport-chest-xray
InstanceOf: ImagingDiagnosticReport
Title: "A DiagnosticReport: XR Chest"
Description: "Two View Chest XRay Report"
Usage: #example

* subject = Reference(Patient/example-Patient)

* category = $SCT#309964003 "Radiology department"
* code = $CPT#71045 "RADIOLOGIC EXAMINATION, CHEST; SINGLE VIEW"
* study = Reference(ImagingStudy/example-ImagingStudy)
// * procedure = Reference(Procedure/example-procedure-chest-xray)
// * extension[comparison].valueReference = Reference(ImagingStudy/example-ImagingStudy-Comparison)

* performer = Reference(Organization/example-Organization)
* resultsInterpreter = Reference(Practitioner/example-Practitioner-Radiologist)

/*
* results[0]
*/
// TODO Rebundle to separate the coded findings and the unstructured finding block of text

// TODO grab Impression text to go into Observation.text
* conclusionCode[0].reference = Reference(Observation/example-Observation-Infarct)
* conclusionCode[1].reference = Reference(Observation/example-Observation-Density)

* recomendation.reference = Reference(ServiceRequest/example-ServiceRequest-Mammo-Recommendation)

* status = #final
* issued = 2020-11-11T10:32:33-05:00

* text
  * status = #additional
  * div = """
  <div xmlns="http://www.w3.org/1999/xhtml">
    <p><b>Patient Name:</b> Jane Doe</p>
    <p><b>Date of Examination:</b> 2020-11-11</p>
    <div id="111" class="loinc-55115-0">
      <h2>Order:</h2>
      <p><b>Referring Physician:</b> Welby, Marcus</p>
      <p><b>Study:</b> Chest X-Ray (PA and Lateral views)</p>
      <p><b>Indications:</b> Chest Pain, Shortness of Breath; Rule out pulmonary pathology</p>
    </div>
    <div id="222" class="loinc-55111-9">
      <h2>Procedure:</h2>
      <p>Standard posteroanterior (PA) and lateral views of the chest were obtained. The study is of diagnostic quality, with satisfactory inspiration and penetration.</p>
    </div>
    <div id="333" class="loinc-18834-2">
      <h2>Comparison:</h2>
      <ul>
        <li>Chest X-Ray (Single view); 2020-01-05</li>
      </ul>
    </div>
    <div id="444" class="loinc-59776-5">
      <h2>Findings:</h2>
      <p>The cardiac silhouette is within normal size limits. Mediastinal contours are normal, with no evidence of widening or mediastinal shift.</p>
      <p>The lung volumes are adequate and the vascular markings are within normal limits. A wedge-shaped opacity is noted in the right lower lobe, consistent with a pulmonary infarct. No obvious consolidation, significant pleural effusion, or other focal airspace disease is detected in the remaining lung fields.</p>
      <p>The bony thorax, including the ribs, clavicles, and visible portions of the spine, shows no acute fracture or suspicious lytic/blastic lesions. Soft tissues of the chest wall are unremarkable, except for a small, suspicious density projected over the left breast region, which cannot be fully characterized on this examination.</p>
      <p>The hemidiaphragms are smooth and sharply outlined. The costophrenic angles are clear. The visualized portions of the upper abdomen appear unremarkable.</p>
    </div>
    <div id="555" class="loinc-19005-8">
      <h2>Impression:</h2>
      <ul>
        <li>Right lower lobe pulmonary infarct consistent with the clinical scenario.</li>
        <li>Suspicious soft tissue density overlying the left breast region that warrants further evaluation.</li>
      </ul>
    </div>
    <div id="666" class="loinc-18783-1">
      <h2>Recommendation:</h2>
      <ul>
        <li>Bilateral diagnostic mammogram; to followup suspicious soft tissue density</li>
      </ul>
    </div>
  </div>
  """
