
unit uCarregaImagemWeb;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JPeg,  pngimage ,  WinInet,
  IdBaseComponent,  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL, IOUtils,
  IdServerIOHandler, IdSSL, IdComponent;

type
  TfrmImgtoView = class(TForm)
    edtUrlImagem: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;
var frmImgtoView: TfrmImgtoView;
implementation
{$R *.dfm}

function LoadImageFromURL(const URL: string; ImageControl: TImage): boolean;
var
  hhInternet, hConnect: HINTERNET;
  Buffer: array of Byte;
  BytesRead: DWORD;
  Stream: TMemoryStream;
begin
  Result := False;

  hhInternet := InternetOpen('Delphi App', INTERNET_OPEN_TYPE_DIRECT, nil, nil, 0);
  if Assigned(hhInternet) then
  begin
    hConnect := InternetOpenUrl(hhInternet, PChar(URL), nil, 0, INTERNET_FLAG_RELOAD, 0);
    if Assigned(hConnect) then
    begin
      Stream := TMemoryStream.Create;
      try
        SetLength(Buffer, 1024);
        repeat
          if InternetReadFile(hConnect, @Buffer[0], Length(Buffer), BytesRead) then
          begin
            if BytesRead > 0 then
              Stream.Write(Buffer[0], BytesRead);
          end
          else
          begin
            Break;
          end;
        until BytesRead = 0;

        Stream.Position := 0;

        // Carrega a imagem no TImage a partir do MemoryStream
        ImageControl.Picture.LoadFromStream(Stream);

        Result := True;
      finally
        Stream.Free;
      end;

      InternetCloseHandle(hConnect);
    end;

    InternetCloseHandle(hhInternet);
  end;
end;

procedure urltoimg(URL: string; APicture: TPicture);
var
  Jpeg          : TJpegImage;
  Jpng          : TPNGImage;
  Strm          : TMemoryStream;
  idhttp        : TIdHTTP;
  IDSSLHandler  : TIdSSLIOHandlerSocketOpenSSL;
begin
      try
        Screen.Cursor     := crHourGlass;
        Jpeg              := TJPEGImage.Create;
        jPng              := TPNGImage.Create;

        Strm              := TMemoryStream.Create;
        idhttp            := TIdHTTP.Create(nil);
        IDSSLHandler      := TIdSSLIOHandlerSocketOpenSSL.Create;
        idhttp.IOHandler  := IDSSLHandler;
        IDSSLHandler.SSLOptions.Method := sslvTLSv1_2;
        try
          idhttp.Get(url, Strm);

           if (Strm.Size > 0) then
           begin
              Strm.Position := 0;

              if url.EndsWith('.png') then
              begin
                jPng.LoadFromStream(Strm);
                APicture.Assign(jPng);
              end
              else
              //imagem de exemplo https://wdglojamedicaweb.s3.sa-east-1.amazonaws.com/wdglojamedicaweb1506.jpg
              if url.Contains('amazonaws')then //caso de erro JPEG error #53 em alguns links
              begin
                LoadImageFromURL(url, frmImgtoView.Image1 )
              end
              else
              if url.EndsWith('.jpg') or url.EndsWith( '.jpeg' ) then
              begin
                Jpeg.LoadFromStream(Strm);
                APicture.Assign(Jpeg);
              end
              else
              begin
                try
                  jPng.LoadFromStream(Strm);
                  APicture.Assign(jPng);
                except
                  Strm.Position := 0;
                  Jpeg.LoadFromStream(Strm);
                  APicture.Assign(Jpeg);
                end;
              end;
           end;
        finally
          Strm.Free;
          Jpeg.Free;
          jPng.Free;
          idhttp.Free;
          IDSSLHandler.Free;
          Screen.Cursor := crDefault;
        end;
      except
       on e:Exception do
       begin
        ShowMessage('Exception: '+e.Message)
       end;
      end;
end;

procedure TfrmImgtoView.Button2Click(Sender: TObject);
begin
 urltoimg(''+edtUrlImagem.Text+'', Image1.Picture);
end;

end.
