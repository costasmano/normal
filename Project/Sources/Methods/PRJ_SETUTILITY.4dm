//%attributes = {"invisible":true}
//Method: PRJ_SETUTILITY
//Description
//  `Perform set operations for Projectdetail records based on record ID
// Parameters
// $1 : $Task_txt
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 12/23/13, 09:13:17
	// ----------------------------------------------------
	//Created : 
	Mods_2013_12
	
End if 
//
C_TEXT:C284($1; $Task_txt)
$Task_txt:=$1

Case of 
	: ($Task_txt="SAVE")
		SETUTIL_Control("SAVE"; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1)
	: ($Task_txt="LOAD") | ($Task_txt="ADD") | ($Task_txt="SUBTRACT") | ($Task_txt="INTERSECT")
		If (SETUTIL_Control($Task_txt; ->[PRJ_ProjectDetails:115]PRJ_ProjectID_l:1))
			If (Size of array:C274(v_115_002_aL)>0)
				Case of 
					: (Size of array:C274(PRJ_StructProjMgr_atxt)>0)
						PRJ_DetailLBSetUpDisplayEvent
					Else 
						PRJ_SetupListBoxDisplayEvent
				End case 
			Else 
				ut_SetSortColumns(7; 0)
				ut_PRJSortByBridge
				ut_SetSortColumns(7; 1)
				
			End if 
			ut_PRJSetWindowTitle("Project Lists"; ->[PRJ_ProjectDetails:115])
		End if 
End case 

//End PRJ_SETUTILITY