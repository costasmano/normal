//%attributes = {"invisible":true}
//Method: InspectionTypeToForm
//Description
//This method called from blankstarter form method
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2019_05
End if 
C_TEXT:C284($0; $Form_txt)
Case of 
	: ([Inspections:27]Insp Type:6="RTN") | ([Inspections:27]Insp Type:6="RTA")
		$Form_txt:="Routine Combined"
	: ([Inspections:27]Insp Type:6="RRR") | ([Inspections:27]Insp Type:6="RRA")
		$Form_txt:="RailRoutineInput"
	: ([Inspections:27]Insp Type:6="FCR") | ([Inspections:27]Insp Type:6="CMI") | ([Inspections:27]Insp Type:6="OTH") | \
		([Inspections:27]Insp Type:6="RRS") | ([Inspections:27]Insp Type:6="RRF") | ([Inspections:27]Insp Type:6="RRO")
		$Form_txt:="Critical Member"
	: ([Inspections:27]Insp Type:6="CUL")
		$Form_txt:="Culvert Combined"
	: ([Inspections:27]Insp Type:6="CLD")
		$Form_txt:="Closed Bridge"
	: ([Inspections:27]Insp Type:6="DAM") | ([Inspections:27]Insp Type:6="RRD")
		$Form_txt:="Damage Form"  //`
	: ([Inspections:27]Insp Type:6="DVE")
		$Form_txt:="Dive Form"
	: ([Inspections:27]Insp Type:6="DVL")
		$Form_txt:="Dive LowCl"
	: ([Inspections:27]Insp Type:6="DVS")
		$Form_txt:="Underwater Special Member"
	: ([Inspections:27]Insp Type:6="PON")
		$Form_txt:="Pontis Form"
	: ([Inspections:27]Insp Type:6="FRZ")
		If ([Inspections:27]Insp Date:78<<>InspFormRevDate_7)
			$Form_txt:="FreezeThaw"
		Else 
			$Form_txt:="FreezeThawA"
		End if 
	: ([Inspections:27]Insp Type:6="DVF")
		$Form_txt:="StormDamageInspection"
	: ([Inspections:27]Insp Type:6="PED")
		$Form_txt:="PedestrianInspection-PED"
	: ([Inspections:27]Insp Type:6="RRC")
		$Form_txt:="RailCulvertCombined-RRC"
	: ([Inspections:27]Insp Type:6="TAL")
		$Form_txt:="TunnelInspection"
	: ([Inspections:27]Insp Type:6="TOV")
		$Form_txt:="TunnelOverheadInspection"
	: ([Inspections:27]Insp Type:6="TSP")
		$Form_txt:="TunnelSpecial"
	: ([Inspections:27]Insp Type:6="TDA")
		$Form_txt:="TunnelDamageForm"
	: ([Inspections:27]Insp Type:6="TOT")
		$Form_txt:="TunnelSpecial"
	Else 
		$Form_txt:="Not Configured"
End case 
$0:=$Form_txt
//End InspectionTypeToForm