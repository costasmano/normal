
//----------------------------------------------------
//User name (OS): administrator
//Date and time: 05/26/16, 10:52:46
//----------------------------------------------------
//Method: Object Method: CNV_RunningProcesses.Button
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2015_10  // 
	//Modified by: administrator (5/26/16 10:52:48)
	
End if 

C_LONGINT:C283($Column_l; $Row_l)
C_BOOLEAN:C305($Stop_B)
$Stop_B:=True:C214
LISTBOX GET CELL POSITION:C971(CNV_RunningProcess_aB; $Column_l; $Row_l)
If ($Row_l>0) & ($Row_l<=Size of array:C274(<>CNV_UpdatePictProcessIDs_aL))
	LISTBOX SELECT ROW:C912(CNV_RunningProcess_L; $Row_l)
	SET PROCESS VARIABLE:C370(<>CNV_UpdatePictProcessIDs_aL{$Row_l}; CNV_StopMe_B; $Stop_B)
	LISTBOX DELETE ROWS:C914(*; "CNV_RunningProcess_aB"; $Row_l)
	If (Size of array:C274(<>CNV_UpdatePictProcessIDs_aL)=0)
		CANCEL:C270
	End if 
End if 
//End Object Method: CNV_RunningProcesses.Button

