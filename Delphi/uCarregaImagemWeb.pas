
unit uCarregaImagemWeb;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, JPeg,  pngimage ,
  IdBaseComponent,  IdTCPConnection, IdTCPClient, IdHTTP, IdSSLOpenSSL,
  IdServerIOHandler, IdSSL, IdComponent;

type
  TfrmImgtoView = class(TForm)
    edtUrlImagem: TEdit;
    GroupBox1: TGroupBox;
    Image1: TImage;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;




var
  frmImgtoView: TfrmImgtoView;



implementation

{$R *.dfm}

procedure urltoimg(URL: string; APicture: TPicture);
var
  tt            : TThread;
begin

    tt := TThread.CreateAnonymousThread
      (
      procedure
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
            idhttp.Get(URL, Strm);
            if (Strm.Size > 0) then
            begin
              try
                Strm.Position := 0;
                Jpeg.LoadFromStream(Strm);
                APicture.Assign(Jpeg);
              except
                Strm.Position := 0;
                jPng.LoadFromStream(Strm);
                APicture.Assign(jPng);
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
        except on e:Exception do
          ShowMessage('ERROR: '+e.Message);
        end;


      end
      );
    tt.start();





end;


procedure TfrmImgtoView.Button2Click(Sender: TObject);
begin
 urltoimg(''+edtUrlImagem.Text+'', Image1.Picture);
end;

procedure TfrmImgtoView.FormShow(Sender: TObject);
begin
    edtUrlImagem.Text := 'https://avatars.githubusercontent.com/u/26030963?v=4';
    Button2.Click; //test example
end;

end.
