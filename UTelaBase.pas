unit UTelaBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ToolWin, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls;

type
  TTelaBase = class(TForm)
    barraSuperior: TPanel;
    tituloTela: TLabel;
    barraFerramentas: TToolBar;
    iconesBotoes: TImageList;
    grupoFoco: TGroupBox;
    dataSource: TDataSource;
    btnNovo: TToolButton;
    btnEditar: TToolButton;
    btnGravar: TToolButton;
    btnCancelar: TToolButton;
    btnExcluir: TToolButton;
    btnImprimir: TToolButton;
    ToolButton7: TToolButton;
    btnPesquisar: TToolButton;
    ToolButton9: TToolButton;
    btnSair: TToolButton;
    pageControl: TPageControl;
    informacoes: TTabSheet;
    filtrosPesquisa: TTabSheet;
    grupoFiltros: TGroupBox;
    tabela: TDBGrid;
    grupoInformacoes: TGroupBox;
    barraStatus: TStatusBar;
    procedure dataSourceStateChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure tabelaDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TelaBase: TTelaBase;

implementation

{$R *.dfm}

procedure TTelaBase.btnCancelarClick(Sender: TObject);
begin
  ActiveControl := Nil;
  if not (Sender is TForm) then
    if Application.MessageBox('Cancelar o registro atual?', 'Cancelar', MB_YESNO + MB_ICONQUESTION) = ID_YES then
      dataSource.DataSet.Cancel;
end;

procedure TTelaBase.btnEditarClick(Sender: TObject);
begin
  if dataSource.DataSet.Active then
    if not dataSource.DataSet.IsEmpty then
    begin
      dataSource.DataSet.Edit;
      pageControl.ActivePageIndex := 0;
    end
    else
      ShowMessage('Não há Registros a Alterar!');
end;
procedure TTelaBase.btnExcluirClick(Sender: TObject);
begin
  if dataSource.DataSet.Active then
    if not dataSource.DataSet.IsEmpty then
    begin
      if Application.MessageBox('Deseja realmente excluir o registro atual?', 'Excluir', MB_YESNO + MB_ICONQUESTION) = ID_YES then
        dataSource.DataSet.Delete;
    end
    else
      ShowMessage('Não há registros a excluir!');
end;

procedure TTelaBase.btnGravarClick(Sender: TObject);
begin
  ActiveControl := Nil;
  dataSource.DataSet.Post;
  // Após salvar atualiza
  btnPesquisarClick(btnPesquisar);
end;

procedure TTelaBase.btnImprimirClick(Sender: TObject);
begin
  if dataSource.DataSet.IsEmpty or not dataSource.DataSet.Active then
  begin
    ShowMessage('Não há registros a imprimir!');
    Abort;
  end;
end;

procedure TTelaBase.btnNovoClick(Sender: TObject);
begin
  if ActiveControl = tabela then
    ActiveControl := Nil;

  if not dataSource.DataSet.Active then
    dataSource.DataSet.Open;

  dataSource.DataSet.Append;
  pageControl.ActivePageIndex := 0;
end;

procedure TTelaBase.btnPesquisarClick(Sender: TObject);
begin
  ActiveControl := Nil;

  try
    pageControl.SetFocus;
  Except
  end;

  dataSource.DataSet.Close;
  dataSource.DataSet.Open;
  barraStatus.Panels[1].Text := IntToStr(dataSource.DataSet.RecordCount);
end;
procedure TTelaBase.btnSairClick(Sender: TObject);
begin
  Close;
end;
procedure TTelaBase.dataSourceStateChange(Sender: TObject);
begin
  filtrosPesquisa.TabVisible := dataSource.DataSet.State in [dsBrowse, dsInactive];
  grupoInformacoes.Enabled   := dataSource.DataSet.State in dsEditModes;
  grupoFoco.Enabled          := dataSource.DataSet.State in dsEditModes;
  btnNovo.Enabled            := not (dataSource.DataSet.State in dsEditModes);
  btnEditar.Enabled          := not (dataSource.DataSet.State in dsEditModes) and not (dataSource.DataSet.IsEmpty);
  btnGravar.Enabled          :=     (dataSource.DataSet.State in dsEditModes);
  btnCancelar.Enabled        :=     (dataSource.DataSet.State in dsEditModes);
  btnPesquisar.Enabled       := not (dataSource.DataSet.State in dsEditModes);
  btnImprimir.Enabled        := not (dataSource.DataSet.State in dsEditModes);
  btnSair.Enabled            := not (dataSource.DataSet.State in dsEditModes);
  btnExcluir.Enabled         := not (dataSource.DataSet.State in dsEditModes);
end;
procedure TTelaBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  dataSource.DataSet.Close;
  Action := caFree;
  TForm(Sender) := nil;
end;

procedure TTelaBase.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if dataSource.DataSet.State in dsEditModes then
    if Application.MessageBox('Gravar as alterações?', pChar(Application.Title), MB_YESNO + MB_ICONQUESTION) = ID_YES then
      btnGravarClick(btnGravar)
    else
      btnCancelarClick(btnCancelar);
end;

procedure TTelaBase.FormCreate(Sender: TObject);
begin
  TForm(Sender) := Self;
end;

procedure TTelaBase.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_RETURN)
    and not (ActiveControl is TDBGrid)
    and not (ActiveControl is TDBMemo)
    and not (ActiveControl is TMemo)
    and not (ActiveControl is TDBRichEdit) then
    Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TTelaBase.FormShow(Sender: TObject);
begin
  dataSourceStateChange(dataSource);
  pageControl.ActivePage := filtrosPesquisa;
  dataSource.DataSet.Open;
end;

procedure TTelaBase.tabelaDblClick(Sender: TObject);
begin
  pageControl.ActivePageIndex := 0;
end;

end.
