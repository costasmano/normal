//%attributes = {"invisible":true}
If (False:C215)
	//G_DefInspElmts
	//Create a list with the default elements for an inspection
	// Modified by: costasmanousakis-(Designer)-(2/16/09 12:04:54)
	Mods_2009_CM_5404  // --- "FREEZETHAW"
	// Modified by: costasmanousakis-(Designer)-(1/19/11 09:07:47)
	Mods_2011_01
	//` RR - also increased size of arrElements to 200
	Mods_2012_12  //r001 ` Code for new inspection types
	//Modified by: Charles Miller (12/13/12 13:06:44)
	// Modified by: Costas Manousakis-(Designer)-(4/15/13 18:58:37)
	Mods_2013_04
	//  ` Tunnels
	Mods_2013_05  //r001 ` Add TOV and TAL
	//Modified by: Charles Miller (5/2/13 16:36:16)
End if 
C_BOOLEAN:C305($1; $vbPrompt)
C_LONGINT:C283($0; $hlList)
C_BOOLEAN:C305($vbBridgeOverWater; $vbDoIt)
C_TEXT:C284($vItem42b)  // Command Replaced was o_C_STRING length was 1

If (Count parameters:C259=1)
	$vbPrompt:=$1
Else 
	$vbPrompt:=False:C215
End if 

$vbDoIt:=True:C214  //assume true
$vItem42b:=Substring:C12([Bridge MHD NBIS:1]Item42:85; 2; 1)
$vbBridgeOverWater:=(([Bridge MHD NBIS:1]Item6A:63="WATER@") | (Position:C15($vItem42b; "56789")>0))
C_LONGINT:C283($i; $k)  //Command Replaced was o_C_INTEGER
ARRAY INTEGER:C220(arrElements; 200)

$hlList:=0  //initialize it.-changed 12-dec-03 from NewList

Case of 
	: ([Inspections:27]Insp Type:6="RTN")
		For ($i; 1; Size of array:C274(arrElements))
			arrElements{$i}:=0
		End for 
		$k:=1
		//N58
		For ($i; 100; 112)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		For ($i; 114; 116)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		//N59    
		For ($i; 200; 220)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		arrElements{$k}:=227
		$k:=$k+1
		//N60    
		For ($i; 300; 312)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		arrElements{$k}:=331
		$k:=$k+1
		For ($i; 313; 330)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		
		If ($vbBridgeOverWater)
			//Bridge over water      
			For ($i; 400; 414)
				arrElements{$k}:=$i
				$k:=$k+1
			End for 
		End if 
		
		For ($i; 10; 12)  //approach
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		For ($i; 30; 33)  //traffic
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		
		If ($vbPrompt)
			If ($vbBridgeOverWater)
				//Bridge over water  
				CONFIRM:C162("Set elements to all elements of Items 58, 59, 60, 61, Approach, Traffic ?")
			Else 
				CONFIRM:C162("Set elements to all elements of Items 58, 59, 60, Approach, Traffic ?")
			End if 
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=GetDefElemHlistFromArr(->arrElements)
		End if 
	: ([Inspections:27]Insp Type:6="RTA")
		//Item 58    
		For ($i; 1; Size of array:C274(arrElements))
			arrElements{$i}:=0
		End for 
		$k:=1
		arrElements{1}:=100
		arrElements{2}:=101
		arrElements{3}:=113
		$k:=$k+3
		For ($i; 103; 116)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		//Item 59    
		arrElements{$k}:=221
		arrElements{$k+1}:=222
		arrElements{$k+2}:=200
		arrElements{$k+3}:=201
		arrElements{$k+4}:=223
		arrElements{$k+5}:=224
		arrElements{$k+6}:=216
		arrElements{$k+7}:=213
		arrElements{$k+8}:=212
		arrElements{$k+9}:=225
		arrElements{$k+10}:=217
		arrElements{$k+11}:=218
		arrElements{$k+12}:=226
		arrElements{$k+13}:=219
		arrElements{$k+14}:=220
		arrElements{$k+15}:=228
		$k:=$k+16
		//Item 60
		//Abutments
		For ($i; 300; 312)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		arrElements{$k}:=331
		$k:=$k+1
		//Piers    
		For ($i; 313; 324)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		//Pile Bents    
		For ($i; 325; 330)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		//Item 61    
		For ($i; 400; 407)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		//Approaches    
		For ($i; 10; 12)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		//Traffic safety
		For ($i; 30; 33)
			arrElements{$k}:=$i
			$k:=$k+1
		End for 
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all elements of Items 58, 59, 60, Approach, Traffic ?")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=GetDefElemHlistFromArr(->arrElements)
		End if 
		
	: ([Inspections:27]Insp Type:6="CUL")
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all elements of Items 61, 62, Approach, Traffic ?")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=CreateDefElemHlist("N61"; "N62"; "APP"; "TRA")
		End if 
		
	: ([Inspections:27]Insp Type:6="CLD")
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all elements of Traffic ?")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=CreateDefElemHlist("TRA")
		End if 
		
	: ([Inspections:27]Insp Type:6="DVL")
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all elements of Items 60 and 61?")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=CreateDefElemHlist("N60"; "N61")
		End if 
	: ([Inspections:27]Insp Type:6="FRZ")
		If ($vbPrompt)
			CONFIRM:C162("Set elements to the Freeze/Thaw Elements?")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=CreateDefElemHlist("FRZ")
		End if 
		
	: ([Inspections:27]Insp Type:6="DVE")
		If (Substring:C12([Bridge MHD NBIS:1]Item43:75; 2; 2)="19")
			//culvert
			If ($vbPrompt)
				CONFIRM:C162("Culvert - Set elements to all elements of Items 61 and 62?")
				$vbDoit:=(OK=1)
			End if 
			If ($vbDoIt)
				$hlList:=CreateDefElemHlist("N61"; "N62")
			End if 
		Else 
			If ($vbPrompt)
				CONFIRM:C162("Set elements to all elements of Items 60 and 61?")
				$vbDoit:=(OK=1)
			End if 
			If ($vbDoIt)
				$hlList:=CreateDefElemHlist("N60"; "N61")
			End if 
		End if 
		
	: ([Inspections:27]Insp Type:6="RRR")  //Railroad Routine
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all Rail/Transit Elements of Items 58, 59, 60,  61, 62, Approach, Overhead Sig"+"ns, and General?")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=INSP_NewCreateElementDictHlist
		End if 
	: ([Inspections:27]Insp Type:6="RRA")  //Railroad Routine Arch
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all Rail/Transit Elements of Items 58, 59, 60,  61,  Approach, and Overhead Signs")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=INSP_NewCreateElementDictHlist
		End if 
	: ([Inspections:27]Insp Type:6="PED")  //Railroad Ped bridge
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all Pedestrian Bridge elements of Items 58, 59, 60,  Approach, and Overhead Signs?")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=INSP_NewCreateElementDictHlist
		End if 
	: ([Inspections:27]Insp Type:6="RRC")  //Railroad Culvert
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all Rail/Transit Elements of Items 60, 62 and  Approach ")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=INSP_NewCreateElementDictHlist
		End if 
	: ([Inspections:27]Insp Type:6="TAL")  //Tunnal All Access
		If ($vbPrompt)
			CONFIRM:C162("Set elements to all Tunnel Elements ? ")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=INSP_NewCreateElementDictHlist
		End if 
		
	: ([Inspections:27]Insp Type:6="TOV")  //Tunnal Overhead Items
		If ($vbPrompt)
			CONFIRM:C162("Set elements to Tunnel Overhead Elements ? ")
			$vbDoit:=(OK=1)
		End if 
		If ($vbDoIt)
			$hlList:=INSP_NewCreateElementDictHlist
		End if 
		
	Else 
		If ($vbPrompt)
			ALERT:C41("There are no Default Elements for "+[Inspection Type:31]Description:2+" Inspections")
		End if 
		
End case 

ARRAY INTEGER:C220(arrElements; 0)  //reduce array size to 0

$0:=$hlList