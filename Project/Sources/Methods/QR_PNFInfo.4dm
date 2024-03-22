//%attributes = {"shared":true}
If (False:C215)
	// ----------------------------------------------------
	// User name (OS): costasmanousakis
	// User name (4D): Designer
	// Date and time: 11/04/08, 11:05:01
	// ----------------------------------------------------
	// Method: QR_PNFInfo
	// Description
	// Return info needed for PNF Forms for bridge information
	// 
	// Parameters
	// $0 : $BRInfo_txt
	// ----------------------------------------------------
	
	Mods_2008_CM_5404
End if 
C_TEXT:C284($0; $BRInfo_txt)
$BRInfo_txt:=""
If ([Bridge MHD NBIS:1]BDEPT:1#"")
	$BRInfo_txt:="Bridge "+[Bridge MHD NBIS:1]BDEPT:1+" ("+[Bridge MHD NBIS:1]BIN:3+") :"
	$BRInfo_txt:=$BRInfo_txt+"Year Built="+String:C10([Bridge MHD NBIS:1]Item27:83)
	If ([Bridge MHD NBIS:1]Item106:84>0)
		$BRInfo_txt:=$BRInfo_txt+", Year Reconstructed="+String:C10([Bridge MHD NBIS:1]Item106:84)
	End if 
	If ([Bridge MHD NBIS:1]Item43:75#"000")
		$BRInfo_txt:=$BRInfo_txt+"; Struct.Type="+QR_Item43A+"-"+QR_Item43B
	End if 
	If ([Bridge MHD NBIS:1]Item107:79#"N")
		$BRInfo_txt:=$BRInfo_txt+"; Deck Type="+QR_Item107
	End if 
	If ([Bridge MHD NBIS:1]Item90:161>!00-00-00!)
		$BRInfo_txt:=$BRInfo_txt+"; Last Routine Insp="+String:C10([Bridge MHD NBIS:1]Item90:161)
	End if 
	C_BOOLEAN:C305($Condenterd_b)
	$BRInfo_txt:=$BRInfo_txt+"; Element Condition :"
	$Condenterd_b:=False:C215
	If ([Bridge MHD NBIS:1]Item59:131#"N")
		$Condenterd_b:=True:C214
		$BRInfo_txt:=$BRInfo_txt+" SuperStr="+[Bridge MHD NBIS:1]Item59:131
	End if 
	If ([Bridge MHD NBIS:1]Item58:130#"N")
		If ($Condenterd_b)
			$BRInfo_txt:=$BRInfo_txt+","
		End if 
		$BRInfo_txt:=$BRInfo_txt+" Deck="+[Bridge MHD NBIS:1]Item58:130
		$Condenterd_b:=True:C214
	End if 
	If ([Bridge MHD NBIS:1]Item60:132#"N")
		If ($Condenterd_b)
			$BRInfo_txt:=$BRInfo_txt+","
		End if 
		$BRInfo_txt:=$BRInfo_txt+" SubStr="+[Bridge MHD NBIS:1]Item60:132
		$Condenterd_b:=True:C214
	End if 
	If ([Bridge MHD NBIS:1]Item62:134#"N")
		If ($Condenterd_b)
			$BRInfo_txt:=$BRInfo_txt+","
		End if 
		$BRInfo_txt:=$BRInfo_txt+" Culvert="+[Bridge MHD NBIS:1]Item62:134
	End if 
	C_BOOLEAN:C305($Postenterd_B)
	$Postenterd_B:=False:C215
	Case of 
		: ([Bridge MHD NBIS:1]PostingStatus:8="Closed")
			$BRInfo_txt:=$BRInfo_txt+"; Bridge is Closed"
			$Postenterd_B:=True:C214
		: ([Bridge MHD NBIS:1]PostingStatus:8="LEGAL")
			$BRInfo_txt:=$BRInfo_txt+"; Bridge is Posted for Legal Loads"
			$Postenterd_B:=True:C214
		: ([Bridge MHD NBIS:1]PostingStatus:8="POSTED")
			If ([Bridge MHD NBIS:1]Posting2Axle:9=[Bridge MHD NBIS:1]Posting3Axle:10)
				$BRInfo_txt:=$BRInfo_txt+"; Posted for "+String:C10([Bridge MHD NBIS:1]Posting2Axle:9; "###T")
			Else 
				$BRInfo_txt:=$BRInfo_txt+"; Posted for 2Axle="+String:C10([Bridge MHD NBIS:1]Posting2Axle:9; "###T")
				$BRInfo_txt:=$BRInfo_txt+", 3Axle="+String:C10([Bridge MHD NBIS:1]Posting3Axle:10; "###T")
				$BRInfo_txt:=$BRInfo_txt+", 5Axle="+String:C10([Bridge MHD NBIS:1]Posting5Axle:11; "###T")
			End if 
			$Postenterd_B:=True:C214
	End case 
	If (Not:C34($Postenterd_B))
		If ([Bridge MHD NBIS:1]Item41:141#"A")
			$BRInfo_txt:=$BRInfo_txt+"; Bridge Status="+QR_Item41
		End if 
	End if 
	If ([Bridge MHD NBIS:1]StructDef:103)
		$BRInfo_txt:=$BRInfo_txt+"; Bridge is Structurally Deficient"
	End if 
	If ([Bridge MHD NBIS:1]FunctObs:106)
		$BRInfo_txt:=$BRInfo_txt+"; Bridge is Functionally Obsolete"
	End if 
	C_BOOLEAN:C305($OtherInfo_b)
	$OtherInfo_b:=False:C215
	If ([Bridge MHD NBIS:1]Item61:133#"N")
		$BRInfo_txt:=$BRInfo_txt+";  Channel Prot.="+[Bridge MHD NBIS:1]Item61:133
	End if 
	If (([Bridge MHD NBIS:1]Item113:151#"N") & ([Bridge MHD NBIS:1]Item113:151#""))
		$BRInfo_txt:=$BRInfo_txt+";  Scour Rating="+[Bridge MHD NBIS:1]Item113:151+" ("+QR_Item113+")"
	End if 
	If ([Bridge MHD NBIS:1]Item37:129#"N")
		$BRInfo_txt:=$BRInfo_txt+";  Hist.Signif.="+Get_Description(-><>aItem37des; -><>aItem37; ->[Bridge MHD NBIS:1]Item37:129)
	End if 
	$BRInfo_txt:=$BRInfo_txt+"; ADT="+String:C10([Bridge MHD NBIS:1]Item29:88)+"; Truck %="+String:C10([Bridge MHD NBIS:1]Item109:90)
End if 

$0:=$BRInfo_txt