program Carrega_Imagem_Web;

uses
  Vcl.Forms,
  uCarregaImagemWeb in 'uCarregaImagemWeb.pas' {frmImgtoView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmImgtoView, frmImgtoView);
  Application.Run;
end.
