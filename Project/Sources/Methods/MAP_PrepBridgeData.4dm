//%attributes = {"invisible":true,"publishedWeb":true}
//Method: MAP_PrepBridgeData
//Description
// Prepare the bridge data arrays to be used in a kml export
// Parameters
// $0 : required parameter so that it is available for HTML tags
// $1 : required parameter so that it is available for HTML tags
// ----------------------------------------------------
If (False:C215)
	// ----------------------------------------------------
	//User name (OS): Costas Manousakis
	//User (4D) : Designer
	//Date and time: 11/27/16, 09:03:05
	// ----------------------------------------------------
	//Created : 
	Mods_2016_11
	C_TEXT:C284(MAP_PrepBridgeData; $0)
	C_TEXT:C284(MAP_PrepBridgeData; $1)
	
End if 
//
C_TEXT:C284($0)
C_TEXT:C284($1)

$0:=""

C_LONGINT:C283($loop_L)
C_POINTER:C301($Field_ptr)
For ($loop_L; 1; Size of array:C274(KML_Fields_aptr))
	$Field_ptr:=KML_Fields_aptr{$loop_L}
	Case of 
		: (Type:C295($Field_ptr->)=Is alpha field:K8:1) | (Type:C295($Field_ptr->)=Is text:K8:3)
			KML_Fields_Value_atxt{$loop_L}:=$Field_ptr->
			
		: (Type:C295($Field_ptr->)=Is real:K8:4) | (Type:C295($Field_ptr->)=Is integer:K8:5) | (Type:C295($Field_ptr->)=Is longint:K8:6) | (Type:C295($Field_ptr->)=Is integer 64 bits:K8:25)  //| (Type($Field_ptr->)=_o_Is float)
			KML_Fields_Value_atxt{$loop_L}:=String:C10($Field_ptr->)
		: (Type:C295($Field_ptr->)=Is date:K8:7)
			KML_Fields_Value_atxt{$loop_L}:=String:C10($Field_ptr->)
		: (Type:C295($Field_ptr->)=Is time:K8:8)
			KML_Fields_Value_atxt{$loop_L}:=String:C10($Field_ptr->)
		: (Type:C295($Field_ptr->)=Is boolean:K8:9)
			KML_Fields_Value_atxt{$loop_L}:=String:C10($Field_ptr->)
			
	End case 
	
End for 

KML_BridgeName_txt:=""
C_TEXT:C284($Prefix_txt; $Postfix_txt)
For ($loop_L; 1; Size of array:C274(KML_LabelFields_aptr))
	$Prefix_txt:=""
	$Postfix_txt:=""
	$Field_ptr:=KML_LabelFields_aptr{$loop_L}
	If ($Field_ptr=(->[Bridge MHD NBIS:1]BIN:3))
		$Prefix_txt:="("
		$Postfix_txt:=")"
	End if 
	If ($loop_L>1)
		$Prefix_txt:=" "+$Prefix_txt
	End if 
	Case of 
		: (Type:C295($Field_ptr->)=Is alpha field:K8:1) | (Type:C295($Field_ptr->)=Is text:K8:3)
			KML_BridgeName_txt:=KML_BridgeName_txt+$Prefix_txt+$Field_ptr->+$Postfix_txt
			
		: (Type:C295($Field_ptr->)=Is real:K8:4) | (Type:C295($Field_ptr->)=Is integer:K8:5) | (Type:C295($Field_ptr->)=Is longint:K8:6) | (Type:C295($Field_ptr->)=Is integer 64 bits:K8:25)  //| (Type($Field_ptr->)=_o_Is float)
			KML_BridgeName_txt:=KML_BridgeName_txt+$Prefix_txt+String:C10($Field_ptr->)+$Postfix_txt
		: (Type:C295($Field_ptr->)=Is date:K8:7)
			KML_BridgeName_txt:=KML_BridgeName_txt+$Prefix_txt+String:C10($Field_ptr->)+$Postfix_txt
		: (Type:C295($Field_ptr->)=Is time:K8:8)
			KML_BridgeName_txt:=KML_BridgeName_txt+$Prefix_txt+String:C10($Field_ptr->)+$Postfix_txt
		: (Type:C295($Field_ptr->)=Is boolean:K8:9)
			KML_BridgeName_txt:=KML_BridgeName_txt+$Prefix_txt+String:C10($Field_ptr->)+$Postfix_txt
			
	End case 
	
End for 

KML_BridgeLon_r:=-([Bridge MHD NBIS:1]Item17A:70+([Bridge MHD NBIS:1]Item17B:71/60)+([Bridge MHD NBIS:1]Item17C:136/3600))
KML_BridgeLat_r:=[Bridge MHD NBIS:1]Item16A:68+([Bridge MHD NBIS:1]Item16B:69/60)+([Bridge MHD NBIS:1]Item16C:109/3600)

//End MAP_PrepBridgeData