C_TEXT:C284($currFont; $MyArea_name)
C_LONGINT:C283($currSize)
$MyArea_name:="writeproarea"
ST GET ATTRIBUTES:C1094(*; $MyArea_name; ST Start text:K78:15; ST End text:K78:16; Attribute font name:K65:5; $currFont; Attribute text size:K65:6; $currSize)
If (($currFont="") | ($currFont#"Arial"))
	//Not everything same or not Arial
	ST SET ATTRIBUTES:C1093(*; $MyArea_name; ST Start text:K78:15; ST End text:K78:16; Attribute font name:K65:5; "Arial")
End if 
If ($currSize#11)
	//Not everything size 11
	ST SET ATTRIBUTES:C1093(*; $MyArea_name; ST Start text:K78:15; ST End text:K78:16; Attribute text size:K65:6; 11)
End if 
C_POINTER:C301($area_; $area2_; $area3_)

$area3_:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")

OBJECT SET ENTERABLE:C238(*; "WriteProArea"; False:C215)
C_COLLECTION:C1488($Pages)
C_OBJECT:C1216($pipParamObj)
G_InitInspVars

$Pages:=wrpSplitPages($area3_->)

$pipParamObj:=wrpPrintInPartsNewParamObj
$pipParamObj.isOpenPrintingJob:=False:C215  // True=OpenPrintingJobIsGiven , False=NoOpenPrintingJobIsGiven
$pipParamObj.orientation:=1  // 1=Portrait(default), 2=Landscape
$pipParamObj.firstPageFormName:="Culvertprpg2wp"
$pipParamObj.firstPageFormTable:=Table:C252(->[Inspections:27])
$pipParamObj.PagesFormName:="WPCmtsPrint"
$pipParamObj.PagesFormTable:=Table:C252(->[Inspections:27])
SET PRINT PREVIEW:C364(True:C214)

//SET PRINT OPTION(_o_Hide printing progress option; 1)
SET PRINT OPTION:C733(Paper option:K47:1; 612; 792)

wrpCustomPrintParts($area3_->; $pipParamObj)

CLOSE PRINTING JOB:C996

SET PRINT PREVIEW:C364(False:C215)
//SET PRINT OPTION(_o_Hide printing progress option; 0)
