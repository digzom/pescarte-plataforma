defmodule PescarteWeb.GraphQL.Middlewares.HandleChangesetErrors do
  @behaviour Absinthe.Middleware

  def call(resolution, _) do
    %{resolution | errors: Enum.flat_map(resolution.errors, &handle_error/1)}
  end

  defp handle_error(%Ecto.Changeset{} = changeset) do
    changeset
    |> Ecto.Changeset.traverse_errors(fn {err, _opts} -> err end)
    |> map_errors()
  end

  defp handle_error(error), do: [error]

  defp map_errors(errors) do
    Enum.flat_map(errors, fn
      {e, err} when is_list(err) ->
        Enum.reduce(err, [], fn
          err, acc ->
            if Enum.empty?(err) do
              acc
            else
              [{k, v}] = Map.to_list(err)
              err = "#{e} => #{k}: #{v}"
              [err | acc]
            end
        end)

      {k, v} ->
        "#{k}: #{v}"
    end)
  end
end
