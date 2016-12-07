defmodule Cms.CommentResolver do
  alias Cms.Repo
  alias Cms.Comment

  def all(_args, _info) do
    {:ok, Repo.all(Comment)}
  end
end
