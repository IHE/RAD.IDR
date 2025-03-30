CodeSystem: IDRImpressionConditionCategoryCS
Id: idr-impression-condition-category-cs
Title: "IDR Impression category"
Description: "Impression category codes for IDR"

* #imaging-impression "Imaging Impression"
* ^experimental = false
* ^caseSensitive = true

//TODO Kinson - is this for the actionability codes? Should be able to take those from RadLex?

ValueSet: IDRImpressionConditionCategoryVS
Id: idr-impression-condition-category-vs
Title: "Impression Condition category ValueSet"
Description: "Valueset for impression as Condition."

* include codes from system IDRImpressionConditionCategoryCS
* ^experimental = false