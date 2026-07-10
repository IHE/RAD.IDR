// Invariant
Invariant:   IDRAttachmentInvariant
Description: "Either data or url SHALL be present for any attachment (e.g. in DiagnosticReport)."
Expression:  "data.exists() or url.exists()"
Severity:    #error