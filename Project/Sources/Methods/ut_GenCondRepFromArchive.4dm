//%attributes = {"invisible":true}
// Method: ut_GenCondRepFromArchive
// Description
//  ` Generate a condition report from records in [BridgeMHDNBISArchive]
//  ` will request a date and then search the MonthlyArchives for the date, reduce to FHWArecords only
//  ` then create the status report record using the date supplied as datecreated.
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 02/11/11, 15:36:19
	// ----------------------------------------------------
	
	Mods_2011_02
	Mods_2011_06  // CJ Miller`06/20/11, 10:32:27      ` Type all local variables for v11 
	// Modified by: Costas Manousakis-(Designer)-(12/1/15 10:50:59)
	Mods_2015_12_bug
	//  `adjusted to include area calculations; show alert if no records were found
	// Modified by: Costas Manousakis-(Designer)-(10/26/17 11:36:16)
	Mods_2017_10
	//  `added comments in the comment field
	// Modified by: Costas Manousakis-(Designer)-(5/15/18 09:58:17)
	Mods_2018_05
	//  `ask for which method will be used in calculcating SD status (new FHWA (POOR=SD) or the old one
	//  `Set new field [Status Report]SD_Calc_New_b depending on the type of SD Calculation.
	//  `Set new fields [Status Report]UseLegacyOwner_b and [Status Report]DistrictMethod_L 
	//  `depending on process vars STATREP_UseLegacyOwn_b and STATREP_DistrictMethod_L
	//  `use form "BridgeStatRepParameters" to get the parameters
	// Modified by: Costas Manousakis-(Designer)-(9/9/19 16:21:27)
	Mods_2019_09
	//  `allow creation of status reports for non-nbi bridges or other bridge selection.
	//  //still limit only 
	// Modified by: Costas Manousakis-(Designer)-(2022-11-14 09:55:40)
	Mods_2022_11_bug
	//  `When running on server make [Status Report]Owner as Designer
End if 

G_InitCondRepVars
C_BOOLEAN:C305($vbCustomSel)
C_LONGINT:C283($viOnScreen)

$vbCustomSel:=True:C214
$viOnScreen:=1  //1= on screen msgs only
C_BOOLEAN:C305($vbOnScreen; $vbToFile)
$vbOnScreen:=(($viOnScreen=1) | ($viOnScreen=3))
$vbToFile:=(($viOnScreen=2) | ($viOnScreen=3))

C_LONGINT:C283($i; $j; $n; $Recs; $Interval)  //Command Replaced was o_C_INTEGER
//C_POINTER($p)
C_BOOLEAN:C305($agency)
C_POINTER:C301($aCond)
C_REAL:C285($vrAASHTOLimit)
$vrAASHTOLimit:=80

ARRAY REAL:C219($r_a58; 4)
ARRAY REAL:C219($r_a59; 4)
ARRAY REAL:C219($r_a60; 4)
ARRAY INTEGER:C220($i_a58; 4)
ARRAY INTEGER:C220($i_a59; 4)
ARRAY INTEGER:C220($i_a60; 4)

ARRAY REAL:C219($a_State_CEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_State_TEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_Town_CEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_Town_TEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_S_T_CEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_S_T_TEV; STATREP_NumDistr_L+1)

ARRAY REAL:C219($a_INTR_CEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_INTR_TEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_SU_CEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_SU_TEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_Local_CEV; STATREP_NumDistr_L+1)
ARRAY REAL:C219($a_Local_TEV; STATREP_NumDistr_L+1)
C_REAL:C285($MBTA_CEV; $MBTA_TEV; $MDC_CEV; $MDC_TEV; $MTA_CEV; $MTA_TEV; $MPA_CEV; $MPA_TEV; $DEM_CEV; $DEM_TEV; $OTHER_CEV; $OTHER_TEV)
C_REAL:C285($vr_ALLBridges_CEV; $vr_ALLBridges_TEV)

C_REAL:C285($MBTA_DA; $MBTA_SD_DA; $MDC_DA; $MDC_SD_DA; $DEM_DA; $DEM_SD_DA; $MPA_DA; $MPA_SD_DA; $OTH_DA; $OTH_SD_DA)
C_REAL:C285($MBTA_NHS_DA; $MBTA_NHS_SD_DA; $MDC_NHS_DA; $MDC_NHS_SD_DA; $DEM_NHS_DA; $DEM_NHS_SD_DA; $MPA_NHS_DA; $MPA_NHS_SD_DA; $OTH_NHS_DA; $OTH_NHS_SD_DA)

ARRAY TEXT:C222($FldSuffix_atxt; 0)
APPEND TO ARRAY:C911($FldSuffix_atxt; "_Area")
APPEND TO ARRAY:C911($FldSuffix_atxt; "_SD_Area")
APPEND TO ARRAY:C911($FldSuffix_atxt; "_NHS_Area")
APPEND TO ARRAY:C911($FldSuffix_atxt; "_NHS_SD_Area")


ARRAY REAL:C219($a_DA_S_; 0)
ARRAY REAL:C219($a_DA_S_SD; 0)
ARRAY REAL:C219($a_DA_T_; 0)
ARRAY REAL:C219($a_DA_T_SD; 0)
ARRAY REAL:C219($a_DA_S_NHS_; 0)
ARRAY REAL:C219($a_DA_S_NHS_SD; 0)
ARRAY REAL:C219($a_DA_T_NHS_; 0)
ARRAY REAL:C219($a_DA_T_NHS_SD; 0)

ARRAY REAL:C219($a_DA_S_; STATREP_NumDistr_L)
ARRAY REAL:C219($a_DA_S_SD; STATREP_NumDistr_L)
ARRAY REAL:C219($a_DA_S_NHS_; STATREP_NumDistr_L)
ARRAY REAL:C219($a_DA_S_NHS_SD; STATREP_NumDistr_L)
ARRAY REAL:C219($a_DA_T_; STATREP_NumDistr_L)
ARRAY REAL:C219($a_DA_T_SD; STATREP_NumDistr_L)
ARRAY REAL:C219($a_DA_T_NHS_; STATREP_NumDistr_L)
ARRAY REAL:C219($a_DA_T_NHS_SD; STATREP_NumDistr_L)

ARRAY POINTER:C280($StateArrays_aptr; 0)
APPEND TO ARRAY:C911($StateArrays_aptr; ->$a_DA_S_)
APPEND TO ARRAY:C911($StateArrays_aptr; ->$a_DA_S_SD)
APPEND TO ARRAY:C911($StateArrays_aptr; ->$a_DA_S_NHS_)
APPEND TO ARRAY:C911($StateArrays_aptr; ->$a_DA_S_NHS_SD)
ARRAY POINTER:C280($TownArrays_aptr; 0)
APPEND TO ARRAY:C911($TownArrays_aptr; ->$a_DA_T_)
APPEND TO ARRAY:C911($TownArrays_aptr; ->$a_DA_T_SD)
APPEND TO ARRAY:C911($TownArrays_aptr; ->$a_DA_T_NHS_)
APPEND TO ARRAY:C911($TownArrays_aptr; ->$a_DA_T_NHS_SD)

ARRAY REAL:C219($MBTA_DA_ar; 0)
ARRAY REAL:C219($MDC_DA_ar; 0)
ARRAY REAL:C219($DEM_DA_ar; 0)
ARRAY REAL:C219($MPA_DA_ar; 0)
ARRAY REAL:C219($MTA_DA_ar; 0)
ARRAY REAL:C219($OTH_DA_ar; 0)
//Index of arrays  to match the fields as in array $FldSuffix_atxt :
// 1: Total area
// 2 : SD Area
// 3 : NHS Area
// 4 : NHS SD Area
ARRAY REAL:C219($MBTA_DA_ar; Size of array:C274($FldSuffix_atxt))
ARRAY REAL:C219($MDC_DA_ar; Size of array:C274($FldSuffix_atxt))
ARRAY REAL:C219($MTA_DA_ar; Size of array:C274($FldSuffix_atxt))
ARRAY REAL:C219($MPA_DA_ar; Size of array:C274($FldSuffix_atxt))
ARRAY REAL:C219($DEM_DA_ar; Size of array:C274($FldSuffix_atxt))
ARRAY REAL:C219($OTH_DA_ar; Size of array:C274($FldSuffix_atxt))

//
// *** arrays $Agencies_atxt and $AgencyArrays_aptr MUST BE IN SAME ORDER !!!
//
ARRAY TEXT:C222($Agencies_atxt; 0)
APPEND TO ARRAY:C911($Agencies_atxt; "MBTA")
APPEND TO ARRAY:C911($Agencies_atxt; "MDC")
APPEND TO ARRAY:C911($Agencies_atxt; "MTA")
APPEND TO ARRAY:C911($Agencies_atxt; "MPA")
APPEND TO ARRAY:C911($Agencies_atxt; "DEM")
APPEND TO ARRAY:C911($Agencies_atxt; "DNR")

ARRAY POINTER:C280($AgencyArrays_aptr; 0)
APPEND TO ARRAY:C911($AgencyArrays_aptr; ->$MBTA_DA_ar)
APPEND TO ARRAY:C911($AgencyArrays_aptr; ->$MDC_DA_ar)
APPEND TO ARRAY:C911($AgencyArrays_aptr; ->$MTA_DA_ar)
APPEND TO ARRAY:C911($AgencyArrays_aptr; ->$MPA_DA_ar)
APPEND TO ARRAY:C911($AgencyArrays_aptr; ->$DEM_DA_ar)
APPEND TO ARRAY:C911($AgencyArrays_aptr; ->$OTH_DA_ar)

C_TEXT:C284($vs_Item7_2)  // Command Replaced was o_C_STRING length was 2//1st two chars of item 7

For ($i; 1; 4)
	$r_a58{$i}:=0
	$r_a59{$i}:=0
	$r_a60{$i}:=0
	$i_a58{$i}:=0
	$i_a59{$i}:=0
	$i_a60{$i}:=0
End for 

If (False:C215)
	//
	//  ` description of $j dimension for 2D arrays (astate,atown) 
	//  ` and $i dimension for 1D arrays (aMBTA,..,aDNR, astate_z, atownn_z, atotal)
	//  `  ` 1 : total count
	//  `  ` 2 : SD count
	//  `  ` 4 : FO Count
	//  `  ` 6 : posted count
	//  `  ` 8 : closed count`
	//  `  ` 10 : temporary stucture count`
	//  `  ` 12 : over 50 yrs old
	//  `  ` the odds are reserved for percentage
	
End if 

For ($i; 1; STATREP_NumDistr_L)
	For ($j; 1; 13)
		astate{$i}{$j}:=0
		atown{$i}{$j}:=0
	End for 
End for 
For ($i; 1; 13)
	aMBTA{$i}:=0
	aMDC{$i}:=0
	aMTA{$i}:=0
	aMPA{$i}:=0
	aDEM{$i}:=0
	aDNR{$i}:=0
	astate_z{$i}:=0
	atown_z{$i}:=0
	atotal{$i}:=0
End for 

C_DATE:C307($StatRepDate_d)
$StatRepDate_d:=Date:C102(Request:C163("Enter Date to create status report"))
If (OK=1)
	QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]ArchiveReason_s:223="MONTHLYARCHIVE"; *)
	QUERY:C277([BridgeMHDNBISArchive:139];  & ; [BridgeMHDNBISArchive:139]ArchiveDate_d:224=$StatRepDate_d)
	CONFIRM:C162("Report only on NBI records or do a custom search?"; "Only NBI"; "Custom Search")
	
	If (OK=1)
		QUERY SELECTION:C341([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]FHWARecord:173=True:C214)
		$Recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
	Else 
		QUERY SELECTION:C341([BridgeMHDNBISArchive:139])
		$Recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
	End if 
	
Else 
	$Recs:=-1
End if 


If ($Recs>0)
	
	CREATE RECORD:C68([Status Report:69])
	
	If ($vbOnScreen)
		SHORT_MESSAGE("Loading Data...")
	End if 
	
	STATREP_UseLegacyOwn_b:=False:C215
	STATREP_DistrictMethod_L:=2
	C_BOOLEAN:C305($Poor_or_OldSD_b)
	
	C_OBJECT:C1216(STATREP_CalcParams_o)
	OB SET:C1220(STATREP_CalcParams_o; "DistrictCalc"; STATREP_DistrictMethod_L)
	OB SET:C1220(STATREP_CalcParams_o; "SDNewCalcMethod"; $Poor_or_OldSD_b)
	OB SET:C1220(STATREP_CalcParams_o; "UseLegacy"; STATREP_UseLegacyOwn_b)
	C_LONGINT:C283($newwin_L)
	$newwin_L:=Open form window:C675("BridgeStatRepParameters"; Movable form dialog box:K39:8)
	
	DIALOG:C40("BridgeStatRepParameters")
	CLOSE WINDOW:C154($newwin_L)
	
	STATREP_DistrictMethod_L:=OB Get:C1224(STATREP_CalcParams_o; "DistrictCalc"; Is longint:K8:6)
	$Poor_or_OldSD_b:=OB Get:C1224(STATREP_CalcParams_o; "SDNewCalcMethod"; Is boolean:K8:9)
	STATREP_UseLegacyOwn_b:=OB Get:C1224(STATREP_CalcParams_o; "UseLegacy"; Is boolean:K8:9)
	
	C_TEXT:C284($BrgCond_txt)
	
	ARRAY TEXT:C222($aowner; $Recs)  //Command Replaced was o_ARRAY string length was 12
	ARRAY TEXT:C222($aLegOwner; $Recs)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($aBDEPT; $Recs)  //Command Replaced was o_ARRAY string length was 6
	ARRAY TEXT:C222($a5; $Recs)  //Command Replaced was o_ARRAY string length was 9
	ARRAY REAL:C219($a49; $Recs)
	ARRAY BOOLEAN:C223($a112; $Recs)
	ARRAY TEXT:C222($a42; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY INTEGER:C220($a27; $Recs)
	ARRAY INTEGER:C220($a106; $Recs)
	ARRAY REAL:C219($aashto; $Recs)
	ARRAY TEXT:C222($a43; $Recs)  //Command Replaced was o_ARRAY string length was 3
	ARRAY TEXT:C222($a58; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a59; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a60; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a62; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a67; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a67; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a71; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a68; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a69; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a72; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a2; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY TEXT:C222($a41; $Recs)  //Command Replaced was o_ARRAY string length was 2
	ARRAY BOOLEAN:C223($a103; $Recs)
	ARRAY REAL:C219($aBridgeTEV; $Recs)
	ARRAY REAL:C219($aBridgeCEV; $Recs)
	ARRAY REAL:C219($a49; $Recs)
	ARRAY REAL:C219($a52; $Recs)
	ARRAY INTEGER:C220($a34; $Recs)
	ARRAY REAL:C219($a32; $Recs)
	ARRAY BOOLEAN:C223($a104; $Recs)
	ARRAY TEXT:C222($a7; $Recs)  //Command Replaced was o_ARRAY string length was 18
	
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item8 Owner:205; $aowner; [BridgeMHDNBISArchive:139]Item5:58; $a5; [BridgeMHDNBISArchive:139]Item49:92; $a49; [BridgeMHDNBISArchive:139]Item112:117; $a112)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item42:84; $a42; [BridgeMHDNBISArchive:139]Item27:82; $a27; [BridgeMHDNBISArchive:139]Item106:83; $a106; [BridgeMHDNBISArchive:139]AASHTO:5; $aashto)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item43:74; $a43; [BridgeMHDNBISArchive:139]Item58:129; $a58; [BridgeMHDNBISArchive:139]Item59:130; $a59; [BridgeMHDNBISArchive:139]Item60:131; $a60)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item62:133; $a62; [BridgeMHDNBISArchive:139]Item67:141; $a67; [BridgeMHDNBISArchive:139]Item71:144; $a71; [BridgeMHDNBISArchive:139]Item68:142; $a68)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item69:143; $a69; [BridgeMHDNBISArchive:139]Item72:145; $a72; [BridgeMHDNBISArchive:139]Item2:59; $a2; [BridgeMHDNBISArchive:139]Item41:140; $a41; [BridgeMHDNBISArchive:139]Item103:123; $a103)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]HI_Current_Elmt_Cost:218; $aBridgeCEV; [BridgeMHDNBISArchive:139]HI_Total_Elmt_Cost:217; $aBridgeTEV; [BridgeMHDNBISArchive:139]LegacyOwner:225; $aLegOwner)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item7:64; $a7; [BridgeMHDNBISArchive:139]BDEPT:1; $aBDEPT)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item49:92; $a49; [BridgeMHDNBISArchive:139]Item52:96; $a52; [BridgeMHDNBISArchive:139]Item34:99; $a34; [BridgeMHDNBISArchive:139]Item32:97; $a32; [BridgeMHDNBISArchive:139]Item104:118; $a104)
	
	ARRAY BOOLEAN:C223($NBIRecord_ab; 0)
	ARRAY TEXT:C222($BrgCategory_atxt; 0)
	DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]FHWARecord:173; $NBIRecord_ab)
	DISTINCT VALUES:C339([BridgeMHDNBISArchive:139]Item8 BridgeCat:204; $BrgCategory_atxt)
	C_LONGINT:C283($totNBI_L; $TotBRI_L)
	SET QUERY DESTINATION:C396(Into variable:K19:4; $totNBI_L)
	Begin SQL
		select count(*)
		from [BridgeMHDNBISArchive]
		where
		[BridgeMHDNBISArchive].ArchiveReason_s= 'MONTHLYARCHIVE'
		and 
		[BridgeMHDNBISArchive].ArchiveDate_d = :$StatRepDate_d
		and
		cast ([BridgeMHDNBISArchive].FHWARecord as INT) =1
		into :$totNBI_L ;
	End SQL
	Begin SQL
		select count(*)
		from [BridgeMHDNBISArchive]
		where
		[BridgeMHDNBISArchive].ArchiveReason_s= 'MONTHLYARCHIVE'
		and 
		[BridgeMHDNBISArchive].ArchiveDate_d = :$StatRepDate_d
		and
		[BridgeMHDNBISArchive].[Item8 BridgeCat] = 'BRI'
		into :$TotBRI_L ;
	End SQL
	
	If ($vbOnScreen)
		CLOSE WINDOW:C154
	End if 
	C_LONGINT:C283(STATREP_DistrictMethod_L)
	
	$agency:=False:C215
	C_BOOLEAN:C305($StateBridge_b)
	C_TEXT:C284($owner_txt)
	C_REAL:C285($area_r)
	C_POINTER:C301($Ag_area_ptr; $ag_sdarea_ptr; $ag_nhsarea_ptr; $ag_nhssdarea_ptr; $Ag_areas_ptr)
	//C_TIME($TesTout_t)
	//$TesTout_t:=Create document("")
	C_OBJECT:C1216($progressObj_o)
	
	If ($vbOnScreen)
		$progressObj_o:=ProgressNew("Condition Data"; $Recs; False:C215; ""; 3)
		
		//<>ProgressPID:=StartProgress ("GenCondRep";"None";"Condition Data")
		$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
		//UpdateProgress (1;$Recs)
		
	End if 
	For ($i; 1; Records in selection:C76([BridgeMHDNBISArchive:139]))
		$n:=STATREP_DistrNo($a2{$i}; $aBDEPT{$i})
		If (STATREP_UseLegacyOwn_b)
			$owner_txt:=$aLegOwner{$i}
			If ($owner_txt="")
				$owner_txt:=$aowner{$i}
			End if 
			$StateBridge_b:=fStateBridge($owner_txt)
		Else 
			$owner_txt:=$aowner{$i}
			$StateBridge_b:=fStateBridge($aowner{$i})
		End if 
		$area_r:=QR_BridgeArea_r($a49{$i}; $a52{$i}; $a34{$i}; $a32{$i})
		C_BOOLEAN:C305($B_SD_b; $B_FO_b; $B_NHS_b)
		$B_SD_b:=False:C215
		$B_FO_b:=False:C215
		$B_NHS_b:=$a104{$i}
		
		If ($Poor_or_OldSD_b)
			$BrgCond_txt:=SIA_BridgeCondRating($a58{$i}; $a59{$i}; $a60{$i}; $a62{$i})
			
			Case of 
				: ($BrgCond_txt="POOR@")
					$B_SD_b:=True:C214
				: ($BrgCond_txt="FAIR@")
					$B_FO_b:=True:C214
			End case 
			
		Else 
			
			If (bFuncObsCheck($a5{$i}; $a49{$i}; $a112{$i}; $a42{$i}; $a27{$i}; $a106{$i}) & ($aashto{$i}<$vrAASHTOLimit))
				If (bDeficient($a42{$i}; $a43{$i}; $a58{$i}; $a59{$i}; $a60{$i}; $a62{$i}; $a67{$i}; $a71{$i}))
					$B_SD_b:=True:C214
				Else 
					If (bObsolete($a42{$i}; $a67{$i}; $a68{$i}; $a69{$i}; $a71{$i}; $a72{$i}))
						$B_FO_b:=True:C214
					End if 
				End if 
			End if 
			
		End if 
		//SEND PACKET($TesTout_t;String($n)+Char(9)+f_Boolean2String ($StateBridge_b;"SN")+Char(9)+String($area_r)+Char(9)+f_Boolean2String ($B_SD_b;"YN")+Char(9)+f_Boolean2String ($B_NHS_b;"YN")+Char(13))
		Case of 
			: ($StateBridge_b=True:C214)
				
				If (($n>0) & ($n<=STATREP_NumDistr_L))
					$a_State_CEV{$n}:=$a_State_CEV{$n}+$aBridgeCEV{$i}
					$a_State_TEV{$n}:=$a_State_TEV{$n}+$aBridgeTEV{$i}
					
					If ($a58{$i}#"N")
						$r_a58{1}:=$r_a58{1}+Num:C11($a58{$i})
						$i_a58{1}:=$i_a58{1}+1
					End if 
					If ($a59{$i}#"N")
						$r_a59{1}:=$r_a59{1}+Num:C11($a59{$i})
						$i_a59{1}:=$i_a59{1}+1
					End if 
					If ($a60{$i}#"N")
						$r_a60{1}:=$r_a60{1}+Num:C11($a60{$i})
						$i_a60{1}:=$i_a60{1}+1
					End if 
					
					astate{$n}{1}:=astate{$n}{1}+1
					
					$a_DA_S_{$n}:=$a_DA_S_{$n}+$area_r
					If ($B_NHS_b)
						$a_DA_S_NHS_{$n}:=$a_DA_S_NHS_{$n}+$area_r
					End if 
					
					If ($B_SD_b)
						astate{$n}{2}:=astate{$n}{2}+1
						$a_DA_S_SD{$n}:=$a_DA_S_SD{$n}+$area_r
						If ($B_NHS_b)
							$a_DA_S_NHS_SD{$n}:=$a_DA_S_NHS_SD{$n}+$area_r
						End if 
					End if 
					If ($B_FO_b)
						astate{$n}{4}:=astate{$n}{4}+1
					End if 
					
					//If ((bFuncObsCheck ($a5{$i};$a49{$i};$a112{$i};$a42{$i};$a27{$i};$a106{$i})=True) & ($aashto{$i}<$vrAASHTOLimit))
					//If (bDeficient ($a42{$i};$a43{$i};$a58{$i};$a59{$i};$a60{$i};$a62{$i};$a67{$i};$a71{$i})=True)
					//astate{$n}{2}:=astate{$n}{2}+1
					//Else 
					//If (bObsolete ($a42{$i};$a67{$i};$a68{$i};$a69{$i};$a71{$i};$a72{$i})=True)
					//astate{$n}{4}:=astate{$n}{4}+1
					//End if 
					//End if 
					//End if 
					Case of 
						: ($a41{$i}="P")
							astate{$n}{6}:=astate{$n}{6}+1
						: ($a41{$i}="K")
							astate{$n}{8}:=astate{$n}{8}+1
					End case 
					If ($a103{$i}=True:C214)
						astate{$n}{10}:=astate{$n}{10}+1
					End if 
					If (iAgeofBridge($a27{$i}; $a106{$i})>50)
						astate{$n}{12}:=astate{$n}{12}+1
					End if 
				End if 
			: ((fTWNBridge($owner_txt)=True:C214) | (fMUNBridge($owner_txt)=True:C214))
				If (($n>0) & ($n<=STATREP_NumDistr_L))
					$a_Town_CEV{$n}:=$a_Town_CEV{$n}+$aBridgeCEV{$i}
					$a_Town_TEV{$n}:=$a_Town_TEV{$n}+$aBridgeTEV{$i}
					
					If ($a58{$i}#"N")
						$r_a58{2}:=$r_a58{2}+Num:C11($a58{$i})
						$i_a58{2}:=$i_a58{2}+1
					End if 
					If ($a59{$i}#"N")
						$r_a59{2}:=$r_a59{2}+Num:C11($a59{$i})
						$i_a59{2}:=$i_a59{2}+1
					End if 
					If ($a60{$i}#"N")
						$r_a60{2}:=$r_a60{2}+Num:C11($a60{$i})
						$i_a60{2}:=$i_a60{2}+1
					End if 
					atown{$n}{1}:=atown{$n}{1}+1
					
					$a_DA_T_{$n}:=$a_DA_T_{$n}+$area_r
					If ($B_NHS_b)
						$a_DA_T_NHS_{$n}:=$a_DA_T_NHS_{$n}+$area_r
					End if 
					
					If ($B_SD_b)
						atown{$n}{2}:=atown{$n}{2}+1
						$a_DA_T_SD{$n}:=$a_DA_T_SD{$n}+$area_r
						If ($B_NHS_b)
							$a_DA_T_NHS_SD{$n}:=$a_DA_T_NHS_SD{$n}+$area_r
						End if 
					End if 
					If ($B_FO_b)
						atown{$n}{4}:=atown{$n}{4}+1
					End if 
					
					//If ((bFuncObsCheck ($a5{$i};$a49{$i};$a112{$i};$a42{$i};$a27{$i};$a106{$i})=True) & ($aashto{$i}<$vrAASHTOLimit))
					//If (bDeficient ($a42{$i};$a43{$i};$a58{$i};$a59{$i};$a60{$i};$a62{$i};$a67{$i};$a71{$i})=True)
					//atown{$n}{2}:=atown{$n}{2}+1
					//Else 
					//If (bObsolete ($a42{$i};$a67{$i};$a68{$i};$a69{$i};$a71{$i};$a72{$i})=True)
					//atown{$n}{4}:=atown{$n}{4}+1
					//End if 
					//End if 
					//End if 
					Case of 
						: ($a41{$i}="P")
							atown{$n}{6}:=atown{$n}{6}+1
						: ($a41{$i}="K")
							atown{$n}{8}:=atown{$n}{8}+1
					End case 
					If ($a103{$i}=True:C214)
						atown{$n}{10}:=atown{$n}{10}+1
					End if 
					If (iAgeofBridge($a27{$i}; $a106{$i})>50)
						atown{$n}{12}:=atown{$n}{12}+1
					End if 
				End if 
			: (bMBTABridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aMBTA
				$MBTA_CEV:=$MBTA_CEV+$aBridgeCEV{$i}
				$MBTA_TEV:=$MBTA_TEV+$aBridgeTEV{$i}
				$Ag_areas_ptr:=->$MBTA_DA_ar
				
			: (bMDCBridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aMDC
				$MDC_CEV:=$MDC_CEV+$aBridgeCEV{$i}
				$MDC_TEV:=$MDC_TEV+$aBridgeTEV{$i}
				$Ag_areas_ptr:=->$MDC_DA_ar
				
			: (bMTABridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aMTA
				$MTA_CEV:=$MTA_CEV+$aBridgeCEV{$i}
				$MTA_TEV:=$MTA_TEV+$aBridgeTEV{$i}
				$Ag_areas_ptr:=->$MTA_DA_ar
				
			: (bMPABridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aMPA
				$MPA_CEV:=$MPA_CEV+$aBridgeCEV{$i}
				$MPA_TEV:=$MPA_TEV+$aBridgeTEV{$i}
				$Ag_areas_ptr:=->$MPA_DA_ar
				
			: (bDEMBridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aDEM
				$DEM_CEV:=$DEM_CEV+$aBridgeCEV{$i}
				$DEM_TEV:=$DEM_TEV+$aBridgeTEV{$i}
				$Ag_areas_ptr:=->$DEM_DA_ar
				
			: (bDNRBridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aDNR
				$OTHER_CEV:=$OTHER_CEV+$aBridgeCEV{$i}
				$OTHER_TEV:=$OTHER_TEV+$aBridgeTEV{$i}
				$Ag_areas_ptr:=->$OTH_DA_ar
				
				//23-mar-01 : added check for bridges that do not fall in any
				//     category above
			Else 
				$agency:=True:C214
				$aCond:=->aDNR
				$OTHER_CEV:=$OTHER_CEV+$aBridgeCEV{$i}
				$OTHER_TEV:=$OTHER_TEV+$aBridgeTEV{$i}
				$Ag_areas_ptr:=->$OTH_DA_ar
				
				//ALERT("Unknown owner for bridge : "+$owner_txt)
		End case 
		If ($agency=True:C214)
			If ($a58{$i}#"N")
				$r_a58{4}:=$r_a58{4}+Num:C11($a58{$i})
				$i_a58{4}:=$i_a58{4}+1
			End if 
			If ($a59{$i}#"N")
				$r_a59{4}:=$r_a59{4}+Num:C11($a59{$i})
				$i_a59{4}:=$i_a59{4}+1
			End if 
			If ($a60{$i}#"N")
				$r_a60{4}:=$r_a60{4}+Num:C11($a60{$i})
				$i_a60{4}:=$i_a60{4}+1
			End if 
			$aCond->{1}:=$aCond->{1}+1
			
			$Ag_areas_ptr->{1}:=$Ag_areas_ptr->{1}+$area_r
			If ($B_NHS_b)
				$Ag_areas_ptr->{3}:=$Ag_areas_ptr->{3}+$area_r
			End if 
			
			If ($B_SD_b)
				$aCond->{2}:=$aCond->{2}+1
				$Ag_areas_ptr->{2}:=$Ag_areas_ptr->{2}+$area_r
				If ($B_NHS_b)
					$Ag_areas_ptr->{4}:=$Ag_areas_ptr->{4}+$area_r
				End if 
			End if 
			
			If ($B_FO_b)
				$aCond->{4}:=$aCond->{4}+1
			End if 
			
			//If ((bFuncObsCheck ($a5{$i};$a49{$i};$a112{$i};$a42{$i};$a27{$i};$a106{$i})=True) & ($aashto{$i}<$vrAASHTOLimit))
			//If (bDeficient ($a42{$i};$a43{$i};$a58{$i};$a59{$i};$a60{$i};$a62{$i};$a67{$i};$a71{$i})=True)
			//$aCond->{2}:=$aCond->{2}+1
			//Else 
			//If (bObsolete ($a42{$i};$a67{$i};$a68{$i};$a69{$i};$a71{$i};$a72{$i})=True)
			//$aCond->{4}:=$aCond->{4}+1
			//End if 
			//End if 
			//End if 
			Case of 
				: ($a41{$i}="P")
					$aCond->{6}:=$aCond->{6}+1
				: ($a41{$i}="K")
					$aCond->{8}:=$aCond->{8}+1
			End case 
			If ($a103{$i}=True:C214)
				$aCond->{10}:=$aCond->{10}+1
			End if 
			If (iAgeofBridge($a27{$i}; $a106{$i})>50)
				$aCond->{12}:=$aCond->{12}+1
			End if 
			$agency:=False:C215
		End if 
		//Check for interstate - state hwy - Local
		$vs_Item7_2:=Substring:C12($a7{$i}; 1; 2)
		//$n:=Num($a2{$i})
		
		Case of 
			: ($vs_Item7_2="I ")
				If (($n>0) & ($n<=STATREP_NumDistr_L))
					$a_INTR_CEV{$n}:=$a_INTR_CEV{$n}+$aBridgeCEV{$i}
					$a_INTR_TEV{$n}:=$a_INTR_TEV{$n}+$aBridgeTEV{$i}
				End if 
				
			: ($vs_Item7_2="ST")
				If (($n>0) & ($n<=STATREP_NumDistr_L))
					$a_SU_CEV{$n}:=$a_SU_CEV{$n}+$aBridgeCEV{$i}
					$a_SU_TEV{$n}:=$a_SU_TEV{$n}+$aBridgeTEV{$i}
				End if 
			: ($vs_Item7_2="US")
				If (($n>0) & ($n<=STATREP_NumDistr_L))
					$a_SU_CEV{$n}:=$a_SU_CEV{$n}+$aBridgeCEV{$i}
					$a_SU_TEV{$n}:=$a_SU_TEV{$n}+$aBridgeTEV{$i}
				End if 
			: ($vs_Item7_2="HW")
				If (($n>0) & ($n<=STATREP_NumDistr_L))
					$a_Local_CEV{$n}:=$a_Local_CEV{$n}+$aBridgeCEV{$i}
					$a_Local_TEV{$n}:=$a_Local_TEV{$n}+$aBridgeTEV{$i}
				End if 
				
				
		End case 
		
		If ($vbOnScreen)
			If ($i%$Interval)=0
				UpdateProgressNew($progressObj_o; $i)
			End if 
		End if 
	End for 
	//CLOSE DOCUMENT($TesTout_t)
	If ($vbOnScreen)
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
	End if 
	
	For ($i; 1; 6)
		For ($j; 1; STATREP_NumDistr_L)
			astate{$j}{($i*2)+1}:=Round:C94((astate{$j}{$i*2}*100)/astate{$j}{1}; 0)
			atown{$j}{($i*2)+1}:=Round:C94((atown{$j}{$i*2}*100)/atown{$j}{1}; 0)
		End for 
	End for 
	
	For ($i; 1; 6)
		aMBTA{($i*2)+1}:=Round:C94((aMBTA{$i*2}*100)/aMBTA{1}; 0)
		aMDC{($i*2)+1}:=Round:C94((aMDC{$i*2}*100)/aMDC{1}; 0)
		aMTA{($i*2)+1}:=Round:C94((aMTA{$i*2}*100)/aMTA{1}; 0)
		aMPA{($i*2)+1}:=Round:C94((aMPA{$i*2}*100)/aMPA{1}; 0)
		aDEM{($i*2)+1}:=Round:C94((aDEM{$i*2}*100)/aDEM{1}; 0)
		aDNR{($i*2)+1}:=Round:C94((aDNR{$i*2}*100)/aDNR{1}; 0)
	End for 
	
	For ($i; 1; 13)
		For ($j; 1; STATREP_NumDistr_L)
			astate_z{$i}:=astate_z{$i}+astate{$j}{$i}
			atown_z{$i}:=atown_z{$i}+atown{$j}{$i}
		End for 
	End for 
	
	For ($i; 1; 13)
		atotal{$i}:=astate_z{$i}+atown_z{$i}
		atotal{$i}:=atotal{$i}+aMBTA{$i}+aMDC{$i}+aMTA{$i}+aMPA{$i}+aDEM{$i}+aDNR{$i}
	End for 
	
	For ($i; 1; 6)
		astate_z{($i*2)+1}:=Round:C94((astate_z{$i*2}*100)/astate_z{1}; 0)
		atown_z{($i*2)+1}:=Round:C94((atown_z{$i*2}*100)/atown_z{1}; 0)
		atotal{($i*2)+1}:=Round:C94((atotal{$i*2}*100)/atotal{1}; 0)
	End for 
	
	$i_a58{3}:=$i_a58{1}+$i_a58{2}
	$i_a59{3}:=$i_a59{1}+$i_a59{2}
	$i_a60{3}:=$i_a60{1}+$i_a60{2}
	$i_a58{4}:=$i_a58{4}+$i_a58{3}
	$i_a59{4}:=$i_a59{4}+$i_a59{3}
	$i_a60{4}:=$i_a60{4}+$i_a60{3}
	
	$r_a58{3}:=$r_a58{1}+$r_a58{2}
	$r_a59{3}:=$r_a59{1}+$r_a59{2}
	$r_a60{3}:=$r_a60{1}+$r_a60{2}
	$r_a58{4}:=$r_a58{4}+$r_a58{3}
	$r_a59{4}:=$r_a59{4}+$r_a59{3}
	$r_a60{4}:=$r_a60{4}+$r_a60{3}
	
	For ($i; 1; 4)
		$r_a58{$i}:=$r_a58{$i}/$i_a58{$i}
		$r_a59{$i}:=$r_a59{$i}/$i_a59{$i}
		$r_a60{$i}:=$r_a60{$i}/$i_a60{$i}
	End for 
	
	[Status Report:69]S_58:122:=$r_a58{1}
	[Status Report:69]S_59:123:=$r_a59{1}
	[Status Report:69]S_60:124:=$r_a60{1}
	[Status Report:69]T_58:125:=$r_a58{2}
	[Status Report:69]T_59:126:=$r_a59{2}
	[Status Report:69]T_60:127:=$r_a60{2}
	[Status Report:69]ST_58:128:=$r_a58{3}
	[Status Report:69]ST_59:129:=$r_a59{3}
	[Status Report:69]ST_60:130:=$r_a60{3}
	[Status Report:69]A_58:131:=$r_a58{4}
	[Status Report:69]A_59:132:=$r_a59{4}
	[Status Report:69]A_60:133:=$r_a60{4}
	
	For ($i; 1; STATREP_NumDistr_L)
		$a_State_CEV{(STATREP_NumDistr_L+1)}:=$a_State_CEV{(STATREP_NumDistr_L+1)}+$a_State_CEV{$i}
		$a_State_TEV{(STATREP_NumDistr_L+1)}:=$a_State_TEV{(STATREP_NumDistr_L+1)}+$a_State_TEV{$i}
		$a_Town_CEV{(STATREP_NumDistr_L+1)}:=$a_Town_CEV{(STATREP_NumDistr_L+1)}+$a_Town_CEV{$i}
		$a_Town_TEV{(STATREP_NumDistr_L+1)}:=$a_Town_TEV{(STATREP_NumDistr_L+1)}+$a_Town_TEV{$i}
		$a_S_T_CEV{$i}:=$a_State_CEV{$i}+$a_Town_CEV{$i}
		$a_S_T_TEV{$i}:=$a_State_TEV{$i}+$a_Town_TEV{$i}
		$a_S_T_CEV{(STATREP_NumDistr_L+1)}:=$a_S_T_CEV{(STATREP_NumDistr_L+1)}+$a_S_T_CEV{$i}
		$a_S_T_TEV{(STATREP_NumDistr_L+1)}:=$a_S_T_TEV{(STATREP_NumDistr_L+1)}+$a_S_T_TEV{$i}
		$a_INTR_CEV{(STATREP_NumDistr_L+1)}:=$a_INTR_CEV{(STATREP_NumDistr_L+1)}+$a_INTR_CEV{$i}
		$a_INTR_TEV{(STATREP_NumDistr_L+1)}:=$a_INTR_TEV{(STATREP_NumDistr_L+1)}+$a_INTR_TEV{$i}
		$a_SU_CEV{(STATREP_NumDistr_L+1)}:=$a_SU_CEV{(STATREP_NumDistr_L+1)}+$a_SU_CEV{$i}
		$a_SU_TEV{(STATREP_NumDistr_L+1)}:=$a_SU_TEV{(STATREP_NumDistr_L+1)}+$a_SU_TEV{$i}
		$a_Local_CEV{(STATREP_NumDistr_L+1)}:=$a_Local_CEV{(STATREP_NumDistr_L+1)}+$a_Local_CEV{$i}
		$a_Local_TEV{(STATREP_NumDistr_L+1)}:=$a_Local_TEV{(STATREP_NumDistr_L+1)}+$a_Local_TEV{$i}
		
	End for 
	$vr_ALLBridges_CEV:=$a_S_T_CEV{(STATREP_NumDistr_L+1)}+$MBTA_CEV+$MDC_CEV+$MTA_CEV+$MPA_CEV+$DEM_CEV+$OTHER_CEV
	$vr_ALLBridges_TEV:=$a_S_T_TEV{(STATREP_NumDistr_L+1)}+$MBTA_TEV+$MDC_TEV+$MTA_TEV+$MPA_TEV+$DEM_TEV+$OTHER_TEV
	
	C_POINTER:C301($StatReptFld_ptr)
	For ($i; 1; STATREP_NumDistr_L)
		$StatReptFld_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($i)+"_HI")
		$StatReptFld_ptr->:=HI_CalcHI_Function($a_State_CEV{$i}; $a_State_TEV{$i})
		$StatReptFld_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($i)+"_HI")
		$StatReptFld_ptr->:=HI_CalcHI_Function($a_Town_CEV{$i}; $a_Town_TEV{$i})
		$StatReptFld_ptr:=STATREP_GetFieldPTR("S_T_D"+String:C10($i)+"_HI")
		$StatReptFld_ptr->:=HI_CalcHI_Function($a_S_T_CEV{$i}; $a_S_T_TEV{$i})
		$StatReptFld_ptr:=STATREP_GetFieldPTR("INT_D"+String:C10($i)+"_HI")
		$StatReptFld_ptr->:=HI_CalcHI_Function($a_INTR_CEV{$i}; $a_INTR_TEV{$i})
		$StatReptFld_ptr:=STATREP_GetFieldPTR("SU_D"+String:C10($i)+"_HI")
		$StatReptFld_ptr->:=HI_CalcHI_Function($a_SU_CEV{$i}; $a_SU_TEV{$i})
		$StatReptFld_ptr:=STATREP_GetFieldPTR("Loc_D"+String:C10($i)+"_HI")
		$StatReptFld_ptr->:=HI_CalcHI_Function($a_Local_CEV{$i}; $a_Local_TEV{$i})
	End for 
	
	[Status Report:69]S_Tot_HI:141:=HI_CalcHI_Function($a_State_CEV{(STATREP_NumDistr_L+1)}; $a_State_TEV{(STATREP_NumDistr_L+1)})
	[Status Report:69]T_Tot_HI:147:=HI_CalcHI_Function($a_Town_CEV{(STATREP_NumDistr_L+1)}; $a_Town_TEV{(STATREP_NumDistr_L+1)})
	[Status Report:69]S_T_Tot_HI:153:=HI_CalcHI_Function($a_S_T_CEV{(STATREP_NumDistr_L+1)}; $a_S_T_TEV{(STATREP_NumDistr_L+1)})
	[Status Report:69]INT_Tot_HI:166:=HI_CalcHI_Function($a_INTR_CEV{(STATREP_NumDistr_L+1)}; $a_INTR_TEV{(STATREP_NumDistr_L+1)})
	[Status Report:69]SU_Tot_HI:172:=HI_CalcHI_Function($a_SU_CEV{(STATREP_NumDistr_L+1)}; $a_SU_TEV{(STATREP_NumDistr_L+1)})
	[Status Report:69]Loc_Tot_HI:178:=HI_CalcHI_Function($a_Local_CEV{(STATREP_NumDistr_L+1)}; $a_Local_TEV{(STATREP_NumDistr_L+1)})
	
	[Status Report:69]MBTA_HI:154:=HI_CalcHI_Function($MBTA_CEV; $MBTA_TEV)
	[Status Report:69]MDC_HI:155:=HI_CalcHI_Function($MDC_CEV; $MDC_TEV)
	[Status Report:69]MTA_HI:156:=HI_CalcHI_Function($MTA_CEV; $MTA_TEV)
	[Status Report:69]MPA_HI:157:=HI_CalcHI_Function($MPA_CEV; $MPA_TEV)
	[Status Report:69]DEM_HI:158:=HI_CalcHI_Function($DEM_CEV; $DEM_TEV)
	[Status Report:69]OTHER_HI:159:=HI_CalcHI_Function($OTHER_CEV; $OTHER_TEV)
	[Status Report:69]ALLBR_HI:160:=HI_CalcHI_Function($vr_ALLBridges_CEV; $vr_ALLBridges_TEV)
	
	//
	// ****   SAVE THE SD Area calculations
	//agencies
	
	C_LONGINT:C283($loop_L; $loop2_L)
	C_POINTER:C301($Fld_ptr; $Var_ptr)
	For ($loop_L; 1; Size of array:C274($Agencies_atxt))
		For ($loop2_L; 1; Size of array:C274($FldSuffix_atxt))
			$Fld_ptr:=STATREP_GetFieldPTR($Agencies_atxt{$loop_L}+$FldSuffix_atxt{$loop2_L})
			$Fld_ptr->:=$AgencyArrays_aptr{$loop_L}->{$loop2_L}
		End for 
		
	End for 
	
	//State and Town
	
	For ($loop_L; 1; STATREP_NumDistr_L)
		
		For ($loop2_L; 1; Size of array:C274($FldSuffix_atxt))
			//State fields
			$Fld_ptr:=STATREP_GetFieldPTR("S_D"+String:C10($loop_L)+$FldSuffix_atxt{$loop2_L})
			$Fld_ptr->:=$StateArrays_aptr{$loop2_L}->{$loop_L}
			//Town Fields
			$Fld_ptr:=STATREP_GetFieldPTR("T_D"+String:C10($loop_L)+$FldSuffix_atxt{$loop2_L})
			$Fld_ptr->:=$TownArrays_aptr{$loop2_L}->{$loop_L}
		End for 
		
	End for 
	
	[Status Report:69]Date_Created:1:=Current date:C33(*)
	Case of 
		: (Application type:C494=4D Server:K5:6)
			//running on server 
			[Status Report:69]Owner:2:="Designer"
		Else 
			[Status Report:69]Owner:2:=Current user:C182
	End case 
	[Status Report:69]Time_Created:134:=Current time:C178(*)
	[Status Report:69]SD_Calc_New_b:265:=$Poor_or_OldSD_b
	[Status Report:69]UseLegacyOwner_b:266:=STATREP_USELEGACYOWN_B
	[Status Report:69]DistrictMethod_L:267:=STATREP_DistrictMethod_L
	
	Case of 
		: (Size of array:C274($NBIRecord_ab)=1)
			//only one type
			If ($NBIRecord_ab{1})
				//just NBI records 
				
				If ($Recs=$TotBRI_L)
					//all NBI records 
					
				Else 
					//some NBI records 
					[Status Report:69]DistrictMethod_L:267:=400+[Status Report:69]DistrictMethod_L:267
					
				End if 
				
			Else 
				//all non-NBI
				If (Size of array:C274($BrgCategory_atxt)=1)
					If ($BrgCategory_atxt{1}="BRI")
						//just BRIs
						
						If ($Recs=$TotBRI_L)
							//All BRIs
							[Status Report:69]DistrictMethod_L:267:=100+[Status Report:69]DistrictMethod_L:267
							
						Else 
							//some BRIs
							[Status Report:69]DistrictMethod_L:267:=500+[Status Report:69]DistrictMethod_L:267
							
						End if 
						
					Else 
						//some other non-NBI
						[Status Report:69]DistrictMethod_L:267:=200+[Status Report:69]DistrictMethod_L:267
					End if 
				Else 
					//multiple non-NBIs
					[Status Report:69]DistrictMethod_L:267:=200+[Status Report:69]DistrictMethod_L:267
				End if 
			End if 
			
		Else 
			//multiple NBI types and categories
			[Status Report:69]DistrictMethod_L:267:=300+[Status Report:69]DistrictMethod_L:267
	End case 
	
	
	C_TEXT:C284($ReportCmt_txt)
	$ReportCmt_txt:="Report from Bridge Archives generated by "+Current user:C182+Char:C90(13)
	$ReportCmt_txt:=$ReportCmt_txt+"For Monthly Archive dated "+String:C10($StatRepDate_d)+Char:C90(13)
	$ReportCmt_txt:=$ReportCmt_txt+"Using SD Calculation method  : "+Choose:C955($Poor_or_OldSD_b; "New (POOR=SD)"; "Old")+Char:C90(13)
	$ReportCmt_txt:=$ReportCmt_txt+"Using Legacy Owner : "+Choose:C955(STATREP_OWNERMETHOD_B; "True"; "False")+Char:C90(13)
	$ReportCmt_txt:=$ReportCmt_txt+"Using District Method : "+String:C10(STATREP_DistrictMethod_L)+" = "+Choose:C955(STATREP_DistrictMethod_L; " "; " "; "New 6 distr"; "5 Distr"; "6 Distr - Force Sommerville to D4")+Char:C90(13)
	$ReportCmt_txt:=$ReportCmt_txt+"Bridge Selection : "+String:C10([Status Report:69]DistrictMethod_L:267\100)+" = "+STATREP_BridgesSelected([Status Report:69]DistrictMethod_L:267\100)
	[Status Report:69]Comments:135:=$ReportCmt_txt
	
	DataToCondRep
	
	SAVE RECORD:C53([Status Report:69])
	UNLOAD RECORD:C212([Status Report:69])
Else 
	If ($Recs=0)
		ALERT:C41("No MONTHLYARCHIVE FHWARecords were found for date "+String:C10($StatRepDate_d)+"!!")
	End if 
End if 