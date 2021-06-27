' Este es el código fuente en Rapid-Q, del Delectomorfo para Windows.
' Este programa fue escrito en su totalidad por Pablo García y
' Lucas Velásquez. Queda prohibida su reproducción o publicación parcial
' o total por cualquier medio, y los autores se reservan todos los derechos.
' Copyright (c) 1999, 2000, 2001, 2002. Fracasoft Co.
' A continuación, el programa.

'================== DECLARACIONES GENERALES ==================

$RESOURCE icono AS "delecto.ico"
$RESOURCE iconot AS "delectab.ico"
$RESOURCE splash AS "intro.bmp"
$RESOURCE creditos AS "barra.bmp"
Application.Title = "Delectomorfo para Windows"
DECLARE SUB Progresion
DECLARE SUB Errord
DECLARE SUB Conversion
DECLARE SUB NewDraw
DECLARE SUB Imprimir
DIM Y AS INTEGER
Const pi = 3.141592654

'================== TIMER DE LA VENTANA SPLASH ==================
DIM Timer1 AS QTIMER
Timer1.Interval = 1000

'================== MENU PRINCIPAL ==================

DIM mnuFile AS QMENUITEM, mnuBar AS QMENUITEM, mnuPrint AS QMENUITEM, mnuExit AS QMENUITEM
mnuFile.Caption = "&Archivo"
mnuPrint.Caption = "&Imprimir"
mnuBar.Caption = "-"
mnuExit.Caption = "&Salir"
mnuFile.AddItems mnuPrint, mnuBar, mnuExit
'--------------------------------------------------------------
DIM mnuVer AS QMENUITEM, mnuBarraControl AS QMENUITEM, mnuConversion AS QMENUITEM
mnuVer.Caption = "&Ver"
mnuBarraControl.Caption = "&Barra de control"
mnuConversion.Caption = "&Conversión de ranuras"
mnuVer.AddItems mnuBarraControl, mnuConversion
'--------------------------------------------------------------
DIM mnuHelp AS QMENUITEM, mnuAyudaLinea AS QMENUITEM, mnuBar2 AS QMENUITEM, mnuAcerca AS QMENUITEM
mnuHelp.Caption = "A&yuda"
mnuAyudaLinea.Caption = "&Ayuda en línea"
mnuBar2.Caption = "-"
mnuAcerca.Caption = "A&cerca de..."
mnuHelp.AddItems mnuAyudaLinea, mnuBar2, mnuAcerca

'================== DEFINICION DEL TIMER DE LOS CREDITOS ==================

DIM AboutTimer AS QTimer

'================== FUENTE DE LOS CREDITOS ==================

CREATE Fuente AS QFONT
    Name = "Verdana"
    Size = 7
END CREATE

'================== FORMULARIO SPLASH ==================

CREATE frmSplash AS QFORM
    Caption = ""
    Width = 400
    Height = 247
    BorderStyle = 0
    Center
    CREATE Image1 AS QIMAGE
        BMPHandle = splash
        Left = 0
        Top = 0
        Width = 401
        Height = 249
    END CREATE
END CREATE

'================== FORMULARIO PRINCIPAL ==================

CREATE frmMain AS QFORM
    Caption = "Delectomorfo para Windows"
    Width = 392
    Height = 460
    Top = 40
    Left = 180
    BorderStyle = 1
    DelBorderIcons(2)
    IcoHandle = icono
    CREATE Menu AS QMAINMENU
        AddItems mnuFile
        AddItems mnuVer
        AddItems mnuHelp
    END CREATE
    CREATE Check1 AS QCHECKBOX
        Caption = "Check1"
        Left = 322
        Top = 206
        Width = 65
        Visible = 0
    END CREATE
    CREATE Text2 AS QEDIT
        Text = "2"
        Left = 359
        Top = 132
        Width = 33
        Visible = 0
    END CREATE
    CREATE Text9 AS QEDIT
        Text = "9"
        Left = 319
        Top = 156
        Width = 33
        Visible = 0
    END CREATE
    CREATE Text4 AS QEDIT
        Text = "4"
        Left = 319
        Top = 180
        Width = 33
        Visible = 0
    END CREATE
    CREATE Text5 AS QEDIT
        Text = "5"
        Left = 359
        Top = 180
        Width = 33
        Visible = 0
    END CREATE
    CREATE Text1 AS QEDIT
        Text = "1"
        Left = 319
        Top = 132
        Width = 33
        Visible = 0
    END CREATE
END CREATE

'================== FORMULARIO BARRA DE CONTROL ==================

CREATE frmBarra AS QFORM
    Caption = "Barra de control"
    Width = 140
    Height = 390
    Top = 50
    Left = 30
    BorderStyle = 4
    CREATE Frame2 AS QGROUPBOX
        Caption = " Control principal "
        Left = 10
        Top = 10
        Width = 113
        Height = 348
        CREATE Gauge1 AS QGAUGE
            Left = 10
            Top = 319
            Width = 92
            Height = 20
            Kind = 1
        END CREATE     
        CREATE Label5 AS QLABEL
            Caption = "Número de ranuras"
            Left = 5
            Top = 24
            Width = 53
            Height = 31
            Transparent = 1
            Wordwrap = 1
        END CREATE
        CREATE Label3 AS QLABEL
            Caption = "Líneas individuales"
            Left = 5
            Top = 64
            Width = 63
            Height = 26
            Wordwrap = 1
        END CREATE
        CREATE Label4 AS QLABEL
            Caption = "Progresiones aritméticas"
            Left = 5
            Top = 120
            Width = 63
            Height = 26
            Wordwrap = 1
        END CREATE
        CREATE Label2 AS QLABEL
            Caption = "Razón"
            Left = 18
            Top = 227
            Width = 40
        END CREATE
        CREATE Text8 AS QEDIT
            'Numero de ranuras
            Text = ""
            Left = 66
            Top = 24
            Width = 33
            TabOrder = 1
        END CREATE
        CREATE Option1 AS QRADIOBUTTON
            'Activar lineas individuales
            Caption = "Activar"
            Left = 5
            Top = 97
            Width = 57
            TabOrder = 2
        END CREATE
        CREATE Option2 AS QRADIOBUTTON
            'Activar progresiones concatenadas
            Caption = "Concatenadas"
            Left = 5
            Top = 153
            Width = 97
            TabOrder = 3
        END CREATE
        CREATE Option3 AS QRADIOBUTTON
            'Activar progresiones alternadas
            Caption = "Alternadas"
            Left = 5
            Top = 169
            Width = 97
            TabOrder = 4
        END CREATE
        CREATE Combo1 AS QEDIT
            'Primer punto de una línea a ser trazada
            Text = ""
            Left = 10
            Top = 200
            Width = 41
            TabOrder = 5
        END CREATE
        CREATE Combo2 AS QEDIT
            'Segundo punto de una línea a ser trazada
            Text = ""
            Left = 58
            Top = 200
            Width = 41
            TabOrder = 6
        END CREATE
        CREATE Text3 AS QEDIT
            'Razón de la progresión
            Text = ""
            Left = 58
            Top = 224
            Width = 41
            TabOrder = 7
        END CREATE
        CREATE Command1 AS QBUTTON
            Caption = "Ver"
            Left = 11
            Top = 253
            Width = 91
            TabOrder = 8
        END CREATE
        CREATE Command2 AS QBUTTON
            Caption = "Borrar"
            Left = 12
            Top = 287
            Width = 91
            TabOrder = 9
        END CREATE
    END CREATE
END CREATE

'================== FORMULARIO CONVERSION DE RANURAS ==================

CREATE frmConversion AS QFORM
    Caption = "Conversión de ranuras"
    Width = 276
    Height = 160
    BorderStyle = 1
    DelBorderIcons(1, 2)
    IcoHandle = iconot
    Center
    CREATE lblRanuras AS QLABEL
        Caption = "Número de ranuras"
        Left = 13
        Top = 9
        Width = 104
        Transparent = 1
    END CREATE
    CREATE lblOriginal AS QLABEL
        Caption = "Número original"
        Left = 13
        Top = 33
        Width = 90
        Transparent = 1
    END CREATE
    CREATE lblResultado AS QLABEL
        Caption = "Número en el Delectomorfo"
        Left = 13
        Top = 57
        Width = 74
        Height = 34
        Transparent = 1
        Wordwrap = 1
    END CREATE
    CREATE ranuras AS QEDIT
        Text = ""
        Left = 114
        Top = 9
        Width = 145
    END CREATE
    CREATE original AS QEDIT
        Text = ""
        Left = 114
        Top = 33
        Width = 145
        TabOrder = 1
    END CREATE
    CREATE resultado AS QEDIT
        Text = ""
        Left = 114
        Top = 57
        Width = 145
        Enabled = 0
        TabOrder = 2
    END CREATE
    CREATE cmdVer AS QBUTTON
        Caption = "&Ver"
        Left = 36
        Top = 97
        Width = 91
        TabOrder = 3
    END CREATE
    CREATE cmdCancelar AS QBUTTON
        Caption = "&Cerrar"
        Left = 140
        Top = 97
        Width = 91
        TabOrder = 4
    END CREATE
END CREATE

'================== FORMULARIO DE LOS CREDITOS (ACERCA) ==================

CREATE frmAcerca AS QFORM
    Caption = "Acerca del Delectomorfo para Windows"
    Width = 286
    Height = 209
    BorderStyle = 3
    Center
    CREATE Image2 AS QIMAGE
        BMPHandle = creditos
        Left = 6
        Top = 9
        Width = 41
        Height = 161
    END CREATE
    CREATE Canvas AS QCANVAS
        Left = 62
        Top = 10
        Width = 201
        Height = 121
        Font = Fuente
        Color = 0
    END CREATE
    CREATE Button1 AS QBUTTON
        Caption = "'OK, that's enough!', you say" 
        Left = 62
        Width = 201
        Top = 146
    END CREATE
END CREATE
 
'================== SUBS DE LA VENTANA DE CREDITOS ==================
SUB Button1_Click
    frmAcerca.Close
END SUB

SUB Paint1
    Canvas.Paint 0, 0, 0, 0
    Canvas.Textout (5,Y,"DELECTOMORFO PARA WINDOWS", &HFFFFFF, 0)
    Canvas.Textout (5,Y+12,"                        ", &HFFFFFF, 0)
    Canvas.Textout (5,Y+24,"Programado para", &HFFFFFF, 0)
    Canvas.Textout (10,Y+36,"Fracasoft Co.", &HFFFFFF, 0)
    Canvas.Textout (5,Y+48,"por:", &HFFFFFF, 0)
    Canvas.Textout (10,Y+60,"Pablo García R.", &HFFFFFF, 0)
    Canvas.Textout (10,Y+72,"Lucas Velásquez P.", &HFFFFFF, 0)
    Canvas.Textout (5,Y+84,"Copyright 2002.", &HFFFFFF, 0)
    Canvas.Textout (5,Y+96,"All rights reserved.", &HFFFFFF, 0)
    Canvas.Textout (5,Y+108,"                        ", &HFFFFFF, 0)
END SUB
'--------------------------------------------------------------
SUB AboutTimerOver
    AboutTimer.Interval = 1 
    If Y <= -130 then Y = 150
    Y = Y - 1
    Paint1
END SUB    

'================== SUBS DE LA VENTANA SPLASH ==================

SUB Timer1_Timer
    frmMain.ShowModal
    frmSplash.Visible = 0
END SUB

'================== SUBS DE LA VENTANA PRINCIPAL ==================

SUB mnuPrint_Click
    frmBarra.Show
    Check1.Checked = 1
    
    If Option1.Checked = 1 Then
        Call Conversion
    ElseIf Option2.Checked = 1 And Text3.Text = "" Then
        GoTo Error
    ElseIf Option2.Checked = 1 Then
        Combo1.Text = "0"
        Combo2.Text = Text3.Text
        Call Conversion
    ElseIf Option3.Checked = 1 And (Text3.Text = "" Or Combo1.Text = "" Or Combo2.Text = "") Then
        GoTo Error
    ElseIf Option3.Checked = 1 Then
        Text4.Text = Combo1.Text
        Text5.Text = Combo2.Text
        Call Conversion
    End If
Exit Sub

Error:
    MessageBox "Es necesario escribir un número", "Delectomorfo error",
    Exit Sub
END SUB
'--------------------------------------------------------------
SUB mnuAyudaLinea_Click
    MessageBox "Consulte la ayuda en el archivo léame", "Delectomorfo ayuda",
END SUB
'--------------------------------------------------------------
SUB mnuConversion_Click
    frmConversion.Show
END SUB
'--------------------------------------------------------------
SUB BarraControl
    '0 = Falso
    '1 = Verdadero
    If mnuBarraControl.Checked = 1 Then
        frmBarra.Close
        mnuBarraControl.Checked = 0
    ElseIf mnuBarraControl.Checked = 0 Then
        frmBarra.Show
        mnuBarraControl.Checked = 1
    End If
END SUB
'--------------------------------------------------------------
SUB Salir
    End
END SUB    
'--------------------------------------------------------------
SUB frmMain_Show
    frmSplash.Visible = 0
    mnuBarraControl.Checked = 1
    frmBarra.Show
END SUB
'--------------------------------------------------------------
SUB mnuAcerca_Click
    frmAcerca.Show
    Y = 130
END SUB

'================== SUBS DE LA BARRA DE CONTROL ==================

SUB frmBarraClose
    mnuBarraControl.Checked = 0
END SUB    
'--------------------------------------------------------------
Sub Option1_Click
    If Option1.Checked = 1 Then
        Text3.Visible = 0
        Label2.Visible = 0
        Combo1.Visible = 1
        Combo2.Visible = 1        
    End If
    'Combo1.SetFocus
End Sub
'--------------------------------------------------------------
Sub Option2_Click
    If Option2.Checked = 1 Then
        Text3.Visible = 1
        Label2.Visible = 1
        Combo1.Visible = 0
        Combo2.Visible = 0
    End If
End Sub
'--------------------------------------------------------------
Sub Option3_Click
    If Option3.Checked = 1 Then
        Text3.Visible = 1
        Label2.Visible = 1
        Combo1.Visible = 1
        Combo2.Visible = 1        
    End If
End Sub
'--------------------------------------------------------------
Sub Command1_Click
    If Option1.Checked = 1 Then
        Call Conversion
    ElseIf Option2.Checked = 1 And Text3.Text = "" Then
        GoTo Error
    ElseIf Option2.Checked = 1 Then
        Combo1.Text = "0"
        Combo2.Text = Text3.Text
        Call Conversion
    ElseIf Option3.Checked = 1 And (Text3.Text = "" Or Combo1.Text = "" Or Combo2.Text = "") Then
        GoTo Error
    ElseIf Option3.Checked = 1 Then
        Text4.Text = Combo1.Text
        Text5.Text = Combo2.Text
        Call Conversion
    ElseIf Option3.Checked = 1 Or Option2.Checked = 0 Or Option1.Checked = 0 Then
        MessageBox "No ha escogido una opción para graficar los datos", "Delectomorfo error",
    End If
Exit Sub

Error:
    MessageBox "Es necesario escribir un número", "Delectomorfo error",
End Sub
'--------------------------------------------------------------
SUB Command2_Click
    frmMain.Repaint
    Gauge1.Position = 0
END SUB
'--------------------------------------------------------------
SUB EditKeyDown (Key AS WORD, Shift AS INTEGER, Sender AS QEDIT) 
SELECT CASE Key 
    CASE 13 
        Command1_Click
END SELECT 
END SUB 

'================== SUBS DE LA VENTANA DE CONVERSION DE RANURAS ==================

SUB cmdCancelar_Click
    frmConversion.Close
END SUB
'--------------------------------------------------------------
SUB cmdVer_Click
    resultado.Text = Str$(Val(original.Text) - ((Val(original.Text) \ Val(ranuras.Text)) * Val(ranuras.Text)))
END SUB    

'================== PROCEDIMIENTOS GLOBALES (O "OJO CON ESTO") ==================
SUB Progresion
    For chars = 0 To Val(Text8.Text)
    
    Suma:
            Combo1.Text = Str$(((Val(Combo1.Text) * 1) + (Val(Text3.Text) * 1)))
            Combo2.Text = Str$(((Val(Combo2.Text) * 1) + (Val(Text3.Text) * 1)))
        
    Box1:
        If Val(Combo1.Text) >= 0 Then
            Text1.Text = Str$(Val(Combo1.Text) - ((Val(Combo1.Text) \ Val(Text8.Text)) * Val(Text8.Text)))
        End If
        
    Box2:
        If Val(Combo2.Text) >= 0 Then
            Text2.Text = Str$(Val(Combo2.Text) - ((Val(Combo2.Text) \ Val(Text8.Text)) * Val(Text8.Text)))
        End If

    Draw:
        frmMain.Line ((193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text1.Text))) * 3.141592654))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text1.Text))) * 3.141592654))), (193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * 3.141592654))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * 3.141592654))), 0)
        Gauge1.Position = (100 * chars) / (Val(Text8.Text))        
    Next
    
    Combo1.Text = Text4.Text
    Combo2.Text = Text5.Text
    
    Exit Sub
End Sub
'--------------------------------------------------------------
SUB Errord
    MessageBox "Error",,
END SUB
'--------------------------------------------------------------
SUB Conversion
    If Val(Text8.Text) <= 0 Then Goto Error2

Box1:
    If Val(Combo1.Text) < 0 Then
        GoTo Error2
    ElseIf Val(Combo1.Text) >= 0 Then
        Text1.Text = Str$(Val(Combo1.Text) - ((Val(Combo1.Text) \ Val(Text8.Text)) * Val(Text8.Text)))
    End If
    
Box2:
    If Val(Combo2.Text) < 0 Then
        GoTo Error2
    ElseIf Val(Combo2.Text) >= 0 Then
        Text2.Text = Str$(Val(Combo2.Text) - ((Val(Combo2.Text) \ Val(Text8.Text)) * Val(Text8.Text)))
    End If
    
Final:
    
    If Check1.Checked = 0 Then
        Call NewDraw
    Elseif Check1.Checked = 1 Then
        Call Imprimir
    End If
    Exit Sub
     
Error2:
    MessageBox "El número escrito es negativo", "Delectomorfo error",
End Sub
'--------------------------------------------------------------
SUB NewDraw
    xone = (193 + (185 * Cos(1.5 * pi)))
    yone = (201 + (185 * Sin(1.5 * pi)))
    xtwo = (193 + (185 * Cos(1.5 * pi)))
    ytwo = (201 + (185 * Sin(1.5 * pi)))
    frmMain.Line (xone, yone, xtwo, ytwo,)
    
    Text9.Text = Str$((2 / Val(Text8.Text)))

    Do 
        frmMain.Line ((193 + (185 * Cos((1.5 + Val(Text9.Text)) * pi))), (201 + (185 * Sin((1.5 + Val(Text9.Text)) * pi))), (193 + (177 * Cos((1.5 + Val(Text9.Text)) * pi))), (201 + (177 * Sin((1.5 + Val(Text9.Text)) * pi))),)
        Text9.Text = Str$((Val(Text9.Text) + (2 / Val(Text8.Text))))
    Loop Until Val(Text9.Text) > 3.5
        
    frmMain.Line ((193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text1.Text))) * pi))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text1.Text))) * pi))), (193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * pi))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * pi))),)
        
    If Option2.Checked = 1 Then
        Call Progresion
    ElseIf Option3.Checked = 1 Then
        Call Progresion
    End If
End Sub
'--------------------------------------------------------------
SUB Imprimir
    Printer.Title = "Delectomorfo"
    Printer.BeginDoc
    Printer.Line ((193 + (185 * Cos(1.5 * 3.141592654))), (201 + (185 * Sin(1.5 * 3.141592654))), (193 + (177 * Cos(1.5 * 3.141592654))), (201 + (177 * Sin(1.5 * 3.141592654))),)
    Text9.Text = Str$((2 / Val(Text8.Text)))

    Do
        Printer.Line ((193 + (185 * Cos((1.5 + Val(Text9.Text)) * 3.141592654))), (201 + (185 * Sin((1.5 + Val(Text9.Text)) * 3.141592654))), (193 + (177 * Cos((1.5 + Val(Text9.Text)) * 3.141592654))), (201 + (177 * Sin((1.5 + Val(Text9.Text)) * 3.141592654))),)
        Text9.Text = Str$((Val(Text9.Text) + (2 / Val(Text8.Text))))
    Loop Until Val(Text9.Text) > 3.5
    
    Printer.Line ((193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text1))) * 3.141592654))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text1.Text))) * 3.141592654))), (193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * 3.141592654))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * 3.141592654))),)

    If Option2.Checked = 1 Then
        GoTo Prog
        Printer.EndDoc
    ElseIf Option3.Checked = 1 Then
        GoTo Prog
        Printer.EndDoc
    End If

    Exit Sub

Prog:
    For chars = 0 To Val(Text8.Text)
    
Suma:
        Combo1.Text = Str$(((Val(Combo1.Text) * 1) + (Val(Text3.Text) * 1)))
        Combo2.Text = Str$(((Val(Combo2.Text) * 1) + (Val(Text3.Text) * 1)))
    
Box1:
        If Val(Combo1.Text) >= 0 Then
            Text1.Text = Str$(Val(Combo1.Text) - ((Val(Combo1.Text) \ Val(Text8.Text)) * Val(Text8.Text)))
        End If
    
Box2:
        If Val(Combo2.Text) >= 0 Then
            Text2.Text = Str$(Val(Combo2.Text) - ((Val(Combo2.Text) \ Val(Text8.Text)) * Val(Text8.Text)))
        End If
    
Draw:
        Printer.Line ((193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text1.Text))) * 3.141592654))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text1.Text))) * 3.141592654))), (193 + (177 * Cos((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * 3.141592654))), (201 + (177 * Sin((1.5 + ((2 / Val(Text8.Text)) * Val(Text2.Text))) * 3.141592654))),)

    Next chars
    
    Printer.EndDoc

    Combo1.Text = Text4.Text
    Combo2.Text = Text5.Text
    Check1.Checked = 0
End Sub 'FIN DEL "OJO CON ESTO"

'--------------------------------------------------------------

'================== ASIGNA EVENTOS DE LA VENTANA PRINCIPAL ==================

mnuAyudaLinea.OnClick = mnuAyudaLinea_Click
mnuConversion.OnClick = mnuConversion_Click
mnuBarraControl.OnClick = BarraControl
mnuPrint.OnClick = mnuPrint_Click
mnuAcerca.OnClick = mnuAcerca_Click
frmMain.OnShow = frmMain_Show
Text3.OnKeyDown = EditKeyDown
Text8.OnKeyDown = EditKeyDown
Combo1.OnKeyDown = EditKeyDown
Combo2.OnKeyDown = EditKeyDown
frmMain.OnClose = Salir
mnuExit.OnClick = Salir

'================== ASIGNA EVENTOS DE LA BARRA DE CONTROL ==================

frmBarra.OnClose = frmBarraClose
Option1.OnClick = Option1_Click
Option2.OnClick = Option2_Click
Option3.OnClick = Option3_Click
Command1.OnClick = Command1_Click
Command2.OnClick = Command2_Click

'================== ASIGNA EVENTOS DE LA VENTANA SPLASH ==================

Timer1.OnTimer = Timer1_Timer

'================== ASIGNA EVENTOS DE LOS CREDITOS (ACERCA) ==================

AboutTimer.OnTimer = AboutTimerOver
Canvas.OnPaint = Paint1
Button1.OnClick = Button1_Click

'================== ASIGNA EVENTOS DE CONVERSION DE RANURAS ==================

cmdCancelar.OnClick = cmdCancelar_Click
cmdVer.OnClick = cmdVer_Click

'================== INICIAR EL PROGRAMA ==================

frmSplash.ShowModal
