//%attributes = {"invisible":true}
If (False:C215)
	//SD_QryDateCheck 
	//
	//Verify that ending date is greater or equal to 
	//start date in form [SD_History];"QryForm"
	
	Mods_2005_CM04
End if 

C_BOOLEAN:C305($0; $vDatesOK_b)
C_DATE:C307($vStart_date; $vEnd_Date)
$vStart_date:=Date:C102(<>SD_BeginMonth_s+"/01/"+<>SD_BeginYear_s)
$vEnd_date:=Date:C102(<>SD_EndMonth_s+"/01/"+<>SD_EndYear_s)
$vDatesOK_b:=($vEnd_date>=$vStart_date)
If (Not:C34($vDatesOK_b))
	C_TEXT:C284($DateMsg)
	$DateMsg:="Beginning Mo/Year ("+<>SD_BeginMonth_s+"/"+<>SD_BeginYear_s+") is AFTER Ending Mo/Year ("
	$DateMsg:=$DateMsg+<>SD_EndMonth_s+"/"+<>SD_EndYear_s+")"
	ALERT:C41($DateMsg)
End if 

$0:=$vDatesOK_b