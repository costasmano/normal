
//----------------------------------------------------
//User name (OS): Charles Miller
//Date and time: 02/12/13, 10:15:57
//----------------------------------------------------
//Method: Object Method: [ScourCriticalInfo].Input.SC_SubItemforI113_atxt
//Description
//
// Parameters
// ----------------------------------------------------
If (False:C215)
	Mods_2013_01  //r001 ` 
	//Modified by: Charles Miller (2/12/13 10:15:58)
	
End if 
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
		Compiler_ScourCriticalItems
		
		If (Size of array:C274(SC_SubItemforI113_atxt)=0)
			C_TEXT:C284(TOL_ListName_txt)
			
			C_TEXT:C284($SQLQuery_txt)
			TOL_ListName_txt:="SUB Item for 113"
			
			$SQLQuery_txt:="SELECT [TableOfLists].[ListValue_s], [TableOfLists].[ListSequence_l] FROM [TableOfLists] "+Char:C90(Carriage return:K15:38)
			$SQLQuery_txt:=$SQLQuery_txt+"WHERE [TableOfLists].[ListName_s] = :TOL_ListName_txt "+Char:C90(Carriage return:K15:38)
			$SQLQuery_txt:=$SQLQuery_txt+" ORDER BY 2 ASC "+Char:C90(Carriage return:K15:38)
			$SQLQuery_txt:=$SQLQuery_txt+"INTO :SC_SubItemforI113_atxt;"
			
			Begin SQL
				EXECUTE IMMEDIATE :$SQLQuery_txt;
			End SQL
			
			ARRAY TEXT:C222(SC_SubItemforI113Key_atxt; Size of array:C274(SC_SubItemforI113_atxt))
			C_LONGINT:C283($Loop_l)
			For ($Loop_l; 1; Size of array:C274(SC_SubItemforI113_atxt))
				SC_SubItemforI113Key_atxt{$Loop_l}:=Substring:C12(SC_SubItemforI113_atxt{$Loop_l}; 1; 1)
			End for 
			
		End if 
		
End case 
POPUPMENUC(->SC_SubItemforI113_atxt; ->SC_SubItemforI113Key_atxt; ->[ScourCriticalInfo:150]SubItem113_s:15)
//End Object Method: [ScourCriticalInfo].Input.SC_SubItemforI113_atxt

