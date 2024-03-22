//%attributes = {"invisible":true}
If (False:C215)
	//by: Susie Hwang
	//created: 4/21/2006
	//purpose: Creates Scour Report records
	//Mods_2006_SH01 
	//Mods_2006_SH02 
End if 

If (Current user:C182="designer")
	//Check for duplicate Report Date
	QUERY:C277([Scour Report:129]; [Scour Report:129]ReportDate:1=Current date:C33(*))
	If (Records in selection:C76([Scour Report:129])>0)
		//in case of duplicate record, alert the user
		C_TEXT:C284($msg)
		$msg:="There is an existing Bridge Scour Report with the same date ("+String:C10(Current date:C33(*))+")."
		$msg:=$msg+<>sCR+<>sCR+"Please delete the existing record before creating a new one. "
		ALERT:C41($msg)
	Else 
		C_LONGINT:C283($i; $Recs)
		ARRAY TEXT:C222($aBIN; 0)  //Command Replaced was o_ARRAY string length was 3
		ARRAY TEXT:C222($aOwner; 0)  //Command Replaced was o_ARRAY string length was 12
		ARRAY TEXT:C222($a113; 0)  //Scour Critical//Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($a62; 0)  //Culvert//Command Replaced was o_ARRAY string length was 1
		ARRAY TEXT:C222($aOnOff; 0)  //Item 26 - On/Off System//Command Replaced was o_ARRAY string length was 3
		ARRAY BOOLEAN:C223($a12; 0)  //Base highway network
		
		//_ScourCrit = 0 - 3
		//_Monitor = 0 - 4
		//_ScourSuscept = 6 & D
		//_LowRiskTotal = 45 - 789
		//_CounterM = 7
		C_LONGINT:C283($On_StateMun_ScourCrit; $On_StateMun_Monitor; $On_StateMun_ScourSuscept; $On_StateMun_LowRisk; $On_StateMun_U; $On_StateMun_T; $On_StateMun_CounterM)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($Off_StateMun_ScourCrit; $Off_StateMun_Monitor; $Off_StateMun_ScourSuscept; $Off_StateMun_LowRisk; $Off_StateMun_U; $Off_StateMun_T; $Off_StateMun_CounterM)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($On_Agency_ScourCrit; $On_Agency_Monitor; $On_Agency_ScourSuscept; $On_Agency_LowRisk; $On_Agency_U; $On_Agency_T; $On_Agency_CounterM)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($Off_Agency_ScourCrit; $Off_Agency_Monitor; $Off_Agency_ScourSuscept; $Off_Agency_LowRisk; $Off_Agency_U; $Off_Agency_T; $Off_Agency_CounterM)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($On_StateMun_LowRisk_Culvert; $On_Agency_LowRisk_Culvert; $Off_StateMun_LowRisk_Culvert; $Off_Agency_LowRisk_Culvert)  //Command Replaced was o_C_INTEGER
		
		QUERY:C277([Bridge MHD NBIS:1]; [Bridge MHD NBIS:1]FHWARecord:174=True:C214; *)
		QUERY:C277([Bridge MHD NBIS:1];  & ; [Bridge MHD NBIS:1]Item113:151#"N")
		//QUERY([Bridge MHD NBIS]; | ;[Bridge MHD NBIS]Item113#"")
		
		SELECTION TO ARRAY:C260([Bridge MHD NBIS:1]Item26:120; $aOnOff; [Bridge MHD NBIS:1]Item62:134; $a62; [Bridge MHD NBIS:1]Item8 Owner:208; $aOwner; [Bridge MHD NBIS:1]Item113:151; $a113; [Bridge MHD NBIS:1]Item12:196; $a12; [Bridge MHD NBIS:1]BIN:3; $aBIN)
		
		$Recs:=Records in selection:C76([Bridge MHD NBIS:1])
		
		For ($i; 1; $Recs)
			Case of 
				: (Position:C15($aOnOff{$i}; "-01-02-06-07-11-12-14-16-17-")>0)  // ON SYSTEM
					//````````State & Municipal
					If (($aOwner{$i}="MHD") | (fMUNBridge($aOwner{$i})=True:C214))
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3"))
							$On_StateMun_ScourCrit:=$On_StateMun_ScourCrit+1
						End if 
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3") | ($a113{$i}="4"))
							$On_StateMun_Monitor:=$On_StateMun_Monitor+1
						End if 
						If (($a113{$i}="6") | ($a113{$i}="D"))
							$On_StateMun_ScourSuscept:=$On_StateMun_ScourSuscept+1
						End if 
						If (($a113{$i}="4") | ($a113{$i}="5") | ($a113{$i}="7") | ($a113{$i}="8") | ($a113{$i}="9"))
							$On_StateMun_LowRisk:=$On_StateMun_LowRisk+1
							If ($a62{$i}#"N")
								$On_StateMun_LowRisk_Culvert:=$On_StateMun_LowRisk_Culvert+1
							End if 
						End if 
						Case of 
							: ($a113{$i}="U")
								$On_StateMun_U:=$On_StateMun_U+1
							: ($a113{$i}="T")
								$On_StateMun_T:=$On_StateMun_T+1
							: ($a113{$i}="7")
								$On_StateMun_CounterM:=$On_StateMun_CounterM+1
						End case 
					Else 
						//````````Agencies
						//If ((bMDCBridge ($aOwner{$i})=True) | (bMPABridge ($aOwner{$i})=True) | (bMTABridge ($aowner{$i})=True))
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3"))
							$On_Agency_ScourCrit:=$On_Agency_ScourCrit+1
						End if 
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3") | ($a113{$i}="4"))
							$On_Agency_Monitor:=$On_Agency_Monitor+1
						End if 
						If (($a113{$i}="6") | ($a113{$i}="D"))
							$On_Agency_ScourSuscept:=$On_Agency_ScourSuscept+1
						End if 
						If (($a113{$i}="4") | ($a113{$i}="5") | ($a113{$i}="7") | ($a113{$i}="8") | ($a113{$i}="9"))
							$On_Agency_LowRisk:=$On_Agency_LowRisk+1
							If ($a62{$i}#"N")
								$On_Agency_LowRisk_Culvert:=$On_Agency_LowRisk_Culvert+1
							End if 
						End if 
						Case of 
							: ($a113{$i}="U")
								$On_Agency_U:=$On_Agency_U+1
							: ($a113{$i}="T")
								$On_Agency_T:=$On_Agency_T+1
							: ($a113{$i}="7")
								$On_Agency_CounterM:=$On_Agency_CounterM+1
						End case 
						//End if 
					End if 
					
					
				: (Position:C15($aOnOff{$i}; "-08-09-19-")>0)  // OFF SYSTEM
					//````````State & Municipal
					If (($aOwner{$i}="MHD") | (fMUNBridge($aOwner{$i})=True:C214))
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3"))
							$Off_StateMun_ScourCrit:=$Off_StateMun_ScourCrit+1
						End if 
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3") | ($a113{$i}="4"))
							$Off_StateMun_Monitor:=$Off_StateMun_Monitor+1
						End if 
						If (($a113{$i}="6") | ($a113{$i}="D"))
							$Off_StateMun_ScourSuscept:=$Off_StateMun_ScourSuscept+1
						End if 
						If (($a113{$i}="4") | ($a113{$i}="5") | ($a113{$i}="7") | ($a113{$i}="8") | ($a113{$i}="9"))
							$Off_StateMun_LowRisk:=$Off_StateMun_LowRisk+1
							If ($a62{$i}#"N")
								$Off_StateMun_LowRisk_Culvert:=$Off_StateMun_LowRisk_Culvert+1
							End if 
						End if 
						Case of 
							: ($a113{$i}="U")
								$Off_StateMun_U:=$Off_StateMun_U+1
							: ($a113{$i}="T")
								$Off_StateMun_T:=$Off_StateMun_T+1
							: ($a113{$i}="7")
								$Off_StateMun_CounterM:=$Off_StateMun_CounterM+1
						End case 
					Else 
						//````````Agencies
						//If ((bDEMBridge ($aOwner{$i})=True) | (bMDCBridge ($aOwner{$i})=True) | ($aOwner{$i}="STA"))
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3"))
							$Off_Agency_ScourCrit:=$Off_Agency_ScourCrit+1
						End if 
						If (($a113{$i}="0") | ($a113{$i}="1") | ($a113{$i}="2") | ($a113{$i}="3") | ($a113{$i}="4"))
							$Off_Agency_Monitor:=$Off_Agency_Monitor+1
						End if 
						If (($a113{$i}="6") | ($a113{$i}="D"))
							$Off_Agency_ScourSuscept:=$Off_Agency_ScourSuscept+1
						End if 
						If (($a113{$i}="4") | ($a113{$i}="5") | ($a113{$i}="7") | ($a113{$i}="8") | ($a113{$i}="9"))
							$Off_Agency_LowRisk:=$Off_Agency_LowRisk+1
							If ($a62{$i}#"N")
								$Off_Agency_LowRisk_Culvert:=$Off_Agency_LowRisk_Culvert+1
							End if 
						End if 
						Case of 
							: ($a113{$i}="U")
								$Off_Agency_U:=$Off_Agency_U+1
							: ($a113{$i}="T")
								$Off_Agency_T:=$Off_Agency_T+1
							: ($a113{$i}="7")
								$Off_Agency_CounterM:=$Off_Agency_CounterM+1
						End case 
						//End if 
					End if 
					
				Else 
					ALERT:C41("BIN "+$aBIN{$i}+" has an invalid Item 26 code :<"+$aOnOff{$i}+"> !")
			End case 
		End for 
		
		//_ScourCrit = 0 - 3
		//_Monitor = 0 - 4
		//_ScourSuscept = 6 & D
		//_LowRiskTotal = 45 - 789
		//_CounterM = 7
		C_LONGINT:C283($Total_On_Mass; $Total_Off_Mass)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($Total_On_StateMun; $Total_Off_StateMun; $Total_On_Agency; $Total_Off_Agency)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($On_Mass_LowRisk; $Off_Mass_LowRisk; $On_Mass_ScourSuscept; $Off_Mass_ScourSuscept)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($On_Mass_U; $Off_Mass_U; $On_Mass_T; $Off_Mass_T; $On_Mass_ScourCrit; $Off_Mass_ScourCrit)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($On_Mass_Scour; $Off_Mass_Scour; $On_Mass_CounterM; $Off_Mass_CounterM)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($On_Mass_Monitor; $Off_Mass_Monitor)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($Total_On_Mass_LowRisk_NoCul; $Total_Off_Mass_LowRisk_NoCul)  //Command Replaced was o_C_INTEGER
		C_LONGINT:C283($On_StateMun_LowRisk_NoCul; $Off_StateMun_LowRisk_NoCul; $On_Agency_LowRisk_NoCul; $Off_Agency_LowRisk_NoCul)  //Command Replaced was o_C_INTEGER
		
		//`````````````````````````````````````````````````````````
		//Massachusetts Attachment
		//State & Mun Attachment
		//Agencies Attachment
		//`````````````````````````````````````````````````````````
		//Create a Scour Report record
		CREATE RECORD:C68([Scour Report:129])
		[Scour Report:129]ReportDate:1:=Current date:C33(*)
		[Scour Report:129]Time_Created:43:=Current time:C178
		[Scour Report:129]Owner:42:=Current user:C182
		
		//1. Over Waterways & 2. Evaluation Total
		$Total_On_StateMun:=$On_StateMun_ScourCrit+$On_StateMun_LowRisk+$On_StateMun_ScourSuscept+$On_StateMun_T+$On_StateMun_U
		$Total_Off_StateMun:=$Off_StateMun_ScourCrit+$Off_StateMun_LowRisk+$Off_StateMun_ScourSuscept+$Off_StateMun_T+$Off_StateMun_U
		$Total_On_Agency:=$On_Agency_ScourCrit+$On_Agency_LowRisk+$On_Agency_ScourSuscept+$On_Agency_T+$On_Agency_U
		$Total_Off_Agency:=$Off_Agency_ScourCrit+$Off_Agency_LowRisk+$Off_Agency_ScourSuscept+$Off_Agency_T+$Off_Agency_U
		$Total_On_Mass:=$Total_On_StateMun+$Total_On_Agency
		$Total_Off_Mass:=$Total_Off_StateMun+$Total_Off_Agency
		
		//A.  Low risk Total
		$On_Mass_LowRisk:=$On_StateMun_LowRisk+$On_Agency_LowRisk
		$Off_Mass_LowRisk:=$Off_StateMun_LowRisk+$Off_Agency_LowRisk
		[Scour Report:129]On_State_LowRiskTotal:2:=$On_StateMun_LowRisk
		[Scour Report:129]Off_State_LowRiskTotal:12:=$Off_StateMun_LowRisk
		[Scour Report:129]On_Agency_LowRiskTotal:22:=$On_Agency_LowRisk
		[Scour Report:129]Off_Agency_LowRiskTotal:32:=$Off_Agency_LowRisk
		
		//B. Scour Susceptible
		$On_Mass_ScourSuscept:=$On_StateMun_ScourSuscept+$On_Agency_ScourSuscept
		$Off_Mass_ScourSuscept:=$Off_StateMun_ScourSuscept+$Off_Agency_ScourSuscept
		[Scour Report:129]On_State_ScourSuscept:3:=$On_StateMun_ScourSuscept
		[Scour Report:129]Off_State_ScourSuscept:13:=$Off_StateMun_ScourSuscept
		[Scour Report:129]On_Agency_ScourSuscept:23:=$On_Agency_ScourSuscept
		[Scour Report:129]Off_Agency_ScourSuscept:33:=$Off_Agency_ScourSuscept
		
		//C.  Unknown Foundations
		$On_Mass_U:=$On_StateMun_U+$On_Agency_U
		$Off_Mass_U:=$Off_StateMun_U+$Off_Agency_U
		[Scour Report:129]On_State_Unknown:4:=$On_StateMun_U
		[Scour Report:129]Off_State_Unknown:14:=$Off_StateMun_U
		[Scour Report:129]On_Agency_Unknown:24:=$On_Agency_U
		[Scour Report:129]Off_Agency_Unknown:34:=$Off_Agency_U
		
		$On_Mass_T:=$On_StateMun_T+$On_Agency_T
		$Off_Mass_T:=$Off_StateMun_T+$Off_Agency_T
		[Scour Report:129]On_State_Tidal:5:=$On_StateMun_T
		[Scour Report:129]Off_State_Tidal:15:=$Off_StateMun_T
		[Scour Report:129]On_Agency_Tidal:25:=$On_Agency_T
		[Scour Report:129]Off_Agency_Tidal:35:=$Off_Agency_T
		
		//D.  Scour Critical
		$On_Mass_ScourCrit:=$On_StateMun_ScourCrit+$On_Agency_ScourCrit
		$Off_Mass_ScourCrit:=$Off_StateMun_ScourCrit+$Off_Agency_ScourCrit
		[Scour Report:129]On_State_ScourCrit:6:=$On_StateMun_ScourCrit
		[Scour Report:129]Off_State_ScourCrit:16:=$Off_StateMun_ScourCrit
		[Scour Report:129]On_Agency_ScourCrit:26:=$On_Agency_ScourCrit
		[Scour Report:129]Off_Agency_ScourCrit:36:=$Off_Agency_ScourCrit
		
		//3.  Analyzed for Scour ( = Total - Scour Susceptible )
		$On_Mass_Scour:=$Total_On_Mass-$On_Mass_ScourSuscept
		$Off_Mass_Scour:=$Total_Off_Mass-$Off_Mass_ScourSuscept
		//$On_StateMun_Scour:=$Total_On_StateMun-$On_StateMun_ScourSuscept
		//$Off_StateMun_Scour:=$Total_Off_StateMun-$Off_StateMun_ScourSuscept
		//$On_Agency_Scour:=$Total_On_Agency-$On_Agency_ScourSuscept
		//$Off_Agency_Scour:=$Total_Off_Agency-$Off_Agency_ScourSuscept
		
		//4.  Countermeasures Installed ( Ratings = 7)
		$On_Mass_CounterM:=$On_StateMun_CounterM+$On_Agency_CounterM
		$Off_Mass_CounterM:=$Off_StateMun_CounterM+$Off_Agency_CounterM
		[Scour Report:129]On_State_Counter:7:=$On_StateMun_CounterM
		[Scour Report:129]Off_State_Counter:17:=$Off_StateMun_CounterM
		[Scour Report:129]On_Agency_Counter:27:=$On_Agency_CounterM
		[Scour Report:129]Off_Agency_Counter:37:=$Off_Agency_CounterM
		
		//5. Monitoring Planned ( Ratings <= 4 )
		$On_Mass_Monitor:=$On_StateMun_Monitor+$On_Agency_Monitor
		$Off_Mass_Monitor:=$Off_StateMun_Monitor+$Off_Agency_Monitor
		[Scour Report:129]On_State_Monitor:8:=$On_StateMun_Monitor
		[Scour Report:129]Off_State_Monitor:18:=$Off_StateMun_Monitor
		[Scour Report:129]On_Agency_Monitor:28:=$On_Agency_Monitor
		[Scour Report:129]Off_Agency_Monitor:38:=$Off_Agency_Monitor
		
		//2A.  Low Risk Total
		//   (1) Calculated or Assessed 4,5,7,8,9(-Cul)
		
		$On_StateMun_LowRisk_NoCul:=$On_StateMun_LowRisk-$On_StateMun_LowRisk_Culvert
		$Off_StateMun_LowRisk_NoCul:=$Off_StateMun_LowRisk-$Off_StateMun_LowRisk_Culvert
		$On_Agency_LowRisk_NoCul:=$On_Agency_LowRisk-$On_Agency_LowRisk_Culvert
		$Off_Agency_LowRisk_NoCul:=$Off_Agency_LowRisk-$Off_Agency_LowRisk_Culvert
		//$On_Mass_LowRisk_NoCul:=$On_StateMun_LowRisk_NoCul+$On_Agency_LowRisk_NoCul
		//$Off_Mass_LowRisk_NoCul:=$Off_StateMun_LowRisk_NoCul+$Off_Agency_LowRisk_NoCul
		[Scour Report:129]On_State_LRT_Calc:9:=$On_StateMun_LowRisk_NoCul
		[Scour Report:129]Off_State_LRT_Calc:19:=$Off_StateMun_LowRisk_NoCul
		[Scour Report:129]On_Agency_LRT_Calc:29:=$On_Agency_LowRisk_NoCul
		[Scour Report:129]Off_Agency_LRT_Calc:39:=$Off_Agency_LowRisk_NoCul
		
		//   (2)  Screened  --->  These values are entered by hand in the Input Form.
		//[Scour Report]On_State_LRT_Screen
		//[Scour Report]Off_State_LRT_Screen
		//[Scour Report]On_Agency_LRT_Screen
		//[Scour Report]Off_Agency_LRT_Screen
		
		//   (3)  Culverts
		[Scour Report:129]On_State_LRT_Culv:11:=$On_StateMun_LowRisk_Culvert
		[Scour Report:129]Off_State_LRT_Culv:21:=$Off_StateMun_LowRisk_Culvert
		[Scour Report:129]On_Agency_LRT_Culv:31:=$On_Agency_LowRisk_Culvert
		[Scour Report:129]Off_Agency_LRT_Culv:41:=$Off_Agency_LowRisk_Culvert
		
		
		SAVE RECORD:C53([Scour Report:129])
		
		//````````````````````````````````````````````````````````````````````````````````
		//````````````````````````````````````````````````````````````````````````````````
		//````````````````````````````````````````````````````````````````````````````````
		//C_TEXT($text;$path;$file)
		//C_TIME(dScourRpt)
		//$path:=GetPath 
		//$file:=$path+"Scour Report.xls"
		//dScourRpt:=Create document($file)
		//SEND PACKET(dScourRpt;"<html xmlns:o="+Char(34)+"urn:schemas-microsoft-com:office:office"+Char(34)+"")
		//SEND PACKET(dScourRpt;"xmlns:x="+Char(34)+"urn:schemas-microsoft-com:office:excel"+Char(34)+"")
		//SEND PACKET(dScourRpt;"xmlns="+Char(34)+"http://www.w3.org/TR/REC-html40"+Char(34)+">")
		//CLOSE DOCUMENT(dScourRpt)
	End if 
End if 

