//%attributes = {"invisible":true}
// Method: ARCHIVE_GenCondReport
// Description
//  ` Copy of GenerateCondRep for the Archive table [BridgeMHDNBISArchive]
// 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 07/01/11, 13:38:41
	// ----------------------------------------------------
	
	Mods_2011_06
	// Modified by: Costas Manousakis-(Designer)-(10/25/17 12:12:14)
	Mods_2017_10
	//  `use new ProgressNew and UpdateProgressNew
End if 
If (True:C214)
	ALERT:C41("This method "+Current method name:C684+" Not used anymore!!")
Else 
	C_BOOLEAN:C305($1; $vbCustomSel)
	C_LONGINT:C283($2; $viOnScreen)
	
	$vbCustomSel:=$1
	If (Count parameters:C259>=2)
		$viOnScreen:=$2
	Else 
		$viOnScreen:=1  //1= on screen msgs only
	End if 
	C_BOOLEAN:C305($vbOnScreen; $vbToFile)
	$vbOnScreen:=(($viOnScreen=1) | ($viOnScreen=3))
	$vbToFile:=(($viOnScreen=2) | ($viOnScreen=3))
	
	CREATE RECORD:C68([Status Report:69])
	
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
	
	C_TEXT:C284($vs_Item7_2)  // Command Replaced was o_C_STRING length was 2//1st two chars of item 7
	
	For ($i; 1; 4)
		$r_a58{$i}:=0
		$r_a59{$i}:=0
		$r_a60{$i}:=0
		$i_a58{$i}:=0
		$i_a59{$i}:=0
		$i_a60{$i}:=0
	End for 
	
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
	
	If ($vbOnScreen)
		SHORT_MESSAGE("Loading Data...")
	End if 
	
	If (Not:C34($vbCustomSel))
		QUERY:C277([BridgeMHDNBISArchive:139]; [BridgeMHDNBISArchive:139]FHWARecord:173=True:C214)
	End if 
	
	$Recs:=Records in selection:C76([BridgeMHDNBISArchive:139])
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
	ARRAY TEXT:C222($a7; $Recs)  //Command Replaced was o_ARRAY string length was 18
	
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item8 Owner:205; $aowner; [BridgeMHDNBISArchive:139]Item5:58; $a5; [BridgeMHDNBISArchive:139]Item49:92; $a49; [BridgeMHDNBISArchive:139]Item112:117; $a112)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item42:84; $a42; [BridgeMHDNBISArchive:139]Item27:82; $a27; [BridgeMHDNBISArchive:139]Item106:83; $a106; [BridgeMHDNBISArchive:139]AASHTO:5; $aashto)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item43:74; $a43; [BridgeMHDNBISArchive:139]Item58:129; $a58; [BridgeMHDNBISArchive:139]Item59:130; $a59; [BridgeMHDNBISArchive:139]Item60:131; $a60)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item62:133; $a62; [BridgeMHDNBISArchive:139]Item67:141; $a67; [BridgeMHDNBISArchive:139]Item71:144; $a71; [BridgeMHDNBISArchive:139]Item68:142; $a68)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item69:143; $a69; [BridgeMHDNBISArchive:139]Item72:145; $a72; [BridgeMHDNBISArchive:139]Item2:59; $a2; [BridgeMHDNBISArchive:139]Item41:140; $a41; [BridgeMHDNBISArchive:139]Item103:123; $a103)
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]HI_Current_Elmt_Cost:218; $aBridgeCEV; [BridgeMHDNBISArchive:139]HI_Total_Elmt_Cost:217; $aBridgeTEV; [BridgeMHDNBISArchive:139]LegacyOwner:225; $aLegOwner)
	
	SELECTION TO ARRAY:C260([BridgeMHDNBISArchive:139]Item7:64; $a7; [BridgeMHDNBISArchive:139]BDEPT:1; $aBDEPT)
	
	If ($vbOnScreen)
		CLOSE WINDOW:C154
	End if 
	C_LONGINT:C283(STATREP_DistrictMethod_L)
	C_OBJECT:C1216($progressObj_o)
	
	If ($vbOnScreen)
		$progressObj_o:=ProgressNew("Condition Data"; $Recs; False:C215; ""; 3)
		
		//<>ProgressPID:=StartProgress ("GenCondRep";"None";"")
		$Interval:=MaxNum(MinNum(Int:C8($Recs/40); 20); 2)  // get an update interval between 2 and 20
		//UpdateProgress (1;$Recs)
		
	End if 
	$agency:=False:C215
	C_BOOLEAN:C305($StateBridge_b)
	C_TEXT:C284($owner_txt)
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
					If ((bFuncObsCheck($a5{$i}; $a49{$i}; $a112{$i}; $a42{$i}; $a27{$i}; $a106{$i})=True:C214) & ($aashto{$i}<$vrAASHTOLimit))
						If (bDeficient($a42{$i}; $a43{$i}; $a58{$i}; $a59{$i}; $a60{$i}; $a62{$i}; $a67{$i}; $a71{$i})=True:C214)
							astate{$n}{2}:=astate{$n}{2}+1
						Else 
							If (bObsolete($a42{$i}; $a67{$i}; $a68{$i}; $a69{$i}; $a71{$i}; $a72{$i})=True:C214)
								astate{$n}{4}:=astate{$n}{4}+1
							End if 
						End if 
					End if 
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
					If ((bFuncObsCheck($a5{$i}; $a49{$i}; $a112{$i}; $a42{$i}; $a27{$i}; $a106{$i})=True:C214) & ($aashto{$i}<$vrAASHTOLimit))
						If (bDeficient($a42{$i}; $a43{$i}; $a58{$i}; $a59{$i}; $a60{$i}; $a62{$i}; $a67{$i}; $a71{$i})=True:C214)
							atown{$n}{2}:=atown{$n}{2}+1
						Else 
							If (bObsolete($a42{$i}; $a67{$i}; $a68{$i}; $a69{$i}; $a71{$i}; $a72{$i})=True:C214)
								atown{$n}{4}:=atown{$n}{4}+1
							End if 
						End if 
					End if 
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
			: (bMDCBridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aMDC
				$MDC_CEV:=$MDC_CEV+$aBridgeCEV{$i}
				$MDC_TEV:=$MDC_TEV+$aBridgeTEV{$i}
			: (bMTABridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aMTA
				$MTA_CEV:=$MTA_CEV+$aBridgeCEV{$i}
				$MTA_TEV:=$MTA_TEV+$aBridgeTEV{$i}
			: (bMPABridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aMPA
				$MPA_CEV:=$MPA_CEV+$aBridgeCEV{$i}
				$MPA_TEV:=$MPA_TEV+$aBridgeTEV{$i}
			: (bDEMBridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aDEM
				$DEM_CEV:=$DEM_CEV+$aBridgeCEV{$i}
				$DEM_TEV:=$DEM_TEV+$aBridgeTEV{$i}
			: (bDNRBridge($owner_txt)=True:C214)
				$agency:=True:C214
				$aCond:=->aDNR
				$OTHER_CEV:=$OTHER_CEV+$aBridgeCEV{$i}
				$OTHER_TEV:=$OTHER_TEV+$aBridgeTEV{$i}
				//23-mar-01 : added check for bridges that do not fall in any
				//     category above
			Else 
				$agency:=True:C214
				$aCond:=->aDNR
				$OTHER_CEV:=$OTHER_CEV+$aBridgeCEV{$i}
				$OTHER_TEV:=$OTHER_TEV+$aBridgeTEV{$i}
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
			If ((bFuncObsCheck($a5{$i}; $a49{$i}; $a112{$i}; $a42{$i}; $a27{$i}; $a106{$i})=True:C214) & ($aashto{$i}<$vrAASHTOLimit))
				If (bDeficient($a42{$i}; $a43{$i}; $a58{$i}; $a59{$i}; $a60{$i}; $a62{$i}; $a67{$i}; $a71{$i})=True:C214)
					$aCond->{2}:=$aCond->{2}+1
				Else 
					If (bObsolete($a42{$i}; $a67{$i}; $a68{$i}; $a69{$i}; $a71{$i}; $a72{$i})=True:C214)
						$aCond->{4}:=$aCond->{4}+1
					End if 
				End if 
			End if 
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
				//    GOTO XY(1;2)  ` 2-10-2000 : CM 
				//    MESSAGE(String($i;"00000"))
				//UpdateProgress ($i;$Recs)
				//update progress
				UpdateProgressNew($progressObj_o; $i)
				
			End if 
		End if 
	End for 
	//CLOSE WINDOW
	If ($vbOnScreen)
		//quit progress
		Progress QUIT(OB Get:C1224($progressObj_o; "progress"; Is longint:K8:6))
		//CALL PROCESS(<>ProgressPID)
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
	
	If (False:C215)
		[Status Report:69]S_D1_HI:136:=HI_CalcHI_Function($a_State_CEV{1}; $a_State_TEV{1})
		[Status Report:69]S_D2_HI:137:=HI_CalcHI_Function($a_State_CEV{2}; $a_State_TEV{2})
		[Status Report:69]S_D3_HI:138:=HI_CalcHI_Function($a_State_CEV{3}; $a_State_TEV{3})
		[Status Report:69]S_D4_HI:139:=HI_CalcHI_Function($a_State_CEV{4}; $a_State_TEV{4})
		[Status Report:69]S_D5_HI:140:=HI_CalcHI_Function($a_State_CEV{5}; $a_State_TEV{5})
		//[Status Report]S_D6_HI:=HI_CalcHI_Function ($a_State_CEV{6};$a_State_TEV{6})
		
		[Status Report:69]T_D1_HI:142:=HI_CalcHI_Function($a_Town_CEV{1}; $a_Town_TEV{1})
		[Status Report:69]T_D2_HI:143:=HI_CalcHI_Function($a_Town_CEV{2}; $a_Town_TEV{2})
		[Status Report:69]T_D3_HI:144:=HI_CalcHI_Function($a_Town_CEV{3}; $a_Town_TEV{3})
		[Status Report:69]T_D4_HI:145:=HI_CalcHI_Function($a_Town_CEV{4}; $a_Town_TEV{4})
		[Status Report:69]T_D5_HI:146:=HI_CalcHI_Function($a_Town_CEV{5}; $a_Town_TEV{5})
		//[Status Report]T_D6_HI:=HI_CalcHI_Function ($a_Town_CEV{6};$a_Town_TEV{6})
		
		[Status Report:69]S_T_D1_HI:148:=HI_CalcHI_Function($a_S_T_CEV{1}; $a_S_T_TEV{1})
		[Status Report:69]S_T_D2_HI:149:=HI_CalcHI_Function($a_S_T_CEV{2}; $a_S_T_TEV{2})
		[Status Report:69]S_T_D3_HI:150:=HI_CalcHI_Function($a_S_T_CEV{3}; $a_S_T_TEV{3})
		[Status Report:69]S_T_D4_HI:151:=HI_CalcHI_Function($a_S_T_CEV{4}; $a_S_T_TEV{4})
		[Status Report:69]S_T_D5_HI:152:=HI_CalcHI_Function($a_S_T_CEV{5}; $a_S_T_TEV{5})
		//[Status Report]S_T_D6_HI:=HI_CalcHI_Function ($a_S_T_CEV{6};$a_S_T_TEV{6})
		
		[Status Report:69]INT_D1_HI:161:=HI_CalcHI_Function($a_INTR_CEV{1}; $a_INTR_TEV{1})
		[Status Report:69]INT_D2_HI:162:=HI_CalcHI_Function($a_INTR_CEV{2}; $a_INTR_TEV{2})
		[Status Report:69]INT_D3_HI:163:=HI_CalcHI_Function($a_INTR_CEV{3}; $a_INTR_TEV{3})
		[Status Report:69]INT_D4_HI:164:=HI_CalcHI_Function($a_INTR_CEV{4}; $a_INTR_TEV{4})
		[Status Report:69]INT_D5_HI:165:=HI_CalcHI_Function($a_INTR_CEV{5}; $a_INTR_TEV{5})
		//[Status Report]INT_D6_HI:=HI_CalcHI_Function ($a_INTR_CEV{6};$a_INTR_TEV{6})
		
		[Status Report:69]SU_D1_HI:167:=HI_CalcHI_Function($a_SU_CEV{1}; $a_SU_TEV{1})
		[Status Report:69]SU_D2_HI:168:=HI_CalcHI_Function($a_SU_CEV{2}; $a_SU_TEV{2})
		[Status Report:69]SU_D3_HI:169:=HI_CalcHI_Function($a_SU_CEV{3}; $a_SU_TEV{3})
		[Status Report:69]SU_D4_HI:170:=HI_CalcHI_Function($a_SU_CEV{4}; $a_SU_TEV{4})
		[Status Report:69]SU_D5_HI:171:=HI_CalcHI_Function($a_SU_CEV{5}; $a_SU_TEV{5})
		//[Status Report]SU_D6_HI:=HI_CalcHI_Function ($a_SU_CEV{6};$a_SU_TEV{6})
		
		[Status Report:69]Loc_D1_HI:173:=HI_CalcHI_Function($a_Local_CEV{1}; $a_Local_TEV{1})
		[Status Report:69]Loc_D2_HI:174:=HI_CalcHI_Function($a_Local_CEV{2}; $a_Local_TEV{2})
		[Status Report:69]Loc_D3_HI:175:=HI_CalcHI_Function($a_Local_CEV{3}; $a_Local_TEV{3})
		[Status Report:69]Loc_D4_HI:176:=HI_CalcHI_Function($a_Local_CEV{4}; $a_Local_TEV{4})
		[Status Report:69]Loc_D5_HI:177:=HI_CalcHI_Function($a_Local_CEV{5}; $a_Local_TEV{5})
		//[Status Report]Loc_D6_HI:=HI_CalcHI_Function ($a_Local_CEV{6};$a_Local_TEV{6})
		
	End if 
	
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
	
	
	[Status Report:69]Date_Created:1:=Current date:C33(*)
	[Status Report:69]Owner:2:=Current user:C182
	[Status Report:69]Time_Created:134:=Current time:C178(*)
	
	DataToCondRep
	
	SAVE RECORD:C53([Status Report:69])
End if 
