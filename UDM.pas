unit UDM;

interface

uses
  System.SysUtils, System.Classes, Datasnap.Provider, Datasnap.DBClient,
  Data.DB, Data.Win.ADODB;

type
  TDM = class(TDataModule)
    conexaoBanco: TADOConnection;
    queryProduto: TADOQuery;
    cdsProduto: TClientDataSet;
    dspProduto: TDataSetProvider;
    cdsProdutocodigo: TAutoIncField;
    cdsProdutoNome: TStringField;
    cdsProdutoDataCriacao: TDateField;
    cdsProdutoPreço: TFloatField;
    cdsProdutoModelo: TStringField;
    cdsProdutoQuantidade: TIntegerField;
    cdsProdutoEspecificações: TWideMemoField;
    cdsProdutoNacional: TBooleanField;
    cdsProdutoidFornecedor: TIntegerField;
    queryFornecedor: TADOQuery;
    dspFornecedor: TDataSetProvider;
    cdsFornecedor: TClientDataSet;
    queryPedido: TADOQuery;
    dspPedido: TDataSetProvider;
    cdsPedido: TClientDataSet;
    cdsPedidoCodigoPedido: TAutoIncField;
    cdsPedidocodigo: TIntegerField;
    cdsPedidoQuantidadeProduto: TIntegerField;
    cdsFornecedoridFornecedor: TAutoIncField;
    cdsFornecedornome: TStringField;
    dsFornecedor: TDataSource;
    dsPedido: TDataSource;
    queryUsuario: TADOQuery;
    dspUsuario: TDataSetProvider;
    cdsUsuario: TClientDataSet;
    cdsUsuarioidUsuario: TAutoIncField;
    cdsUsuarionome: TStringField;
    cdsUsuariosenha: TStringField;
    queryTela: TADOQuery;
    queryUsuTela: TADOQuery;
    dspTela: TDataSetProvider;
    cdsTela: TClientDataSet;
    dspUsuTela: TDataSetProvider;
    cdsUsuTela: TClientDataSet;
    cdsTelaidTela: TAutoIncField;
    cdsTelaNome: TStringField;
    cdsTelaDescrição: TMemoField;
    cdsUsuTelaidUsuario: TIntegerField;
    cdsUsuTelaidTela: TIntegerField;
    procedure cdsProdutoAfterDelete(DataSet: TDataSet);
    procedure cdsProdutoAfterPost(DataSet: TDataSet);
    procedure cdsProdutoAfterCancel(DataSet: TDataSet);
    procedure cdsProdutoAfterInsert(DataSet: TDataSet);
    procedure conexaoBancoBeforeConnect(Sender: TObject);
    procedure cdsPedidoAfterCancel(DataSet: TDataSet);
    procedure cdsPedidoAfterPost(DataSet: TDataSet);
    procedure cdsPedidoAfterDelete(DataSet: TDataSet);
    procedure queryPedidoBeforeOpen(DataSet: TDataSet);
    procedure cdsProdutoAfterScroll(DataSet: TDataSet);
    procedure cdsFornecedorAfterCancel(DataSet: TDataSet);
    procedure cdsFornecedorAfterDelete(DataSet: TDataSet);
    procedure cdsFornecedorAfterPost(DataSet: TDataSet);
    procedure cdsUsuarioAfterCancel(DataSet: TDataSet);
    procedure cdsUsuarioAfterPost(DataSet: TDataSet);
    procedure cdsUsuarioAfterDelete(DataSet: TDataSet);
    procedure cdsTelaAfterCancel(DataSet: TDataSet);
    procedure cdsTelaAfterDelete(DataSet: TDataSet);
    procedure cdsTelaAfterPost(DataSet: TDataSet);
    procedure cdsUsuTelaAfterCancel(DataSet: TDataSet);
    procedure cdsUsuTelaAfterDelete(DataSet: TDataSet);
    procedure cdsUsuTelaAfterPost(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    idUsuario : integer;
    usuario : string;
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDM.cdsFornecedorAfterCancel(DataSet: TDataSet);
begin
  cdsFornecedor.CancelUpdates;
end;

procedure TDM.cdsFornecedorAfterDelete(DataSet: TDataSet);
begin
  cdsFornecedor.ApplyUpdates(-1);
end;

procedure TDM.cdsFornecedorAfterPost(DataSet: TDataSet);
begin
  cdsFornecedor.ApplyUpdates(-1);
end;

procedure TDM.cdsPedidoAfterCancel(DataSet: TDataSet);
begin
  cdsPedido.CancelUpdates;
end;

procedure TDM.cdsPedidoAfterDelete(DataSet: TDataSet);
begin
  cdsPedido.ApplyUpdates(-1);
end;

procedure TDM.cdsPedidoAfterPost(DataSet: TDataSet);
begin
  cdsPedido.ApplyUpdates(-1);
end;

procedure TDM.cdsProdutoAfterCancel(DataSet: TDataSet);
begin
  cdsProduto.CancelUpdates;
end;

procedure TDM.cdsProdutoAfterDelete(DataSet: TDataSet);
begin
  cdsProduto.ApplyUpdates(-1);
end;

procedure TDM.cdsProdutoAfterInsert(DataSet: TDataSet);
begin
  cdsProdutoDataCriacao.AsDateTime := Date;
  cdsProdutoPreço.AsFloat          := 0.00;
  cdsProdutoQuantidade.AsInteger   := 0;
  cdsProdutoNacional.AsBoolean     := False;
end;

procedure TDM.cdsProdutoAfterPost(DataSet: TDataSet);
begin
  cdsProduto.ApplyUpdates(-1);
end;

procedure TDM.cdsProdutoAfterScroll(DataSet: TDataSet);
begin
  queryPedido.Close;
  cdsPedido.Close;
  queryPedido.Open;
  cdsPedido.Open;
end;

procedure TDM.cdsTelaAfterCancel(DataSet: TDataSet);
begin
 cdsTela.CancelUpdates;
end;

procedure TDM.cdsTelaAfterDelete(DataSet: TDataSet);
begin
  cdsTela.ApplyUpdates(-1);
end;

procedure TDM.cdsTelaAfterPost(DataSet: TDataSet);
begin
 cdsTela.ApplyUpdates(-1);
end;

procedure TDM.cdsUsuarioAfterCancel(DataSet: TDataSet);
begin
  cdsUsuario.CancelUpdates;
end;

procedure TDM.cdsUsuarioAfterDelete(DataSet: TDataSet);
begin
  cdsUsuario.ApplyUpdates(-1);
end;

procedure TDM.cdsUsuarioAfterPost(DataSet: TDataSet);
begin
  cdsUsuario.ApplyUpdates(-1);
end;

procedure TDM.cdsUsuTelaAfterCancel(DataSet: TDataSet);
begin
 cdsUsuTela.CancelUpdates;
end;

procedure TDM.cdsUsuTelaAfterDelete(DataSet: TDataSet);
begin
 cdsUsuTela.ApplyUpdates(-1);
end;

procedure TDM.cdsUsuTelaAfterPost(DataSet: TDataSet);
begin
  cdsUsuTela.ApplyUpdates(-1);
end;

procedure TDM.conexaoBancoBeforeConnect(Sender: TObject);
begin
  //conexaoBanco.ConnectionString := 'Provider=SQLNCLI11.1;Integrated Security=SSPI;Persist Security Info=False;User ID="";' + 'Initial Catalog=cadastro;Data Source=.\SQLEXPRESS;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;' + 'Workstation ID=DESKTOP-QRS1J44;Initial File Name="";Use Encryption for Data=False;Tag with column collation when possible=False;MARS Connection=False;DataTypeCompatibility=0;Trust Server Certificate=False;Application Intent=READWRITE;';
end;

procedure TDM.queryPedidoBeforeOpen(DataSet: TDataSet);
begin
  queryPedido.Parameters.ParamByName('codigo').Value := cdsProdutocodigo.AsInteger;
end;

end.
