//Method: "SpellAllTest"
//Description
// Form method 
// Parameters
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): manousakisc
	//User (4D) : Designer
	//Date and time: 02/23/22, 03:00:10
	// ----------------------------------------------------
	//Created : 
End if 
//
C_POINTER:C301($Wpfield_ptr; $todoaction_ptr; $wp_ptr)
$Wpfield_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "wpfield")
$todoaction_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "todoaction")
$wp_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "WPArea")
C_OBJECT:C1216(SpellCheckAllData_o)
C_POINTER:C301($Field_ptr)
C_TEXT:C284($WpLabel_txt)
C_LONGINT:C283($stack_L)
$Field_ptr:=SpellCheckAllData_o.fieldptr
$WpLabel_txt:=SpellCheckAllData_o.label
$stack_L:=SpellCheckAllData_o.stack

C_BLOB:C604($wpblob)
Case of 
	: (Form event code:C388=On Load:K2:1)
		$Wpfield_ptr->:=""
		$todoaction_ptr->:=""
		
		If (False:C215)
			QUERY:C277([Inspections:27]; [Inspections:27]InspID:2=103589)
			If (Records in selection:C76([Inspections:27])>0)
				FIRST RECORD:C50([Inspections:27])
				
				QUERY:C277([ElementsSafety:29]; [ElementsSafety:29]InspID:4=[Inspections:27]InspID:2; *)
				QUERY:C277([ElementsSafety:29];  & ; [ElementsSafety:29]Comment Flag:6=True:C214)
				
			End if 
			
		End if 
		
		SET TIMER:C645(1)
		
	: (Form event code:C388=On Timer:K2:25)
		SET TIMER:C645(0)  // turn off timer
		
		C_TEXT:C284($piece)
		$piece:=$Wpfield_ptr->
		C_BOOLEAN:C305($done; $modified)
		$done:=False:C215
		OBJECT SET TITLE:C194(*; "Wparealabel"; $WpLabel_txt)
		$wpblob:=INSP_GetWPDocFromBlob($Field_ptr->)
		$wp_ptr->:=WP New:C1317($wpblob)
		OB SET:C1220($wp_ptr->; "modified"; False:C215)
		
	: (Form event code:C388=On Validate:K2:3)
		
End case 

//End SpellAllTest