defmodule Cms.Schema.Types do
  use Absinthe.Schema.Notation
  use Absinthe.Ecto, repo: Cms.Repo

 object :post do
   field :id, :id
   field :title, :string
   field :body, :string
   field :comments, list_of(:comment), resolve: assoc(:comments)
 end

 object :comment do
   field :id, :id
   field :name, :string
   field :content, :string
   field :post, :post, resolve: assoc(:post)
 end

end
