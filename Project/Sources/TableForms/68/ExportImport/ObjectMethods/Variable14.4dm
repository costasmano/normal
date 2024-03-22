If (False:C215)
	//Script: bExport  [Dialogs];"ExportImport"
	//ACI University Programming Classes
	//Created By: Jim Steinman
	//Date:  10/5/95
	
	//Purpose:  Verifies if text is to be exported then checks for CR delimiters
	
	<>fGeneric:=False:C215
	<>f_Ver1x20:=False:C215
	<>fJ_Steinman:=False:C215
	
End if 


C_LONGINT:C283($LTextField; $i)

$LTextField:=0  // Let's find out if a text field is being exported.
For ($i; 1; Size of array:C274(apExpImp))
	If (Type:C295(apExpImp{$i}->)=2)  // Is this a text field?
		$LTextField:=$i
	End if 
End for 

Case of 
	: ((Substring:C12(sDlogText1; 1; 1)="E") & ($LTextField#0) & ((sFldDel="13") | (sRecDel="13")))
		ALERT:C41("You can not use a carriage return"+<>sCR+"(ASCII 13) as a field or record delimiter since you are dealing with a text file")
		asExpImpFld:=$LTextField
		sFldDel:="124"
		sRecDel:="126"
		ckCRLF:=0
		
	Else 
		ACCEPT:C269
End case 

If ((ck4DFormat=1) | (ckLayout=1))
	ckCRLF:=0
End if 
//End of script