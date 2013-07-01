Attribute VB_Name = "Module1"
Sub Thermal_FD_Computation()
Attribute Thermal_FD_Computation.VB_Description = "Macro recorded 3/31/2009 by Nate"
Attribute Thermal_FD_Computation.VB_ProcData.VB_Invoke_Func = " \n14"

' Macro Thermal_FD Computation
' Recorded 3/31/2009 by Nate

Sheets("sheet1").Select

' Set maximum iteration threshhold to the following value:

iterations = 300

settled = Range("AT26")

' Set all appropriate system variables based on user inputs

Range("A1:U21").Font.ColorIndex = 1

resetVal = Range("AT28")

run_weight = Range("AT30")

SetWeight = Range("AT32")

' Clear all pertinent cells in preparation for computation

Range("At2:Au21").ClearContents

Range("AL31:AP31").ClearContents

Sheets("sheet1").Range("B1:T21") = resetVal

' If the field for Run Weight is enabled, then iteratively calculate the board
' temperature until convergence given different SOR values, 1 < w < 2.

If run_weight = "Yes" Or run_weight = "Y" Or run_weight = "yes" Or run_weight = "y" Or run_weight = 1 Then

    ' Iterate across the different SOR weights.

    For Weight = 0 To 20
        w = 1 + Weight / 20
        
        Sheets("sheet1").Range("B1:T21") = resetVal
        
        For i = 0 To iterations
        
            ' Paste the current version of the temperature board into Sheet 2 for future calculations.
        
            Sheets("sheet1").Select
            Sheets("sheet1").Range("A1:U21").Copy
            Sheets("sheet2").Range("A1").PasteSpecial
            Sheets("sheet1").Select
            
            ' Perform mathematic computation on all cells using the Finite Difference (FD) Method.
            ' Program accounts for boundary conditions and heat generated if cell contains a component.
            
            For x = 1 To 21
                For y = 1 To 21
                    If Cells(x, y + 23) = "E" Then
                       
                    ElseIf Cells(x, y + 23) = "" Then
                        Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1)) * w + (1 - w) * Cells(x, y)
                    ElseIf Cells(x, y + 23) = 1 Then
                        Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 51.2 / 2) * w + (1 - w) * Cells(x, y)
                    ElseIf Cells(x, y + 23) = 2 Then
                        Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 16 / 2) * w + (1 - w) * Cells(x, y)
                    ElseIf Cells(x, y + 23) = 3 Then
                        Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 12.44 / 2) * w + (1 - w) * Cells(x, y)
                    ElseIf Cells(x, y + 23) = 4 Then
                        Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 9 / 2) * w + (1 - w) * Cells(x, y)
                    ElseIf Cells(x, y + 23) = "U" Then
                        Cells(x, y) = (0.25) * (Cells(x + 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1)) * w + (1 - w) * Cells(x, y)
                     ElseIf Cells(x, y + 23) = "L" Then
                        Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x - 1, y) + Cells(x, y + 1) + Cells(x, y - 1)) * w + (1 - w) * Cells(x, y)
                    End If
                                   
                Next y
            Next x
            
            ' Store the current iteration in a cell for display purposes.
            
            Sheets("sheet1").Range("AT24") = i
            
            t = 0
            
            ' Check to see if each individual cell in the current spreadsheet is within .001 degrees of the previous run.
            ' If all areas of the current board - old board are less than < .001 degrees, then we have reach steady state.
            ' Once steady state is reached, terminate the program.
            
            For x = 1 To 21
                For y = 1 To 21
                    If Abs(Sheets("sheet1").Cells(x, y) - Sheets("sheet2").Cells(x, y)) < settled Then
                    t = t + 0
                    Else
                    t = t + 1
                    End If
                                  
                Next y
            Next x
            
            ' If all board temperatures are below the threshhold, kick out of the loop.
            
            If t = 0 Then
            
                Sheets("sheet1").Range("AU" & Weight + 2) = i
            
                i = iterations
            
            End If
        
        Next i
        
        ' Create a copy of the board layout onto sheet 3 in prepartion for calculations.
        
        Range("X1:ar21").Copy
        Sheets("sheet3").Select
        Range("A1").PasteSpecial
        
        a = 1
        B = 1
        c = 1
        d = 1
        
        ' Iterate across the board. If a component is found, then calculate it's avg. board temperature & junction temperature.
        ' Components are found and named in an iterative fashion from top-left to the bottom-right of the board.
        ' Cell computations and averages are hard-coded, since we know where component lays given its top-left coordinate.
        
        For x = 1 To 21
            For y = 1 To 21
            
               ' Do nothing if you find a cell that is not a component.
               
               If Cells(x, y) = "E" Then
               ActiveCell = "x"
               ElseIf Cells(x, y) = "U" Then
               ActiveCell = "x"
               ElseIf Cells(x, y) = "L" Then
               ActiveCell = "x"
               ElseIf Cells(x, y) = "" Then
               ActiveCell = "x"
               
               ' If you find a cell that contains Component 1, compute it's board and junction temperatures.
               ' Store these values in the respective Excel cell.
               
               ElseIf Cells(x, y) = 1 Then
               
                    Sheets("Sheet1").Cells(40 + a, 25) = Sheets("sheet1").Cells(x, y)
                    Sheets("Sheet1").Cells(30 + a, 25) = Sheets("sheet1").Cells(40 + a, 25) + (1.6 * 35)
                    ActiveCell = "x"
                    a = a + 1
                    
               ' If you find a cell that contains Component 2, compute it's board and junction temperatures.
               ' Store these values in the respective Excel cell.
                    
                ElseIf Cells(x, y) = 2 Then
                
                    Sheets("Sheet1").Cells(40 + B, 28) = (1 / 4) * (Sheets("sheet1").Cells(x, y) _
                                                + Sheets("sheet1").Cells(x + 1, y) _
                                                + Sheets("sheet1").Cells(x, y + 1) _
                                                + Sheets("sheet1").Cells(x + 1, y + 1))
                    Sheets("Sheet1").Cells(30 + B, 28) = Sheets("sheet1").Cells(40 + B, 28) + (2 * 15)
                                                
                                                
                    Range(Cells(x, y), Cells(x + 1, y + 1)) = "x"
                    B = B + 1
                    
               ' If you find a cell that contains Component 3, compute it's board and junction temperatures.
               ' Store these values in the respective Excel cell.
                
                ElseIf Cells(x, y) = 3 Then
                
                    Sheets("Sheet1").Cells(40 + c, 31) = (1 / 9) * (Sheets("sheet1").Cells(x, y) _
                                                + Sheets("sheet1").Cells(x + 1, y) _
                                                + Sheets("sheet1").Cells(x + 2, y) _
                                                + Sheets("sheet1").Cells(x, y + 1) _
                                                + Sheets("sheet1").Cells(x, y + 2) _
                                                + Sheets("sheet1").Cells(x + 1, y + 1) _
                                                + Sheets("sheet1").Cells(x + 2, y + 1) _
                                                + Sheets("sheet1").Cells(x + 1, y + 2) _
                                                + Sheets("sheet1").Cells(x + 2, y + 2))
                    Sheets("Sheet1").Cells(30 + c, 31) = Sheets("sheet1").Cells(40 + c, 31) + (3.5 * 12)
                                                
                    Range(Cells(x, y), Cells(x + 2, y + 2)) = "x"
                    c = c + 1
                    
               ' If you find a cell that contains Component 4, compute it's board and junction temperatures.
               ' Store these values in the respective Excel cell.
                    
                ElseIf Cells(x, y) = 4 Then
                
                    Sheets("Sheet1").Cells(40 + d, 34) = (1 / 16) * (Sheets("sheet1").Cells(x, y) _
                                                + Sheets("sheet1").Cells(x + 1, y) _
                                                + Sheets("sheet1").Cells(x + 2, y) _
                                                + Sheets("sheet1").Cells(x + 3, y) _
                                                + Sheets("sheet1").Cells(x, y + 1) _
                                                + Sheets("sheet1").Cells(x, y + 2) _
                                                + Sheets("sheet1").Cells(x, y + 3) _
                                                + Sheets("sheet1").Cells(x + 1, y + 1) _
                                                + Sheets("sheet1").Cells(x + 1, y + 2) _
                                                + Sheets("sheet1").Cells(x + 1, y + 3) _
                                                + Sheets("sheet1").Cells(x + 2, y + 1) _
                                                + Sheets("sheet1").Cells(x + 2, y + 2) _
                                                + Sheets("sheet1").Cells(x + 2, y + 3) _
                                                + Sheets("sheet1").Cells(x + 3, y + 1) _
                                                + Sheets("sheet1").Cells(x + 3, y + 2) _
                                                + Sheets("sheet1").Cells(x + 3, y + 3))
                                                
                    Sheets("Sheet1").Cells(30 + d, 34) = Sheets("sheet1").Cells(40 + d, 34) + (4.5 * 7)
                    
                    Range(Cells(x, y), Cells(x + 3, y + 3)) = "x"
                    d = d + 1
                    
                    ElseIf Cells(x, y) = "x" Then
                        ActiveCell = "O"
                    
                End If
            Next y
        Next x
        
        Sheets("sheet1").Range("at" & Weight + 2) = w
        
    Next Weight
    
' ***** Code is identical to that listed above! No iterative SOR is used in these computations. *****
' ***** The predefined SOR (based on value in respective spreadsheet cell) is used.             *****

Else
        
    w = SetWeight
        
    For i = 0 To iterations
    
        Sheets("sheet1").Select
        
        Sheets("sheet1").Range("A1:U21").Copy
        Sheets("sheet2").Range("A1").PasteSpecial
        
        Sheets("sheet1").Select
        
        For x = 1 To 21
            For y = 1 To 21
                If Cells(x, y + 23) = "E" Then
                   
                ElseIf Cells(x, y + 23) = "" Then
                    Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1)) * w + (1 - w) * Cells(x, y)
                ElseIf Cells(x, y + 23) = 1 Then
                    Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 51.2 / 2) * w + (1 - w) * Cells(x, y)
                ElseIf Cells(x, y + 23) = 2 Then
                    Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 16 / 2) * w + (1 - w) * Cells(x, y)
                ElseIf Cells(x, y + 23) = 3 Then
                    Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 12.44 / 2) * w + (1 - w) * Cells(x, y)
                ElseIf Cells(x, y + 23) = 4 Then
                    Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1) + 9 / 2) * w + (1 - w) * Cells(x, y)
                ElseIf Cells(x, y + 23) = "U" Then
                    Cells(x, y) = (0.25) * (Cells(x + 1, y) + Cells(x + 1, y) + Cells(x, y + 1) + Cells(x, y - 1)) * w + (1 - w) * Cells(x, y)
                 ElseIf Cells(x, y + 23) = "L" Then
                    Cells(x, y) = (0.25) * (Cells(x - 1, y) + Cells(x - 1, y) + Cells(x, y + 1) + Cells(x, y - 1)) * w + (1 - w) * Cells(x, y)
                End If
                               
            Next y
        Next x
        
        Sheets("sheet1").Range("AT24") = i
        
        t = 0
        
        For x = 1 To 21
            For y = 1 To 21
                If Abs(Sheets("sheet1").Cells(x, y) - Sheets("sheet2").Cells(x, y)) < settled Then
                t = t + 0
                Else
                t = t + 1
                End If
                              
            Next y
        Next x
        
        If t = 0 Then
        
        i = iterations
        
        End If
    
    Next i
    
    Range("X1:ar21").Copy
    Sheets("sheet3").Select
    Range("A1").PasteSpecial
    
    a = 1
    B = 1
    c = 1
    d = 1
    
    For x = 1 To 21
        For y = 1 To 21
        
           'Cells(x, y).Select 'this can be deleted but lets you see whats happening
           
           If Cells(x, y) = "E" Then
           ActiveCell = "x"
           ElseIf Cells(x, y) = "U" Then
           ActiveCell = "x"
           ElseIf Cells(x, y) = "L" Then
           ActiveCell = "x"
           ElseIf Cells(x, y) = "" Then
           ActiveCell = "x"
           
           ElseIf Cells(x, y) = 1 Then
                
                Sheets("Sheet1").Cells(40 + a, 25) = Sheets("sheet1").Cells(x, y)
                Sheets("Sheet1").Cells(30 + a, 25) = Sheets("sheet1").Cells(40 + a, 25) + (1.6 * 35)
                
                ActiveCell = "x"
                a = a + 1
            
            ElseIf Cells(x, y) = 2 Then
                
                Sheets("Sheet1").Cells(40 + B, 28) = (1 / 4) * (Sheets("sheet1").Cells(x, y) _
                                            + Sheets("sheet1").Cells(x + 1, y) _
                                            + Sheets("sheet1").Cells(x, y + 1) _
                                            + Sheets("sheet1").Cells(x + 1, y + 1))
                Sheets("Sheet1").Cells(30 + B, 28) = Sheets("sheet1").Cells(40 + B, 28) + (2 * 15)
                
                Range(Cells(x, y), Cells(x + 1, y + 1)) = "x"
                B = B + 1
            
            ElseIf Cells(x, y) = 3 Then
                
                Sheets("Sheet1").Cells(40 + c, 31) = (1 / 9) * (Sheets("sheet1").Cells(x, y) _
                                            + Sheets("sheet1").Cells(x + 1, y) _
                                            + Sheets("sheet1").Cells(x + 2, y) _
                                            + Sheets("sheet1").Cells(x, y + 1) _
                                            + Sheets("sheet1").Cells(x, y + 2) _
                                            + Sheets("sheet1").Cells(x + 1, y + 1) _
                                            + Sheets("sheet1").Cells(x + 2, y + 1) _
                                            + Sheets("sheet1").Cells(x + 1, y + 2) _
                                            + Sheets("sheet1").Cells(x + 2, y + 2))
                Sheets("Sheet1").Cells(30 + c, 31) = Sheets("sheet1").Cells(40 + c, 31) + (3.5 * 12)
                
                Range(Cells(x, y), Cells(x + 2, y + 2)) = "x"
                c = c + 1
            
            ElseIf Cells(x, y) = 4 Then
                
                Sheets("Sheet1").Cells(40 + d, 34) = (1 / 16) * (Sheets("sheet1").Cells(x, y) _
                                            + Sheets("sheet1").Cells(x + 1, y) _
                                            + Sheets("sheet1").Cells(x + 2, y) _
                                            + Sheets("sheet1").Cells(x + 3, y) _
                                            + Sheets("sheet1").Cells(x, y + 1) _
                                            + Sheets("sheet1").Cells(x, y + 2) _
                                            + Sheets("sheet1").Cells(x, y + 3) _
                                            + Sheets("sheet1").Cells(x + 1, y + 1) _
                                            + Sheets("sheet1").Cells(x + 1, y + 2) _
                                            + Sheets("sheet1").Cells(x + 1, y + 3) _
                                            + Sheets("sheet1").Cells(x + 2, y + 1) _
                                            + Sheets("sheet1").Cells(x + 2, y + 2) _
                                            + Sheets("sheet1").Cells(x + 2, y + 3) _
                                            + Sheets("sheet1").Cells(x + 3, y + 1) _
                                            + Sheets("sheet1").Cells(x + 3, y + 2) _
                                            + Sheets("sheet1").Cells(x + 3, y + 3))
                                            
                Sheets("Sheet1").Cells(30 + d, 34) = Sheets("sheet1").Cells(40 + d, 34) + (4.5 * 7)
                
                Range(Cells(x, y), Cells(x + 3, y + 3)) = "x"
                d = d + 1
                ElseIf Cells(x, y) = "x" Then
                    ActiveCell = "O"
                
            End If
        Next y
    Next x
End If

' Visibly display the hottest temperature on the board.

Sheets("sheet1").Select
Range("AL31") = "= max(A1:U21)"
Hottest = Range("AL31")

        For x = 1 To 21
            For y = 1 To 21
                If Cells(x, y) = Hottest Then
                    
                    Cells(x, y).Select
                    Selection.Font.ColorIndex = 2
                    
                End If
            Next y
        Next x
End Sub



Sub reset()

Sheets("sheet1").Range("B1:T21") = Range("AT28")

End Sub



