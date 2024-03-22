//Method: ElementDeficiencyQuery.Button1
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Chuck Miller
	//User (4D) : Designer
	//Date and time: 01/10/19, 13:03:59
	// ----------------------------------------------------
	//Created : 
	Mods_2019_01
End if 
//
If (Records in set:C195("FinalElementSet")=0)
	ALERT:C41("There are no records to be reported on.")
Else 
	USE SET:C118("FinalElementSet")
	C_BLOB:C604($REPBlob_blb)
	C_LONGINT:C283($offset_L)
	
	
	VARIABLE TO BLOB:C532(v_162_002_atxt; $REPBlob_blb; *)
	VARIABLE TO BLOB:C532(v_162_001_aL; $REPBlob_blb; *)
	VARIABLE TO BLOB:C532(v_162_001_aL; $REPBlob_blb; *)
	M_CreateLSSElementReport
	BLOB TO VARIABLE:C533($REPBlob_blb; v_162_002_atxt; $offset_L)
	BLOB TO VARIABLE:C533($REPBlob_blb; v_162_001_aL; $offset_L)
	BLOB TO VARIABLE:C533($REPBlob_blb; v_162_001_aL; $offset_L)
End if 
//End ElementDeficiencyQuery.Button1