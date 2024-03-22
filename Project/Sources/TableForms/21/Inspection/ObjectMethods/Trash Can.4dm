//Object Method: Trash Can on [Dialogs];"Inspection"
//Purpose: delete elements from inspection configuration
//accept drags from hList2
//by: Albert Leung
//Date Created: 4/25/2001

C_POINTER:C301($vpSrcObj)
C_LONGINT:C283($vlSrcElem; $vlPID)

Case of 
	: (Form event code:C388=On Drag Over:K2:13)
		//_O_DRAG AND DROP PROPERTIES($vpSrcObj; $vlSrcElem; $vlPID)
		//If ($vpSrcObj=Get pointer("hList2"))
		////Accept objects only from hList1      
		//$0:=0
		//Else 
		//$0:=-1
		//End if 
	: (Form event code:C388=On Drop:K2:12)
		//Delete the selected item    
		DELETE FROM LIST:C624(hList2; *; *)
		REDRAW:C174(hList2)  // Command Replaced was o_REDRAW LIST 
End case 