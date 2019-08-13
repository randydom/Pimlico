unit nePimlico.Node;

interface

uses
  nePimlico.Base.Types, nePimlico.Node.Types, System.Generics.Collections,
  nePimlico.LoadBalancer.Types;

type
  TmNode = class (TBaseInterfacedObject, ImNode)
  private
    fList: TList<ILoadBalancer>;
{$REGION 'Interface'}
  function add(const aLoadBalancer: ILoadBalancer): ImNode;
  procedure delete (const aLoadBalancer: ILoadBalancer);
  procedure push(const aPattern: string; const aParameters: string); overload;
  procedure push(const aPattern: string; const aParameters: string;
                                out aStatus: TStatus); overload;
{$ENDREGION}
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

constructor TmNode.Create;
begin
  inherited;
  fList:=TList<ILoadBalancer>.Create;
end;

destructor TmNode.Destroy;
begin
  fList.Free;
  inherited;
end;

procedure TmNode.push(const aPattern: string; const aParameters: string; out
    aStatus: TStatus);
var
  loadBalancer: ILoadBalancer;
begin
  for loadBalancer in fList do
    loadBalancer.distribute(aPattern, aParameters, aStatus);
end;

{ TmNode }

function TmNode.add(const aLoadBalancer: ILoadBalancer): ImNode;
begin
  Assert(Assigned(aLoadBalancer));
  if not fList.Contains(aLoadBalancer) then
    fList.Add(aLoadBalancer);
  Result:=Self;
end;

procedure TmNode.delete(const aLoadBalancer: ILoadBalancer);
begin
  Assert(Assigned(aLoadBalancer));
  if fList.Contains(aLoadBalancer) then
    fList.Remove(aLoadBalancer);
end;

procedure TmNode.push(const aPattern, aParameters: string);
var
  loadBalancer: ILoadBalancer;
begin
  for loadBalancer in fList do
    loadBalancer.distribute(aParameters, aParameters);
end;

end.
