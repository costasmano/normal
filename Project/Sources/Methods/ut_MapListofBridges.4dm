//%attributes = {"invisible":true}
//Method: ut_MapListofBridges
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 05/13/13, 11:07:34
	// ----------------------------------------------------
	//Created : 
	Mods_2013_05
	// Modified by: Costas Manousakis-(Designer)-(3/20/14 17:46:40)
	Mods_2014_03
	//  `Updated the code
End if 
//

C_TEXT:C284($htmlHdr_txt; $htmlFtr_txt; $HtmlBridge_txt)

$htmlHdr_txt:=ut_GetSysParameter("MAPBRGLISTHDR")

$htmlFtr_txt:=ut_GetSysParameter("MAPBRGLISTFTR")

$HtmlBridge_txt:=ut_GetSysParameter("MAPBRGLISTBRIDGES")

C_BOOLEAN:C305($roBridge_b)
$roBridge_b:=Read only state:C362([Bridge MHD NBIS:1])
If (Not:C34($roBridge_b))
	READ ONLY:C145([Bridge MHD NBIS:1])
End if 
QUERY:C277([Bridge MHD NBIS:1])
//Selection range to arrays (bin, item7, 6a, bdept,  [Bridge MHD NBIS]Item16A, 16b, 16c, 17a, 17b, 17c
ARRAY TEXT:C222($bins_atxt; 0)
ARRAY TEXT:C222($item7_atxt; 0)
ARRAY TEXT:C222($item6a_atxt; 0)
ARRAY TEXT:C222($bdepts_atxt; 0)
ARRAY INTEGER:C220($i16a_ar; 0)
ARRAY INTEGER:C220($i16b_ar; 0)
ARRAY REAL:C219($i16c_ar; 0)
ARRAY INTEGER:C220($i17a_ar; 0)
ARRAY INTEGER:C220($i17b_ar; 0)
ARRAY REAL:C219($i17c_ar; 0)
SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]BIN:3; $bins_atxt; [Bridge MHD NBIS:1]Item7:65; $item7_atxt; [Bridge MHD NBIS:1]Item6A:63; $item6a_atxt; [Bridge MHD NBIS:1]BDEPT:1; $bdepts_atxt; [Bridge MHD NBIS:1]Item16A:68; $i16a_ar; [Bridge MHD NBIS:1]Item16B:69; $i16b_ar; [Bridge MHD NBIS:1]Item16C:109; $i16c_ar; [Bridge MHD NBIS:1]Item17A:70; $i17a_ar; [Bridge MHD NBIS:1]Item17B:71; $i17b_ar; [Bridge MHD NBIS:1]Item17C:136; $i17c_ar)

//init centerlat, centerlong
C_REAL:C285(BRGLATCENTER; BRGLONGCENTER; $binLat_r; $binLon_r)
//init arrays BRIDGELATDEG_ar BRIDGELONGDEG_ar BRIDGEBINLABEL_atxt
ARRAY REAL:C219(BRIDGELATDEG_ar; 0)
ARRAY REAL:C219(BRIDGELONGDEG_ar; 0)
ARRAY TEXT:C222(BRIDGEBINLABEL_atxt; 0)

BRGLATCENTER:=0
BRGLONGCENTER:=0
//calc all Lat and long
C_LONGINT:C283($loop_L; BRIDGECOUNT)

For ($loop_L; 1; Size of array:C274($bins_atxt))
	$binLat_r:=$i16a_ar{$loop_L}+($i16b_ar{$loop_L}/60)+($i16c_ar{$loop_L}/3600)
	$binLon_r:=$i17a_ar{$loop_L}+($i17b_ar{$loop_L}/60)+($i17c_ar{$loop_L}/3600)
	//  ` if lat and long #0
	If (($binLat_r#0) & ($binLon_r#0))
		
		//  `  `increment counter
		BRIDGECOUNT:=BRIDGECOUNT+1
		$binLon_r:=-1*$binLon_r
		BRGLATCENTER:=BRGLATCENTER+$binLat_r
		BRGLONGCENTER:=BRGLONGCENTER+$binLon_r
		APPEND TO ARRAY:C911(BRIDGELATDEG_ar; $binLat_r)
		APPEND TO ARRAY:C911(BRIDGELONGDEG_ar; $binLon_r)
		$bins_atxt{$loop_L}:=$bdepts_atxt{$loop_L}+" - "+$bins_atxt{$loop_L}+" "+f_TrimStr($item7_atxt{$loop_L}; True:C214; True:C214)+" over "+f_TrimStr($item6a_atxt{$loop_L}; True:C214; True:C214)
		$bins_atxt{$loop_L}:=Replace string:C233($bins_atxt{$loop_L}; "  "; " ")
		APPEND TO ARRAY:C911(BRIDGEBINLABEL_atxt; $bins_atxt{$loop_L})
		//  `  `add lat to LATCENTER, long to LONGCENTER
		//  `  `append to arrays BRIDGELATDEG_ar BRIDGELONGDEG_ar BRIDGEBINLABEL_atxt
	End if 
End for 

//if both centers #0
If (($binLat_r#0) & ($binLon_r#0))
	BRGLATCENTER:=BRGLATCENTER/BRIDGECOUNT
	BRGLONGCENTER:=BRGLONGCENTER/BRIDGECOUNT
End if 
//  `centers = centers / counter

C_BLOB:C604($Result_blb)
C_TEXT:C284($process_txt)
PROCESS 4D TAGS:C816($htmlHdr_txt; $process_txt)
TEXT TO BLOB:C554($process_txt; $Result_blb; Mac text without length:K22:10)

PROCESS 4D TAGS:C816($HtmlBridge_txt; $process_txt)
TEXT TO BLOB:C554($process_txt; $Result_blb; Mac text without length:K22:10; *)

TEXT TO BLOB:C554($htmlFtr_txt; $Result_blb; Mac text without length:K22:10; *)
C_TIME:C306($temFile_t)
$temFile_t:=Create document:C266(""; "html")
C_TEXT:C284($TempHtmlFile_txt)
If (Ok=1)
	$TempHtmlFile_txt:=Document
	CLOSE DOCUMENT:C267($temFile_t)
	BLOB TO DOCUMENT:C526($TempHtmlFile_txt; $Result_blb)
	ut_OpenDocument($TempHtmlFile_txt)
End if 

If (Not:C34($roBridge_b))
	READ WRITE:C146([Bridge MHD NBIS:1])
End if 
//End ut_MapListofBridges