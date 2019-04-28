unit screenShotter;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, System.ImageList,
  Vcl.ImgList, Vcl.PlatformDefaultStyleActnCtrls, Vcl.ActnMan,
  System.Actions, Vcl.ActnList, Vcl.StdCtrls, Vcl.Buttons, Vcl.ToolWin,
  Vcl.ActnCtrls, Generics.Collections, Vcl.ComCtrls, Vcl.Samples.Spin,
  Vcl.ButtonGroup, System.Win.TaskbarCore, Vcl.Taskbar;

  procedure screenShotter_Capture(Form : TForm; Const AdditionalInformation : String = '');

type

  TDrawingTool = (dtLine, dtArrow, dtEllipse, dtRoundRect, dtRectangle, dtText);

  TFrmScreenShotter = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    SaveDialog: TSaveDialog;
    ActionManager: TActionManager;
    ActionSave: TAction;
    ActionSaveAs: TAction;
    ActionCopyClipboard: TAction;
    ActionSendMail: TAction;
    ActionEditorOpen: TAction;
    ActionPrint: TAction;
    ActionClose: TAction;
    ActionChangeShapeColor: TAction;
    ActionChangeShapeSize: TAction;
    ActionDrawSquare: TAction;
    ActionDrawRoundedSquare: TAction;
    ActionDrawCircle: TAction;
    ActionDrawLine: TAction;
    ActionDrawArrow: TAction;
    ActionDrawText: TAction;
    ActionChangeFontName: TAction;
    ActionChangeFontColor: TAction;
    ActionChangeFontSize: TAction;
    ActionChangeFontBold: TAction;
    ActionZoomIn: TAction;
    ActionZoomOut: TAction;
    ActionUndo: TAction;
    ActionRedo: TAction;
    ActionZoomDefault: TAction;
    ImageList32: TImageList;
    ImageList16: TImageList;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    GroupBox3: TGroupBox;
    Panel4: TPanel;
    GroupBox4: TGroupBox;
    Panel5: TPanel;
    cbFontName: TComboBox;
    StatusBar: TStatusBar;
    cbFontColor: TColorBox;
    seFontSize: TSpinEdit;
    cbShapeColor: TColorBox;
    seShapeSize: TSpinEdit;
    btSaveAs: TButton;
    btCopyToClipboard: TButton;
    btSendMail: TButton;
    btSave: TButton;
    btOpenEditor: TButton;
    btPrint: TButton;
    bgShapes: TButtonGroup;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ScrollBox1: TScrollBox;
    Image: TImage;
    btBold: TButton;
    procedure ActionDrawSquareExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormMouseWheelDown(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseWheelUp(Sender: TObject; Shift: TShiftState;
      MousePos: TPoint; var Handled: Boolean);
    procedure ActionDrawRoundedSquareExecute(Sender: TObject);
    procedure ActionDrawCircleExecute(Sender: TObject);
    procedure ActionDrawLineExecute(Sender: TObject);
    procedure ActionDrawArrowExecute(Sender: TObject);
    procedure ActionDrawTextExecute(Sender: TObject);
    procedure ActionZoomInExecute(Sender: TObject);
    procedure ActionZoomOutExecute(Sender: TObject);
    procedure ActionUndoExecute(Sender: TObject);
    procedure ActionRedoExecute(Sender: TObject);
    procedure ActionZoomDefaultExecute(Sender: TObject);
    procedure ActionSaveExecute(Sender: TObject);
    procedure ActionSaveAsExecute(Sender: TObject);
    procedure ActionCopyClipboardExecute(Sender: TObject);
    procedure ActionSendMailExecute(Sender: TObject);
    procedure ActionEditorOpenExecute(Sender: TObject);
    procedure ActionPrintExecute(Sender: TObject);
    procedure ActionChangeFontBoldExecute(Sender: TObject);
    procedure StatusBarDrawPanel(StatusBar: TStatusBar;
      Panel: TStatusPanel; const Rect: TRect);
  private
    UserMenu : Integer;
    OriginalWidth : Integer;
    OriginalHeight : Integer;
    OriginalFileName : String;
    FileName : String;
    AdditionalInformation : String;

    Drawing : Boolean;
    DrawingTool : TDrawingTool;
    Origin : TPoint;
    MovePt : TPoint;
    Saved : Boolean;

    BufferUndo : TList<TBitmap>;
    BufferRedo : TList<TBitmap>;

    {$REGION ' Configuration '}
    procedure loadConfigurations;
    procedure setDefaultValues;
    procedure setShortcut;
    procedure updateCanvasConfiguration;
    procedure fillComboFontName;
    {$ENDREGION}

    {$REGION ' Draw ' }
    procedure changeShapeRectangle;
    procedure changeShapeRoundRect;
    procedure changeShapeEllipse;
    procedure changeShapeLine;
    procedure changeShapeArrow;
    procedure changeShapeText;
    procedure drawShape(TopLeft : TPoint; BottomRight : TPoint; const AMode: TPenMode);
    procedure drawArrow(TopLeft : TPoint; BottomRight : TPoint);
    procedure drawLine(TopLeft : TPoint; BottomRight : TPoint);
    procedure drawRectangle(TopLeft : TPoint; BottomRight : TPoint);
    procedure drawEllipse(TopLeft : TPoint; BottomRight : TPoint);
    procedure drawRoundRect(TopLeft : TPoint; BottomRight : TPoint);
    procedure drawText(TopLeft : TPoint; BottomRight : TPoint);
    {$ENDREGION}

    {$REGION ' Buffer ' }
    procedure undo;
    procedure redo;
    procedure addBuffer(var Buffer : TList<TBitmap>);
    procedure changeBuffer(var BufferSource : TList<TBitmap>; var BufferBackup : TList<TBitmap>);
    procedure deleteBuffer(var Buffer : TList<TBitmap>; const index : Integer);
    procedure clearBuffer(var Buffer : TList<TBitmap>);
    {$ENDREGION}

    {$REGION ' File '}
    function saveTempFile : String;
    function saveImage(const SaveAs : Boolean) : boolean;
    procedure saveImageAs;
    procedure copyToClipboard;
    procedure print;
    procedure sendMail;
    procedure openDefaultEditor;
    {$ENDREGION}

    {$REGION ' Zoom ' }
    procedure setCanvasZoom(const increment : Boolean);
    procedure setZoomIn;
    procedure setZoomOut;
    procedure setZoom;
    procedure calcZoomFactor(var Point : TPoint);
    procedure refreshCoordinates(x : integer; y : integer);
    procedure setZoomDefault;
    {$ENDREGION}

    {$REGION ' Forms ' }
    procedure changeShape(Draw : TDrawingTool);
    procedure changeShapeColor;
    procedure changeShapeSize;
    procedure changeFont;
    procedure changeFontColor;
    procedure changeFontSize;
    procedure changeBold;
    procedure changeBrushColor;
    procedure toggleBold;
    {$ENDREGION}

    {$REGION ' Others ' }
    function getExeDateTime : String;
    procedure setStatusSaved(const Saved : Boolean);
    {$ENDREGION}

  public
    constructor createForm(AOwner: TComponent; Bitmap : TBitmap; UserMenu : Integer);
  published
    procedure imageMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure imageMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imageMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
  end;

resourcestring

  STR_ATENTION          = 'Atention';
  STR_COPY_CLIPBOARD    = 'Image copied to the clipboard.';
  STR_INFORM_TEXT       = 'Enter text';
  STR_TEMP_PATH         = 'Error while trying to get windows temporary folder : %s';
  STR_ERROR_OPEN_MAIL   = 'Could not open email client.';
  STR_NOT_SAVED         = 'Your changes have not been saved, do you want to save them before you quit?';
  STR_NAME              = 'Name: ';
  STR_STATUS_NOT_SAVED  = 'Not Saved';
  STR_STATUS_SAVED      = 'Saved';
  STR_FILE_EXIST_SAVE   = 'File %s already exists, do you want to overwrite?';

  {$REGION ' Mail ' }
  STR_EMAIL_SEND_ERROR  = 'Error trying to open Outlook : %s';
  STR_EMAIL_SUBJECT     = 'APP - Print';

  STR_EXCEPTION_OPEN_MAIL = 'An exception occurred while attempting to open the mail client: %s';
  STR_SENT_MAIL_MSG_00 = 'Success';
  STR_SENT_MAIL_MSG_01 = 'User Abort';
  STR_SENT_MAIL_MSG_02 = 'Failure';
  STR_SENT_MAIL_MSG_03 = 'Login Failure';
  STR_SENT_MAIL_MSG_04 = 'Disk Full';
  STR_SENT_MAIL_MSG_05 = 'Insufficient Memory';
  STR_SENT_MAIL_MSG_06 = 'Blk Too Small';
  STR_SENT_MAIL_MSG_07 = '';
  STR_SENT_MAIL_MSG_08 = 'Too Many Sessions';
  STR_SENT_MAIL_MSG_09 = 'Too Many Files';
  STR_SENT_MAIL_MSG_10 = 'Too Many Recipients';
  STR_SENT_MAIL_MSG_11 = 'Attachment Not Found';
  STR_SENT_MAIL_MSG_12 = 'Attachment Open Failure';
  STR_SENT_MAIL_MSG_13 = 'Attachment Write Failure';
  STR_SENT_MAIL_MSG_14 = 'Unknown Recipientv';
  STR_SENT_MAIL_MSG_15 = 'Bad Recipient type';
  STR_SENT_MAIL_MSG_16 = 'No Messages';
  STR_SENT_MAIL_MSG_17 = 'Invalid Message';
  STR_SENT_MAIL_MSG_18 = 'Bodytext Too Large';
  STR_SENT_MAIL_MSG_19 = 'Invalid Session';
  STR_SENT_MAIL_MSG_20 = 'Type Not Supported';
  STR_SENT_MAIL_MSG_21 = 'Ambiguous Recipient';
  STR_SENT_MAIL_MSG_22 = 'Message in use';
  STR_SENT_MAIL_MSG_23 = 'Network failure';
  STR_SENT_MAIL_MSG_24 = 'Invalid edit fields';
  STR_SENT_MAIL_MSG_25 = 'Invalid recipients';
  STR_SENT_MAIL_MSG_26 = 'Feature not support';
  {$ENDREGION}

const

  CNT_FILE_EXT          = '.bmp';

  CNT_TAHOMA            = 'Tahoma';
  CNT_FILE_NAME         = 'USER_%d_MENU_%d' + CNT_FILE_EXT;
  CNT_APP               = 'APP';
  CNT_SIZE              = '%d X %d';
  CNT_COORDINATES       = 'X %d - Y %d';

  CNT_PRINT             = 'print';

  CNT_MAPI_SEND_MAIL    = 'MAPISendMail';

  CNT_DATE_FORMAT       = 'dd/mm/yyyy';
  CNT_TIME_FORMAT       = 'hh:nn:ss';

  {$REGION ' Zoom '}
  CNT_ZOOM_DEFAULT      = 100;
  CNT_ZOOM_MAX          = 200;
  CNT_ZOOM_MIN          = 50;
  CNT_ZOOM_INCREMENT    = 10;
  {$ENDREGION}

  CNT_MAX_UNDO_REDO     = 10;

  CNT_FORM_SIZE_DEFAULT = 2;
  CNT_FONT_SIZE_DEFAULT = 22;

  {$REGION ' Status Bar '}
  CNT_SB_SIZE           = 0;
  CNT_SB_COORDINATES    = 1;
  CNT_SB_ZOOM           = 2;
  CNT_SB_EMPTY          = 3;
  CNT_SB_STATUS_SAVE    = 4;
  {$ENDREGION}

  {$REGION ' Mail ' }
  STR_SENT_MAIL_MSG : array[0..26] of String = (STR_SENT_MAIL_MSG_00, STR_SENT_MAIL_MSG_01, STR_SENT_MAIL_MSG_02, STR_SENT_MAIL_MSG_03, STR_SENT_MAIL_MSG_04
                                               ,STR_SENT_MAIL_MSG_05, STR_SENT_MAIL_MSG_06, STR_SENT_MAIL_MSG_07, STR_SENT_MAIL_MSG_08, STR_SENT_MAIL_MSG_09
                                               ,STR_SENT_MAIL_MSG_10, STR_SENT_MAIL_MSG_11, STR_SENT_MAIL_MSG_12, STR_SENT_MAIL_MSG_13, STR_SENT_MAIL_MSG_14
                                               ,STR_SENT_MAIL_MSG_15, STR_SENT_MAIL_MSG_16, STR_SENT_MAIL_MSG_17, STR_SENT_MAIL_MSG_18, STR_SENT_MAIL_MSG_19
                                               ,STR_SENT_MAIL_MSG_20, STR_SENT_MAIL_MSG_21, STR_SENT_MAIL_MSG_22, STR_SENT_MAIL_MSG_23, STR_SENT_MAIL_MSG_24
                                               ,STR_SENT_MAIL_MSG_25, STR_SENT_MAIL_MSG_26
                                               );
  {$ENDREGION}

implementation

uses Clipbrd
   , ShellApi
   , Menus
   , Math
   , Mapi
   , AnsiStrings
   , Types
   ;

{$R *.dfm}

procedure screenShotter_Capture(Form : TForm; Const AdditionalInformation : String = '');
var FrmScreenShotter : TFrmScreenShotter;
    CanvasImg : TCanvas;
    Bitmap : TBitMap;
begin
  Bitmap := TBitMap.Create;
  Bitmap.Height := Form.Height;
  Bitmap.Width := Form.Width;
  CanvasImg := TCanvas.Create;
  CanvasImg.Handle := GetWindowDC(0);
  Bitmap.Canvas.CopyRect(Rect(0, 0, Form.Width, Form.Height)
                        ,canvasImg
                        ,Rect(Form.Left, Form.Top, Form.Width + Form.Left, Form.Height + Form.Top)
                        );

  FrmScreenShotter := TFrmScreenShotter.createForm(Nil, Bitmap, 0);

  FrmScreenShotter.AdditionalInformation := AdditionalInformation;
  FrmScreenShotter.WindowState := wsMaximized;
  FrmScreenShotter.ShowModal;
  FreeAndNil(FrmScreenShotter);
  FreeAndNil(Bitmap);
end;

procedure TFrmScreenShotter.ActionChangeFontBoldExecute(Sender: TObject);
begin
  toggleBold;
end;

procedure TFrmScreenShotter.ActionCopyClipboardExecute(Sender: TObject);
begin
  copyToClipboard;
end;

procedure TFrmScreenShotter.ActionDrawArrowExecute(Sender: TObject);
begin
  changeShapeArrow;
end;

procedure TFrmScreenShotter.ActionDrawCircleExecute(Sender: TObject);
begin
  changeShapeEllipse;
end;

procedure TFrmScreenShotter.ActionDrawRoundedSquareExecute(
  Sender: TObject);
begin
  changeShapeRoundRect
end;

procedure TFrmScreenShotter.ActionDrawLineExecute(Sender: TObject);
begin
  changeShapeLine;
end;

procedure TFrmScreenShotter.ActionDrawSquareExecute(Sender: TObject);
begin
  changeShapeRectangle;
end;

procedure TFrmScreenShotter.ActionDrawTextExecute(Sender: TObject);
begin
  changeShapeText;
end;

procedure TFrmScreenShotter.ActionEditorOpenExecute(Sender: TObject);
begin
  openDefaultEditor;
end;

procedure TFrmScreenShotter.ActionPrintExecute(Sender: TObject);
begin
  print;
end;

procedure TFrmScreenShotter.ActionRedoExecute(Sender: TObject);
begin
  redo;
end;

procedure TFrmScreenShotter.ActionSaveAsExecute(Sender: TObject);
begin
  saveImageAs;
end;

procedure TFrmScreenShotter.ActionSaveExecute(Sender: TObject);
begin
  saveImage(False);
end;

procedure TFrmScreenShotter.ActionSendMailExecute(Sender: TObject);
begin
  sendMail;
end;

procedure TFrmScreenShotter.ActionUndoExecute(Sender: TObject);
begin
  undo;
end;

procedure TFrmScreenShotter.ActionZoomDefaultExecute(Sender: TObject);
begin
  setZoomDefault;
end;

procedure TFrmScreenShotter.ActionZoomInExecute(Sender: TObject);
begin
  setZoomIn;
end;

procedure TFrmScreenShotter.ActionZoomOutExecute(Sender: TObject);
begin
  setZoomOut;
end;

procedure TFrmScreenShotter.addBuffer(var Buffer: TList<TBitmap>);
var Bitmap : TBitmap;
begin
  if   Buffer.Count = CNT_MAX_UNDO_REDO then
       deleteBuffer(Buffer, 0);

  Bitmap := TBitmap.Create;
  Bitmap.Assign(Image.Picture.Bitmap);
  Buffer.Add(Bitmap);
end;

procedure TFrmScreenShotter.calcZoomFactor(var Point: TPoint);
begin
  if   OriginalWidth <> Image.width then
       begin
         Point.X := Trunc( Point.X * OriginalWidth / Image.Width );
         Point.Y := Trunc( Point.Y * OriginalWidth / Image.Width );
       end;
end;

procedure TFrmScreenShotter.changeBold;
begin
  if btBold.Tag = 0 then
     Image.Canvas.Font.Style := []
  else
     Image.Canvas.Font.Style := [fsBold];
end;

procedure TFrmScreenShotter.toggleBold;
begin
  btBold.Tag := IfThen(btBold.Tag = 0, 1, 0);
  btBold.ImageIndex := btBold.Tag;
  changeBold;
end;

procedure TFrmScreenShotter.changeBrushColor;
begin
  case DrawingTool of
   dtArrow : Image.Canvas.Brush.Color := cbShapeColor.Selected;
   dtText  : Image.Canvas.Brush.Color := IfThen(cbShapeColor.Selected = Image.Canvas.Font.Color, clWhite, cbShapeColor.Selected);
  else
    Image.Canvas.Brush.Style := bsClear;
  end;
end;

procedure TFrmScreenShotter.changeBuffer(var BufferSource,
  BufferBackup: TList<TBitmap>);
begin
  if   BufferSource.Count > 0 then
       begin
         setStatusSaved(False);
         addBuffer(BufferBackup);
         Image.Picture.Bitmap.Assign(BufferSource[Pred(BufferSource.Count)]);
         deleteBuffer(BufferSource, Pred(BufferSource.Count));
       end;
end;

procedure TFrmScreenShotter.changeFont;
begin
  Image.Canvas.Font.Name := cbFontName.Text;
end;

procedure TFrmScreenShotter.changeFontColor;
begin
  Image.Canvas.Font.Color := cbFontColor.Selected;
end;

procedure TFrmScreenShotter.changeFontSize;
begin
  Image.Canvas.Font.Size := Trunc(seFontSize.Value);
end;

procedure TFrmScreenShotter.changeShape(Draw: TDrawingTool);
begin
  DrawingTool := Draw;

  Image.Cursor := IfThen(DrawingTool = dtText, crIBeam, crCross);
end;

procedure TFrmScreenShotter.changeShapeArrow;
begin
  changeShape(dtArrow);
end;

procedure TFrmScreenShotter.changeShapeColor;
begin
  Image.Canvas.Pen.Color := cbShapeColor.Selected;
end;

procedure TFrmScreenShotter.changeShapeEllipse;
begin
  changeShape(dtEllipse);
end;

procedure TFrmScreenShotter.changeShapeLine;
begin
  changeShape(dtLine);
end;

procedure TFrmScreenShotter.changeShapeRectangle;
begin
  changeShape(dtRectangle);
end;

procedure TFrmScreenShotter.changeShapeRoundRect;
begin
  changeShape(dtRoundRect);
end;

procedure TFrmScreenShotter.changeShapeSize;
begin
  Image.Canvas.Pen.Width := Trunc(seShapeSize.Value);
end;

procedure TFrmScreenShotter.changeShapeText;
begin
  changeShape(dtText);
end;

procedure TFrmScreenShotter.clearBuffer(var Buffer: TList<TBitmap>);
begin
  while Buffer.Count > 0 do
    deleteBuffer(Buffer, Pred(Buffer.Count));

  Buffer.Clear;
end;

procedure TFrmScreenShotter.copyToClipboard;
begin
  Clipboard.Assign(Image.Picture);
  Application.MessageBox(PChar(STR_COPY_CLIPBOARD), PChar(STR_ATENTION), MB_OK);
end;

constructor TFrmScreenShotter.createForm(AOwner: TComponent; Bitmap: TBitmap; UserMenu: Integer);
begin
  inherited create(AOwner);

  OriginalWidth := Bitmap.Width;
  OriginalHeight := Bitmap.Height;

  Image.Width := Bitmap.Width;
  Image.Height := Bitmap.Height;
  Image.Picture.Bitmap.Assign(Bitmap);
end;

procedure TFrmScreenShotter.deleteBuffer(var Buffer: TList<TBitmap>;
  const index: Integer);
begin
  TBitmap(Buffer[index]).Free;
  Buffer.Delete(index);
end;

procedure TFrmScreenShotter.drawArrow(TopLeft, BottomRight: TPoint);
var xBase : Integer;
    xDelta : Integer;
    yBase : Integer;
    yDelta : Integer;
begin
  drawLine(TopLeft, BottomRight);

  xBase := TopLeft.X + MulDiv(BottomRight.X - TopLeft.X, 9, 10);  // 90% from (TopLeft.X, TopLeft.Y) to (BottomRight.X, BottomRight.Y)
  yBase := TopLeft.Y + MulDiv(BottomRight.Y - TopLeft.Y, 9, 10);

  xDelta := BottomRight.X - xBase;
  yDelta := BottomRight.Y - yBase;

  // base of arrow tip is perpendicular to original vector.  A normal vector
  // to the original line can be found by swapping the delta X and delta Y
  // components and negating one of them.

  // Draw the arrow tip
  Image.Canvas.Polygon([BottomRight
                       ,Point(xBase + yDelta, yBase - xDelta)
                       ,Point(xBase - yDelta, yBase + xDelta)
                       ]);
end;

procedure TFrmScreenShotter.drawEllipse(TopLeft, BottomRight: TPoint);
begin
  Image.Canvas.Ellipse(Topleft.X, TopLeft.Y, BottomRight.X, BottomRight.Y);
end;

procedure TFrmScreenShotter.drawLine(TopLeft, BottomRight: TPoint);
begin
  Image.Canvas.MoveTo(TopLeft.X, TopLeft.Y);
  Image.Canvas.LineTo(BottomRight.X, BottomRight.Y);
end;

procedure TFrmScreenShotter.drawRectangle(TopLeft, BottomRight: TPoint);
begin
  Image.Canvas.Rectangle(TopLeft.X, TopLeft.Y, BottomRight.X, BottomRight.Y);
end;

procedure TFrmScreenShotter.drawRoundRect(TopLeft, BottomRight: TPoint);
begin
  Image.Canvas.RoundRect(TopLeft.X, TopLeft.Y, BottomRight.X, BottomRight.Y, (TopLeft.X - BottomRight.X) div 2, (TopLeft.Y - BottomRight.Y) div 2);
end;

procedure TFrmScreenShotter.drawShape(TopLeft, BottomRight: TPoint;
  const AMode: TPenMode);
begin
  Image.Canvas.Pen.Mode := AMode;

  if   Image.Tag <> CNT_ZOOM_DEFAULT then
       calcZoomFactor(BottomRight);

  updateCanvasConfiguration;

  case DrawingTool of
    dtLine : drawLine(TopLeft, BottomRight);
    dtRectangle : drawRectangle(TopLeft, BottomRight);
    dtEllipse : drawEllipse(TopLeft, BottomRight);
    dtRoundRect : drawRoundRect(TopLeft, BottomRight);
    dtText : drawText(TopLeft, BottomRight);
    dtArrow : drawArrow(TopLeft, BottomRight);
  end;
end;

procedure TFrmScreenShotter.drawText(TopLeft, BottomRight: TPoint);
var text       : String;
    lineSize   : Integer;
begin
  lineSize := 0;
  InputQuery(STR_INFORM_TEXT, EmptyStr, text);

  if   trim(text) <> EmptyStr then
       begin
         lineSize := IfThen(Image.Canvas.Pen.Width < 3, lineSize, Image.Canvas.Pen.Width);
         drawRectangle(Point(TopLeft.X - lineSize
                            ,TopLeft.Y - lineSize
                            )
                      ,Point(TopLeft.X + Image.Canvas.TextWidth(text) + lineSize
                            ,TopLeft.Y + Image.Canvas.TextHeight(text) + lineSize
                            )
                      );

         Image.Canvas.TextOut(TopLeft.X, TopLeft.y, text);
       end;
end;

procedure TFrmScreenShotter.fillComboFontName;
begin
  cbFontName.Clear;
  cbFontName.Items.AddStrings(Screen.Fonts);
  cbFontName.Text := CNT_TAHOMA;
end;

procedure TFrmScreenShotter.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if   Not Saved then
       begin
         case Application.MessageBox(PChar(STR_NOT_SAVED), PChar(STR_ATENTION), MB_YESNOCANCEL or MB_ICONQUESTION or MB_DEFBUTTON3) of
           mrYes : begin
                     if   saveImage(True) then
                          Action := caFree
                     else
                          Action := caNone;
                   end;
           mrNo : Action := caFree;
           mrCancel : Action := caNone;
         end;
       end
  else
       Action := caFree;
end;

procedure TFrmScreenShotter.FormCreate(Sender: TObject);
begin
  BufferUndo := TList<TBitmap>.Create;
  BufferRedo := TList<TBitmap>.Create;
end;

procedure TFrmScreenShotter.FormDestroy(Sender: TObject);
begin
  clearBuffer(BufferUndo);
  clearBuffer(BufferRedo);

  FreeAndNil(BufferUndo);
  FreeAndNil(BufferRedo);
end;

procedure TFrmScreenShotter.FormMouseWheelDown(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if   ssCtrl in Shift then
       setCanvasZoom(False);
end;

procedure TFrmScreenShotter.FormMouseWheelUp(Sender: TObject;
  Shift: TShiftState; MousePos: TPoint; var Handled: Boolean);
begin
  if   ssCtrl in Shift then
       setCanvasZoom(True);
end;

procedure TFrmScreenShotter.FormShow(Sender: TObject);
begin
  loadConfigurations;
end;

function TFrmScreenShotter.getExeDateTime: String;
var lDateTime: TDateTime;
begin
  FileAge(Application.ExeName, lDateTime);

  Result :=  FormatDateTime(CNT_DATE_FORMAT, lDateTime) + ' ' +
             FormatDateTime(CNT_TIME_FORMAT, lDateTime);
end;

procedure TFrmScreenShotter.imageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Drawing := True;
  setStatusSaved(False);

  Origin := Point(X, Y);
  calcZoomFactor(Origin);
  Image.Canvas.MoveTo(X, Y);
  MovePt := Point(X, Y);
  addBuffer(BufferUndo);
end;

procedure TFrmScreenShotter.imageMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
  if   Drawing then
       begin
         if   DrawingTool <> dtText then
              drawShape(Origin, MovePt, pmNotXor);

         MovePt := Point(X, Y);

         if   DrawingTool <> dtText then
              drawShape(Origin, MovePt, pmNotXor);
       end;

  refreshCoordinates(x, y);
end;

procedure TFrmScreenShotter.imageMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if   Drawing then
       begin
         drawShape(Origin, Point(X, Y), pmCopy);
         Drawing := False;
         clearBuffer(BufferRedo);
       end;
end;

procedure TFrmScreenShotter.loadConfigurations;
begin
  setDefaultValues;
  setShortcut;
end;

procedure TFrmScreenShotter.openDefaultEditor;
begin
  ShellExecute(Handle, nil, PChar(saveTempFile), nil, nil, SW_SHOWNORMAL)
end;

procedure TFrmScreenShotter.print;
begin
  ShellExecute(handle, CNT_PRINT, PWideChar(saveTempFile), '', '', SW_SHOWNORMAL);
end;

procedure TFrmScreenShotter.redo;
begin
  changeBuffer(BufferRedo, BufferUndo);
end;

procedure TFrmScreenShotter.refreshCoordinates(x, y: integer);
begin
  StatusBar.Panels[CNT_SB_COORDINATES].Text := Format(CNT_COORDINATES, [x, y]);
end;

function TFrmScreenShotter.saveImage(const SaveAs: Boolean): boolean;
var extName : String;
    fileExist : Boolean;

    {$Region ' Check File '}
    function checkFile : boolean;
    begin
      Result := True;

      if   FileExist then
           begin
             if   SaveAs
             or   Not Saved then
                  Result := Application.MessageBox(PChar(Format(STR_FILE_EXIST_SAVE, [FileName])), PChar(STR_ATENTION), MB_YESNO or MB_ICONQUESTION or MB_DEFBUTTON2) = mrYes;
           end;
    end;
    {$EndRegion}

begin
  Result := False;

  {$Region ' Get File Name ' }
  if   SaveAs
  or   (Trim(FileName) = EmptyStr) then
       begin
         if   SaveDialog.Execute then
              FileName := SaveDialog.FileName
         else
              Exit;
       end;
  {$EndRegion}

  {$REGION ' Verify File Ext ' }
  extName := ExtractFileExt(FileName);

  if   extName = EmptyStr then
       FileName := SaveDialog.FileName + CNT_FILE_EXT
  else
       if   extName <> CNT_FILE_EXT then
            begin
              Delete(FileName, pos(extName, FileName), Length(extName));
              FileName := FileName + CNT_FILE_EXT;
            end;

  SaveDialog.FileName := FileName;
  {$EndRegion}

  fileExist := FileExists(FileName);

  if   Not FileExist
  or   checkFile then
       begin
         Image.Picture.SaveToFile(FileName);
         setStatusSaved(True);
         Result := True;
       end
  else
       FileName := EmptyStr;
end;

procedure TFrmScreenShotter.saveImageAs;
begin
  saveImage(True);
end;

function TFrmScreenShotter.saveTempFile: String;
var TempFile : array[0..MAX_PATH - 1] of Char;
    TempPath : array[0..MAX_PATH - 1] of Char;
begin
  GetTempPath(MAX_PATH, TempPath);
  if   GetTempFileName(TempPath, PChar(CNT_APP), 0, TempFile) = 0 then
       raise Exception.CreateFmt(STR_TEMP_PATH, [SysErrorMessage(GetLastError)]);

  result := TempFile + String('_') + OriginalFileName;
  RenameFile(TempFile, result);
  Image.Picture.SaveToFile(result);
end;

procedure TFrmScreenShotter.sendMail;
var MapiMessage : TMapiMessage;
    MapiFileAttach : TMapiFileDesc;
    MapiSendMail : TFNMapiSendMail;
    MAPIModule : HModule;
    EmailSentCode : Integer;
begin
  FillChar(MapiMessage, SizeOf(MapiMessage), 0);

  MapiMessage.lpszSubject := AnsiStrings.StrNew(PAnsiChar(AnsiString(STR_EMAIL_SUBJECT)));
  MapiMessage.lpszNoteText := AnsiStrings.StrNew(PAnsiChar(AnsiString(AdditionalInformation)));

  {$REGION ' File Atach '}
  MapiMessage.lpRecips := nil;
  FillChar(MapiFileAttach, SizeOf(MapiFileAttach), 0);
  MapiFileAttach.nPosition := Cardinal($FFFFFFFF);
  MapiFileAttach.lpszPathName := AnsiStrings.StrNew(PAnsiChar(AnsiString(saveTempFile)));
  MapiMessage.nFileCount := 1;
  MapiMessage.lpFiles := @MapiFileAttach;
  {$EndRegion}

  MAPIModule := LoadLibrary(PChar(MAPIDLL));

  if   MAPIModule <> 0 then
       begin
         try
           @MapiSendMail := GetProcAddress(MAPIModule, CNT_MAPI_SEND_MAIL);

           if   @MapiSendMail <> nil then
                begin
                  EmailSentCode := MapiSendMail(0, Application.Handle, MapiMessage, MAPI_DIALOG or MAPI_LOGON_UI, 1);
                  if   EmailSentCode > 1 then
                       raise Exception.CreateFmt(STR_EXCEPTION_OPEN_MAIL, [STR_SENT_MAIL_MSG[EmailSentCode]]);
                end
           else
                raise Exception.Create(STR_ERROR_OPEN_MAIL);
         finally
           FreeLibrary(MAPIModule);
         end;
       end
  else
       raise Exception.Create(STR_ERROR_OPEN_MAIL);
end;

procedure TFrmScreenShotter.setCanvasZoom(const increment: Boolean);
begin
  Image.Tag := EnsureRange(Image.Tag + (CNT_ZOOM_INCREMENT * IfThen(increment, 1, -1)), CNT_ZOOM_MIN, CNT_ZOOM_MAX);
  setZoom;
end;

procedure TFrmScreenShotter.setDefaultValues;
begin
  setStatusSaved(false);

  FileName := EmptyStr;

  SaveDialog.Filter := CNT_FILE_EXT;
  SaveDialog.FileName := OriginalFileName;

  StatusBar.Panels[CNT_SB_SIZE].Width := 85;
  StatusBar.Panels[CNT_SB_COORDINATES].Width := 100;
  StatusBar.Panels[CNT_SB_ZOOM].Width := 55;
//  StatusBar.Panels[CNT_SB_STATUS_SAVE].Width := 16;

  DrawingTool := dtRectangle;

  bgShapes.ItemIndex := Byte(dtRectangle);

  cbShapeColor.Selected := clRed;
  seShapeSize.Value := CNT_FORM_SIZE_DEFAULT;

  fillComboFontName;
  cbFontColor.Selected := clRed;
  seFontSize.Value := CNT_FONT_SIZE_DEFAULT;

  changeShape(dtRectangle);

  updateCanvasConfiguration;

  Image.Tag := CNT_ZOOM_DEFAULT;
  setZoom;

  StatusBar.Panels[CNT_SB_SIZE].Text := Format(CNT_SIZE, [Image.Width, Image.Height]);
end;

procedure TFrmScreenShotter.setZoomDefault;
begin
  Image.Tag := CNT_ZOOM_DEFAULT;
  setZoom;
end;

procedure TFrmScreenShotter.setShortcut;
begin
  ActionZoomIn.ShortCut := Menus.ShortCut(VK_ADD, [ssCtrl]);
  ActionZoomOut.ShortCut := Menus.ShortCut(VK_SUBTRACT, [ssCtrl]);
end;

procedure TFrmScreenShotter.setStatusSaved(const Saved: Boolean);
begin
  self.Saved := Saved;
end;

procedure TFrmScreenShotter.setZoom;
begin
  if   Image.Tag = 100 then
       begin
         Image.Stretch := False;
         Image.Width := OriginalWidth;
         Image.Height := OriginalHeight;
       end
  else
       begin
         Image.Stretch := True;

         Image.Width := OriginalWidth + Round(OriginalWidth / 100 * (Image.Tag - 100));
         Image.Height := OriginalHeight + Round(OriginalHeight / 100 * (Image.Tag - 100));
       end;

  StatusBar.Panels[CNT_SB_ZOOM].Text := IntToStr(Image.Tag) + '%';
end;

procedure TFrmScreenShotter.setZoomIn;
begin
  setCanvasZoom(True);
end;

procedure TFrmScreenShotter.setZoomOut;
begin
  setCanvasZoom(False);
end;

procedure TFrmScreenShotter.undo;
begin
  changeBuffer(BufferUndo, BufferRedo);
end;

procedure TFrmScreenShotter.updateCanvasConfiguration;
begin
  changeBrushColor;
  changeShapeColor;
  changeShapeSize;
  changeBold;
  changeFont;
  changeFontColor;
  changeFontSize;
end;

procedure TFrmScreenShotter.StatusBarDrawPanel(StatusBar: TStatusBar;
  Panel: TStatusPanel; const Rect: TRect);
begin
  StatusBar.Canvas.Brush.Color := clRed;
  StatusBar.Canvas.FillRect(Rect);
  StatusBar.Canvas.Font.color := clRed;
  ImageList16.Draw(StatusBar.Canvas, Rect.Left, Rect.Top, 0);
  TextOut(Handle, Rect.Left + 30, Rect.Top + 2, PChar('panel' + IntToStr(Panel.Index)), 0);
end;

end.
