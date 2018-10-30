defmodule ActivityStreams.TypeGenerator do
  @types [
    Object: %{
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
    Link: %{
      :properties => [
        :href,
        :rel,
        :media_type,
        :name,
        :hreflang,
        :height,
        :width,
        :preview
      ]
    },
    Activity: %{
      :extends => [:Object],
      :properties => [
        :actor,
        :object,
        :target,
        :result,
        :origin,
        :instrument
      ]
    }
  ]

  defp parent_to_use(name) when is_atom(name), do: @types[name][:properties]

  defp parent_to_use({name, opts}) do
    only = opts[:only] || []
    except = opts[:except] || []

    properties = @types[name].properties

    cond do
      except != [] ->
        Enum.filter(properties, fn elem ->
          not (Enum.member?(properties, elem) and Enum.member?(except, elem))
        end)
      only != []  ->
        Enum.filter(properties, fn elem ->
          Enum.member?(properties, elem) and Enum.member?(only, elem)
        end)
      true ->
        properties
    end
  end

  defp parent_to_use(thing), do: raise "No clue what #{thing} is"

  defmacro __using__(_opts) do
    for {name, data} <- @types do
      type_name = Atom.to_string(name)
      module_name = String.to_atom("Elixir.ActivityStreams.Type.#{type_name}")
      # Since there's always an info/1 function this conditional will tell us
      # if a module is already defined.
      if !function_exported?(module_name, :__info__, 1) do
        inherited_properties =
        if data[:extends] do
          for p <- data[:extends] do
           parent_to_use(p)
          end
        else
          []
        end

        properties = (data[:properties] || []) ++ inherited_properties

        quote do
          defmodule unquote(module_name) do
            @properties unquote(properties)
            @required unquote(data[:required])

            def properties, do: @properties

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
