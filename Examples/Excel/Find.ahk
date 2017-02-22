; Basic version of a script to find all values in a range.
; The script looks in a workbook for the text "abc123".
; The range searched is the used range on sheet 1, columns A-Z.

; Constants
xlValues := -4163
xlWhole := 1

; Workbook file
Filename := "Book.xlsx"
FilePath := A_ScriptDir "\" FileName

FindThis := "abc123"  ; Look for this.
xlApp := ComObjCreate("Excel.Application")  ; Create an Excel application.
xlApp.Visible := true  ; Make the application visible.
MyWorkbook := xlApp.Workbooks.Open(FilePath, 0, 0)  ; Open the workbook. UpdateLinks:=0, ReadOnly:=0

; Determine the total range. Get the last cell in that range.
LastRow := MyWorkbook.Sheets(1).UsedRange.Rows.Count  ; Get the number of rows in the used range.
MyRange := MyWorkbook.Sheets(1).Range("A1:Z" LastRow)  ; Get the range of all cells in column A-Z in the used range.
LastCell := MyRange.Cells(MyRange.Cells.Count)  ; The last cell in the used range.

; Find the first cell.
FoundCell := MyRange.Find(FindThis, LastCell, xlValues, xlWhole)  ; LookIn:=xlValues, LookAt:=xlWhole
FirstAddr := FoundCell.Address  ; The while-loop below will exit when it reaches this cell.
MsgBox, % "The first found cell in the range is " FirstAddr " with a value of '" FoundCell.Value "'."

; Repeat the search.
while FoundCell := MyRange.FindNext(FoundCell)
{
    if (FoundCell.Address = FirstAddr)  ; Loop has wrapped around to the first found cell. Exit the loop.
        break
    MsgBox, % "The next found cell in the range is " FoundCell.Address " with a value of '" FoundCell.Value "'."
}

; References:
;   http://www.cpearson.com/excel/FindAll.aspx
