# DevtestElixir

1 Phoenix app == 2 isolated APIs (separate ports)

  * no umbrella as those are 100% pointless: if you want separate supervision trees, why keep (& deploy) the apps together?
  * no silly, artificial Contexts: Contexts were invented to extract methods from fat models (+ you should do ONE thing WELL)

  Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
