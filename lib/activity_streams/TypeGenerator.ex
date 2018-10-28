defmodule ActivityStreams.TypeGenerator do
  @types [
    Object: %{
      :extends => [],
      :properties => [
        :attachment,
        :attributed_to,
        :audience,
        :bcc,
        :bto,
        :cc,
        :content,
        :context,
        :duration,
        :end_time,
        :generator,
        :icon,
        :id,
        :image,
        :in_reply_to,
        :location,
        :media_type,
        :name,
        :preview,
        :published,
        :replies,
        :start_time,
        :summary,
        :tag,
        :to,
        :type,
        :updated,
        :url
      ]
    },
    Activity: %{
      :extends => [
      Object: []
    ],
    }
  ]

  defp parent_to_use({name, opts}) do
    except = opts[:except] || []
    only = opts[:only] || []

    properties = @types[name]

    final =
    cond do
      only != [] ->
        Enum.filter(properties, fn elem ->
          not (Enum.member?(properties, elem) and Enum.member?(except, elem))
        end)
      except != []  ->
        Enum.filter(properties, fn elem ->
          Enum.member?(properties, elem) and Enum.member?(only, elem)
        end)
      true ->
        properties
    end

    quote do
      @properties unquote(final)
    end
  end

  defmacro __using__(_opts) do
    for {name, data} <- @types do
      type_name = Atom.to_string(name)
      module_name = String.to_atom("Elixir.ActivityStreams.Type.#{type_name}")
      if !function_exported?(module_name, :__info__, 1) do
        quote do
          defmodule unquote(module_name) do
            Module.register_attribute(__MODULE__, :properties, accumulate: true)
            @properties unquote(data[:properties])
            unquote(
            if data[:extends] do
              for p <- data[:extends], do: parent_to_use(p)
            end
            )

            def valid?(struct) do
              :ok == validate(struct)
            end

            def validate(struct) do
              ActivityStreams.Validator.validate(struct, @required)
            end
          end
        end
      end
    end
  end
end
