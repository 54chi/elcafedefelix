# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Cms.Repo.insert!(%Cms.SomeModel{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Cms.Repo
alias Cms.Post
alias Cms.Comment

Repo.insert!(%Post{title: "Post 001", body: "Un post como otro"})
Repo.insert!(%Post{title: "Post 002", body: "Otro post parecido a los demas"})

for _ <- 1..10 do
  Repo.insert!(%Comment{
    name: Faker.Name.name,
    content: Faker.Lorem.paragraph,
    post_id: [1,2] |> Enum.take_random(1) |> hd
  })
end
