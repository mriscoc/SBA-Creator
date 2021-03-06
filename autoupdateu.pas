unit AutoUpdateU;

{$mode objfpc}{$H+}

interface

uses
  Classes, Forms, SysUtils, Dialogs, IniFiles, LazFileUtils, StrUtils,
  Process, AsyncProcess, versionsupportu, DwFileU;

Const
  SBADwUrl='http://sba.accesus.com/%s?attredirects=0';
{$IFDEF WINDOWS}
  {$IFDEF WIN32}
  VersionFile='sbamainexe.ini';
  UpdaterZipfile='sbamainexe.zip';
  {$ENDIF}
  {$IFDEF WIN64}
  VersionFile='sbamainx64.ini';
  UpdaterZipfile='sbamainx64.zip';
  {$ENDIF}
  WhatsNewFile='whatsnew.txt';
  C_LOCALUPDATER = 'updatehm.exe';
{$ENDIF}
{$IFDEF LCLGTK2}
  {$IFDEF CPUARM}
  VersionFile='sbamainarmgtk2.ini';
  UpdaterZipfile='sbamainarmgtk2.zip';
  WhatsNewFile='whatsnewarmgtk2.txt';
  C_LOCALUPDATER = 'updatehm';
  {$ENDIF}
  {$IFDEF CPU386}
  VersionFile='sbamainx86gtk2.ini';
  UpdaterZipfile='sbamainx86gtk2.zip';
  WhatsNewFile='whatsnewx86gtk2.txt';
  C_LOCALUPDATER = 'updatehm';
  {$ENDIF}
  {$IFDEF CPUX86_64}
  VersionFile='sbamaingtk2.ini';
  UpdaterZipfile='sbamaingtk2.zip';
  WhatsNewFile='whatsnewgtk2.txt';
  C_LOCALUPDATER = 'updatehm';
  {$ENDIF}
{$ENDIF}
{$IFDEF LCLGTK3}
  {$IFDEF CPUX86_64}
  VersionFile='sbamaingtk3.ini';
  UpdaterZipfile='sbamaingtk3.zip';
  WhatsNewFile='whatsnewgtk3.txt';
  C_LOCALUPDATER = 'updatehm';
  {$ENDIF}
{$ENDIF}

type

  { TAutoUpdate }
  TUpdateStatus=(upStGetVersionFile,upStGetWhatsNew,upStDwNewVersion,upStUpdating,upStIdle);

  TAutoUpdate=class(TObject)
  private
    FNewVersionAvailable:boolean;
    Fupdatefolder: string;
    procedure EndCheckNewVersion;
    procedure FileDownloaded;
    procedure WaitForIdle;
  public
    upStatus:TUpdateStatus;
    upStError:boolean;
    CBCheckNewVersion:procedure of object;
    constructor Create;
    procedure CheckNewVersion;
    function GetWhatsNew: boolean;
    function DownloadNewVersion:boolean;
    function UpdateToNewVersion:boolean;
    function GetNewVersion:string;
    function DownloadInProgress:boolean;
  published
    property NewVersionAvailable:Boolean read FNewVersionAvailable;
    property updatefolder:string read Fupdatefolder write Fupdatefolder;
  end;

implementation

uses
  UtilsU, DebugU, ConfigFormU;

var
  VersionStr:string;

procedure TAutoUpdate.FileDownloaded;
begin
  Info('TAutoUpdate.FileDownloaded','');
  case upStatus of
    upStGetVersionFile:begin
      upStatus:=upStIdle;
      EndCheckNewVersion;
    end;
    upStGetWhatsNew:upStatus:=upStIdle;
    upStDwNewVersion:upStatus:=upStIdle;
    upStUpdating:upStatus:=upStIdle;
  else upStatus:=upStIdle;
  end;
end;

procedure TAutoUpdate.WaitForIdle;
var TimeOut:integer;
begin
  TimeOut:=10000;
  while (upStatus<>upStIdle) and (TimeOut>0) do
  begin
    Application.ProcessMessages;
    Dec(TimeOut);
    sleep(2);
  end;
end;

constructor TAutoUpdate.Create;
begin
  inherited Create;
  upStatus:=upStIdle;
  upStError:=false;
  CBCheckNewVersion:=nil;
end;

procedure TAutoUpdate.CheckNewVersion;
var
  f:string;
  Dwt:TDownloadThread;
begin
  Info('TAutoUpdate.CheckNewVersion');
  FNewVersionAvailable:=false;
  f:=ConfigDir+VersionFile;
  Deletefile(f);
  upStatus:=upStGetVersionFile;
  DwT:=TDownloadThread.create(Format(SBADwUrl,[VersionFile]),f);
  DwT.OnDownloaded:=@FileDownloaded;
  DwT.start;
end;


procedure TAutoUpdate.EndCheckNewVersion;
var
  f:string;
  ini:TiniFile;
begin
  Info('TAutoUpdate.EndCheckNewVersion');
  f:=ConfigDir+VersionFile;
  if not fileexists(f) then exit;
  ini:=TIniFile.Create(f);
  try
    VersionStr:=Ini.ReadString('versions','GUI','0.0.0.1');
  finally
    if assigned(ini) then FreeAndNil(ini);
  end;
  FNewVersionAvailable:=VCmpr(GetFileVersion,VersionStr)<0;
  Info('TAutoUpdate','Online version: '+VersionStr);
  Info('TAutoUpdate.NewVersionAvailable',FNewVersionAvailable);
  if assigned(CBCheckNewVersion) then CBCheckNewVersion;
end;

function TAutoUpdate.GetWhatsNew:boolean;
var
  f:String;
  Dwt:TDownloadThread;
begin
  f:=ConfigDir+WhatsNewFile;
  upStatus:=upStGetWhatsNew;
  DwT:=TDownloadThread.create(Format(SBADwUrl,[WhatsNewFile]),f);
  DwT.OnDownloaded:=@FileDownloaded;
  DwT.start;
  WaitForIdle;
  result:=fileexistsUTF8(f)
end;

function TAutoUpdate.DownloadNewVersion: boolean;
var
  f:String;
  Dwt:TDownloadThread;
begin
  result:=false;
  f:=ConfigDir+UpdaterZipfile;
  upStatus:=upStDwNewVersion;
  DwT:=TDownloadThread.create(Format(SBADwUrl,[UpdaterZipfile]),f);
  DwT.OnDownloaded:=@FileDownloaded;
  DwT.Start;
  WaitForIdle;
  if not fileexists(f) then exit;
  Unzip(f,AppDir+'updates');
  DeleteFile(f);
  result:=true;
end;

function TAutoUpdate.UpdateToNewVersion: boolean;
var
  UpdateProcess: TAsyncProcess;
  cCount: cardinal;
begin
  DeleteFile(AppDir+WhatsNewFile); //Flag File
  // Update and re-start the app
  UpdateProcess := TAsyncProcess.Create(nil);
  try
    UpdateProcess.Executable := AppDir + C_LOCALUPDATER;
    UpdateProcess.CurrentDirectory := AppDir;
    UpdateProcess.Parameters.Clear;
    UpdateProcess.Parameters.Add(ExtractFileName(Application.ExeName)); //Param 1 = EXEname
    UpdateProcess.Parameters.Add('updates'); // Param 2 = updates
    UpdateProcess.Parameters.Add(WhatsNewFile); // Param 3 = whatsnew.txt
    UpdateProcess.Parameters.Add(Application.Title); // Param 4 = Prettyname
    UpdateProcess.Parameters.Add('copytree');
   // Param 5 = Copy the whole of /updates to the App Folder
    Info('TAutoUpdate.UpdateToNewVersion',UpdateProcess.Executable);
    Info('TAutoUpdate.UpdateToNewVersion',UpdateProcess.Parameters);
    UpdateProcess.Execute;
    // Check for WhatsNewFile in the app directory in a LOOP
    cCount:=100000; // Timeout
    while (cCount>0) and not FileExists(AppDir+WhatsNewFile) do
    begin
      Application.ProcessMessages;
      sleep(100);
      Dec(CCount);
    end;
    //Terminate the Main application
    if FileExists(AppDir+WhatsNewFile) then Application.Terminate
    else begin
      ShowMessage('There was an error updating the application, please check permissions');
    end;
  finally
    UpdateProcess.Free;
  end;
  Result := True;
end;

function TAutoUpdate.GetNewVersion: string;
begin
  result:=VersionStr;
end;

function TAutoUpdate.DownloadInProgress: boolean;
begin
  result:=(upStatus<>upStIdle);
  Info('DownloadInProgress',IFTHEN(result,'Is','Is not')+' downloading');
end;

end.

