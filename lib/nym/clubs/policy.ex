defmodule Nym.Clubs.Policy do
  alias Nym.Clubs.Member
  alias Nym.Clubs.Club

  def can?(%Member{role: "owner"}, :update_club, %Club{}), do: true

  def can?(%Member{role: "moderator"}, :approve_join_request, _club), do: true
  def can?(%Member{role: "moderator"}, :delete_post, _club), do: true

  def can?(%Member{role: "member"}, :create_post, _club), do: true

  def can?(%Member{role: "owner"}, _action, _resource), do: true
  def can?(_, _, _), do: false
end
