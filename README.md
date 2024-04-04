### 2 isolated APIs in 1 OTP app (optional read: [full requirements](https://github.com/pbc/devtest))

---

###### API design

- no ~~noob trap~~ umbrella
- both APIs [major versioned](https://github.com/engelanna/devtest_elixir/tree/master/lib/private_api/v1)

Degree of isolation |||||
:-- | --- | --- | --- | --- |
*Shared* | OTP app (this repo) | [Supervisor](https://github.com/engelanna/devtest_elixir/blob/master/lib/devtest_elixir/application.ex#L21-L22) | Ecto layer (`Contexts` =  CRUD bags)
*Separate between APIs* | [Endpoints](https://github.com/engelanna/devtest_elixir/blob/master/config/config.exs#L14-L33) (= Bandit servers) | [Ports](https://github.com/engelanna/devtest_elixir/blob/master/config/dev.exs#L22-L35) | Routers ([PrivateAPI](https://github.com/engelanna/devtest_elixir/blob/master/lib/private_api/router.ex#L10-L23) / [PublicAPI](https://github.com/engelanna/devtest_elixir/blob/master/lib/public_api/router.ex#L11-L22)) | [Telemetry](https://github.com/engelanna/devtest_elixir/blob/master/lib/devtest_elixir/application.ex#L11-L12)
*Separate between API versions* | [Controllers](https://github.com/engelanna/devtest_elixir/blob/master/lib/private_api/v1/controllers.ex#L5) ([usage](https://github.com/engelanna/devtest_elixir/blob/master/lib/private_api/v1/controllers/json/location_controller.ex#L4)) | [Views](https://github.com/engelanna/devtest_elixir/blob/master/lib/private_api/v1/views.ex#L15-L19) | [Templates](https://github.com/engelanna/devtest_elixir/blob/master/lib/public_api/v1/views.ex#L7) (if need be) | "[ActionParams](https://github.com/engelanna/devtest_elixir/blob/master/lib/private_api/v1/params/location_params.ex#L6-L9)" ([definition](https://github.com/engelanna/devtest_elixir/blob/master/lib/private_api/v1/params.ex#L4-L11))

---

###### Test-Driven Development
- the [test suite](https://ibb.co/28BbPLv) at a glance (`ExUnit`, `Mimic` [mocks](https://github.com/engelanna/devtest_elixir/blob/master/test/private_api/v1/controllers/json/target_controller/evaluate_target_test.exs#L21))
  - [hand-rolled factories](https://github.com/engelanna/devtest_elixir/blob/master/test/support/factories/location_group_factory.ex#L10) to see what they'd have to look like (next time: `ExMachina`)
  - 3 scrapers involved: [tested](https://github.com/engelanna/devtest_elixir/blob/master/test/devtest_elixir/pricing_strategies/count_html_nodes_at_url_then_divide_test.exs) with `ExVCR` using a custom [CassetteCase](https://github.com/engelanna/devtest_elixir/blob/master/test/support/cassette_case.ex)
- de facto 100% test coverage, as [controller tests](https://github.com/engelanna/devtest_elixir/blob/master/test/public_api/v1/controllers/json/target_group_controller/target_groups_for_country_code_test.exs#L9) double as integration -//-
---

###### Security
- `.secret_code` fields **not** stored in the DB: SHA256 hash & salt [stored instead](https://github.com/engelanna/devtest_elixir/blob/master/lib/devtest_elixir/contexts/shared/secret_code_context.ex#L6-L8) ([spec](https://github.com/engelanna/devtest_elixir/blob/master/test/devtest_elixir/contexts/secret_code_context_test.exs#L12))
- `PublicAPI` exposed to the public - bearer token authentication ([plug](https://github.com/engelanna/devtest_elixir/blob/master/lib/public_api/v1/plugs/verify_token.ex), [spec](https://github.com/engelanna/devtest_elixir/blob/master/test/public_api/v1/plugs/verify_token_test.exs#L33))
  - `.id`s are of type `:uuid` (foils enumeration attacks)
- `PrivateAPI` internal to the company - no authentication, instead whitelist IPs/SSH keys with your cloud provider
