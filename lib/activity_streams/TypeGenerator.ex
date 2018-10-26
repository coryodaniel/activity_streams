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
    }
  ]

  defp parent_to_use({name, data}) do
    except = data[:except]

    parent = @types[name]
    properties = parent[:properties]

    final = Enum.filter(properties, fn elem ->
      not (Enum.member?(properties, elem) and Enum.member?(except, elem))
    end)

    quote do
      @properties unquote(final)
    end
  end

  defmacro __using__(_opts) do
    deferred = []

    for {name, data} <- @types do
      type_name = Atom.to_string(name)
      module_name = String.to_atom("Type.#{type_name}")
      if !function_exported?(module_name, :__info__, 1) do
        quote do
          defmodule unquote(module_name) do
            Module.register_attribute(__MODULE__, :properties, accumulate: true)
            @properties unquote(data[:properties])
            unquote(
            if data[:parents] do
              for p <- data[:parents], do: parent_to_use(p)
            end
            )
            unquote(IO.puts "Bye")

            def name do
              IO.puts __MODULE__
              IO.puts @properties
            end
          end
        end
      end
    end
  end
end
