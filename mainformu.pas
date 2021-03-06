unit MainFormU;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, Buttons,
  ComCtrls, Process, AsyncProcess, ExtCtrls, Menus, ActnList, SynEdit, SynEditTypes,
  SynEditKeyCmds, SynPluginSyncroEdit, SynEditHighlighter,
  SynPluginMulticaret, SynExportHTML,
  SynCompletion, FileUtil, LazFileUtils,
  dateutils, ListViewFilterEdit, BGRABitmap, BGRABitmapTypes,
  BGRASpriteAnimation, strutils, LazUTF8, Math, Clipbrd, IniPropStorage,
  StdActns, uebutton, uETilePanel, uEImage, versionsupportu, types, lclintf,
  LCLType, HistoryFiles, attabs, IniFiles, EditorU, FilesMonitorU, DataSheetU;

type
  tProcessStatus=(Idle,TimeOut,SyntaxChk,exePlugIn);

  { TMainForm }

  TMainForm = class(TForm)
    MI_FindInstance: TMenuItem;
    ProjectFindInstance: TAction;
    LogClear: TAction;
    LogCopy: TAction;
    MenuItem14: TMenuItem;
    MenuItem5: TMenuItem;
    PlugInBar: TPanel;
    LogPopup: TPopupMenu;
    SearchReplace: TAction;
    ReplaceDialog1: TReplaceDialog;
    SearchFindNext: TAction;
    FindDialog1: TFindDialog;
    SearchFind: TAction;
    MiniMap: TEditor;
    PrgPage: TPanel;
    SplitEd: TEditor;
    SplitterEd : TSplitter;
    EditSplitVertical: TAction;
    EditSplitHorizontal: TAction;
    EditShowMiniMap: TAction;
    ActivePanel:TPanel;
    AnnouncementImage: TBGRASpriteAnimation;
    AnnouncementPanel: TPanel;
    btn_config: TuEButton;
    btn_new_project: TuEButton;
    btn_open_project: TuEButton;
    btn_prj_editor: TuEButton;
    btn_prj_prgeditor: TuEButton;
    btn_sba_forum: TuEButton;
    btn_sba_library: TuEButton;
    btn_sba_website: TuEButton;
    EditorTabs: TATTabs;
    CoreImagePanel: TuEImage;
    header_bg: TImage;
    header_text: TImage;
    HelpOpenHelp: TAction;
    LogoImage: TImage;
    MainPanel: TuETilePanel;
    MenuItem16: TMenuItem;
    MenuItem91: TMenuItem;
    MenuItem92: TMenuItem;
    MenuItem93: TMenuItem;
    MenuItem94: TMenuItem;
    EditorPages: TPanel;
    EditorsPanel: TPanel;
    PrgTemplateButton: TToolButton;
    ProgEditPanel: TPanel;
    Shape1: TShape;
    Spl_Prog: TSplitter;
    SystemPanel: TPanel;
    ProgToolBar: TToolBar;
    SyncMiniMap: TTimer;
    ToolButton13: TToolButton;
    TB_SBAReturnToEditor: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton28: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton40: TToolButton;
    ToolButton43: TToolButton;
    ToolButton46: TToolButton;
    ToolButton47: TToolButton;
    ToolButton50: TToolButton;
    ToolButton52: TToolButton;
    ToolButton53: TToolButton;
    ToolButton61: TToolButton;
    TBMiniMap: TToolButton;
    TBSplitHorizontal: TToolButton;
    TBSplitVertical: TToolButton;
    ToolButton62: TToolButton;
    ToolButton63: TToolButton;
    ToolButton64: TToolButton;
    ToolsReloadPlugIns: TAction;
    EditCopyAsHtml: TAction;
    MenuItem10: TMenuItem;
    MenuItem4: TMenuItem;
    SynExporterHTML: TSynExporterHTML;
    SyncroEdit: TSynPluginSyncroEdit;
    SynMultiCaret:TSynPluginMulticaret;
    SynAutoComplete: TSynAutoComplete;
    ToolsExporttoHtml: TAction;
    PlugInsMenu: TMenuItem;
    ProjectItemDataSheet: TAction;
    B_InsertSnipped: TBitBtn;
    B_SBAAdress: TBitBtn;
    B_SBALabels: TBitBtn;
    FileOpenLoc: TAction;
    FileSaveAll: TAction;
    EditInsertAuthor: TAction;
    HelpSettings: TAction;
    HelpCheckUpdate: TAction;
    HelpGotoSBAWebsite: TAction;
    HelpGotoSBAForum: TAction;
    HelpAbout: TAction;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    LV_Snippets: TListView;
    L_PrjInfo: TLabel;
    L_SBAAddress: TListView;
    L_SBALabels: TListView;
    MI_OpenDataSheet: TMenuItem;
    MenuItem71: TMenuItem;
    MenuItem72: TMenuItem;
    MenuItem73: TMenuItem;
    MenuItem74: TMenuItem;
    MenuItem75: TMenuItem;
    MenuItem76: TMenuItem;
    MenuItem77: TMenuItem;
    MenuItem78: TMenuItem;
    MenuItem80: TMenuItem;
    MenuItem81: TMenuItem;
    MenuItem82: TMenuItem;
    MenuItem83: TMenuItem;
    MenuItem85: TMenuItem;
    MenuItem86: TMenuItem;
    MenuItem87: TMenuItem;
    MenuItem88: TMenuItem;
    MenuItem89: TMenuItem;
    MenuItem90: TMenuItem;
    PrjTree: TTreeView;
    P_CodeSnippets: TPanel;
    P_ProgAddress: TPanel;
    P_ProgLabels: TPanel;
    SnippetDescription: TMemo;
    SnippetsFilter: TListViewFilterEdit;
    Splitter3: TSplitter;
    TabOpenLoc: TMenuItem;
    MI_OpenTreeItem: TMenuItem;
    ProjectOpenItem: TAction;
    ProjectUpdCore: TAction;
    EditInsertTemplate: TAction;
    EditBlkUncomment: TAction;
    EditBlkComment: TAction;
    EditBlkUnindent: TAction;
    EditBlkIndent: TAction;
    MenuItem56: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem68: TMenuItem;
    MenuItem69: TMenuItem;
    MenuItem70: TMenuItem;
    MI_UpdCore: TMenuItem;
    ProjectsHistory: TMenuItem;
    MI_RemUserFile: TMenuItem;
    MI_AddUserFile: TMenuItem;
    MI_RemCore: TMenuItem;
    EditorPopUp: TPopupMenu;
    ProjectRemUserFile: TAction;
    ProjectAddUserFiles: TAction;
    ProjectRemCore: TAction;
    PrjTreeMenu: TPopupMenu;
    ProjectCoresAddInst: TAction;
    MenuItem29: TMenuItem;
    MenuItem55: TMenuItem;
    MI_AddInstance: TMenuItem;
    ProjectEditCoreList: TAction;
    EditInsertDate: TAction;
    EditorHistory: THistoryFiles;
    MenuItem26: TMenuItem;
    FileHistoryEd: TMenuItem;
    MI_AddCore: TMenuItem;
    MenuItem929: TMenuItem;
    MenuItem956: TMenuItem;
    MenuItem957: TMenuItem;
    MenuItem958: TMenuItem;
    MenuItem962: TMenuItem;
    MenuItem963: TMenuItem;
    M_EdPrjCores: TPopupMenu;
    ProjectMenuEd: TMenuItem;
    PrjHistory: THistoryFiles;
    MarkImages: TImageList;
    ProjectsHistory2: TMenuItem;
    SBA_InsertTemplate: TAction;
    MenuItem13: TMenuItem;
    SBA_NewPrg: TAction;
    ProjectExport: TAction;
    ProjectClose: TAction;
    ProjectSave: TAction;
    MenuItem12: TMenuItem;
    MainGotoPrg: TAction;
    Log: TListBox;
    EdTabMenu: TPopupMenu;
    TabFileNew: TMenuItem;
    TabFileClose: TMenuItem;
    P_Project: TPanel;
    P_Editors: TPanel;
    MenuItem36: TMenuItem;
    MainGotoEditor: TAction;
    ProjectNew: TAction;
    ProjectOpen: TAction;
    MainMenu: TMainMenu;
    MenuItem33: TMenuItem;
    MenuItem34: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem79: TMenuItem;
    ProgMenu: TMainMenu;
    MenuItem32: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    MenuItem49: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem59: TMenuItem;
    Spl_Project: TSplitter;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    EndProcTimer: TTimer;
    DeferredTimer: TTimer;
    PrjToolBar: TToolBar;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton27: TToolButton;
    ToolButton33: TToolButton;
    ToolButton48: TToolButton;
    ToolButton49: TToolButton;
    ToolButton60: TToolButton;
    ToolButton8: TToolButton;
    UpdGuiTimer: TTimer;
    EdTemplateButton: TToolButton;
    ToolButton51: TToolButton;
    ToolButton54: TToolButton;
    ToolButton55: TToolButton;
    ToolButton56: TToolButton;
    ToolButton57: TToolButton;
    ToolButton58: TToolButton;
    ToolButton59: TToolButton;
    TreeImg: TImageList;
    EditRedo: TAction;
    EditCopy: TEditCopy;
    EditCut: TEditCut;
    EditPaste: TEditPaste;
    EditSelectAll: TEditSelectAll;
    EditUndo: TEditUndo;
    MenuItem18: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    SearchMenu: TMenuItem;
    MenuItem27: TMenuItem;
    MenuItem28: TMenuItem;
    HelpMenuItem: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    SBA_SaveAs: TAction;
    SBA_Open: TAction;
    SBA_Save: TAction;
    SBA_cancel: TAction;
    SBA_ReturnToEditor: TAction;
    FileSaveAs: TAction;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    P_AuxProg: TPanel;
    SBA_EditProgram: TAction;
    Splitter_ProgAddress: TSplitter;
    ToolsFileSyntaxCheck: TAction;
    FileRevert: TAction;
    FileClose: TAction;
    FileSave: TAction;
    ToolsMenu: TMenuItem;
    MenuItem17: TMenuItem;
    FileNew: TAction;
    FileOpen: TAction;
    FileExit: TFileExit;
    IniStor: TIniPropStorage;
    EditorMenu: TMainMenu;
    MenuItem11: TMenuItem;
    EditMenu: TMenuItem;
    MenuItem3: TMenuItem;
    FileMenu: TMenuItem;
    FileNewMenu: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    OpenDialog: TOpenDialog;
    ActionList: TActionList;
    ImageList: TImageList;
    MI_Addnew: TMenuItem;
    MI_Remove: TMenuItem;
    ObfRsvMenu: TPopupMenu;
    ToolProcess: TAsyncProcess;
    SaveDialog: TSaveDialog;
    Spl_Log: TSplitter;
    StatusBar1: TStatusBar;
    EditorToolBar: TToolBar;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton14: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolButton25: TToolButton;
    ToolButton26: TToolButton;
    ToolButton39: TToolButton;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    TBSearchFind: TToolButton;
    TBSearchReplace: TToolButton;
    TBEditNew: TToolButton;
    TBEditOpen: TToolButton;
    ToolButton9: TToolButton;
    procedure B_SBAAdressClick(Sender: TObject);
    procedure btn_sba_libraryClick(Sender: TObject);
    procedure B_InsertSnippedClick(Sender: TObject);
    procedure B_SBALabelsClick(Sender: TObject);
    procedure DeferredTimerTimer(Sender: TObject);
    procedure EditBlkCommentExecute(Sender: TObject);
    procedure EditBlkIndentExecute(Sender: TObject);
    procedure EditBlkUncommentExecute(Sender: TObject);
    procedure EditBlkUnindentExecute(Sender: TObject);
    procedure EditCopyAsHtmlExecute(Sender: TObject);
    procedure EditCopyExecute(Sender: TObject);
    procedure EditCutExecute(Sender: TObject);
    procedure EditInsertAuthorExecute(Sender: TObject);
    procedure EditInsertDateExecute(Sender: TObject);
    procedure EditInsertTemplateExecute(Sender: TObject);
    procedure EditorHistoryClickHistoryItem(Sender: TObject; Item: TMenuItem;
      const Filename: string);
    procedure EditorsPanelClick(Sender: TObject);
    procedure EditorTabsTabClose(Sender: TObject; ATabIndex: integer;
      var ACanClose, ACanContinue: boolean);
    procedure EditPasteExecute(Sender: TObject);
    procedure EditRedoExecute(Sender: TObject);
    procedure EditSelectAllExecute(Sender: TObject);
    procedure EditShowMiniMapExecute(Sender: TObject);
    procedure EditSplitHorizontalExecute(Sender: TObject);
    procedure EditSplitVerticalExecute(Sender: TObject);
    procedure EditUndoExecute(Sender: TObject);
    procedure FileOpenLocExecute(Sender: TObject);
    procedure FileSaveAllExecute(Sender: TObject);
    procedure FileSaveAsExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure HelpCheckUpdateExecute(Sender: TObject);
    procedure HelpGotoSBAForumExecute(Sender: TObject);
    procedure HelpGotoSBAWebsiteExecute(Sender: TObject);
    procedure HelpOpenHelpExecute(Sender: TObject);
    procedure HelpSettingsExecute(Sender: TObject);
    procedure LogClearExecute(Sender: TObject);
    procedure LogCopyExecute(Sender: TObject);
    procedure LogoImageDblClick(Sender: TObject);
    procedure L_SBALabelsClick(Sender: TObject);
    procedure L_SBALabelsDblClick(Sender: TObject);
    procedure MainPanelResize(Sender: TObject);
    procedure MiniMapMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MiniMapEnter(Sender: TObject);
    procedure MiniMapMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MiniMapMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MiniMapSpecialLineColors(Sender: TObject; Line: integer;
      var Special: boolean; var FG, BG: TColor);
    procedure PrjHistoryClickHistoryItem(Sender: TObject; Item: TMenuItem;
      const Filename: string);
    procedure PrjTreeClick(Sender: TObject);
    procedure PrjTreeContextPopup(Sender: TObject; MousePos: TPoint;
      var Handled: Boolean);
    procedure PrjTreeDblClick(Sender: TObject);
    procedure PrjTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PrjTreeMouseLeave(Sender: TObject);
    procedure PrjTreeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure EndProcTimerTimer(Sender: TObject);
    procedure PrjTreeSelectionChanged(Sender: TObject);
    procedure ProjectAddUserFilesExecute(Sender: TObject);
    procedure ProjectCoresAddInstExecute(Sender: TObject);
    procedure ProjectCloseExecute(Sender: TObject);
    procedure ProjectEditCoreListExecute(Sender: TObject);
    procedure ProjectExportExecute(Sender: TObject);
    procedure MainGotoEditorExecute(Sender: TObject);
    procedure MainGotoPrgExecute(Sender: TObject);
    procedure ProjectFindInstanceExecute(Sender: TObject);
    procedure ProjectItemDataSheetExecute(Sender: TObject);
    procedure ProjectNewExecute(Sender: TObject);
    procedure ProjectOpenExecute(Sender: TObject);
    procedure ProjectOpenItemExecute(Sender: TObject);
    procedure ProjectRemCoreExecute(Sender: TObject);
    procedure ProjectRemUserFileExecute(Sender: TObject);
    procedure ProjectSaveExecute(Sender: TObject);
    procedure ProjectsHistory2Click(Sender: TObject);
    procedure ProjectUpdCoreExecute(Sender: TObject);
    procedure ReplaceDialog1Show(Sender: TObject);
    procedure SBA_cancelExecute(Sender: TObject);
    procedure SBA_EditProgramExecute(Sender: TObject);
    procedure EditorPagesChange(Sender: TObject);
    procedure FileCloseExecute(Sender: TObject);
    procedure SBA_InsertTemplateExecute(Sender: TObject);
    procedure SBA_NewPrgExecute(Sender: TObject);
    procedure LV_SnippetsClick(Sender: TObject);
    procedure SearchFindExecute(Sender: TObject);
    procedure SearchReplaceExecute(Sender: TObject);
    procedure SyncMiniMapTimer(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure ToolsExporttoHtmlExecute(Sender: TObject);
    procedure FileRevertExecute(Sender: TObject);
    procedure FileSaveExecute(Sender: TObject);
    procedure ToolsFileSyntaxCheckExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormDropFiles(Sender: TObject; const FileNames: array of String);
    procedure HelpAboutExecute(Sender: TObject);
    procedure LogDblClick(Sender: TObject);
    procedure LogMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure SBA_OpenExecute(Sender: TObject);
    procedure SBA_ReturnToEditorExecute(Sender: TObject);
    procedure SBA_SaveAsExecute(Sender: TObject);
    procedure SBA_SaveExecute(Sender: TObject);
    procedure ToolsReloadPlugInsExecute(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure UpdGuiTimerTimer(Sender: TObject);
    procedure WordMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure WordSelectionChange(Sender: TObject);
    procedure FileNewExecute(Sender: TObject);
    procedure FileOpenExecute(Sender: TObject);
    procedure ToolProcessReadData(Sender: TObject);
    procedure ToolProcessTerminate(Sender: TObject);
    procedure EditorStatusChange(Sender: TObject; Changes: TSynStatusChanges);
  private
    FPrjVisible: boolean;
    FilesMon:TFilesMon;
    procedure AddIPCoresToTree(t: TTreeNode; cl: TStrings);
    procedure AddUserFilesToTree(const t: TTreeNode; cl:TStrings);
    procedure AsyncLoadPlugIns(Data: PtrInt);
    { private declarations }
    procedure ChangeEditorButtons(var Editor: TEditor);
    procedure Check;
    procedure CheckStartParams;
    function CloseProg: boolean;
    function CloseEditor(i:integer): boolean;
    function CloseProject: boolean;
    procedure Colorize(ini:string);
    procedure CopyPrjHistory;
    procedure EditorNameChanged(Sender: TObject);
    procedure EndCheckUpdate;
    procedure GotoSystem;
    procedure GotoProgEdit;
    procedure NewFileMenuExecute(Sender: TObject);
    procedure NewPrg;
    procedure ExporttoHtmlFile(var Editor: TEditor);
    procedure CopyAsHtml(var Editor: TEditor);
    procedure LoadPlugIns;
    function CreateTempFile(fn:string): boolean;
    procedure DetectSBAController(Editor:TEditor);
    procedure ExtractSBACnfgCnst;
    function GetActiveEditorPage: TEditor;
    function GetEditorPage(i: integer): TEditor;
    function GetEditorFile(f: string): TEditor;
    procedure GetFile(filename: string);
    procedure GotoEditor;
    function selectHighlighter(var Editor: TEditor): TEdType;
    procedure HighLightReservedWords(List:TStrings);
    function NewEditorPage(EdType:TEdType):TEditor;
    function Open(f: String): boolean;
    procedure OpenInEditor(const f: string);
    procedure OpenProject(const f:string);
    procedure OpenTreeItem(TN: TTreeNode);
    procedure PlugInCmd(Sender: TObject);
    procedure ReOpenEditorFiles;
    function EditorSaveAs(var Editor: TEditor): boolean;
    function  SaveFile(f:String; Src:TStrings):Boolean;
    procedure SaveOpenEditor;
    procedure SetActiveEditor;
    procedure SetPrjVisible(AValue: boolean);
    procedure SetupEditorPopupMenu;
    procedure SetupEdTmplMenu;
    procedure MiniMapSetup;
    procedure SetupTBEditOpenPopUp;
    procedure SplitEdSetup;
    procedure SplitEdMove;
    procedure SplitEdSet(FAlign: TAlign);
    procedure SetupNewEdMenu;
    procedure SetupPrgEditor;
    procedure SetupPrgTmplMenu;
    procedure MiniMapSet(X, Y: Integer);
    procedure SyntaxCheck(f,path: string; hdl: TEdType);
    procedure ExtractSBALabels;
    procedure LoadAnnouncement;
    procedure FileChanged(Sender: TObject);
    function ToolProcessWaitforIdle: boolean;
//    function IsShortCut(var Message: TLMKey): Boolean; override;
  public
    { public declarations }
    function LoadTheme(thmdir: string): boolean;
    procedure UpdatePrjTree;
    procedure CheckUpdate;
    property PrjVisible:boolean read FPrjVisible write SetPrjVisible;
  end;

var
  MainForm: TMainForm;

implementation

{$R *.lfm}

uses DebugU, SBAProgContrlrU, SBAProjectU, SBAProgramU, ConfigFormU, AboutFormU, sbasnippetu, PrjWizU,
     SBAIPCoresU, DwFileU, FloatFormU, ExportPrjFormU, AutoUpdateU, WhatsNewU,
     PlugInU;

var
  SBAContrlrProg:TSBAContrlrProg;
  SBASnippet:TSBASnippet;
  AutoUpdate:TAutoUpdate;
  fOldIndex:integer = -1;
  wdir:string;
  PrgReturn:procedure of object=nil;
  PrgEditor:TEditor;
  ProcessStatus:TProcessStatus=Idle;
  MiniMapinDrag:boolean=false;

{ TMainForm }

function TMainForm.CloseEditor(i: integer): boolean;
var
  r:integer;
  f:string;
  Editor:TEditor;
  Tab:integer;
begin
  Info('TMainForm.CloseEditor Start',i);
  result:=true;
  Editor:=GetEditorPage(i);
  if assigned(Editor) then
  begin
    // Test if editor can be closed
    if Editor.Modified then
    begin
      if ActivePanel<>EditorsPanel then GotoEditor;
      EditorTabs.TabIndex:=i;
      f:=Editor.FileName;
      r:=MessageDlg('File was modified', 'Save File? '+f, mtConfirmation, [mbYes, mbNo, mbCancel],0);
      case r of
        mrCancel: result:=false;
        mrYes: result:=SaveFile(f, Editor.Lines);
        mrNo: result:=true;
      end;
    end;
    // Free Tab and Editor if it can be closed
    if result then
    begin
      UpdGuiTimer.Enabled:=false;
      FilesMon.DelFile(Editor.FileName);
      Tab:=TATTabData(Editor.Page).Index;
      EditorTabs.DeleteTab(Tab, false, false);
      if Editor=ActEditor then ActEditor:=nil;
      FreeAndNil(Editor);
    end;
//    ForceEditorPagesChange;
  end;
  Info('TMainForm.CloseEditor End',i);
end;

function TMainForm.LoadTheme(thmdir:string):boolean;
var
  i:integer;
  b:TuEButton;
  bm:TBGRAbitmap;

begin
  result:=false;
  try
    header_bg.Picture.LoadFromFile(thmdir+'header_bg.jpg');
    MainPanel.LoadFromFile(thmdir+'background.jpg');
  except
    ON E:Exception do
    begin
      InfoErr('TMainForm.LoadTheme Error',E.Message);
      ShowMessage('There was an error loading theme in: '+thmdir);
      exit;
    end;
  end;
  for i:=0 to MainPanel.ControlCount-1 do if MainPanel.Controls[i].ClassNameIs('TuEButton') then
  begin
    b:=TuEButton(MainPanel.Controls[i]);
    b.LoadImageFromFile(thmdir+'btn_bg.png');
    if FileExists(thmdir+b.Name+'.png') then b.LoadGlyphFromFile(thmdir+b.Name+'.png');
  end;
  case SelTheme of
    0:ThemeFile:=thmdir+'guicolors_light.ini';
    1:ThemeFile:=thmdir+'guicolors_dark.ini';
    2:ThemeFile:=thmdir+'guicolors.ini';
    else ThemeFile:=thmdir+'guicolors.ini';
  end;
  Colorize(ThemeFile);
  EditorTabs.Font.Size:=9;

  bm:=TBGRAbitmap.Create;
  try
    if FileExists(thmdir+'imagelist.png') then
    begin
      bm.LoadFromFile(thmdir+'imagelist.png');
      ImageList.Clear;
      ImageList.AddSliced(bm.Bitmap,1,bm.Height div 16);
      EditorToolBar.Images:=ImageList;
    end;
    if FileExists(thmdir+'markimages.png') then
    begin
      bm.LoadFromFile(thmdir+'markimages.png');
      markimages.Clear;
      markimages.AddSliced(bm.Bitmap,1,bm.Height div 12);
    end;
    if FileExists(thmdir+'treeimg.png') then
    begin
      bm.LoadFromFile(thmdir+'treeimg.png');
      treeimg.Clear;
      treeimg.AddSliced(bm.Bitmap,1,bm.Height div 16);
    end;
  finally
    bm.free;
  end;

  result:=true;
end;

procedure TMainForm.LoadPlugIns;
var
  PlugIn:TPlugIn;
  i:integer;
  c:TControl;
  M:TMenuItem;

  procedure createbtn(APlugIn:TPlugIn);
  var PlugBtn:TuEButton;
  begin
    if APlugIn.ButtonGlyph.IsEmpty then exit;
    PlugBtn:=TuEButton.Create(MainForm);
    PlugBtn.Parent:=MainPanel;
    PlugBtn.Tag:=1000;
    PlugBtn.Constraints.MinHeight:=btn_new_project.Constraints.MinHeight;
    PlugBtn.Constraints.MinWidth:=btn_new_project.Constraints.MinWidth;
    PlugBtn.TextShadowColor:=btn_new_project.TextShadowColor;
    PlugBtn.Layout:=blGlyphTop;
    PLugBtn.ParentColor:=false;
    PLugBtn.Color:=btn_new_project.Color;
    PlugBtn.Caption:=APlugIn.ButtonCaption;
    PlugBtn.LoadImageFromFile(ThemeDir+'btn_bg.png');
    PlugBtn.LoadGlyphFromFile(APlugIn.Path+APlugIn.ButtonGlyph);
    PlugBtn.OnClick:=@APlugIn.OnClick;
  end;

begin
  PlugInsMenu.Clear;
  for i:=PlugInBar.ControlCount-1 downto 0 do PlugInBar.Controls[i].Free;
  for i:=MainPanel.ControlCount-1 downto 0 do
  begin
    c:=MainPanel.Controls[i];
    if c.Tag=1000 then
    begin
      MainPanel.RemoveControl(c);
      c.Free;
    end;
  end;
  GetPlugInList;
  PlugInsMenu.Visible:=(PlugInsList.Count<>0);
  if PlugInsList.Count=0 then exit;
  for PlugIn in PlugInsList do if PlugIn.Enabled then
  begin
    PlugIn.PlugInCmd:=@PlugInCmd;
    createbtn(PlugIn);
    PlugIn.CreateMenuItem(PlugInsMenu);
    PlugIn.CreateSpeedButton(PlugInBar);
  end;
  PlugInsMenu.AddSeparator;
  M:=TMenuItem.Create(PlugInsMenu);
  M.Action:=ToolsReloadPlugins;
  PlugInsMenu.Add(M);
  PlugInBar.Visible:=PlugInBar.ControlCount<>0;
end;

function TMainForm.CreateTempFile(fn: string): boolean;
var
  f: TStringList;
begin
  result:=true;
  f:=TStringList.Create;
  f.Assign(ActEditor.Lines);
  try
    f.SaveToFile(fn);
  finally
    FreeAndNil(f);
    if not fileexists(fn) then
    begin
      ShowMessage('Temporal file: '+ExtractFileName(fn)+' not could be '
        +'created.');
      result:=false;
    end;
  end;
end;

procedure TMainForm.EditorPagesChange(Sender: TObject);
begin
  Info('TMainForm.EditorPagesChange called by',BackTraceStrFunc(Get_caller_Addr(get_frame)));
  SetActiveEditor;
end;

procedure TMainForm.SetActiveEditor;
var
  NewActiveF:TEditor;
begin
  NewActiveF:=GetActiveEditorPage;
  If NewActiveF=ActEditor then
    exit
  else
    ActEditor:=NewActiveF;
  If assigned(ActEditor) then
  try
    Info('TMainForm.SetActiveEditor FileName',ActEditor.FileName);
    wdir:=extractfilepath(NewActiveF.FileName);
    if wdir='' then wdir:=IFTHEN(SBAPrj.name<>'',SBAPrj.location,ProjectsDir);
    ActEditor.BringToFront;
    UpdGuiTimer.Enabled:=true;
    if assigned(MiniMap) and MiniMap.Visible then
    begin
       MiniMap.ShareTextBufferFrom(ActEditor);
       MiniMap.Invalidate;
    end;
    if assigned(SplitEd) and SplitEd.Visible then
    begin
       SplitEd.ShareTextBufferFrom(ActEditor);
       SplitEd.Invalidate;
    end;
  except
    ON E:Exception do InfoErr('TMainForm.SetActiveEditor Error',E.Message);
  end;
end;

procedure TMainForm.SBA_EditProgramExecute(Sender: TObject);
var result:boolean;
begin
  PrgEditor.BeginUpdate(false);
  PrgEditor.ClearUndo;
  result:= SBAContrlrProg.CpySrc2Prog(ActEditor.Lines,PrgEditor.Lines);
  PrgEditor.EndUpdate;
  PrgEditor.Modified:=true;
  if result then
  begin
    SBAContrlrProg.FileName:=IFTHEN(SBAprj.name='',ExtractFilePath(ActEditor.FileName)+cSBADefaultPrgName,ExtractFilePath(ActEditor.FileName)+SBAprj.name+'.prg');
    PrgReturn:=@GotoEditor;
    SBA_ReturnToEditor.Enabled:=true;
    GotoProgEdit;
    ExtractSBALabels;
    ExtractSBACnfgCnst;
  end else ShowMessage('Format error in controller, please verify "/SBA:" block signatures.');
end;

procedure TMainForm.B_SBALabelsClick(Sender: TObject);
begin
  ExtractSBALabels;
end;

procedure TMainForm.DeferredTimerTimer(Sender: TObject);
begin
  DeferredTimer.Enabled:=false;
  StatusBar1.Panels[1].Text:='Checking for secure internet connection...';
  if IsNetworkEnabled then
  begin
    GetFile('newbanner.gif');
    CheckUpdate;
  end else
  begin
    {$IFDEF WINDOWS}
    ShowMessage('The application does not have a secure active internet connection, some features could be disabled');
    StatusBar1.Panels[1].Text:='No secure internet connection detected';
    {$ELSE}
    ShowMessage('There is not a secure active internet connection or the SSL libraries (libssl-dev) are not installed, some features could be disabled');
    StatusBar1.Panels[1].Text:='No secure internet connection detected or the SSL libraries are not installed';
    {$ENDIF}
  end;
end;

procedure TMainForm.EditBlkCommentExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.CommentBlock
  else If assigned(SplitEd) and SplitEd.Focused then SplitEd.CommentBlock;
end;

procedure TMainForm.EditBlkUncommentExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.UnCommentBlock
  else If assigned(SplitEd) and SplitEd.Focused then SplitEd.UnCommentBlock;
end;

procedure TMainForm.EditBlkIndentExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.ExecuteCommand(ecBlockIndent,'',nil)
  else If assigned(SplitEd) and SplitEd.Focused then SplitEd.ExecuteCommand(ecBlockIndent,'',nil);
end;

procedure TMainForm.EditBlkUnindentExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.ExecuteCommand(ecBlockUnindent,'',nil)
  else If assigned(SplitEd) and SplitEd.Focused then SplitEd.ExecuteCommand(ecBlockUnindent,'',nil);
end;

procedure TMainForm.EditCopyAsHtmlExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then CopyAsHtml(ActEditor)
  else If assigned(SplitEd) and SplitEd.Focused then CopyAsHtml(SplitEd)
       else Info('TMainForm.ToolsExporttoHtmlExecute','Do not exists a default editor');
end;

procedure TMainForm.B_InsertSnippedClick(Sender: TObject);
var
  success:boolean;

  function InsertSnp:boolean;
  begin
    if not InsertBlock(ActEditor,cSBAStartUserProg,cSBAEndUserProg,SBASnippet.code) then exit(false);
    if not InsertBlock(ActEditor,cSBAStartProgUReg,cSBAEndProgUReg,SBASnippet.registers) then exit(false);
    if not InsertBlock(ActEditor,cSBAStartUSignals,cSBAEndUSignals,SBASnippet.USignals) then exit(false);
    if not InsertBlock(ActEditor,cSBAStartUProc,cSBAEndUProc,SBASnippet.UProc) then exit(false);
    if not InsertBlock(ActEditor,cSBAStartUStatements,cSBAEndUStatements,SBASnippet.UStatements) then exit(false);
    exit(true);
  end;

begin
  if ActEditor=nil then exit;
  success:=true;
  try
    ActEditor.BeginUpdate(true);
    ActEditor.BeginUndoBlock;
    ActEditor.CaretX:=0;
    success:=InsertSnp;
    ActEditor.EndUndoBlock;
  finally
    If success then ExtractSBALabels else ActEditor.Undo;
    ActEditor.EndUpdate;
  end;
  ActEditor.SetFocus;
end;

procedure TMainForm.btn_sba_libraryClick(Sender: TObject);
var s:string;
begin
  Enabled:=false;
  {$IFDEF WINDOWS}
  RunCommand(AppDir+'SBAlibrary.exe',[ConfigFile],s);
  {$ELSE}
  RunCommand(AppDir+'SBAlibrary',[ConfigFile],s);
  {$ENDIF}
  Enabled:=true;
  SBASnippet.UpdateSnippetsFilter(SnippetsFilter);
end;

procedure TMainForm.PlugInCmd(Sender: TObject);
var
  PlugIn:TPlugIn;
begin
  PlugIn:=TPlugIn(Sender);
  if (not assigned(PlugIn)) or (PlugIn.ClassName<>'TPlugIn') then exit;
  with PlugIn do
  begin
    if not ToolProcessWaitforIdle then
    begin
      ShowMessage('There was an error when executing external plugin');
      exit;
    end;
    // Because TProcess is not a shell it better to use the OS command
    // interpreter to launch process, also it is not possible to launch
    // a program if it is not in the path or a fully path is attached:
    ToolProcess.Executable:=Path+Cmd;
    ToolProcess.CurrentDirectory:=Path; //<< it's not a search path for exe
    ToolProcess.Parameters.Delimiter:=' ';
    ToolProcess.Parameters.DelimitedText:=ParseParameters;
    Info('TMainForm.PlugInCmd',ToolProcess.Executable);
    Info('TMainForm.PlugInCmd Parameters',ToolProcess.Parameters);
    try
      ProcessStatus:=exePlugIn;
      EndProcTimer.Enabled:=true;
      ToolProcess.Execute
    except
      ON E:exception do
      begin
        ProcessStatus:=Idle;
        InfoErr('TMainForm.PlugInCmd Error:',E.Message);
        ShowMessage('There was an error when executing: '+ToolProcess.Executable);
      end;
    end;
  end;
end;

procedure TMainForm.B_SBAAdressClick(Sender: TObject);
begin
  if SBAPrj.name<>'' then ExtractSBACnfgCnst else ShowMessage('There is no an open project');
end;

procedure TMainForm.ExtractSBACnfgCnst;
var
  sl:TStringList;
  f,s:string;
  i:integer;
begin
  if SBAPrj.name<>'' then
  try
    L_SBAAddress.Items.Clear;
    sl:=TStringList.Create;
    f:=SBAPrj.location+SBAPrj.name+'_'+cSBAcfg;
    if (EditorTabs.TabCount>0) then
      for i:=0 to EditorTabs.TabCount-1 do if EditorTabs.GetTabData(i).TabHint=f then
      begin
        sl.Text:=SBAPrj.GetConfigConst((EditorTabs.GetTabData(i).TabObject as TSynEdit).lines);
        for s in sl do L_SBAAddress.Items.Add.Caption:=s;
        exit;
      end;
    sl.LoadFromFile(f);
    sl.Text:=SBAPrj.GetConfigConst(sl);
    for s in sl do L_SBAAddress.Items.Add.Caption:=s;
  finally
    if assigned(sl) then freeandnil(sl);
  end;
end;

procedure TMainForm.EditCopyExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.CopyToClipboard;
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.CopyToClipboard;
end;

procedure TMainForm.EditPasteExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.PasteFromClipboard;
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.PasteFromClipboard;
end;

procedure TMainForm.EditCutExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.CutToClipboard;
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.CutToClipboard;
end;

procedure TMainForm.EditInsertAuthorExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.InsertTextAtCaret(DefAuthor);
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.InsertTextAtCaret(DefAuthor);
end;

procedure TMainForm.EditInsertDateExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.InsertTextAtCaret(FormatDateTime('yyyy/mm/dd',date));
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.InsertTextAtCaret(FormatDateTime('yyyy/mm/dd',date));
end;

procedure TMainForm.EditInsertTemplateExecute(Sender: TObject);
var
  Ini:TIniFile;
  SL:TStringList;
  j,n:integer;
  Editor:TEditor;
begin
  Info('TMainForm.EditInsertTemplateExecute','Menu: '+TMenuItem(Sender).Caption);
  Editor:=nil;
  if (Sender.ClassName='TMenuItem') then
  begin
    if assigned(ActEditor) and ActEditor.Focused then Editor:=ActEditor;
    if assigned(SplitEd) and SplitEd.Focused then Editor:=SplitEd;
  end;
  if assigned(Editor) then
  begin
    Editor.CaretX:=0;
    SL:=TStringList.Create;
    Ini:=TInifile.Create(ConfigDir+'templates.ini',[ifoStripQuotes]);
    try
      SL.Clear;
      j:=Ini.ReadInteger(TMenuItem(Sender).Caption,'Lines',0);
      for n:=0 to j-1 do SL.Add(Ini.ReadString(TMenuItem(Sender).Caption,'L'+inttostr(n),''));
      if SL.Count>0 then Editor.InsertTextAtCaret(SL.Text);
    finally
      if assigned(Ini) then freeAndNil(Ini);
      if assigned(SL) then freeAndNil(SL);
    end;
  end;
end;

procedure TMainForm.EditorHistoryClickHistoryItem(Sender: TObject;
  Item: TMenuItem; const Filename: string);
begin
  OpenInEditor(Filename);
end;

procedure TMainForm.EditorsPanelClick(Sender: TObject);
begin

end;

procedure TMainForm.EditorTabsTabClose(Sender: TObject; ATabIndex: integer;
  var ACanClose, ACanContinue: boolean);
begin
  ACanClose:=false;
  //ACanContinue:=false;
  FileCloseExecute(TATTabs(Sender).GetTabData(ATabIndex));
end;

procedure TMainForm.EditRedoExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.Redo;
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.Redo;
end;

procedure TMainForm.EditSelectAllExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.SelectAll;
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.SelectAll;
end;

procedure TMainForm.EditShowMiniMapExecute(Sender: TObject);
begin
  If not assigned(MiniMap) or not assigned(ActEditor) then exit;
  If MiniMap.Visible then
  begin
    MiniMap.Visible:=false;
    MiniMap.UnShareTextBuffer;
  end else
  begin
    MiniMap.ShareTextBufferFrom(ActEditor);
    MiniMap.Visible:=true;
  end;
  EditShowMiniMap.Checked:=MiniMap.Visible;
end;

procedure TMainForm.EditSplitHorizontalExecute(Sender: TObject);
begin
  SplitEdSet(alBottom);
end;

procedure TMainForm.EditSplitVerticalExecute(Sender: TObject);
begin
  SplitEdSet(alRight);
end;

procedure TMainForm.SplitEdSetup;
begin
  SplitterEd:=TSplitter.Create(Self);
  SplitterEd.ResizeStyle:=rsPattern;
  SplitterEd.Parent:=EditorPages;
  SplitterEd.Height:=3;
  SplitterEd.Width:=3;
  SplitterEd.Align:=alNone;
  SplitterEd.Visible:=false;
  SplitEd:=TEditor.Create(Self);
  Dec(EditorCnt);
  SplitEd.Visible:=false;
  SplitEd.Parent:=EditorPages;
  SplitEd.Align:=alNone;
  SplitEd.PopupMenu:=EditorPopUp;
  SplitEd.BookMarkOptions.BookmarkImages:=MarkImages;
  SplitEd.OnStatusChange:=@EditorStatusChange;
end;

procedure TMainForm.SplitEdSet(FAlign:TAlign);
begin
  If not assigned(SplitEd) or not assigned(ActEditor) or not assigned(SplitterEd) then exit;
  If SplitEd.Align=FAlign then
  begin
    SplitEd.Visible:=false;
    SplitEd.UnShareTextBuffer;
    SplitEd.Align:=alNone;
    SplitterEd.visible:=false;
    SplitterEd.Align:=alNone;
    EditSplitVertical.Checked:=false;
    EditSplitHorizontal.Checked:=false;
  end else
  begin
    SplitterEd.Visible:=false;
    SplitEd.Visible:=false;
    SplitEd.Align:=FAlign;
    SplitEd.Visible:=true;
    SplitterEd.Align:=FAlign;
    SplitterEd.visible:=true;
    case FAlign of
      alBottom: begin
        SplitEd.Height:=SplitEd.Parent.Height div 2;
        EditSplitVertical.Checked:=false;
        EditSplitHorizontal.Checked:=true;
      end;
      alRight: begin
        SplitEd.Width:=SplitEd.Parent.Width div 2;
        EditSplitHorizontal.Checked:=false;
        EditSplitVertical.Checked:=true;
      end;
    end;
    SplitEd.ShareTextBufferFrom(ActEditor);
  end;
end;

procedure TMainForm.SplitEdMove;
var
  al: TAlign;
begin
  al:=SplitEd.Align;
  SplitEd.Align:=alNone;
  SplitterEd.Parent:=ActEditor.Parent;
  SplitEd.Parent:=ActEditor.Parent;
  if SplitEd.Visible then
  begin
    SplitEd.Align:=al;
    SplitterEd.Align:=al;
    SplitEd.Width:=SplitEd.Parent.Width div 2;
    SplitEd.Height:=SplitEd.Parent.Height div 2;
    SplitEd.ShareTextBufferFrom(ActEditor);
    SplitEd.Invalidate;
  end;
end;

procedure TMainForm.EditUndoExecute(Sender: TObject);
begin
  If assigned(ActEditor) and ActEditor.Focused then ActEditor.Undo;
  If assigned(SplitEd) and SplitEd.Focused then SplitEd.Undo;
end;

procedure TMainForm.FileOpenLocExecute(Sender: TObject);
var
  Editor:TEditor;
  d:string;
begin
  Editor:=GetActiveEditorPage;
  d:=ExtractFilePath(Editor.FileName);
  Info('TMainForm.FileOpenLocExecute','Try to open folder : '+d);
  if DirectoryExists(d) then OpenDocument(d);
end;

function TMainForm.SaveFile(f:String; Src:TStrings):Boolean;
begin
  FilesMon.Enabled:=false;
  try
    if FileExists(f) then
      RenameFile(f,f+IfThen(BakTimeStamp,FormatDateTime('"."yyyymmdd"-"hhnnsszzz".bak"',now),'.bak'));
    Src.SaveToFile(f);
  except
    ON E:Exception do
    begin
      InfoErr('TMainForm.SaveFile Error',E.Message);
      showmessage('Can not write '+f);
      FilesMon.Enabled:=EnableFilesMon;
      exit(false);
    end;
  end;
  Log.Items.Append('File saved: '+f);
  Log.ItemIndex:=Log.Count-1;
  FilesMon.UpdateFile(f);
  FilesMon.Enabled:=EnableFilesMon;
  result:=true;
end;

function TMainForm.EditorSaveAs(var Editor:TEditor):boolean;
var
  ext:string;
begin
  result:=false;
  if assigned(Editor) then
  begin
    ext:=GetFileExt(Editor.EdType);
    SaveDialog.Filter:=DefFileFilter;
    SaveDialog.FileName:=ExtractFileName(Editor.FileName);
    SaveDialog.DefaultExt:=ext;
    SaveDialog.InitialDir:=ExtractFilePath(Editor.FileName);
    if SaveDialog.Execute and SaveFile(SaveDialog.FileName, Editor.Lines) then
    begin
      FilesMon.DelFile(Editor.FileName);
      Editor.FileName:=SaveDialog.FileName;
      Editor.Modified:=false;
      selectHighlighter(Editor);
      FilesMon.AddFile(SaveDialog.FileName);
      result:=true;
    end;
  end;
end;

procedure TMainForm.FileSaveAllExecute(Sender: TObject);
var
  Editor:TEditor;
  i:integer;
  Tab:TATTabData;
begin
  if EditorTabs.TabCount>0 then For i:=0 to EditorTabs.TabCount-1 do
  begin
    Editor:=GetEditorPage(i);
    if Editor.Modified then
    begin
      If Pos(cDefNewFileName,Editor.FileName)=0 then
      begin
        SaveFile(Editor.FileName, Editor.Lines);
        Editor.Modified:=false;
      end else EditorSaveAs(Editor);
    end;
    Tab:=Editor.Page as TATTabData;
    if assigned(Tab) then Tab.TabModified:=false;
  end;
  UpdGuiTimer.Enabled:=true;
end;

procedure TMainForm.EditorNameChanged(Sender: TObject);
var
  Tab:TATTabData;
  Editor:TEditor;
begin
  if (Sender<>nil) and (Sender.ClassName='TEditor') then
  begin
    Editor:=TEditor(Sender);
    if not assigned(Editor.Page) then exit;
    Tab:=Editor.Page as TATTabData;
    Tab.TabCaption:=ExtractFileName(Editor.FileName);
    Tab.TabHint:=Editor.FileName;
    EditorTabs.Invalidate;
  end;
end;

procedure TMainForm.FileSaveExecute(Sender: TObject);
var Editor:TEditor;
begin
  If EditorTabs.TabCount>0 then
  begin
    Editor:=GetActiveEditorPage;
    If Pos(cDefNewFileName,Editor.FileName)=0 then
    begin
      SaveFile(Editor.FileName, Editor.Lines);
      Editor.Modified:=false;
    end else FileSaveAsExecute(Sender);
    UpdGuiTimer.Enabled:=true;
  end;
end;

procedure TMainForm.FileSaveAsExecute(Sender: TObject);
begin
  if EditorSaveAs(ActEditor) then UpdGuiTimer.Enabled:=true;
end;

procedure TMainForm.CheckUpdate;
begin
  StatusBar1.Panels[1].Text:='Online check for updates...';
  AutoUpdate.CBCheckNewVersion:=@EndCheckUpdate;
  AutoUpdate.CheckNewVersion;
end;

procedure TMainForm.EndCheckUpdate;
var
  wn:TStringList;
begin
  If AutoUpdate.NewVersionAvailable Then
  begin
    StatusBar1.Panels[1].Text:='A new version is available, getting what is new file.';
    if AutoUpdate.GetWhatsNew then
    try
      info('TMainForm.CheckUpdate','What is new file was downloaded.');
      wn:=TStringList.Create;
      wn.LoadFromFile(ConfigDir+WhatsNewFile);
      info('TMainForm.CheckUpdate',wn);
      WhatsNewF.Caption:='A new version: '+AutoUpdate.GetNewVersion+', is available';
      WhatsNewF.Memo1.Lines.Assign(wn);
    finally
      if assigned(wn) then FreeAndNil(wn);
    end;
    if WhatsNewF.ShowModal=mrok then
    begin
      StatusBar1.Panels[1].Text:='Downloading a new version of SBA Creator';
      if AutoUpdate.DownloadNewVersion Then
      begin
        If MessageDlg(Application.Title, 'Download Succeeded.  Click OK to update',
          mtInformation, [mbOK], 0) = mrOK Then
            If AutoUpdate.UpdateToNewVersion then StatusBar1.Panels[1].Text:='SBA Creator updated, restarting now...'
            else ShowMessage('There was an error when try to updating SBA Creator');
      end Else ShowMessage('Sorry, download of new version failed');
    end else StatusBar1.Panels[1].Text:='';
  end else StatusBar1.Panels[1].Text:='A new version is not available or not detected.';
  info('TMainForm.CheckUpdate','End of search for new version');
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  LogoImage.Visible:=Self.Width>575;
  EditorStatusChange(Self, []);
  if SplitEd.Visible then
  begin
    SplitEd.Width:=EditorPages.Width div 2;
    SplitEd.Height:=EditorPages.Height div 2;
  end;
end;

procedure TMainForm.HelpCheckUpdateExecute(Sender: TObject);
begin
  CheckUpdate;
end;

procedure TMainForm.HelpGotoSBAForumExecute(Sender: TObject);
begin
  OpenURL('http://sbaforum.accesus.com/');
end;

procedure TMainForm.HelpGotoSBAWebsiteExecute(Sender: TObject);
begin
  OpenUrl('http://sba.accesus.com');
end;

procedure TMainForm.HelpOpenHelpExecute(Sender: TObject);
begin
  OpenURL('file://'+ConfigDir+'doc'+PathDelim+'help.html');
end;

procedure TMainForm.HelpSettingsExecute(Sender: TObject);
var
  i:integer;
  Editor:TEditor;
begin
  if ConfigForm.ShowModal=mrOk then
  begin
    SetConfigValues(IniStor);
    FilesMon.Enabled:=EnableFilesMon;
    LoadPlugIns;
    PrgEditor.Font.Name:=EditorFontName;
    PrgEditor.Font.Size:=EditorFontSize;
    SplitEd.Font.Name:=EditorFontName;
    SplitEd.Font.Size:=EditorFontSize;
    if EditorTabs.TabCount>0 then For i:=0 to EditorTabs.TabCount-1 do
    begin
      Editor:=GetEditorPage(i);
      Editor.Font.Name:=EditorFontName;
      Editor.Font.Size:=EditorFontSize;
    end;
    Log.Font.Name:=EditorFontName;
    Log.Font.Size:=EditorFontSize;
  end;
end;

procedure TMainForm.LogClearExecute(Sender: TObject);
begin
  Log.Clear;
end;

procedure TMainForm.LogCopyExecute(Sender: TObject);
begin
  ClipBoard.AsText:=Log.GetSelectedText;
end;

procedure TMainForm.LogoImageDblClick(Sender: TObject);
begin
  {$IFDEF DEBUG}
//
  {$ENDIF}
end;

procedure TMainForm.L_SBALabelsClick(Sender: TObject);
var
  Item:TListItem;
  s:string;
begin
  Item:=TListView(Sender).Selected;
  if Item=nil then exit;
  s:=Item.Caption;
  Info('TMainForm.ListSelectItem',s);
  if ActEditor.EdType in [vhdl,ini,prg,other] then ActEditor.SetHighlightSearch(S,[ssoSelectedOnly,ssoWholeWord])
    else ActEditor.SetHighlightSearch(S,[ssoMatchCase,ssoSelectedOnly,ssoWholeWord]);
end;

procedure TMainForm.L_SBALabelsDblClick(Sender: TObject);
var
  Item:TListItem;
begin
  Item:=TListView(Sender).Selected;
  If Item=nil then exit;
  ActEditor.SearchReplace(cSBALblSignatr+Item.Caption, '', [ssoEntireScope,ssoWholeWord])
end;

procedure TMainForm.MainPanelResize(Sender: TObject);
//var v:integer;
begin
  //v:=max(128,max((MainPanel.Width-(50*5)) div 4,(MainPanel.Height-(50*3)) div 4));
  //btn_new_project.Constraints.MinHeight:=v;
  //btn_new_project.Constraints.MinWidth:=v;
end;

procedure TMainForm.MiniMapSetup;
begin
  MiniMap:=TEditor.Create(Self);
  Dec(EditorCnt);
  MiniMap.Visible:=false;
  MiniMap.Width:=165;
  MiniMap.Align:=alRight;
  MiniMap.Font.Height:= -3;
  MiniMap.Font.Name:= 'Courier New';
  MiniMap.Font.Pitch:= fpFixed;
  MiniMap.Font.Quality := fqAntialiased;
  MiniMap.BorderStyle:= bsNone;
  MiniMap.Gutter.AutoSize:= False;
  MiniMap.Gutter.Visible:= False;
  MiniMap.Gutter.Width:= 0;
  MiniMap.Gutter.MouseActions.Clear;
  MiniMap.RightGutter.Width:= 0;
  MiniMap.RightGutter.MouseActions.Clear;
  MiniMap.Keystrokes.Clear;
  MiniMap.MouseActions.Clear;
  MiniMap.MouseTextActions.Clear;
  MiniMap.MouseSelActions.Clear;
  MiniMap.Options:=[eoNoCaret, eoNoSelection, eoScrollPastEol];
  MiniMap.ReadOnly:= True;
  MiniMap.ScrollBars:= ssNone;
  MiniMap.OnSpecialLineColors:= @MiniMapSpecialLineColors;
  MiniMap.OnMouseDown:= @MiniMapMouseDown;
  MiniMap.OnMouseMove:= @MiniMapMouseMove;
  MiniMap.OnMouseUp:= @MiniMapMouseUp;
  MiniMap.OnEnter:= @MiniMapEnter;
end;

procedure TMainForm.MiniMapMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MiniMapinDrag:=true;
end;

procedure TMainForm.MiniMapEnter(Sender: TObject);
begin
  if assigned(ActEditor) and ActEditor.Visible then ActEditor.SetFocus;
end;

procedure TMainForm.MiniMapMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if MiniMapinDrag then
  begin
//    MiniMapSet(X,Y);
  end;
end;

procedure TMainForm.MiniMapMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MiniMapinDrag:=false;
  MiniMapSet(X,Y);
end;

procedure TMainForm.MiniMapSpecialLineColors(Sender: TObject; Line: integer;
  var Special: boolean; var FG, BG: TColor);
begin
  if not assigned(ActEditor) then exit;
  Special := (Cardinal(Line - ActEditor.TopLine) <= Cardinal(ActEditor.LinesInWindow));
  BG := ActEditor.LineHighlightColor.Background;
end;

procedure TMainForm.MiniMapSet(X, Y: Integer);
var
  Coord:TPoint;
begin
  if not assigned(ActEditor) then exit;
  Info('TMainForm.SetMiniMap',Point(X,Y));
  Coord:=MiniMap.PixelsToRowColumn(Point(X,Y));
  ActEditor.CaretXY:=Coord;
  ActEditor.Invalidate;
  ActEditor.TopLine := Max(1, Coord.Y - (ActEditor.LinesInWindow div 2));
  MiniMapinDrag:=false;
end;

procedure TMainForm.PrjHistoryClickHistoryItem(Sender: TObject;
  Item: TMenuItem; const Filename: string);
begin
  // if the project is already open CheckUpdate the PrjTree, if not, close current
  // project and open the selected one
  if CompareText(Filename,(SBAPrj.location+SBAPrj.name+cSBAPrjExt))=0 then
  begin
    UpdatePrjTree;
    PrjVisible:=true;
    exit;
  end;
  if CloseProject then OpenProject(Filename);
end;

procedure TMainForm.PrjTreeClick(Sender: TObject);
var
  TN:TTreeNode;
begin
  TN:=PrjTree.Selected;
  CoreImagePanel.Image.Clear;
  if (TN<>nil) and (TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).Text='Lib') then
  try
    CoreImagePanel.LoadFromFile(LibraryDir+TN.Text+PathDelim+'image.png');
  except
    ON E:Exception do
    begin
      InfoErr('TMainForm.PrjTreeClick Error',E.Message);
    end;
  end;
end;

procedure TMainForm.PrjTreeContextPopup(Sender: TObject; MousePos: TPoint;
  var Handled: Boolean);
var
  TN:TTreeNode;
begin
  FloatForm.Hide;
  TN:=PrjTree.Selected;
  if TN=nil then
  begin
    Handled:=true;
    exit;
  end;
  MI_AddCore.Visible:=false;
  MI_OpenDataSheet.Visible:=False;
  MI_UpdCore.Visible:=false;
  MI_RemCore.Visible:=false;
  MI_AddInstance.Visible:=false;
  MI_FindInstance.Visible:=False;
  MI_AddUserFile.Visible:=false;
  MI_RemUserFile.Visible:=false;
  if ((TN.Parent=nil) and (TN.Text='User')) or
     ((TN.Parent<>nil) and (TN.Parent.Text='User')) then
  begin
    MI_AddUserFile.Visible:=true;
    MI_RemUserFile.Visible:=true;
  end;
  if ((TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).text='Lib')) or
     ((TN.Parent=nil) and (TN.text='Lib')) then
  begin
    MI_AddCore.Visible:=true;
    MI_OpenDataSheet.Visible:=True;
    MI_FindInstance.Visible:=True;
    //MI_UpdCore.Visible:=true;
    //MI_RemCore.Visible:=true;
    MI_AddInstance.Visible:=true;
  end;
end;

procedure TMainForm.PrjTreeDblClick(Sender: TObject);
var
  TN:TTreeNode;
begin
  TN:=PrjTree.Selected;
  OpenTreeItem(TN);
end;

procedure TMainForm.OpenTreeItem(TN:TTreeNode);
var
  S,P:String;
begin
  if TN.Parent=nil then exit;
  S:=TN.GetParentNodeOfAbsoluteLevel(0).Text;
  if S=SBAPrj.name then P:=SBAPrj.location+SBAPrj.name+'_'+TN.Text+'.vhd'
  else case S of
  'Aux' :P:=SBAPrj.loclib+TN.Text+'.vhd';
  'Lib' :P:=SBAPrj.loclib+TN.Text+'.vhd';
  'User':P:=SBAPrj.GetUserFilePath(TN.Text)+TN.Text;
  else P:='';
  end;
  OpenInEditor(P);
end;

procedure TMainForm.PrjTreeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  TN:TTreeNode;
begin
  FloatForm.hide;
  TN := PrjTree.GetNodeAt(X, Y);
  if (TN<>nil) then TN.Selected:=true else PrjTree.Selected:=nil;
end;

procedure TMainForm.PrjTreeMouseLeave(Sender: TObject);
begin
  FloatForm.L_CoreName.caption:='';
  FloatForm.hide;
end;

procedure TMainForm.PrjTreeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  P: TPoint;
  TN: TTreeNode;
  HitTestInfo: THitTests;
begin
  TN := PrjTree.GetNodeAt(X, Y);
  HitTestInfo := PrjTree.GetHitTestInfoAt(X, Y) ;
  if (htOnItem in HitTestInfo) and (TN<>nil) and
     (TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).text='Lib') then
  begin
    P:=Mouse.CursorPos;
    FloatForm.Top:=P.Y+20;
    FloatForm.Left:=P.X+10;
    FloatForm.ShowCoreInfo(TN.Text);
  end else begin
    FloatForm.L_CoreName.caption:='';
    FloatForm.hide;
  end;
end;

procedure TMainForm.EndProcTimerTimer(Sender: TObject);
var PStr:String;
begin
  { TODO : WorkAround En Linux el método OnTerminate no es ejecutado por lo cual se incluye la condición Running para saber si continúa la ejecución del proceso. }
  //Si se corrije el comportamiento en Linux, se puede prescindir de la evaluación a Running
  if (not ToolProcess.Running) and (ProcessStatus<>Idle) then
  begin
    {IFDEF Debug}
      WriteStr(PStr,ProcessStatus);
      Info('TMainForm.EndProcTimerTimer','ProcessStatus is '+PStr);
    {ENDIF}
    ToolProcessTerminate(nil);
  end;
end;

procedure TMainForm.PrjTreeSelectionChanged(Sender: TObject);
begin
  PrjTreeClick(Sender);
end;

procedure TMainForm.ProjectAddUserFilesExecute(Sender: TObject);
begin
  OpenDialog.DefaultExt:='';
  OpenDialog.Filter:='';
  If OpenDialog.execute and SBAPrj.AddUserFile(OpenDialog.Filename) then UpdatePrjTree;
end;

procedure TMainForm.ProjectCoresAddInstExecute(Sender: TObject);
var
  TN:TTreeNode;
  IP,IPS,STL,AML,DCL,MXL:TStringList;
  iname:string;
begin
  TN:=PrjTree.Selected;
  if (TN<>nil) and (TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).Text='Lib') then
  try
    IP:=TStringList.Create;
    IPS:=TStringList.Create;
    STL:=TStringList.Create;
    AML:=TStringList.Create;
    DCL:=TStringList.Create;
    MXL:=TStringList.Create;
    iname:=TN.Text+'_'+inttostr(random(99));
    if InputQuery ('Add IP Core instance', 'Please type the name of the new instance:',iname) then
    try
      SBAIpCore.FormatData(TN.Text,iname,IP,IPS,STL,AML,DCL,MXL,0);
      ActEditor.CaretX:=0;
      ActEditor.InsertTextAtCaret(IP.Text);
    except
      ON E:Exception do
      begin
        ShowMessage(E.Message);
        InfoErr('TMainForm.ProjectCoresAddInstExecute',E.Message);
      end;
    end;
  finally
    if assigned(MXL) then FreeAndNil(MXL);
    if assigned(DCL) then FreeAndNil(DCL);
    if assigned(AML) then FreeAndNil(AML);
    if assigned(STL) then FreeAndNil(STL);
    if assigned(IPS) then FreeAndNil(IPS);
    if assigned(IP) then FreeAndNil(IP);
  end
  else ShowMessage('Please select an IP core first');
end;

procedure TMainForm.ProjectCloseExecute(Sender: TObject);
begin
  CloseProject;
end;

procedure TMainForm.ProjectEditCoreListExecute(Sender: TObject);
begin
  if SBAPrj.EditLib then UpdatePrjTree;
end;

function TMainForm.CloseProject:boolean;
begin
  Info('TMainForm','Start CloseProject');
  result:=false;
  while (EditorTabs.TabCount>0) do
    If not CloseEditor(EditorTabs.TabIndex) then exit(false);
  If SBAPrj.Close then
  begin
    GotoSystem;
    result:=true;
  end;
  Info('TMainForm','End CloseProject');
end;

procedure TMainForm.ProjectExportExecute(Sender: TObject);
Var
  exportpath:string;
  IniFile:TIniFile;
begin
  { TODO : Grabar también archivos de proyecto antes de exportar }
  If SBAPrj.Modified and (MessageDlg('The Project was modified', 'Save Project and its files? ', mtConfirmation, [mbYes, mbNo],0)=mrYes) then
    ProjectSaveExecute(Sender);
  try
    IniFile:=TIniFile.Create(LocSBAPrjParams);
    exportpath:=IniFile.ReadString('PrjExportPaths',SBAPrj.name,'');
  except
    ON E:Exception do InfoErr('TMainForm.ProjectExportExecute Error',E.Message);
  end;
  ExportPrjForm.L_PrjDir.Caption:='Project folder: '+SBAPrj.location;
  ExportPrjForm.Ed_TargetDir.Directory:=exportpath;
  ExportPrjForm.CB_ExpPrjMonolithic.Checked:=SBAPrj.expmonolithic;
  ExportPrjForm.CB_ExpPrjAllLib.Checked:=SBAPrj.explibfiles;
  ExportPrjForm.CB_ExpPrjUser.Checked:=SBAPrj.expuserfiles;
  if ExportPrjForm.Showmodal=mrOk then with ExportPrjForm, SBAPrj do
  begin
    exportpath:=AppendPathDelim(TrimFilename(Ed_TargetDir.Text));
    If assigned(IniFile) then
    begin
      IniFile.WriteString('PrjExportPaths',SBAPrj.name,exportpath);
      FreeAndNil(IniFile);
    end;
    expmonolithic:=CB_ExpPrjMonolithic.Checked;
    explibfiles:=CB_ExpPrjAllLib.Checked;
    expuserfiles:=CB_ExpPrjUser.Checked;
    If SBAPrj.PrjExport(exportpath) then
    begin
      Log.Items.Append('Project was exported to: '+exportpath);
      Log.ItemIndex:=Log.Count-1;
    end;
  end;
end;

procedure TMainForm.MainGotoEditorExecute(Sender: TObject);
begin
  PrjVisible:=false;
  GotoEditor;
end;

procedure TMainForm.GotoSystem;
begin
  StatusBar1.Panels[0].Text:='';
  StatusBar1.Panels[1].Text:='';
  ActEditor:=nil;
  Log.Clear;
  SystemPanel.BringToFront;
  MainForm.Menu := MainMenu;
  ActivePanel:=SystemPanel;
end;

procedure TMainForm.GotoEditor;
begin
  If EditorTabs.TabCount=0 then
  begin
    EditorCnt:=0;
    NewEditorPage(DefEdType);
  end;
  EditorsPanel.BringToFront;
  MainForm.Menu:= EditorMenu;
  ActEditor:=GetActiveEditorPage;
  MiniMap.Parent:=P_Editors;
  if MiniMap.Visible then
  begin
    MiniMap.ShareTextBufferFrom(ActEditor);
    MiniMap.Invalidate;
  end;
  SplitEdMove;
  ActivePanel:=EditorsPanel;
end;

procedure TMainForm.GotoProgEdit;
begin
  if ActEditor=PrgEditor then exit;
  ActEditor:=PrgEditor;
  ActEditor.FileName:=SBAContrlrProg.FileName;
  selectHighlighter(ActEditor);
  MiniMap.Align:=alNone;
  MiniMap.Parent:=ProgEditPanel;
  MiniMap.Align:=alRight;
  if MiniMap.Visible then
  begin
    MiniMap.ShareTextBufferFrom(ActEditor);
    MiniMap.Invalidate;
  end;
  SplitEdMove;
  ProgEditPanel.BringToFront;
  MainForm.Menu := ProgMenu;
  ActivePanel:=ProgEditPanel;
end;

procedure TMainForm.MainGotoPrgExecute(Sender: TObject);
begin
  PrgReturn:=@GotoSystem;
  SBA_ReturnToEditor.Enabled:=false;
  GotoProgEdit;
  if ActEditor.isEmpty then NewPrg else ExtractSBALabels;
end;

procedure TMainForm.ProjectFindInstanceExecute(Sender: TObject);
var
  TN:TTreeNode;
  corename:string;
begin
  TN:=PrjTree.Selected;
  if (TN<>nil) and (TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).Text='Lib') then
  begin
    corename:=TN.Text;
    if ActEditor.SearchReplace('entity work.'+corename,'',[ssoEntireScope])=0
    then ShowMessage(corename+' instance not found');
  end else ShowMessage('Please select an IP core first');
end;

procedure TMainForm.ProjectItemDataSheetExecute(Sender: TObject);
var
  TN:TTreeNode;
  dsname,f:string;
  Ini:TIniFile;
begin
  TN:=PrjTree.Selected;
  if (TN<>nil) and (TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).Text='Lib') then
  begin
    f:=LibraryDir+TN.Text+PathDelim;
    Ini:=TIniFile.Create(f+TN.Text+'.ini');
    try
      dsname:=f+Ini.ReadString('MAIN','DataSheet','readme.md');
      OpenDataSheet(dsname);
    finally
      Ini.free;
    end;
  end else ShowMessage('Please select an IP core first');
end;

procedure TMainForm.ProjectNewExecute(Sender: TObject);
var TmpPrj:TSBAPrj;
begin
  if CloseProject then
  begin
    TmpPrj:=TSBAPrj.Create;
    if (PrjWizForm.NewPrj(TmpPrj)=mrOk) and TmpPrj.PrepareNewFolder then
    begin
      if assigned(SBAPrj) then freeAndNil(SBAPrj);
      SBAPrj:=TmpPrj;
      OpenProject(SBAPrj.location+SBAPrj.name+cSBAPrjExt);
    end else FreeAndNil(TmpPrj);
  end;
end;

procedure TMainForm.ProjectOpenExecute(Sender: TObject);
begin
  OpenDialog.FileName:='';
  OpenDialog.DefaultExt:='.sba';
  OpenDialog.Filter:='SBA project|*.sba';
  if OpenDialog.Execute then OpenProject(OpenDialog.FileName);
end;

procedure TMainForm.OpenProject(const f: string);
var
  s:string;
begin
  if not SBAPrj.Open(f) then exit;
  UpdatePrjTree;
  PrjHistory.UpdateList(f);
  CopyPrjHistory;
  PrjVisible:=true;
  GotoEditor;
  S:=SBAPrj.location+SBAPrj.name+'_'+cSBATop;
  OpenInEditor(S);
  if AutoOpenPrjF then
  begin
    S:=SBAPrj.location+SBAPrj.name+'_'+cSBAcfg;
    OpenInEditor(S);
    case SBAPrj.SBAver of
      0:S:=SBAPrj.location+SBAPrj.name+'_'+cSBAdcdr;
      1:S:=SBAPrj.location+SBAPrj.name+'_'+cSBAmux;
    end;
    OpenInEditor(S);
    S:=SBAPrj.location+SBAPrj.name+'_'+cSBActrlr;
    OpenInEditor(S);
  end;
  Log.clear;
//  ForceEditorPagesChange;
end;

procedure TMainForm.ProjectOpenItemExecute(Sender: TObject);
var
  TN:TTreeNode;
begin
  TN:=PrjTree.Selected;
  if (TN<>nil) then OpenTreeItem(TN);
end;

procedure TMainForm.ProjectRemCoreExecute(Sender: TObject);
var
  TN:TTreeNode;
begin
  TN:=PrjTree.Selected;
  if (TN<>nil) and (TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).Text='Lib') then
    if SBAPrj.RemoveCore(TN.Text) then  UpdatePrjTree;
end;

procedure TMainForm.ProjectRemUserFileExecute(Sender: TObject);
var
  TN:TTreeNode;
begin
  TN:=PrjTree.Selected;
  if (TN<>nil) and (TN.Parent<>nil) and (TN.Parent.Text='User') and
     SBAPrj.RemUserFile(TN.Text) then
  UpdatePrjTree;
end;

function TMainForm.GetEditorPage(i:integer):TEditor;
var
  Editor:TEditor;
begin
  Info('TMainForm.GetEditorPage index',i);
  if (i>-1) and (i < EditorTabs.TabCount) then Editor:=EditorTabs.GetTabData(i).TabObject as TEditor
  else Editor:=nil;
  Result:=Editor;
end;

function TMainForm.GetEditorFile(f: string): TEditor;
var
  Editor:TEditor;
  i:integer;
begin
  Info('TMainForm.GetEditorFile',f);
  Editor:=nil;
  if f<>'' then For i:=0 to EditorTabs.TabCount-1 do
  begin
    Editor:=GetEditorPage(i);
    if assigned(Editor) and (ExpandFileName(Editor.FileName)=ExpandFileName(f)) then Break;
  end;
  Result:=Editor;
end;

function TMainForm.GetActiveEditorPage:TEditor;
begin
  Result:=GetEditorPage(EditorTabs.TabIndex);
end;

procedure TMainForm.ProjectSaveExecute(Sender: TObject);
begin
  FileSaveAllExecute(Sender);
  SBAPrj.Save;
end;

procedure TMainForm.ProjectsHistory2Click(Sender: TObject);
Var FileName:String;
begin
  FileName:=PrjHistory.GetItemValue(TMenuItem(Sender).MenuIndex);
  if CompareText(Filename,(SBAPrj.location+SBAPrj.name+cSBAPrjExt))=0 then exit;
  if CloseProject then OpenProject(Filename);
end;

procedure TMainForm.ProjectUpdCoreExecute(Sender: TObject);
var
  TN:TTreeNode;
begin
  TN:=PrjTree.Selected;
  if (TN<>nil) and (TN.Parent<>nil) and (TN.GetParentNodeOfAbsoluteLevel(0).Text='Lib') then
      SBAPrj.UpdateCore(TN.Text);
end;

procedure TMainForm.SBA_cancelExecute(Sender: TObject);
begin
  if PrgEditor.Modified then
  case MessageDlg('File was modified', 'Save File? ', mtConfirmation, [mbYes, mbNo, mbCancel],0) of
    mrCancel: exit;
    mrYes: SBA_SaveExecute(nil);
    mrNo: begin PrgEditor.ClearAll; PrgEditor.Modified:=false; end;
  end;
  if not PrgEditor.Modified then
  begin
    if assigned(PrgReturn) then PrgReturn else GotoSystem;
    PrgEditor.ClearAll;
    PrgEditor.Modified:=false;
  end;
end;

procedure TMainForm.FileCloseExecute(Sender: TObject);
var index:integer;
begin
  if Sender is TATTabData then index:=TATTabData(Sender).index
  else index:=EditorTabs.TabIndex;
  Info('TMainForm.FileCloseExecute Start', index);
  CloseEditor(index);
  if EditorTabs.TabCount=0 then
  begin
    if not Prjvisible then
    begin
      GotoSystem;
    end else
    begin
      EditorCnt:=0;
      NewEditorPage(DefEdType);
    end;
  end;
  Info('TMainForm.FileCloseExecute', 'End');
end;

procedure TMainForm.SBA_InsertTemplateExecute(Sender: TObject);
var
  S:String;
begin
  if Sender.ClassName='TMenuItem' then
  begin
    ActEditor.CaretX:=0;
    S:=TMenuItem(Sender).Caption;
    If Pos('/SBA',S)<>0 then S:=S+' '+StringOfChar('-',79-length(S))+sLineBreak;
    ActEditor.InsertTextAtCaret(S);
  end;
end;

procedure TMainForm.SBA_NewPrgExecute(Sender: TObject);
begin
  if ActEditor.Modified then
  case MessageDlg('File was modified', 'Save File? ', mtConfirmation, [mbYes, mbNo, mbCancel],0) of
    mrCancel: exit;
    mrYes: SBA_SaveExecute(nil);
  end;
  NewPrg;
  ActEditor.Modified:=false;
end;

procedure TMainForm.NewPrg;
var
  tmp:TstringList;
begin
  SBAContrlrProg.Filename:=ProgramsDir+cSBADefaultPrgName;
  StatusBar1.Panels[1].Text:=SBAContrlrProg.Filename;
  ActEditor.FileName:=SBAContrlrProg.Filename;
  selectHighlighter(ActEditor);
  try
   tmp:=tstringlist.Create;
   try
     tmp.LoadFromFile(ConfigDir+IFTHEN(CtrlAdvMode,cSBAAdvPrgTemplate,cSBADefPrgTemplate));
     ActEditor.Lines.Assign(tmp);
   except
     On E:Exception do ShowMessage(E.Message);
   end;
  finally
   if assigned(tmp) then freeandnil(tmp);
  end;
  ExtractSBALabels;
end;

procedure TMainForm.LV_SnippetsClick(Sender: TObject);
var
  f:string;
  l:TListItem;
begin
  L:=LV_Snippets.Selected;
  if (L=nil) or (LV_Snippets.Items.Count=0) then exit;
  f:=L.SubItems[0];
  if f<>'' then
  begin
    SBASnippet.filename:=f;
    if SBASnippet.description.count>0 then SnippetDescription.Lines.Assign(SBASnippet.description);
  end;
end;

procedure TMainForm.SyncMiniMapTimer(Sender: TObject);
begin
  SyncMiniMap.Enabled:=false;
  if not assigned(MiniMap) or not assigned(ActEditor) or not MiniMap.Visible then exit;
  if (MiniMap.Tag <> ActEditor.TopLine) then
  begin
    MiniMap.Tag := ActEditor.TopLine;
    if (ActEditor.TopLine+ActEditor.LinesInWindow)>(MiniMap.TopLine+MiniMap.LinesInWindow)
    then MiniMap.TopLine:=ActEditor.TopLine+ActEditor.LinesInWindow-MiniMap.LinesInWindow
    else if  ActEditor.TopLine<MiniMap.TopLine then MiniMap.TopLine:=ActEditor.TopLine;
  end;
  MiniMap.Invalidate;
end;

procedure TMainForm.SearchFindExecute(Sender: TObject);
begin
  FindDialog1.Execute;
end;

procedure TMainForm.SearchReplaceExecute(Sender: TObject);
begin
  ReplaceDialog1.Execute;
end;

procedure TMainForm.FindDialogFind(Sender: TObject);
var
  encon : integer;
  buscado : string;
  opciones: TSynSearchOptions;
begin
{ TODO : No funciona Ctrl-X,C,V }
  if Sender.ClassName='TReplaceDialog' then
  begin
    FindDialog1.FindText:=ReplaceDialog1.FindText;
    FindDialog1.Options:=ReplaceDialog1.Options;
  end;
  buscado := FindDialog1.FindText;
  opciones := [];
  if not(frDown in FindDialog1.Options) then opciones += [ssoBackwards];
  if frMatchCase in FindDialog1.Options then opciones += [ssoMatchCase];
  if frWholeWord in FindDialog1.Options then opciones += [ssoWholeWord];
  if frEntireScope in FindDialog1.Options then opciones += [ssoEntireScope];
  encon := ActEditor.SearchReplace(buscado,'',opciones);
  if encon = 0 then
  ShowMessage('Not found: ' + buscado);
end;

procedure TMainForm.ReplaceDialog1Show(Sender: TObject);
begin
  ReplaceDialog1.FindText:=FindDialog1.FindText;
  ReplaceDialog1.Options:=FindDialog1.Options;
end;

procedure TMainForm.ReplaceDialogReplace(Sender: TObject);
var
  encon, r : integer;
  buscado : string;
  opciones: TSynSearchOptions;
begin
  if ActEditor.ReadOnly then
  begin
   ShowMessage('The file in the editor is read only');
   exit;
  end;
  buscado := ReplaceDialog1.FindText;
  opciones := [ssoFindContinue];
  if not(frDown in ReplaceDialog1.Options) then opciones += [ssoBackwards];
  if frMatchCase in ReplaceDialog1.Options then opciones += [ssoMatchCase];
  if frWholeWord in ReplaceDialog1.Options then opciones += [ssoWholeWord];
  if frEntireScope in ReplaceDialog1.Options then opciones +=
  [ssoEntireScope];
  if frReplaceAll in ReplaceDialog1.Options then
  begin
    //se ha pedido reemplazar todo
    encon := ActEditor.SearchReplace(buscado,ReplaceDialog1.ReplaceText,
    opciones+[ssoReplaceAll]); //reemplaza
    ShowMessage('Se reemplazaron ' + IntToStr(encon) + ' ocurrencias.');
    exit;
  end;
  //reemplazo con confirmación
  ReplaceDialog1.CloseDialog;
  encon := ActEditor.SearchReplace(buscado,'',opciones); //búsqueda
  while encon <> 0 do
  begin
    //pregunta
    r := Application.MessageBox('¿Reemplazar esta ocurrencia?','Reemplazo',MB_YESNOCANCEL);
    if r = IDCANCEL then exit;
    if r = IDYES then
    begin
     ActEditor.TextBetweenPoints[ActEditor.BlockBegin,ActEditor.BlockEnd] :=
     ReplaceDialog1.ReplaceText;
    end;
    //busca siguiente
    encon := ActEditor.SearchReplace(buscado,'',opciones); //búsca siguiente
  end;
  ShowMessage('No se encuentra: ' + buscado);
end;

procedure TMainForm.ToolsExporttoHtmlExecute(Sender: TObject);
begin
  If assigned(ActEditor) then ExporttoHtmlFile(ActEditor)
  else Info('TMainForm.ToolsExporttoHtmlExecute','Do not exists a default editor');
end;

procedure TMainForm.FileRevertExecute(Sender: TObject);
begin
  if not assigned(ActEditor) then exit;
  if ActEditor.Modified and not (QuestionDlg('File revert','Do you want to replace the current document with the saved version?',mtConfirmation,[mrNo,mrYes],0)=mrYes) then exit;
  if (ActivePanel=EditorsPanel) then
  begin
    if Open(ActEditor.FileName) then UpdGuiTimer.Enabled:=true;
  end else if ActivePanel=ProgEditPanel then
  begin
    if Open(ActEditor.FileName) then ExtractSBALabels;
  end;
end;

procedure TMainForm.ToolsFileSyntaxCheckExecute(Sender: TObject);
var s:string;
begin
{ TODO : Colocar un botón sobre el arbol del proyecto para comprobar la sintaxis
  de todos los archivos que forman parte del proyecto. }
{ TODO : Esta parte debe mejorarse para poder verificar sintaxis adecuadamente
  de archivos individales, cores y requerimientos; y proyectos. }
  s:=ActEditor.FileName;
  if ActEditor.Modified then
  case MessageDlg('File must be saved', 'Save File? '+s, mtConfirmation, [mbYes, mbNo],0) of
    mrYes: if not SaveFile(s,ActEditor.Lines) then exit else ActEditor.Modified:=false;
  else exit;
  end;
  ToolsFileSyntaxCheck.Enabled:=false;
  if SBAPrj.name<>'' then
    SyntaxCheck(s,SBAPrj.GetAllFileNames(extractfilepath(s)),ActEditor.EdType)
  else if isIPCore(s) then
    SyntaxCheck(s,SBAIpCore.GetFiles(s),ActEditor.EdType)
  else SyntaxCheck(s,'',ActEditor.EdType);
end;

procedure TMainForm.ExporttoHtmlFile(var Editor: TEditor);
var f:string;
begin
  Info('TMainForm.ExporttoHtmlFile',Editor.FileName);
  if Editor.EdType=markdown then
  begin
    f:=Md2Html(Editor.Text,Editor.FileName);
    if f='' then exit;
    OpenURL('file://'+f+'?time='+TimetoStr(now));
    Sleep(300);
    DeleteFile(f);
    exit;
  end;
  SynExporterHTML.Highlighter:=Editor.CreateExportHighligther;
  if assigned(SynExporterHTML.Highlighter) then
  begin
    SynExporterHTML.Options:=SynExporterHTML.Options-[heoWinClipHeader];
    SynExporterHTML.ExportAll(Editor.Lines);
    SaveDialog.Filter:=SynExporterHTML.DefaultFilter;
    Info('TMainForm.ExporttoHtml','Select File');
    if SaveDialog.Execute then
    begin
      SynExporterHTML.SaveToFile(SaveDialog.FileName);
      OpenUrl('file://'+SaveDialog.FileName+'?time='+TimetoStr(now));
    end;
    SynExporterHTML.Highlighter.Free;
  end;
end;

procedure TMainForm.CopyAsHtml(var Editor: TEditor);
begin
  if not assigned(Editor) or not Editor.SelAvail then exit;
  SynExporterHTML.Highlighter:=Editor.CreateExportHighligther;
  if assigned(SynExporterHTML.Highlighter) then with Editor do
  begin
    SynExporterHTML.Options:=SynExporterHTML.Options+[heoWinClipHeader];
    SynExporterHTML.ExportRange(Lines,BlockBegin,BlockEnd);
    SynExporterHTML.CopyToClipboard;
    SynExporterHTML.Highlighter.Free;
  end;
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  CanClose:=false;
  if not CloseProg then exit else CanClose:=true;
  SaveOpenEditor;
  while CanClose and (EditorTabs.TabCount>0) do
  begin
    CanClose:=CloseEditor(EditorTabs.TabIndex);
  end;
  if CanClose and assigned(SBAPrj) and SBAPrj.Modified then CanClose:=CloseProject;
//  CanClose:=CanClose and not AutoUpdate.DownloadInProgress;
  Info('TMainForm FormCloseQuery CanClose?',CanClose);
end;

procedure TMainForm.SaveOpenEditor;
var
  i,j:integer;
  inifile:TIniFile;
  Editor:TEditor;
begin
  Info('TMainForm','SaveOpenEditor');
  try
   IniFile:=TIniFile.Create(ConfigDir+'FileHistory.ini');
   IniFile.EraseSection('LastOpenEditor');
   if EditorTabs.TabCount>0 then
   begin
     if Prjvisible then IniFile.WriteString('LastOpenEditor','Project',SBAPrj.location+SBAPrj.name+'.sba');
     j:=0;
     for i:=0 to EditorTabs.TabCount-1 do
     begin
       Editor:=GetEditorPage(i);
       if Assigned(Editor) and not Editor.isEmpty then
       begin
         Inc(j);
         IniFile.WriteString('LastOpenEditor',inttostr(j),Editor.FileName);
       end;
     end;
     IniFile.WriteInteger('LastOpenEditor','Count',j);
   end;
  finally
    If Assigned(IniFile) then FreeAndNil(IniFile);
  end;
end;

procedure TMainForm.SetPrjVisible(AValue: boolean);
begin
  if FPrjVisible=AValue then Exit;
  FPrjVisible:=AValue;
  P_Project.Visible:=FPrjVisible;
  Spl_Project.Visible:=FPrjVisible;
  ProjectMenuEd.Visible:=FPrjVisible;
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  Success:Boolean;
begin
  info('TMainForm','Start of create method');
  FPrjVisible:=false;
  Success:=false;
  try
    Success:=GetConfigValues;
    Success:=Success and SetupConfig;
  finally
    if not Success then
    begin
     info('TMainForm.FormCreate','There was an error loading config values');
     ShowMessage('Sorry, an unrecoverable error has occurred, the application is going to exit now');
     Halt;
    end
  end;
  info('TMainForm.FormCreate','Config values OK '+ConfigDir);
  {$IFDEF DEBUG}
  caption:='SBA Creator v'+GetFileVersion+' DEBUG mode';
  info('TMainForm.FormCreate',caption);
  {$ELSE}
  caption:='SBA Creator v'+GetFileVersion;
  {$ENDIF}
  CheckNetworkThread;
  wdir:=ProjectsDir;
  AutoUpdate:=TAutoUpdate.Create;
  Check;
  LoadAnnouncement;
  SetupPrgEditor;
  SplitEdSetup;
  MiniMapSetup;
  Log.Font.Name:=EditorFontName;
  Log.Font.Size:=EditorFontSize;
  FilesMon:=TFilesMon.Create(EnableFilesMon,@FileChanged);
  SBAPrj:=TSBAPrj.Create;
  SBAContrlrProg:=TSBAContrlrProg.Create;
  SBASnippet:=TSBASnippet.Create;
  SBASnippet.UpdateSnippetsFilter(SnippetsFilter);
  IpCoreList:=TStringList.Create;
  SnippetsList:=TStringList.Create;
  ProgramsList:=TStringList.Create;
  UpdateLists;
  SynHighLightersCreate(Self);
  SynMultiCaret:=TSynPluginMulticaret.Create(Self);
  SynAutoComplete:=TSynAutoComplete.Create(Self);
  PrjHistory.IniFile:=ConfigDir+'FileHistory.ini';
  PrjHistory.UpdateParentMenu;
  EditorHistory.IniFile:=ConfigDir+'FileHistory.ini';
  EditorHistory.UpdateParentMenu;
  SetupTBEditOpenPopUp;
  CopyPrjHistory;
  SetupEditorPopupMenu;
  SetupPrgTmplMenu;
  SetupEdTmplMenu;
  SetupNewEdMenu;
  LoadPlugIns;
  LoadTheme(ThemeDir);
  GotoSystem;
  ReOpenEditorFiles;
  CheckStartParams;
  DeferredTimer.Enabled:=true;
  info('TMainForm.FormCreate','All tasks finished');
end;

procedure TMainForm.ReOpenEditorFiles;
var
  i:integer;
  prj:string;
  IniFile:TIniFile;
begin
  if not AutoOpenEdFiles then exit;
  IniFile:=TIniFile.Create(ConfigDir+'FileHistory.ini');
  prj:=IniFile.ReadString('LastOpenEditor','Project','');
  if prj<>'' then OpenProject(prj);
  For i:=1 to IniFile.ReadInteger('LastOpenEditor','Count',0) do
    OpenInEditor(IniFile.ReadString('LastOpenEditor',InttoStr(i),''));
  If EditorTabs.TabCount>0 then GotoEditor;
  IniFile.Free;
end;

procedure TMainForm.CheckStartParams;
var
  i:Integer;
  f:String;
begin
  { TODO 1 : Verificar la opción -c ó /c para definir un archivo o carpeta de configuración diferente. }
  If (ParamCount=1) and FileExists(ParamStr(1)) and (CompareText(ExtractFileExt(ParamStr(1)),'.sba')=0) then
  begin
    OpenProject(ParamStr(1));
    exit;
  end;
//
  If (ParamCount=1) and FileExists(ParamStr(1)) and
     ((CompareText(ExtractFileExt(ParamStr(1)),'.snp')=0) or
     (CompareText(ExtractFileExt(ParamStr(1)),'.prg')=0)) then
  begin
    PrgEditor.Lines.LoadFromFile(ParamStr(1));
    SBAContrlrProg.FileName:=ParamStr(1);
    MainGotoPrgExecute(nil);
    exit;
  end;
//
  If ParamCount>0 then
  begin
    GotoEditor;
    For i:=1 to ParamCount do
    begin
      f:=ParamStr(i);
      if fileexists(f) then OpenInEditor(f);
    end;
  end;
end;

procedure TMainForm.CopyPrjHistory;
Var i:Integer;
    m:TMenuItem;
begin
  if not (assigned(ProjectsHistory) or assigned(ProjectsHistory2)) then exit;
  ProjectsHistory2.Clear;
  for i:=0 to ProjectsHistory.Count-1 do
  begin
    m:=TMenuItem.Create(ProjectsHistory2);
    m.caption:=ProjectsHistory.Items[i].caption;
    m.OnClick:=@ProjectsHistory2Click;
    ProjectsHistory2.Add(m);
  end;
end;

procedure TMainForm.SetupTBEditOpenPopUp;
var
  m,n:TMenuItem;
begin
  if not assigned(EditorHistory.ParentMenu) then exit;
  if assigned(TBEditOpen.DropdownMenu) then TBEditOpen.DropdownMenu.Items.Clear
  else TBEditOpen.DropdownMenu:=TPopupMenu.Create(Self);
  for n in EditorHistory.ParentMenu do
  begin
    M:=TMenuItem.Create(TBEditOpen.DropdownMenu);
    M.Assign(n);
    TBEditOpen.DropdownMenu.Items.Add(M);
  end;
end;

procedure TMainForm.SetupEditorPopupMenu;
var
  i:integer;
  M:TMenuItem;
begin
  EditorPopUp.Items.Clear;
  for i:=0 to EditMenu.Count-1 do
  begin
    M:=TMenuItem.Create(PrgEditor.PopupMenu);
    M.Caption:=EditMenu[i].Caption;
    M.Action:=EditMenu[i].Action;
    EditorPopUp.Items.Add(M);
  end;
end;

procedure TMainForm.SetupPrgTmplMenu;
var
  M:TMenuItem;
  PrgTemplates:TPopupMenu;
  s:string;
  l:TStringlist;
begin
  { TODO : Mover las plantillas de los place holder PRG a un submenu y adicionar capacidad para colocar más plantillas }
  PrgTemplates:=TPopupMenu.Create(Self);
  l:=TStringList.Create;
  try
    l.Add(cSBAStartProgDetails);
    l.Add(cSBAStartUSignals);
    l.Add(cSBAStartUProc);
    l.Add(cSBAStartProgUReg);
    l.Add(cSBAStartUserProg);
    l.Add(cSBAStartUStatements);
    l.Add(cSBAEndProgDetails);
    l.Add(cSBALblSignatr);
    for s in l do
    begin
      M:=TMenuItem.Create(PrgTemplates);
      M.Caption:=s;
      M.OnClick:=@SBA_InsertTemplateExecute;
      M.ImageIndex:=38;
      PrgTemplates.Items.Add(M);
    end;
  finally
    if assigned(l) then l.Free;
  end;
  PrgTemplates.Images := ImageList;
  PrgTemplateButton.DropdownMenu:=PrgTemplates;
end;

{ TODO : Crear una ventana dividida donde un treeview a la izquierda, muestre las entradas de las plantillas y a la derecha un editor vhdl en modo solo lectura muestre un preview de las plantillas antes de agregarlas. }
procedure TMainForm.SetupEdTmplMenu;
var
  Ini:TIniFile;
  M:TMenuItem;
  S:String;
  i,j:integer;
  EdTemplates:TPopupMenu;

  procedure AutoCompleteAdd(Template:String);
  var
    j,n:integer;
  begin
    SynAutoComplete.AutoCompleteList.Add(Ini.ReadString(Template,'AutoComplete',''));
    j:=Ini.ReadInteger(Template,'Lines',0);
    for n:=0 to j-1 do SynAutoComplete.AutoCompleteList.Add('='+Ini.ReadString(Template,'L'+inttostr(n),''));
  end;

  procedure CreateSubMenu(N:TMenuItem);
  var
    M:TMenuItem;
    S:String;
    i,j:integer;
  begin
    If not assigned(N) then exit;
    if Ini.ValueExists(N.Caption,'AutoComplete') then
      AutoCompleteAdd(N.Caption);
    if Ini.ValueExists(N.Caption,'NumItems') then
    begin
      j:=Ini.ReadInteger(N.Caption,'NumItems',0);
      for i:=0 to j-1 do
      begin
        S:=Ini.ReadString(N.Caption,'I'+inttostr(i),'');
        M:=TMenuItem.Create(N);
        M.Caption:=S;
        CreateSubMenu(M);
        N.Add(M);
      end;
    end else
    begin
      N.OnClick:=@EditInsertTemplateExecute;
      N.ImageIndex:=31;
    end;
  end;

begin
  SynAutoComplete.AutoCompleteList.Clear;
  EdTemplates:= TPopupMenu.Create(Self);
  with EdTemplates do
  Try
    Ini:=TIniFile.Create(ConfigDir+'templates.ini',[ifoStripQuotes]);
    j:=Ini.ReadInteger('MAIN','NumItems',0);
    for i:=0 to j-1 do
    begin
      S:=Ini.ReadString('MAIN','I'+inttostr(i),'');
      M:=TMenuItem.Create(EdTemplates);
      M.Caption:=S;
      EdTemplates.Items.Add(M);
      CreateSubMenu(M);
    end;
    EdTemplates.Images:=ImageList;
    EdTemplateButton.DropdownMenu:=EdTemplates;
  finally
    If Assigned(Ini) then FreeAndNil(Ini);
  end;
end;

procedure TMainForm.SetupNewEdMenu;
var
  M,N:TMenuItem;
  S:TStringList;
  i:integer;
  EdNewMenu:TPopupMenu;
begin
  EdNewMenu := TPopupMenu.Create(Self);
  try
    S:=GetFileTypeKey;
    for i:=0 to S.Count-1 do
    begin
     M:=TMenuItem.Create(EdNewMenu);
     M.Caption:=S.Names[i];
     M.Hint:=S.ValueFromIndex[i];
     M.OnClick:=@NewFileMenuExecute;
     M.ImageIndex:=5;
     EdNewMenu.Items.Add(M);
    //
     N:=TMenuItem.Create(FileNewMenu);
     N.Caption:=S.Names[i];
     N.Hint:=S.ValueFromIndex[i];
     N.OnClick:=@NewFileMenuExecute;
     N.ImageIndex:=5;
     FileNewMenu.Add(N);
    end;
    EdNewMenu.Images:=ImageList;
    TBEditNew.DropdownMenu:=EdNewMenu;
  finally
    If Assigned(S) then FreeAndNil(S);
  end;
end;

procedure TMainForm.SetupPrgEditor;
begin
  PrgEditor:=TEditor.Create(PrgPage);
  Dec(EditorCnt);
  PrgEditor.PopupMenu:=EditorPopUp;
  PrgEditor.Align:=alClient;
  PrgEditor.Parent:=PrgPage;
  PrgEditor.BookMarkOptions.BookmarkImages:=MarkImages;
  PrgEditor.OnStatusChange:=@EditorStatusChange;
end;

procedure TMainForm.NewFileMenuExecute(Sender: TObject);
begin
  if (Sender.ClassName='TMenuItem') then
  begin
    Info('TMainForm.NewFileMenuExecute','Menu: '+TMenuItem(Sender).Caption);
    NewEditorPage(GetFileType('F'+TMenuItem(Sender).Hint))
  end;
end;


function TMainForm.NewEditorPage(EdType:TEdType): TEditor;
var
  Editor:TEditor;
  f:string;
  var Tab:integer;
begin
  Editor:=TEditor.Create(Self);
  Editor.PopupMenu:=EditorPopUp;
  Editor.Colorize(ThemeFile);
  f:=cDefNewFileName+inttostr(EditorCnt)+GetFileExt(EdType);
  Editor.FileName:=ProjectsDir+f;
  Editor.Align:=alClient;
  Editor.Parent:=EditorPages;
  EditorTabs.AddTab(-1,f,Editor,false,clNone,-1,EdTabMenu,[],Editor.FileName);
  Tab:=EditorTabs.TabCount-1;
  Editor.Page:=EditorTabs.GetTabData(Tab);
  Editor.EdType:=EdType;
  Editor.BookMarkOptions.BookmarkImages:=MarkImages;
  Editor.OnStatusChange:=@EditorStatusChange;
  Editor.OnFileNameChanged:=@EditorNameChanged;
  selectHighlighter(Editor);
  EditorTabs.TabIndex:=Tab;
  Result:=Editor;
end;

procedure TMainForm.FormDestroy(Sender: TObject);
begin
  Info('TMainForm','Start of FormDestroy');
  if Assigned(FilesMon) then FilesMon.Terminate;
  if Assigned(PlugInsList) then FreeandNil(PlugInsList);
  if Assigned(ProgramsList) then FreeandNil(ProgramsList);
  if Assigned(SnippetsList) then FreeandNil(SnippetsList);
  if Assigned(IPCoreList) then FreeandNil(IPCoreList);
  if Assigned(SBASnippet) then FreeandNil(SBASnippet);
  If Assigned(SBAContrlrProg) then FreeandNil(SBAContrlrProg);
  if assigned(SBAPrj) then FreeAndNil(SBAPrj);
  if assigned(AutoUpdate) then FreeAndNil(AutoUpdate);
  Info('TMainForm','End of FormDestroy');
end;

procedure TMainForm.FormDropFiles(Sender: TObject;
const FileNames: array of String);
var
  f:string;
  i:integer;
begin
  If ActivePanel=SystemPanel then MainGotoEditorExecute(nil);
  For i:=0 to Length(FileNames)-1 do
  begin
    f:=FileNames[i];
    if fileexists(f) then OpenInEditor(f);
  end;
end;

procedure TMainForm.HelpAboutExecute(Sender: TObject);
begin
  AboutForm.ShowModal;
end;

procedure TMainForm.LogDblClick(Sender: TObject);
var
  p:tpoint;
  s:string;
begin
  { TODO : Extraer el nombre del archivo y mostrar la pestaña correspondiente a ese archivo o abrirlo si no lo está, antes de saltar al número de línea que contiene el error. }
  //Si se convierte al Log en un Editor: if Editor.SelAvail then s:=Editor.SelText else exit;
  s:=Log.GetSelectedText; if s='' then exit;
  if s[2]=':' then s[2]:=' '; //to remove ':' in drive letter
  if pos('line ',s)=1 then s[5]:=':';  // for catch hdlobf result errors
  p.y:=strtointdef(ExtractDelimited(2,s,[':']),0);
  p.x:=strtointdef(ExtractDelimited(3,s,[':']),0);
  if (p.y<>0) then ActEditor.CaretXY:=p;
  ActEditor.SetFocus;
end;

procedure TMainForm.LogMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  k: integer;
  s: string;
begin
  k := Log.ItemAtPos(Point(X,Y),true);
  if fOldIndex <> k then Application.CancelHint;
  fOldIndex:= k;
  if k = -1 then begin
    Log.ShowHint:=false;
  end else begin
    s := Log.Items[k];
    if Log.Canvas.TextWidth(s)>Log.Width-10 then begin
      Log.ShowHint := true;
      Log.Hint := Log.Items[k];
    end else begin
      Log.ShowHint := false;
    end;
  end;
end;

procedure TMainForm.SBA_OpenExecute(Sender: TObject);
begin
  if ActEditor.Modified then
  case MessageDlg('File was modified', 'Save File? ', mtConfirmation, [mbYes, mbNo, mbCancel],0) of
    mrCancel: exit;
    mrYes: SBA_SaveExecute(nil);
  end;
  PrgEditor.Modified:=false;
  OpenDialog.FileName:='';
  OpenDialog.InitialDir:=ExtractFilePath(SBAContrlrProg.Filename);
  OpenDialog.DefaultExt:='.prg';
  OpenDialog.Filter:='PRG and SNP files|*.prg;*.snp|PRG file|*.prg|SNP file|*.snp';
  if OpenDialog.Execute and Open(OpenDialog.FileName) then
  begin
    SBAContrlrProg.FileName:=OpenDialog.FileName;
    ExtractSBALabels;
  end;
end;

procedure TMainForm.SBA_ReturnToEditorExecute(Sender: TObject);
var
  Editor:TEditor;
  undostrings:TStringList;
begin
  if PrgReturn<>@GotoEditor then exit;
  Editor:=GetActiveEditorPage;
  If assigned(Editor) then
  try
    undostrings:=TStringList.Create;
    Editor.BeginUpdate(false);
    PrgEditor.BeginUpdate(false);

    undostrings.Assign(Editor.Lines);
    if not SBAContrlrProg.CpyProgDetails(PrgEditor.Lines, Editor.Lines) then
    begin
      Editor.ClearAll;
      Editor.Lines.Assign(undostrings);
      ShowMessage('Error Copying program details: Please verify "'+cSBAStartProgDetails+'" signatures.');
      Exit;
    end;

    undostrings.Assign(Editor.Lines);
    if not SBAContrlrProg.CpyUSignals(PrgEditor.Lines, Editor.Lines) and CtrlAdvMode then
    begin
      Editor.ClearAll;
      Editor.Lines.Assign(undostrings);
      ShowMessage('Error Copying User signals and type definitions: Please verify "'+cSBAStartUSignals+'" signatures.');
      Exit;
    end;

    undostrings.Assign(Editor.Lines);
    if not SBAContrlrProg.CpyUProcedures(PrgEditor.Lines, Editor.Lines) and CtrlAdvMode then
    begin
      Editor.ClearAll;
      Editor.Lines.Assign(undostrings);
      ShowMessage('Error Copying User Procedures and Functions: Please verify "'+cSBAStartUProc+'" signatures.');
      Exit;
    end;

    undostrings.Assign(Editor.Lines);
    if not SBAContrlrProg.CpyProgUReg(PrgEditor.Lines, Editor.Lines) then
    begin
      Editor.ClearAll;
      Editor.Lines.Assign(undostrings);
      ShowMessage('Error Copying user registers and constants: Please verify "'+cSBAStartProgUReg+'" signatures.');
      Exit;
    end;

    undostrings.Assign(PrgEditor.Lines);
    if not SBAContrlrProg.GenLblandProgFormat(PrgEditor.Lines,L_SBALabels.Items) then
    begin
      PrgEditor.Lines.Assign(undostrings);
      ExtractSBALabels;
      ShowMessage('Error Generating Labels constants and formating user program: Program format error, please verify "/SBA:" signatures.');
      Exit;
    end;

    undostrings.Assign(Editor.Lines);
    if not SBAContrlrProg.CpyProgLabels(L_SBALabels.Items, Editor.Lines) then
    begin
      Editor.ClearAll;
      Editor.Lines.Assign(undostrings);
      ShowMessage('Error Copying User generated labels to controller: Please verify "'+cSBAStartProgLabels+'" signature in the controller.');
      Exit;
    end;

    undostrings.Assign(Editor.Lines);
    if not SBAContrlrProg.CpyUserProg(PrgEditor.Lines, Editor.Lines) then
    begin
      Editor.ClearAll;
      Editor.Lines.Assign(undostrings);
      ShowMessage('Error Copying User program to controller: Please verify "'+cSBAStartUserProg+'" signatures.');
      Exit;
    end;

    undostrings.Assign(Editor.Lines);
    if not SBAContrlrProg.CpyUStatements(PrgEditor.Lines, Editor.Lines) and CtrlAdvMode then
    begin
      Editor.ClearAll;
      Editor.Lines.Assign(undostrings);
      ShowMessage('Error Copying User Statements: Please verify "'+cSBAStartUStatements+'" signatures.');
      Exit;
    end;

    PrgEditor.ClearAll;
    SBAContrlrProg.FileName:=cSBADefaultPrgName;
    PrgEditor.Modified:=false;

  finally
    If assigned(undostrings) then FreeAndNil(undostrings);
    PrgEditor.EndUpdate;
    Editor.EndUpdate;
    Editor.Modified:=true;
    GotoEditor;
    UpdGuiTimer.Enabled:=true;
  end;
end;

procedure TMainForm.SBA_SaveAsExecute(Sender: TObject);
begin
  SaveDialog.FileName:=ExtractFileName(SBAContrlrProg.FileName);
  SaveDialog.InitialDir:=ExtractFilePath(SBAContrlrProg.FileName);
  SaveDialog.DefaultExt:='.prg';
  SaveDialog.Filter:='PRG and SNP files|*.prg;*.snp|PRG file|*.prg|SNP file|*.snp';
  if SaveDialog.Execute and SaveFile(SaveDialog.FileName, PrgEditor.Lines) then
  begin
    SBAContrlrProg.FileName:=SaveDialog.FileName;
    PrgEditor.Modified:=false;
    ExtractSBALabels;
    StatusBar1.Panels[1].Text:=SaveDialog.FileName;
  end;
end;

procedure TMainForm.SBA_SaveExecute(Sender: TObject);
begin
  If SBAContrlrProg.FileName<>cSBADefaultPrgName then
  begin
    SaveFile(SBAContrlrProg.FileName,PrgEditor.Lines);
    PrgEditor.Modified:=false;
    ExtractSBALabels;
  end
  else SBA_SaveAsExecute(Sender);
end;

procedure TMainForm.AsyncLoadPlugIns(Data: PtrInt);
begin
  LoadPlugIns;
end;

procedure TMainForm.ToolsReloadPlugInsExecute(Sender: TObject);
begin
  Application.QueueAsyncCall(@AsyncLoadPlugIns,0);
end;

procedure TMainForm.UpdGuiTimerTimer(Sender: TObject);
var
  Tab:TATTabdata;
begin
  UpdGuiTimer.Enabled:=false;
  Info('TMainForm.UpdGuiTimerTimer','Tick');
  if SBAPrj.Name<>'' then L_PrjInfo.Caption:=IFTHEN(SBAPrj.Modified,'Project Modified','Project Info');
  if assigned(ActEditor) then
  begin
    Info('TMainForm.UpdGuiTimerTimer',ActEditor.FileName);
    StatusBar1.Panels[1].Text:=ActEditor.FileName;
    ChangeEditorButtons(ActEditor);
    if assigned(ActEditor.Page) then
    begin
      Tab:=ActEditor.Page as TATTabData;
      Tab.TabModified:=ActEditor.Modified;
      EditorTabs.Invalidate;
    end;
    DetectSBAController(ActEditor);
    SplitEd.Invalidate;
    If SplitEd.Focused then ActiveControl:=SplitEd else ActiveControl:=ActEditor;
  end;
end;

procedure TMainForm.WordMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var
  k: integer;
  s: string;
begin
  k := TListBox(Sender).ItemAtPos(Point(X,Y),true);
  if fOldIndex <> k then Application.CancelHint;
  fOldIndex:= k;
  if k = -1 then begin
    TListBox(Sender).ShowHint:=false;
  end else begin
    s := TListBox(Sender).Items[k];
    if TListBox(Sender).Canvas.TextWidth(s)>TListBox(Sender).Width-10 then begin
      TListBox(Sender).ShowHint := true;
      TListBox(Sender).Hint := TListBox(Sender).Items[k];
    end else begin
      TListBox(Sender).ShowHint := false;
    end;
  end;
end;

procedure TMainForm.WordSelectionChange(Sender: TObject);
Var S:String;
begin
  s:=TListBox(Sender).GetSelectedText;
  if ActEditor.EdType in [vhdl,ini,prg,other] then ActEditor.SetHighlightSearch(S,[ssoSelectedOnly,ssoWholeWord])
    else ActEditor.SetHighlightSearch(S,[ssoMatchCase,ssoSelectedOnly,ssoWholeWord]);
end;

procedure TMainForm.FileNewExecute(Sender: TObject);
var edType:TedType;
begin
  if assigned(ActEditor) then edType:=ActEditor.EdType else edType:=vhdl;
  NewEditorPage(edType);
end;

procedure TMainForm.FileOpenExecute(Sender: TObject);
begin
  Info('FileOpenExecute','InitialDir='+wdir);
  OpenDialog.FileName:='';
  OpenDialog.InitialDir:=wdir;
  OpenDialog.DefaultExt:='.vhd';
  OpenDialog.Filter:=DefFileFilter;
  if OpenDialog.Execute then OpenInEditor(OpenDialog.FileName);
end;

procedure TMainForm.DetectSBAController(Editor: TEditor);
begin
  if assigned(Editor) and (Editor.EdType=vhdl) then
    SBA_EditProgram.Enabled:=SBAContrlrProg.DetectSBAContrlr(Editor.Lines)
  else SBA_EditProgram.Enabled:=false;
end;

procedure TMainForm.ToolProcessReadData(Sender: TObject);
var
  t:TStringList;
  s:string;

  function t2s(str:string;n:integer):string;
  var l,m:integer;
  begin
    if str='' then exit('');
    m:=1;
    l:=posEx(#09,str,m);
    if l>0 then ShowMessage(inttostr(l));
    while l>0 do
    begin
      m:=l div n;
      if (l mod n)>0 then inc(m);
      m:=m*n;
      str:=StuffString(str,l,1,DupeString(' ',m-l));
      l:=posEx(#09,str,m);
    end;
    result:=str;
  end;

begin
   t:=TStringList.Create;
   t.LoadFromStream(ToolProcess.Output);
   for s in t do Log.Items.Add(t2s(ConsoleToUtf8(s),8));
   info('TMainForm.ToolProcessReadData',t);
   t.free;
end;


procedure TMainForm.ToolProcessTerminate(Sender: TObject);
var
  PS:TProcessStatus;
  PStr:String;
begin
  PS:=ProcessStatus;
  ProcessStatus:=Idle;
  EndProcTimer.Enabled:=false;
  try
    if ToolProcess.NumBytesAvailable>0 then ToolProcessReadData(Sender);
  except
    ON E:Exception do InfoErr('TMainForm.ToolProcessTerminate Error',E.Message);
  end;
  Log.ItemIndex:=Log.Count-1;
  case PS of
    SyntaxChk: ToolsFileSyntaxCheck.Enabled:=true;
  end;
{IFDEF Debug}
  WriteStr(PStr,PS);
  info('TMainForm.ToolProcessTerminate','End of process: '+PStr);
{ENDIF}
end;

procedure TMainForm.HighLightReservedWords(List:TStrings);
begin
  if List<>nil then
  begin
    SynSBASyn.HLWordsList.Assign(List);
    SynVerilogSyn.HLWordsList.Assign(List);
  end else
  begin
    SynSBASyn.HLWordsList.Clear;
    SynVerilogSyn.HLWordsList.Clear;
  end;
  ActEditor.Invalidate;
  SplitEd.Invalidate;
end;

procedure TMainForm.EditorStatusChange(Sender: TObject;
  Changes: TSynStatusChanges);
var
  wsel:integer;
begin
  if ([scCaretX, scCaretY] * Changes) <> [] then
  begin
    if TEditor(Sender).SelAvail then
      wsel:=TEditor(Sender).SelEnd-TEditor(Sender).SelStart
    else
      wsel:=0;
    StatusBar1.Panels[0].Text:=Format('%4d:%-4d %4d',[TEditor(Sender).CaretY,TEditor(Sender).CaretX,wsel]);
    if MiniMap.Visible then MiniMap.CaretXY:=TEditor(Sender).CaretXY;
  end;
  if scModified in Changes then
  begin
    UpdGuiTimer.Enabled:=true;
    Info('SysEditStatusChange','scModified is in Changes');
  end;
  if (scFocus in Changes) and TEditor(Sender).Focused then
  begin
    ChangeEditorButtons(TEditor(Sender));
    SyncroEdit.Enabled:=false;
    SyncroEdit.Editor:=TEditor(Sender);
    SyncroEdit.Enabled:=true;
    SynMultiCaret.Editor:=TEditor(Sender);
    SynAutoComplete.AddEditor(TEditor(Sender));
  end;
  SyncMiniMap.Enabled:=true;
end;

function TMainForm.Open(f:String):boolean;
begin
  result:=false;
  if FileExists(f) and assigned(ActEditor) then
  begin
    ActEditor.Lines.LoadFromFile(f);
    ActEditor.FileName:=f;
    selectHighlighter(ActEditor);
    ActEditor.ReadOnly:=(FileGetAttr(f) and faReadOnly)<>0;
    ActEditor.Modified:=false;
    wdir:=extractfilepath(f);
    if wdir='' then wdir:=IFTHEN(SBAPrj.name<>'',SBAPrj.location,ProjectsDir);
    StatusBar1.Panels[1].Text:=f;
    if (ActEditor<>PrgEditor) then
    begin
      FilesMon.AddFile(f);
      EditorHistory.UpdateList(f);
      SetupTBEditOpenPopUp;
    end;
    result:=true;
  end else showmessage('The file: '+f+' was not found.');
end;

procedure TMainForm.OpenInEditor(const f: string);
var
  i:integer;
  //Editor:TEditor;
begin
  if f='' then exit;
  Info('TMainForm.OpenInEditor',f);
  if (EditorTabs.TabCount=0) then NewEditorPage(GetFileType(f)) else
    for i:=0 to EditorTabs.TabCount-1 do  //Search for already open file
      if TEditor(EditorTabs.GetTabData(i).TabObject).FileName=f then
      begin
        EditorTabs.TabIndex:=i;
//        ForceEditorPagesChange;
        break;
      end;
  if TEditor(EditorTabs.GetTabData(EditorTabs.TabIndex).TabObject).FileName<>f then
  begin
    if not ActEditor.isEmpty then NewEditorPage(GetFileType(f));
    Open(f);
  end;
  UpdGuiTimer.Enabled:=true;
end;

procedure TMainForm.ChangeEditorButtons(var Editor: TEditor);
var
  f1,f2,f3:boolean;
begin
  if (ActivePanel<>EditorsPanel) or not assigned(Editor) then exit;
  //Info('TMainForm.ChangeEditorButtons',Editor.FileName);
  //Info('Editor.Modified',Editor.Modified);
  //Info('EditorEmpty',Editor.isEmpty);
  //Info('Editor.ReadOnly',Editor.ReadOnly);
  f1:=Editor.Modified;
  f2:=not Editor.isEmpty;
  f3:=not Editor.ReadOnly;
  FileRevert.Enabled:=f1;
  FileSave.Enabled:=f1;
  ToolsFileSyntaxCheck.Enabled:=f2;
  ToolsExporttoHtml.Enabled:=f2;
  SearchReplace.Enabled:=f3;
end;

procedure TMainForm.SyntaxCheck(f, path: string; hdl: TEdType);
var
  s,wpath,fname,checkbat:string;
begin
  s:=Copy(GetFileExt(hdl),2,3);
  checkbat:='check'+s;
  {$IFDEF WINDOWS}
  checkbat:=checkbat+'.bat';
  {$ENDIF}
  {$IFDEF LINUX}
  checkbat:=checkbat+'.sh';
  {$ENDIF}
  {$IFDEF DARWIN}
  checkbat:=checkbat+'.sh';
  {$ENDIF}
  if not fileexists(AppDir+checkbat) then
  begin
    showmessage('There is not support for this kind of file: .'+s);
    ToolsFileSyntaxCheck.Enabled:=true;
    exit;
  end;
  wpath:=extractfilepath(f);
  fname:=extractfilename(f);
  Log.Clear;
  Log.Items.Add('Starting External Syntax Check Tool, please wait...');
  if not ToolProcessWaitforIdle then
  begin
    ShowMessage('There was an error when executing external tool for syntax check');
    ToolsFileSyntaxCheck.Enabled:=true;
    exit;
  end;
  ToolProcess.Parameters.Clear;
  ToolProcess.CurrentDirectory:=wpath;
  {$IFDEF WINDOWS}
  ToolProcess.Executable:='cmd.exe';
  ToolProcess.Parameters.Add('/c');
  // Hay un bug en el CMD /C que no interpreta adecuadamente las rutas con paréntesis
  // La inclusión de los dobles "" ayuda en la solución temporal del bug
  if path<>'' then
    ToolProcess.Parameters.Add('""'+AppDir+checkbat+'" '+fname+' "'+path+'""')
  else

{ TODO : Evaluar si se trata de un IPCORE (tiene INI) en caso afirmativo agregar
         también los IPCore requeridos al Path en forma recursiva.
         Todo puede ser movido, incluída la insersión del paquete por defecto
         a una función que de el formato necesario al path, antes de llegar
         a esta función. }

    //Por defecto se agrega una versión estable del SBAPackage en la ruta del ghdl si no existe antes en el directorio de trabajo
    if not fileexists(wpath+cSBApkg) then
      ToolProcess.Parameters.Add('""'+AppDir+checkbat+'" '+fname+' "'+SBAbaseDir+cSBApkg+'""')
    else
      ToolProcess.Parameters.Add('""'+AppDir+checkbat+'" '+fname+'"');
  {$ENDIF}
  {$IFDEF LINUX}
  ToolProcess.Executable:='/bin/bash';
  ToolProcess.Parameters.Add('-c');
  if path<>'' then
    ToolProcess.Parameters.Add(AppDir+checkbat+' '+fname+' "'+path+'"')
  else
    //Por defecto se agrega una versión estable del SBAPackage en la ruta del ghdl si no existe antes en el directorio de trabajo
    //Versión estable del SBAPackage: SBAbaseDir+cSBApkg
    if not fileexists(wpath+cSBApkg) then
      ToolProcess.Parameters.Add(AppDir+checkbat+' '+fname+' "'+SBAbaseDir+cSBApkg+'"')
    else
      ToolProcess.Parameters.Add(AppDir+checkbat+' '+fname);
  {$ENDIF}
  {$IFDEF DARWIN}
  ToolProcess.Executable:='sh';
  ToolProcess.Parameters.Add('-c');
  if path<>'' then
    ToolProcess.Parameters.Add(AppDir+checkbat+' '+fname+' "'+path+'"')
  else
    //Por defecto se agrega una versión estable del SBAPackage en la ruta del ghdl si no existe antes en el directorio de trabajo
    //Versión estable del SBAPackage: SBAbaseDir+cSBApkg
    if not fileexists(wpath+cSBApkg) then
      ToolProcess.Parameters.Add(AppDir+checkbat+' '+fname+' "'+SBAbaseDir+cSBApkg+'"')
    else
      ToolProcess.Parameters.Add(AppDir+checkbat+' '+fname);
  {$ENDIF}
  info('TMainForm.SyntaxCheck',ToolProcess.Parameters);
  ProcessStatus:=SyntaxChk;
  EndProcTimer.Enabled:=true;
  ToolProcess.Execute;
  { TODO : Pensar en eliminar el .bat y usar una lista para crear los parámetros debido a las posibles rutas con espacios. }
end;

function TMainForm.ToolProcessWaitforIdle:boolean;
var
  TiO:integer;
  S:string;
begin
  TiO:=100; // Wait for 10 seconds
  While (TiO>0) and (ProcessStatus<>Idle) do
  begin
    Dec(TiO);
    Application.ProcessMessages;
    Sleep(100);
  end;
//
  if (ProcessStatus<>Idle) and not ToolProcess.Running then
  begin
    info('TMainForm.ToolProcessWaitforIdle','el proceso ya no está en ejecución, forzando un Onterminate');
    if ToolProcess.OnTerminate<>nil then ToolProcess.OnTerminate(Self);
    info('TMainForm.ToolProcessWaitforIdle','---- forzado----');
  end;
//
  result:=ProcessStatus=Idle;
  Info('TMainForm.ToolProcessWaitforIdle',IFTHEN(result,'is Idle','can not terminate: Time Out'));
  if not result then
  begin
    WriteStr(S,ProcessStatus);
    Info('TMainForm.ToolProcessWaitforIdle','timeout: '+S);
    //Terminar el proceso que ejecuta si este falla
    EndProcTimer.Enabled:=false;
    ToolProcess.Terminate(0);
    ProcessStatus:=TimeOut;
  end;
end;

procedure TMainForm.ExtractSBALabels;
var
  sl:TStringList;
  l:TListItem;
begin
  ActEditor.BeginUpdate(false);
  if SBAContrlrProg.ExtractSBALbls(ActEditor.Lines, L_SBALabels.Items) then
  begin
    sl:=TStringList.Create;
    For l in L_SBALabels.Items do sl.Add(l.Caption);
    HighLightReservedWords(sl);
    sl.Free;
  end;
  ActEditor.EndUpdate;
end;

procedure TMainForm.UpdatePrjTree;
var
  t: TTreeNode;
begin
  PrjTree.BeginUpdate;
  PrjTree.Items.Clear;

  t:=PrjTree.Items.AddChild(nil,SBAPrj.Name);
  PrjTree.Items.AddChild(t, 'Top').StateIndex:=2;
  PrjTree.Items.AddChild(t, 'SBAcfg').StateIndex:=2;
  PrjTree.Items.AddChild(t, 'SBActrlr').StateIndex:=2;
  case SBAPrj.SBAver of
    0: PrjTree.Items.AddChild(t, 'SBAdcdr').StateIndex:=2;
    1: PrjTree.Items.AddChild(t, 'SBAmux').StateIndex:=2;
  end;

  t:=PrjTree.Items.AddChild(nil, 'Aux');
  PrjTree.Items.AddChild(t, 'SBApkg').StateIndex:=3;
  PrjTree.Items.AddChild(t, 'Syscon').StateIndex:=3;
  if SBAPrj.SBAver=0 then PrjTree.Items.AddChild(t, 'DataIntf').StateIndex:=3;

  t:=PrjTree.Items.AddChild(nil, 'Lib');
  AddIPCoresToTree(t,SBAPrj.libcores);

  t:=PrjTree.Items.AddChild(nil, 'User');
  AddUserFilesToTree(t,SBAPrj.UserFiles);

  PrjTree.FullExpand;
  PrjTree.EndUpdate;
  L_PrjInfo.Caption:=IFTHEN(SBAPrj.Modified,'Project Modified','Project Info');
end;

procedure TMainForm.AddIPCoresToTree(t:TTreeNode;cl:TStrings);
var
  i:integer;
  c:TTreeNode;
  s,v:string;
  l:TStringList;
begin
  if (not assigned(cl)) or (cl.Count=0) then exit;
  if t.Level>5 then
  begin
    PrjTree.Items.AddChild(t,'...');
    exit;
  end;
  for i:=0 to cl.Count-1 do
  begin
    v:=cl[i];
    s:=Copy2SymbDel(v,'=');
    if (v<>'UserFiles') then  // Do not insert Core user files in tree
    begin
      c:=PrjTree.Items.AddChild(t,s);
      case v of
        'IPCores','':c.StateIndex:=4;   // if v='' the files are IPCores
        'Packages'  :c.StateIndex:=3;
        else c.StateIndex:=5;
      end;
      l:=SBAIpCore.GetReq(s);
      AddIPCoresToTree(c,l);
      if assigned(l) then freeandnil(l);
    end;
  end;
end;

procedure TMainForm.AddUserFilesToTree(const t: TTreeNode;cl:TStrings);
var
  l: TStringList;
  s: string;
  i: integer;
begin
  l:=FindAllFiles(SBAPrj.location+CPrjUser);
  for s in l do if cl.IndexOfName(ExtractFileName(s))=-1 then
      PrjTree.Items.AddChild(t, ExtractFileName(s)).StateIndex:=5;
  if cl.Count>0 then for i:=0 to cl.Count-1 do
     PrjTree.Items.AddChild(t, cl.names[i]).StateIndex:=5;
  if assigned(l) then FreeAndNil(l);
end;

function TMainForm.CloseProg: boolean;
begin
  if PrgEditor.Modified then
  begin
    GotoProgEdit;
    case MessageDlg('Prg was modified', 'Save File? '+SBAContrlrProg.FileName,
       mtConfirmation, [mbYes, mbNo, mbCancel], 0) of
       mrYes: Result:=SaveFile(SBAContrlrProg.FileName,PrgEditor.Lines);
       mrNo: Result:=true;
    else Result:=false;
    end;
  end else Result:=true;
end;

procedure TMainForm.Check;
Var ExpDate : TDateTime;
begin
  Info('TMainForm.Check','Compilation Date: '+{$I %date%});
  if TryStrToDate({$I %date%}, ExpDate, 'YYYY/MM/DD', '/') then
  begin
    ExpDate:=IncMonth(ExpDate,6);
  end else ExpDate:=EncodeDate(2020,12,31);
(*
  try
    ExpDate:=IncMonth(ScanDateTime('yyyy/mm/dd',{$I %date%}),6);
  except
    ON E:Exception do
    begin
      Info('TMainForm.Check Error',E.Message);
      ExpDate:=EncodeDate(2019,12,31);
    end;
  end;
*)
  Info('TMainForm.Check','Expiration on: '+DateToStr(ExpDate));
  if CompareDate(Today,ExpDate)>0 then
  begin
    ShowMessage('Sorry, this beta version has expired. You can download the new version from http://sba.accesus.com, thanks you for your support!');
    CheckUpdate;
    If Assigned(AutoUpdate) then FreeAndNil(AutoUpdate);
    halt;
  end;
end;

function TMainForm.selectHighlighter(var Editor:TEditor):TEdType;
begin
  If Editor=nil then
  begin
    result:=None;
    exit;
  end;

  result:=Editor.Edtype;
  Editor.selectHighlighter;

  if assigned(SplitEd) then
  begin
    SplitEd.EdType:=Editor.EdType;
    SplitEd.Highlighter:=Editor.Highlighter;
    SplitEd.Options:=Editor.Options;
  end;
  if assigned(MiniMap) then
  begin
    MiniMap.EdType:=Editor.EdType;
    MiniMap.Highlighter:=Editor.Highlighter;
  end;
  if FileExists(AppDir+'wordlist'+GetFileExt(Editor.EdType)+'.txt') then
    if CopyFile(AppDir+'wordlist'+GetFileExt(Editor.EdType)+'.txt',ConfigDir+'wordlist'+GetFileExt(Editor.EdType)+'.txt')then
      DeleteFile(AppDir+'wordlist'+GetFileExt(Editor.EdType)+'.txt');
  if FileExists(ConfigDir+'wordlist'+GetFileExt(Editor.EdType)+'.txt') then
    Editor.SynCompletion.ItemList.LoadFromFile(ConfigDir+'wordlist'+GetFileExt(Editor.EdType)+'.txt');
end;

procedure TMainForm.GetFile(filename: string);
var
  f:String;
  Dwt:TDownloadThread;
begin
  f:=ConfigDir+filename;
  DwT:=TDownloadThread.create(Format(SBADwUrl,[filename]),f);
  DwT.OnDownloaded:=@LoadAnnouncement;
  DwT.start;
end;

procedure TMainForm.LoadAnnouncement;
begin
  if Fileexists(ConfigDir+'newbanner.gif') then
  try
    AnnouncementImage.AnimatedGifToSprite(ConfigDir+'newbanner.gif');
    info('TMainForm.LoadAnnouncement','Banner loaded');
  except
    ON E:Exception do
    begin
      DeleteFile(ConfigDir+'newbanner.gif');
      InfoErr('TMainForm.LoadAnnouncement','Error loading new banner:'+E.Message);
    end;
  end;
end;

procedure TMainForm.FileChanged(Sender: TObject);
var
  s:string;
  Editor:TEditor;
  Tab:integer;
begin
  if not EnableFilesMon then exit;
  Editor:=GetEditorFile(TFilesMon(Sender).FileChanged);
  Info('TMainForm.FileChanged',Editor.FileName);
  if assigned(Editor.Page) then
  begin
    Tab:=TATTabData(Editor.Page).Index;
    EditorTabs.TabIndex:=Tab;
//    ForceEditorPagesChange;
  end;
  s:='The file has been altered by an external program. Do you wish to '+
     'reload the document?';
  if assigned(Editor) and Editor.Modified then
    s:=s+#$0a#$0a+'Warning! The open file has been modified. If you reload the '+
       'file, the changes will be lost.';
  s:=s+#$0a#$0a+TFilesMon(Sender).FileChanged;
  if MessageDlg(s, mtConfirmation, [mbYes, mbNo],0)=mrYes then FileRevertExecute(Self);
end;

procedure TMainForm.Colorize(ini: string);
var
  IniFile:TIniFile;
  i:integer;

begin
  try
    IniFile:=TIniFile.Create(ini);
    With IniFile do
    begin
      Color:=StringToColor(ReadString('MainForm','Color','clDefault'));
      Font.Color:=StringToColor(ReadString('MainForm','FontColor','clDefault'));
      Log.Color:=StringToColor(ReadString('MainForm','Color','clDefault'));
      Log.Font.Color:=StringToColor(ReadString('MainForm','FontColor','clDefault'));
      SnippetDescription.Color:=StringToColor(ReadString('Editor','Color','clWhite'));
      SnippetDescription.Font.Color:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
      //
      if assigned(SynIniSyn) then
      begin
        SynIniSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynIniSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynIniSyn.StringAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynIniSyn.SymbolAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynIniSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynIniSyn.SectionAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSectionAttriFg','clNavy'));
        SynIniSyn.SectionAttri.Background:=StringToColor(ReadString('Editor','HighlighterSectionAttriBg','clSkyBlue'));
        SynIniSyn.TextAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterTextAttriFg','clNone'));
      end;
      if assigned(SynFreePascalSyn) then
      begin
        SynFreePascalSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynFreePascalSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynFreePascalSyn.StringAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynFreePascalSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynFreePascalSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynFreePascalSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynFreePascalSyn.StringAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynFreePascalSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
      end;
      if assigned(SynPythonSyn) then
      begin
        SynPythonSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynPythonSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynPythonSyn.SymbolAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynPythonSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynPythonSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynPythonSyn.HexAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynPythonSyn.OctalAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynPythonSyn.FloatAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynPythonSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynPythonSyn.StringAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynPythonSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynPythonSyn.CommentAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynPythonSyn.SystemAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynPythonSyn.NonKeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterAttribFg','$000080FF'));
        SynPythonSyn.DocStringAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterAttribFg','$000080FF'));
      end;
      if assigned(SynSBASyn) then
      begin
        SynSBASyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynSBASyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynSBASyn.StringAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynSBASyn.SymbolAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynSBASyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynSBASyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynSBASyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynSBASyn.AttribAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterAttribFg','$000080FF'));
        SynSBASyn.IeeeAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIeeeAttriFg','$00804000'));
        SynSBASyn.SBAAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSBAAttriFg','$00C08000'));
        SynSBASyn.StringAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynSBASyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
      end;
      if assigned(SynJSONSyn) then
      begin
        SynJSONSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynJSONSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynJSONSyn.AttribAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterAttribFg','$000080FF'));
        SynJSONSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynJSONSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynJSONSyn.ValueAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
      end;
      if assigned(SynVerilogSyn) then
      begin
        SynVerilogSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynVerilogSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynVerilogSyn.StringAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynVerilogSyn.SymbolAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynVerilogSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynVerilogSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynVerilogSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynVerilogSyn.AttribAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterAttribFg','$000080FF'));
        SynVerilogSyn.IeeeAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIeeeAttriFg','$00804000'));
        SynVerilogSyn.SBAAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSBAAttriFg','$00C08000'));
        SynVerilogSyn.StringAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynVerilogSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
      end;
      if assigned(SynHTMLSyn) then
      begin
        SynHTMLSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynHTMLSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynHTMLSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynHTMLSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynHTMLSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynHTMLSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
      end;
      if assigned(SynBatSyn) then
      begin
        SynBatSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynBatSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynBatSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynBatSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynBatSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
      end;
      if assigned(SynUnixShellScriptSyn) then
      begin
        SynUnixShellScriptSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynUnixShellScriptSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynUnixShellScriptSyn.VarAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynUnixShellScriptSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynUnixShellScriptSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynUnixShellScriptSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynUnixShellScriptSyn.StringAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynUnixShellScriptSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
      end;
      if assigned(SynTclTkSyn) then
      begin
        SynTclTkSyn.CommentAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
        SynTclTkSyn.KeywordAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynTclTkSyn.SecondKeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynTclTkSyn.KeyAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterKeyAttriFg','clBlue'));
        SynTclTkSyn.NumberAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterNumberAttriFg','clRed'));
        SynTclTkSyn.IdentifierAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterIdentifierFg','clWindowText'));
        SynTclTkSyn.StringAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynTclTkSyn.StringAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterStringAttriFg','clMaroon'));
        SynTclTkSyn.SymbolAttribute.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynTclTkSyn.SymbolAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterSymbolAttriFg','clTeal'));
        SynTclTkSyn.CommentAttri.Foreground:=StringToColor(ReadString('Editor','HighlighterCommentFg','clGreen'));
      end;
      //
      SyncroEdit.MarkupInfoArea.Background:=StringToColor(ReadString('Editor','SyncroEditBg','clMoneyGreen'));
      PrgEditor.Colorize(ini);
      SplitEd.Colorize(ini);
      MiniMap.Colorize(ini);
      MiniMap.LineHighlightColor.Background:=StringToColor(ReadString('MainForm','MidColor','$E0E0E0'));
      MiniMap.LineHighlightColor.FrameColor:=clNone;

      if EditorTabs.TabCount>0 then For i:=0 to EditorTabs.TabCount-1 do
      begin
        GetEditorPage(i).Colorize(Ini);
      end;
      //
      PrjTree.BackgroundColor:=StringToColor(ReadString('PrjTree','BackgroundColor','$F0FBFF'));
      PrjTree.Color:=StringToColor(ReadString('PrjTree','Color','$F0FBFF'));
      PrjTree.Font.Color:=StringToColor(ReadString('PrjTree','FontColor','$000000'));
      PrjTree.ExpandSignColor:=StringToColor(ReadString('PrjTree','ExpandSignColor','$808000'));
      PrjTree.SelectionColor:=StringToColor(ReadString('PrjTree','SelectionColor','$00D778'));
      PrjTree.SelectionFontColor:=StringToColor(ReadString('PrjTree','SelectionFontColor','$FFFFFF'));
      PrjTree.SeparatorColor:=StringToColor(ReadString('PrjTree','SeparatorColor','$808080'));
      PrjTree.TreeLineColor:=StringToColor(ReadString('PrjTree','TreeLineColor','$808080'));
      //
      EditorTabs.ColorBg:=StringToColor(ReadString('MainForm','TabsBackground','clWindow'));
      EditorTabs.ColorFont:=StringToColor(ReadString('MainForm','TabsFontColor','clButtonText'));;
      EditorTabs.ColorTabActive:=StringToColor(ReadString('MainForm','TabsActive','clWindow'));
      EditorTabs.ColorTabOver:=StringToColor(ReadString('MainForm','TabsOver','$F9EAD8'));
      EditorTabs.ColorTabPassive:=StringToColor(ReadString('MainForm','TabsPasive','clBtnFace'));
      EditorTabs.ColorFontModified:=StringToColor(ReadString('MainForm','TabsModifiedFontColor','clNavy'));
      //
      EditorsPanel.Color:=StringToColor(ReadString('MainForm','MidColor','$E0E0E0'));
      EditorToolBar.Color:=StringToColor(ReadString('MainForm','ToolBars','$f0f0f0'));
      PrjToolBar.Color:=StringToColor(ReadString('MainForm','ToolBars','$f0f0f0'));
      ProgToolBar.Color:=StringToColor(ReadString('MainForm','ToolBars','clDefault'));
    end;
  finally
    If assigned(IniFile) then FreeAndNil(IniFile);
  end;
end;

end.

