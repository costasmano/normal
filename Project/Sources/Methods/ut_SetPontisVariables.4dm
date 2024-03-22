//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// ut_SetPontisVariables
	// User name (OS): cjmiller
	// Date and time: 12/13/05, 11:04:04
	// ----------------------------------------------------
	// Description
	// This method will set up variables used to update pontis sql data
	//
	// Parameters
	// ----------------------------------------------------
	Mods_2005_CJM04
End if 
insp_InspectionID_l:=[Cond Units:45]Inspection ID:2
insp_ElementID_l:=[Cond Units:45]Element ID:3
insp_Environment_l:=[Cond Units:45]Environment:4

insp_TotalQty_r:=[Cond Units:45]Total Quantity:5
insp_CondState1_r:=0
insp_CondState2_r:=0
insp_CondState3_r:=0
insp_CondState4_r:=0
insp_CondState5_r:=0
If ([Cond Units:45]CondState1:10>0)
	insp_CondState1_r:=[Cond Units:45]CondState1:10
End if 
If ([Cond Units:45]CondState2:11>0)
	insp_CondState2_r:=[Cond Units:45]CondState2:11
End if 
If ([Cond Units:45]CondState3:12>0)
	insp_CondState3_r:=[Cond Units:45]CondState3:12
End if 
If ([Cond Units:45]CondState4:13>0)
	insp_CondState4_r:=[Cond Units:45]CondState4:13
End if 
If ([Cond Units:45]CondState5:14>0)
	insp_CondState5_r:=[Cond Units:45]CondState5:14
End if 

insp_CondUnitComments_txt:=[Cond Units:45]Comment:7
//End ut_SetPontisVariables