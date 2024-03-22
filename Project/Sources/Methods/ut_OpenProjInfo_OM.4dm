//%attributes = {"invisible":true}
// Method: ut_OpenProjInfo_OM
// Description
// Object method for Open project info page button for a project or a contract
// Parameters
// $1 : $What_txt ("PROJECT" | "CONTRACT")
// $2 : $Number_txt
// $3 : $MyButton_ptr
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 06/01/10, 08:03:32
	// ----------------------------------------------------
	
	Mods_2010_05
	
	// Modified by: manousakisc-(Designer)-(5/10/2023 19:00:48)
	Mods_2023_05_bug
	//  `check if the projectinfo site is available on the network
	// Modified by: Costas Manousakis-(Designer)-(2023-06-21 15:26:09)
	Mods_2023_06_bug
	//  `adjusted logic to account for mac and use Storage so we don't have to check every time.
	// Modified by: manousakisc-(Designer)-(9/7/2023 13:00:39)
	Mods_2023_09
	//  `button is enabled for all is PINFO is available - not just windows and designer group
End if 
C_TEXT:C284($1; $2; $What_txt; $Number_txt)
$What_txt:=$1
$Number_txt:=$2
C_POINTER:C301($3; $MyButton_ptr)
$MyButton_ptr:=$3
Case of 
	: (Form event code:C388=On Load:K2:1)
		//see if we already have this from Storage
		Use (Storage:C1525)
			
			If (Storage:C1525.PinfoSiteAvail=Null:C1517)
				//not there, create it
				//check if in massdot network
				C_TEXT:C284($pinfoSite_txt)
				$pinfoSite_txt:=ut_GetSysParameter("URL_ProjectinfoSite"; "hwyapps.massdot.trans.internal")
				C_TEXT:C284($in; $out; $err)
				SET ENVIRONMENT VARIABLE:C812("_4D_OPTION_HIDE_CONSOLE"; "true")
				C_BOOLEAN:C305($showButton_b)
				If (Is Windows:C1573)
					LAUNCH EXTERNAL PROCESS:C811("ping -n 2 "+$pinfoSite_txt; $in; $out; $err)
					$showButton_b:=Not:C34((Position:C15("could not find host"; $out)>0))
				Else 
					//designer might run this from a Mac
					LAUNCH EXTERNAL PROCESS:C811("ping -c 2 "+$pinfoSite_txt; $in; $out; $err)
					$showButton_b:=Not:C34((Position:C15("Unknown host"; $err)>0))
				End if 
				Storage:C1525.PinfoSiteAvail:=New shared object:C1526("available"; $showButton_b)
				
			End if 
			
		End use 
		
		$showButton_b:=Storage:C1525.PinfoSiteAvail.available
		OBJECT SET VISIBLE:C603(*; OBJECT Get name:C1087(Object current:K67:2); $showButton_b)
		
		//If (Is Windows | User in group(<>CurrentUser_Name;"Design Access Group"))
		
		
		//Else 
		//OBJECT SET VISIBLE(*;OBJECT Get name(Object current);False)
		//End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		C_TEXT:C284($URL_txt)
		
		Case of 
			: (Num:C11($Number_txt)=0)
				//do nothing if number is zero
			: ($What_txt="PROJECT")
				If ($Number_txt#"")
					$URL_txt:=ut_GetSysParameter("URL_GotoProjFileNo")
					If ($URL_txt#"")
						$URL_txt:=Replace string:C233($URL_txt; "<vProjFileNo_txt>"; $Number_txt)
						OPEN URL:C673($URL_txt; *)
					Else 
						ALERT:C41("Connection to ProjectInfo for Projects not configured correctly!")
					End if 
					
				End if 
				
			: ($What_txt="CONTRACT")
				If ($Number_txt#"")
					$URL_txt:=ut_GetSysParameter("URL_GotoContrNo")
					If ($URL_txt#"")
						$URL_txt:=Replace string:C233($URL_txt; "<vContrNo_txt>"; $Number_txt)
						OPEN URL:C673($URL_txt; *)
					Else 
						ALERT:C41("Connection to ProjectInfo for Contracts not configured correctly!")
					End if 
					
				End if 
				
		End case 
		
End case 