object DM: TDM
  OldCreateOrder = False
  Height = 549
  Width = 517
  object conexaoBanco: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=SQLNCLI11.1;Persist Security Info=False;User ID=sa;Init' +
      'ial Catalog=cadastro;Data Source=(local);Use Procedure for Prepa' +
      're=1;Auto Translate=True;Packet Size=4096;Workstation ID=LAPTOP-' +
      'L7QCTLPK;Initial File Name="";Use Encryption for Data=False;Tag ' +
      'with column collation when possible=False;MARS Connection=False;' +
      'DataTypeCompatibility=0;Trust Server Certificate=False;Server SP' +
      'N="";Application Intent=READWRITE;password="123456";'
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    BeforeConnect = conexaoBancoBeforeConnect
    Left = 32
    Top = 32
  end
  object queryProduto: TADOQuery
    Connection = conexaoBanco
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Produtos')
    Left = 128
    Top = 96
  end
  object cdsProduto: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspProduto'
    AfterInsert = cdsProdutoAfterInsert
    AfterPost = cdsProdutoAfterPost
    AfterCancel = cdsProdutoAfterCancel
    AfterDelete = cdsProdutoAfterDelete
    AfterScroll = cdsProdutoAfterScroll
    Left = 288
    Top = 96
    object cdsProdutocodigo: TAutoIncField
      FieldName = 'codigo'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsProdutoNome: TStringField
      FieldName = 'Nome'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsProdutoDataCriacao: TDateField
      FieldName = 'DataCriacao'
      ProviderFlags = [pfInUpdate]
    end
    object cdsProdutoPreço: TFloatField
      FieldName = 'Pre'#231'o'
      ProviderFlags = [pfInUpdate]
    end
    object cdsProdutoModelo: TStringField
      FieldName = 'Modelo'
      ProviderFlags = [pfInUpdate]
      Size = 30
    end
    object cdsProdutoQuantidade: TIntegerField
      FieldName = 'Quantidade'
      ProviderFlags = [pfInUpdate]
    end
    object cdsProdutoEspecificações: TWideMemoField
      FieldName = 'Especifica'#231#245'es'
      ProviderFlags = [pfInUpdate]
      BlobType = ftWideMemo
    end
    object cdsProdutoNacional: TBooleanField
      FieldName = 'Nacional'
      ProviderFlags = [pfInUpdate]
    end
    object cdsProdutoidFornecedor: TIntegerField
      FieldName = 'idFornecedor'
    end
  end
  object dspProduto: TDataSetProvider
    DataSet = queryProduto
    Left = 208
    Top = 96
  end
  object queryFornecedor: TADOQuery
    Connection = conexaoBanco
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Fornecedor')
    Left = 128
    Top = 152
  end
  object dspFornecedor: TDataSetProvider
    DataSet = queryFornecedor
    Left = 208
    Top = 152
  end
  object cdsFornecedor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFornecedor'
    AfterPost = cdsFornecedorAfterPost
    AfterCancel = cdsFornecedorAfterCancel
    AfterDelete = cdsFornecedorAfterDelete
    Left = 288
    Top = 152
    object cdsFornecedoridFornecedor: TAutoIncField
      FieldName = 'idFornecedor'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsFornecedornome: TStringField
      FieldName = 'nome'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
  end
  object queryPedido: TADOQuery
    Connection = conexaoBanco
    CursorType = ctStatic
    BeforeOpen = queryPedidoBeforeOpen
    Parameters = <
      item
        Name = 'codigo'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      'select * from Pedidos where codigo = :codigo')
    Left = 128
    Top = 208
  end
  object dspPedido: TDataSetProvider
    DataSet = queryPedido
    Left = 208
    Top = 208
  end
  object cdsPedido: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspPedido'
    AfterPost = cdsPedidoAfterPost
    AfterCancel = cdsPedidoAfterCancel
    AfterDelete = cdsPedidoAfterDelete
    Left = 288
    Top = 208
    object cdsPedidoCodigoPedido: TAutoIncField
      FieldName = 'CodigoPedido'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsPedidocodigo: TIntegerField
      FieldName = 'codigo'
    end
    object cdsPedidoQuantidadeProduto: TIntegerField
      FieldName = 'QuantidadeProduto'
      ProviderFlags = [pfInUpdate]
    end
  end
  object dsFornecedor: TDataSource
    DataSet = cdsFornecedor
    Left = 368
    Top = 152
  end
  object dsPedido: TDataSource
    DataSet = cdsPedido
    Left = 368
    Top = 208
  end
  object queryUsuario: TADOQuery
    Connection = conexaoBanco
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Usuario')
    Left = 128
    Top = 264
  end
  object dspUsuario: TDataSetProvider
    DataSet = queryUsuario
    Left = 208
    Top = 264
  end
  object cdsUsuario: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuario'
    AfterPost = cdsUsuarioAfterPost
    AfterCancel = cdsUsuarioAfterCancel
    AfterDelete = cdsUsuarioAfterDelete
    Left = 288
    Top = 264
    object cdsUsuarioidUsuario: TAutoIncField
      FieldName = 'idUsuario'
      ReadOnly = True
    end
    object cdsUsuarionome: TStringField
      FieldName = 'nome'
      Size = 50
    end
    object cdsUsuariosenha: TStringField
      FieldName = 'senha'
      Size = 50
    end
  end
  object queryTela: TADOQuery
    Connection = conexaoBanco
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Tela')
    Left = 120
    Top = 336
  end
  object queryUsuTela: TADOQuery
    Connection = conexaoBanco
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'select * from Usuario_Tela')
    Left = 120
    Top = 408
  end
  object dspTela: TDataSetProvider
    DataSet = queryTela
    Left = 208
    Top = 344
  end
  object cdsTela: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTela'
    AfterPost = cdsTelaAfterPost
    AfterCancel = cdsTelaAfterCancel
    AfterDelete = cdsTelaAfterDelete
    Left = 288
    Top = 344
    object cdsTelaidTela: TAutoIncField
      FieldName = 'idTela'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object cdsTelaNome: TStringField
      FieldName = 'Nome'
      ProviderFlags = [pfInUpdate]
      Size = 50
    end
    object cdsTelaDescrição: TMemoField
      FieldName = 'Descri'#231#227'o'
      ProviderFlags = [pfInUpdate]
      BlobType = ftMemo
    end
  end
  object dspUsuTela: TDataSetProvider
    DataSet = queryUsuTela
    Left = 216
    Top = 408
  end
  object cdsUsuTela: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspUsuTela'
    AfterPost = cdsUsuTelaAfterPost
    AfterCancel = cdsUsuTelaAfterCancel
    AfterDelete = cdsUsuTelaAfterDelete
    Left = 304
    Top = 408
    object cdsUsuTelaidUsuario: TIntegerField
      FieldName = 'idUsuario'
    end
    object cdsUsuTelaidTela: TIntegerField
      FieldName = 'idTela'
    end
  end
end
