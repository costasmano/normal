//%attributes = {"invisible":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 08/22/07, 12:52:02
	// ----------------------------------------------------
	// Method: INSP_ConvertSKCH
	// Description
	// Convert a sketch or chart to thumbnali for printing to avoid pixelation if not done.
	// 
	// Parameters
	// $1 : $Portrait_b (Boolean)
	// ----------------------------------------------------
	
	Mods_2007_CM12_5301
	// Modified by: costasmanousakis-(Designer)-(9/15/08 12:20:34)
	Mods_2008_CM_5404  // ("IMAGESTORE")
	//  `change the logic to include windows printing of Mac originated images
	
	// Modified by: costasmanousakis-(Designer)-(10/3/08 11:50:03)
	Mods_2008_CM_5404
	//  `Temporarily don't do any translation on windows machines - it seems to crash the clients
	// Modified by: costasmanousakis-(Designer)-(3/10/09 10:33:50)
	Mods_2009_03
	//Added check for inspection type : no transform for dive inspections
	//  `Addresses issue of problems when printing sketches with hatches or dashed lines.
	// Modified by: Costas Manousakis-(Designer)-(2021-12-01T00:00:00 12:58:08)
	Mods_2021_11_bug
	//  `added check for max os version over 13 - do not transform for later versions - causes skewed images
End if 
C_BOOLEAN:C305($1; $Portrait_b)
$Portrait_b:=$1
C_BOOLEAN:C305($Transform_b)
$Transform_b:=False:C215
If (Folder separator:K24:12#":")
	If (([Inspections:27]Agency:156="Mass. Highway Dept.@") | ([Inspections:27]Agency:156="MHD Underwater Oper.@"))
		$Transform_b:=False:C215
	End if 
Else 
	If (([Inspections:27]Agency:156="Mass. Highway Dept.@") | ([Inspections:27]Agency:156="MHD Underwater Oper.@") | ([Inspections:27]Insp Type:6="DV@"))
	Else 
		$Transform_b:=True:C214
		
		C_OBJECT:C1216($sys_o)
		$sys_o:=Get system info:C1571
		C_TEXT:C284($macOS_)
		$macOS_:=$sys_o.osVersion
		$macOS_:=Replace string:C233($macOS_; "macos "; "")
		$macOS_:=Substring:C12($macOS_; 1; (Position:C15(" "; $macOS_)-1))
		
		If ($macOS_>"10.13.6")
			$Transform_b:=False:C215
		End if 
		
	End if 
End if 
//TRACE

If ($Transform_b)
	C_LONGINT:C283($PrintPicW_L; $PrintPicH_L; $PicW_L; $PicH_L; $Factor_L)
	C_REAL:C285($scale_r)
	$Factor_L:=5
	If ($Portrait_b)
		$PrintPicW_L:=530*$Factor_L
		$PrintPicH_L:=624*$Factor_L
	Else 
		$PrintPicW_L:=717*$Factor_L
		$PrintPicH_L:=447*$Factor_L
	End if 
	PICTURE PROPERTIES:C457(vPicture1; $PicW_L; $PicH_L)
	If (($PrintPicW_L/$PicW_L)<($PrintPicH_L/$PicH_L))
		$scale_r:=$PrintPicW_L/$PicW_L
	Else 
		$scale_r:=$PrintPicH_L/$PicH_L
	End if 
	//thiswasatest:=False
	//vPicture1:=vPicture1*$scale_r  `Comment this out
	$scale_r:=Round:C94($scale_r; 0)
	CREATE THUMBNAIL:C679(vPicture1; vPicture1; ($PicW_L*$scale_r); ($PicH_L*$scale_r); Scaled to fit:K6:2)  //ONLY ORIGINAL LINE
	//CONVERT PICTURE(vPicture1;"image/png")  `Comment this out
	//$type:=ut_ReturnPictureType (vPicture1)  `Comment this out
	
End if 