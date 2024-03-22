//%attributes = {"invisible":true}
//  `Temporarily update the Element Dict Dictionary
//  `Look for element 221
//QUERY([ElementDict];[ElementDict]ElementNo=221)
//If (Records in selection([ElementDict])=0)
//  `not found
//CREATE RECORD([ElementDict])
//[ElementDict]ElementNo:=221
//[ElementDict]Description:="Blank Element 15"
//[ElementDict]Category:="N59"
//[ElementDict]Prefix:="15."
//[ElementDict]IsParent:=False
//[ElementDict]Parent:=0
//SAVE RECORD([ElementDict])
//End if 
//UNLOAD RECORD([ElementDict])
//REDUCE SELECTION([ElementDict];0)
//  `following added Jan 15-2003
//QUERY([Inspection Type];[Inspection Type]Code="DVS")
//If (Records in selection([Inspection Type])=0)
//CREATE RECORD([Inspection Type])
//[Inspection Type]Code:="DVS"
//[Inspection Type]Description:="UW Special Member"
//SAVE RECORD([Inspection Type])
//End if 
//QUERY([Inspection Type];[Inspection Type]Code="RTA")
//If (Records in selection([Inspection Type])=0)
//CREATE RECORD([Inspection Type])
//[Inspection Type]Code:="RTA"
//[Inspection Type]Description:="Routine Arch"
//SAVE RECORD([Inspection Type])
//End if 
//UNLOAD RECORD([Inspection Type])
//REDUCE SELECTION([Inspection Type];0)