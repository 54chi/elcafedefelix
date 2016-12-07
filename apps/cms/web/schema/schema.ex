defmodule Cms.Schema do
  use Absinthe.Schema
  import_types Cms.Schema.Types

  query do
    field :posts, list_of(:post) do
      resolve &Cms.PostResolver.all/2
    end

    field :comments, list_of(:comment) do
      resolve &Cms.CommentResolver.all/2
    end

    field :post, type: :post do
      arg :id, non_null(:id)
      resolve &Cms.PostResolver.find/2
    end
  end
end
