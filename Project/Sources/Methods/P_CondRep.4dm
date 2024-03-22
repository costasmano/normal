//%attributes = {"invisible":true}
If (False:C215)
	//procedure P_CondRep
	//process shows condition report
	//
	//modified 4-dec-2000 : CM
	//    request a sort by date created from procedure gModSelection
	// Modified by: costasmanousakis-(Designer)-(10/26/2005 11:50:30)
	Mods_2005_CM18
	Mods_2022_05  //Added ability to use List box as output
	//Modified by: Chuck Miller (5/5/22 16:35:44)
End if 

C_TEXT:C284(MainTitle)  // Command Replaced was o_C_STRING length was 255//What is the main window title?
C_POINTER:C301(pFile)  //The file that is current
C_TEXT:C284(DefInLay)  // Command Replaced was o_C_STRING length was 255
C_TEXT:C284(DefOutLay)  // Command Replaced was o_C_STRING length was 255

G_InitCondRepVars

pFile:=->[Status Report:69]
DefInLay:="I_StatusReport"  //Default input layout

If (ut_UseListBox(Current method name:C684))
	DefOutLay:="Output_LB"
Else 
	
	DefOutLay:="O_StatusReport"  //Default output layout
End if 

MainTitle:="Condition Reports"
//GModSelection (->[Status Report];DefInLay;DefOutLay;MainTitle;620;450;1;4;1)
GModSelection(->[Status Report:69]; DefInLay; DefOutLay; MainTitle; 620; 450; 1; Plain window:K34:13; 3; ->[Status Report:69]Date_Created:1; "<")