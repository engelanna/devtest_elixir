defmodule DevtestElixir.Repo.Migrations.SeedLocations do
  use Ecto.Migration

  import Ecto.Query, only: [from: 2]

  alias DevtestElixir.Contexts.Shared.UTCTimestampNoMicroseconds
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.Location


  @doc """
  If no Locations present, creates the 20 predefined Locations.
  """
  def up do
    if Repo.aggregate(Location, :count) == 0 do
      Enum.each(
        seeds(),
        fn seed -> %Location{} |> Location.changeset(seed) |> Repo.insert! end
      )
    end
  end

  @doc """
  Deletes the 20 predefined Locations if they are present.
  """
  def down do
    Enum.each(
      seeds(),
      fn seed ->
        Repo.delete_all(
          from(
            l in Location,
            where:
              l.id == ^seed.id and
              l.name == ^seed.name and
              l.external_id == ^seed.external_id
          )
        )
      end
    )
  end


  defp seeds do
    timestamp = UTCTimestampNoMicroseconds.new()

    [
      %{
        id: "257a8835-a1bc-48aa-aead-3bf109c4d72a",
        name: "North Darius",
        external_id: "4358d308-3cc1-4105-8ab9-3b473ae8cb92",
        secret_code: "piW5KtukUI/JA8oX",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "fb6c519c-d60b-48ef-9293-3a498f3b45d0",
        name: "North Mireille",
        external_id: "80be6b3a-7be9-4d95-ab1f-1c5ed8aa420b",
        secret_code: "HgZCX7Auc03IbP9T",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "75f5dd5e-8369-4888-86f7-53b2b3d4952d",
        name: "Wehner",
        external_id: "761df2e6-ccfd-43f2-83e6-f95643620989",
        secret_code: "kXyl/CyEcLlvf5a5",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "570f9165-41e0-4caf-8b1b-f56d8e4b75e1",
        name: "Ledner",
        external_id: "739b543b-1fd1-4bc9-807b-470ba34acb0d",
        secret_code: "f/4u5ZHrWKn4x2HB",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "5930bd52-d99c-4141-9075-7e506b00935b",
        name: "Port Annabel",
        external_id: "6c9c0fca-6758-46b1-8f27-30f54539db6b",
        secret_code: "+wHM9TosikLTHPek",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "6213f2a0-fb89-41c5-b596-d50c3e6e84fc",
        name: "East Joany",
        external_id: "0029cca8-eb27-40eb-aac8-5920f6ce9ec8",
        secret_code: "BTp8rHZhg/29SzbY",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "354a18ef-cba5-4f10-a0d0-76c82ca72522",
        name: "Gulgowski",
        external_id: "fbb77930-4e84-4d92-a7fe-7fc62266bc45",
        secret_code: "XRdK5V3QjTFN6+xX",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "a10c2e52-ba6b-402a-990a-2232269a5818",
        name: "Gisselle",
        external_id: "687e7e0f-e3f6-4d89-8156-27a71d5dd0d5",
        secret_code: "VUWE6E1Ydcy5SGUo",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "4de2dbd0-8260-43ea-b2fe-cc67b2eafbd4",
        name: "Leta",
        external_id: "15a0bc63-25cd-48b0-bd98-ea49370b6557",
        secret_code: "S+wtgDw5355IvjIz",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "314bba26-e367-483e-b558-7cc876dcb935",
        name: "Lake Whitney",
        external_id: "a3441da0-142c-4f7e-8681-a670927d6dd9",
        secret_code: "RfFTmv0RqO/gB4i+",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "48025f04-caa3-4f8b-96a5-032b3396b014",
        name: "Dayton",
        external_id: "23b29c33-ab7a-47cc-b268-8877af1d2ef2",
        secret_code: "HHVBnJqsvKG73HtB",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "69bbb644-c3d1-4c31-972e-6274ba2d4afb",
        name: "Reynolds",
        external_id: "2ec6523a-5147-4b79-aade-76dd51c156ae",
        secret_code: "IDj4hKiTgidwWd1M",
        inserted_at: timestamp,
        updated_at: timestamp

      },
      %{
        id: "87b32f31-2b00-44c8-a46b-d93870df6583",
        name: "Bartoletti",
        external_id: "4c4ba884-b358-4055-980e-edea8d6e178d",
        secret_code: "r+WY96xh5YaJeOTn",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "a248e158-fc00-472c-bb4c-160124237211",
        name: "North Dion",
        external_id: "ef1688a1-c936-452d-91d1-7e307dc4b9d0",
        secret_code: "djpJJtiwIkuYWdtd",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "b1184a05-51b0-4b36-8b2a-fdabe7180b98",
        name: "Gaylord",
        external_id: "b8ff75a0-97ab-4452-aae7-61e5fcde92aa",
        secret_code: "OCc+V50gF0Q8rOZG",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "b73f9b9d-7945-4e0f-890e-c96a3a0d0333",
        name: "Zoey",
        external_id: "5e8ebe37-64d2-4b82-877c-20fb62bb9d03",
        secret_code: "vWPbN8U2AUZyfVTB",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "fb341efd-bd2e-49ad-a57c-25b250d175b7",
        name: "New Larissa",
        external_id: "b2ec81f3-34b7-42a8-b92c-8ff7a8e02ce3",
        secret_code: "Cpr/1aJq0vSr/KZs",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "509bf22a-b1fb-4f4e-94cf-2bc401869192",
        name: "Yost",
        external_id: "9510b325-001e-4033-948e-bc147613483e",
        secret_code: "+KtEBAZW2Wu8Ivvm",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "40b7ef90-c048-46f3-9d56-fa6e4315ca47",
        name: "Bogan",
        external_id: "0eca73de-21fa-45fb-847e-fa6aaf3908ac",
        secret_code: "/9/qy16M7NGY128I",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "203825ec-3327-49ee-9be4-222a5c91fb0b",
        name: "DuBuque",
        external_id: "0b1453a5-a004-411a-8c83-093fbf18c562",
        secret_code: "3nDFoMn31FRnc/Mo",
        inserted_at: timestamp,
        updated_at: timestamp
      }
    ]
  end
end
