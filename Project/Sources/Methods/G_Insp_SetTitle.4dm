//%attributes = {"invisible":true}
If (False:C215)
	// Modified by: costasmanousakis-(Designer)-(12/5/2005 11:34:29)
	Mods_2005_CM19
	// Modified by: costasmanousakis-(Designer)-(2/13/09 11:26:45)
	Mods_2009_CM_5404
	//Fixed the part of adding Spec mem in title. Happens only for
	//Routine  inspections (RT@, CUL)
	// Modified by: Costas Manousakis-(Designer)-(1/2/13 14:39:01)
	Mods_2013_01
	//  `Added the Rail Inspection types
	Mods_2013_04  //r001 ` Add tunnel inspection types TOV. TAL
	//Modified by: Charles Miller (4/30/13 14:19:18)
	// Modified by: Costas Manousakis-(Designer)-(10/24/13 11:19:39)
	Mods_2013_10
	//  `use  method  INSP_IsInspRoutine_b to check if inspection is a routine one
	// Modified by: Costas Manousakis-(Designer)-(4/25/14 15:16:19)
	Mods_2014_04
	//  `For MBTA  fracture critical - add the bridge type 
	// Modified by: Costas Manousakis-(Designer)-(8/11/14 11:27:30)
	Mods_2014_08
	//  `Added inspection type TOV to the INSP_IsInspRoutine_b check
	// Modified by: Costas Manousakis-(Designer)-(2022-09-30 10:15:54)
	Mods_2022_09_bug
	//  `always search in table [Inspection Type] for the description.
End if 

C_TEXT:C284($0; $vsInspTitle)  // Command Replaced was o_C_STRING length was 255
C_LONGINT:C283($vlNumSpecMems)
$vlNumSpecMems:=G_Insp_CountSpMs
C_TEXT:C284($Insptype)
$Insptype:=[Inspections:27]Insp Type:6

Begin SQL
	select [Inspection Type].Description
	from [Inspection Type]
	where [Inspection Type].Code = :$Insptype
	into :$vsInspTitle ;
End SQL
//$vsInspTitle:=[Inspection Type]Description
If ([Inspections:27]InitialInsp:9)
	$vsInspTitle:="Initial "+$vsInspTitle
End if 
If (($vlNumSpecMems>0) & (INSP_IsInspRoutine_b | ([Inspections:27]Insp Type:6="TOV")))
	$vsInspTitle:=$vsInspTitle+" & Special Member"
End if 
$vsInspTitle:=$vsInspTitle+" Inspection"

Case of 
		
	: ([Bridge MHD NBIS:1]InspResp:173="MBTA")
		
		Case of 
			: (([Inspections:27]Insp Type:6="RRF") | ([Inspections:27]Insp Type:6="FCR"))
				$vsInspTitle:=$vsInspTitle+" - "+mbta_ReturnBridgeType
				
		End case 
		
End case 

$0:=$vsInspTitle