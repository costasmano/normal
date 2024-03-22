//%attributes = {"invisible":true}
If (False:C215)
	//attempt to create a record.
	Mods_2005_CM05
	Mods_2005_CM07
	
End if 

C_BOOLEAN:C305($0)
If (False:C215)
	gError:=0
	ON ERR CALL:C155("Error Handler")
	CREATE RECORD:C68([Months:26])
	SAVE RECORD:C53([Months:26])
	ON ERR CALL:C155("")
	If (gError=0)
		DELETE RECORD:C58([Months:26])
		$0:=False:C215
	Else 
		$0:=True:C214
	End if 
	UNLOAD RECORD:C212([Months:26])
Else 
	$0:=Is data file locked:C716
End if 