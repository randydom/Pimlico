unit nePimlico.mService.Default;

interface

uses
  nePimlico.Base.Types, nePimlico.mService.Types;

type
  TmServiceDefault = class(TBaseInterfacedObject, ImService)
  private
    fStatus: TStatus;
{$REGION 'Interface'}
    function getServiceType: TServiceType;
    function getStatus: TStatus;

    procedure invoke(const aParameters: string); virtual;
{$ENDREGION}
  protected
    ServiceType: TServiceType;
  public
    constructor Create;
  end;

implementation

constructor TmServiceDefault.Create;
begin
  inherited;
  ServiceType:=stLocal;
  FillChar(fStatus, Sizeof(fStatus), 0);
end;

function TmServiceDefault.getServiceType: TServiceType;
begin
  Result:=ServiceType;
end;

function TmServiceDefault.getStatus: TStatus;
begin
  Result:=fStatus;
end;

procedure TmServiceDefault.invoke(const aParameters: string);
begin
  fStatus.ErrorCode:=secOK;
  fStatus.Response:='Parameters: '+aParameters+' "All Good!"';
end;

end.
