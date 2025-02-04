defmodule Cotacoes.Handlers.IManageCotacaoHandler do
  alias Cotacoes.Models.Cotacao

  @callback find_cotacoes_not_ingested :: list(Cotacao.t())
  @callback ingest_cotacoes(list(Cotacao.t())) :: :ok
  @callback insert_cotacoes!(list(Cotacao.t())) :: {:ok, list(Cotacao.t()) | nil}
  @callback reject_inserted_cotacoes(list(Cotacao.t())) :: list(Cotacao.t())
end
