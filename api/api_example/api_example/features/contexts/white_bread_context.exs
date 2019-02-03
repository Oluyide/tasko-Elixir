defmodule WhiteBreadContext do
  use WhiteBread.Context
  use Hound.Helpers

  feature_starting_state fn  ->
    Application.ensure_all_started(:hound)
    %{}
  end
  scenario_starting_state fn _state ->
    Hound.start_session
    %{}
  end
  scenario_finalize fn _status, _state ->
    Hound.end_session
  end
  and_ ~r/^I open STRS' web page$/, fn state ->
    navigate_to "/book_a_car"
    {:ok, state}
  end
  and_ ~r/^my email is "(?<argument_one>[^"]+)"$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end
  and_ ~r/^my password is "(?<argument_one>[^"]+)"$/,
  fn state, %{argument_one: _argument_one} ->
    {:ok, state}
  end
  and_ ~r/^my mobnum "(?<argument_one>[^"]+)"$/,
fn state, %{argument_one: _argument_one} ->
  {:ok, state}
end
  when_ ~r/^I summit the Registration details$/, fn state ->
    {:ok, state}
  end
  then_ ~r/^I should be able to Login$/, fn state ->
    {:ok, state}
  end
  and_ ~r/^confirm my password is "(?<argument_one>[^"]+)"$/,
fn state, %{argument_one: _argument_one} ->
  {:ok, state}
end
and_ ~r/^my picuplat is "(?<argument_one>[^"]+)"$/,
fn state, %{argument_one: _argument_one} ->
  {:ok, state}
end
and_ ~r/^my picuplong is "(?<argument_one>[^"]+)"$/,
fn state, %{argument_one: _argument_one} ->
  {:ok, state}
end
and_ ~r/^my destlat is "(?<argument_one>[^"]+)"$/,
fn state, %{argument_one: _argument_one} ->
  {:ok, state}
end
and_ ~r/^my destlong is "(?<argument_one>[^"]+)"   $/,
fn state, %{argument_one: _argument_one} ->
  {:ok, state}
end
and_ ~r/^my mobnum "(?<argument_one>[^"]+)"    $/,
fn state, %{argument_one: _argument_one} ->
  {:ok, state}
end
when_ ~r/^I summit the booking details$/, fn state ->
  {:ok, state}
end
then_ ~r/^I should be able to see information$/, fn state ->
  {:ok, state}
end
end
