program BurclarveYorumlar;

uses
  System.StartUpCopy,
  FMX.Forms,
  burclarfm in 'burclarfm.pas' {fmburclar};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tfmburclar, fmburclar);
  Application.Run;
end.
