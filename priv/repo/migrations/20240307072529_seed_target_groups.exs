defmodule DevtestElixir.Repo.Migrations.SeedTargetGroups do
  use Ecto.Migration

  import Ecto.Query, only: [from: 2]

  alias DevtestElixir.Mixins.UTCTimestampNoMicroseconds
  alias DevtestElixir.Repo
  alias DevtestElixir.Schemas.TargetGroup


  @doc """
  If no TargetGroups present, creates the 4 predefined TargetGroups.
  """
  def up do
    if Repo.aggregate(TargetGroup, :count) == 0 do
      Enum.each(
        seeds(),
        fn seed -> %TargetGroup{} |> TargetGroup.changeset(seed) |> Repo.insert! end
      )
    end
  end

  @doc """
  Deletes the 4 predefined TargetGroups if they are present.
  """
  def down do
    Enum.each(
      seeds(),
      fn seed ->
        Repo.delete_all(
          from(
            tg in TargetGroup,
            where:
              tg.id == ^seed.id and
              tg.external_id == ^seed.external_id and
              tg.panel_provider_id == ^seed.panel_provider_id and
              tg.name == ^seed.name
          )
        )
      end
    )
  end


  defp seeds do
    timestamp = UTCTimestampNoMicroseconds.new()

    [
      %{
        id: "c9b2a288-a41a-4707-94c5-2c282a8fbd63",
        external_id: "59055a0f-1bf1-4a6e-a71d-8f64e585b3dd",
        parent_id: nil,
        panel_provider_id: 1,
        name: "A root node",
        secret_code: "YrwjNzGGNgxslYWPQ1fHyA==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "019cde44-ec36-41af-b6dc-fe6a12d824ab",
        external_id: "830690b0-a58d-4d67-bc1d-6b9ce953d01c",
        parent_id: nil,
        panel_provider_id: 2,
        name: "A root node",
        secret_code: "pZU/ZuW6P2tkjTTjwmcduQ==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "bea8242e-8208-4e79-9c32-1a1c366e673d",
        external_id: "392ba110-ccbb-4d36-885f-5f6912664647",
        parent_id: nil,
        panel_provider_id: 3,
        name: "A root node",
        secret_code: "In+1T2zVI6paBaumdZe5ZA==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "40920526-c4b1-4be0-84d6-f844a402b2d9",
        external_id: "871aab15-7c31-4675-9ed5-b361da82bf4a",
        parent_id: nil,
        panel_provider_id: 1,
        name: "A root node",
        secret_code: "FAemJgNM54uEMG5Ghmk8jQ==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "90183e7f-1cc3-4cf4-9ecc-097a21da7ffa",
        external_id: "acce28db-ca77-41d2-91c8-698f64c4575a",
        parent_id: "c9b2a288-a41a-4707-94c5-2c282a8fbd63",
        panel_provider_id: 1,
        name: "A child node",
        secret_code: "GpUic0pIK13ksm+4SkAEig==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "de8de959-43c1-415d-8a44-57e204fd39b3",
        external_id: "afff1c87-8e45-4abd-a57f-fea33a2bc9f2",
        parent_id: "019cde44-ec36-41af-b6dc-fe6a12d824ab",
        panel_provider_id: 2,
        name: "A child node",
        secret_code: "qNw9DzPASKjiMxGp7GNDVQ==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "210a668b-8e14-4ae0-8c8f-347458987613",
        external_id: "b84de5db-5aa1-4223-9466-dabf1968e006",
        parent_id: "bea8242e-8208-4e79-9c32-1a1c366e673d",
        panel_provider_id: 3,
        name: "A child node",
        secret_code: "aKQep0ImM9bqRx4IErGljg==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "916d20a6-1573-439f-8962-adc544e8851f",
        external_id: "f4777c1a-87cc-4dff-a903-6f6427c110a0",
        parent_id: "40920526-c4b1-4be0-84d6-f844a402b2d9",
        panel_provider_id: 2,
        name: "A child node",
        secret_code: "Ddzn00zo6CdK5WYnDP8dkA==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "0d274d01-595e-4a13-b889-c6616cfa5e84",
        external_id: "6f03c61c-1bb9-40b0-adfb-d0a4e074a8f7",
        parent_id: "90183e7f-1cc3-4cf4-9ecc-097a21da7ffa",
        panel_provider_id: 1,
        name: "A child node",
        secret_code: "G4bPjFhzU0Vcf0VkJ7Y0VQ==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "d5cc05db-3336-4033-ac76-8fa37c8f6310",
        external_id: "69a187b6-8686-4314-a8a7-2ce3c7e89827",
        parent_id: "de8de959-43c1-415d-8a44-57e204fd39b3",
        panel_provider_id: 2,
        name: "A child node",
        secret_code: "FqmO86kfeLMQqBZGiOos8w==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "e798f7df-8022-4844-8704-77d4f9502487",
        external_id: "e8159c87-66e2-4124-a121-52981ba26b9e",
        parent_id: "210a668b-8e14-4ae0-8c8f-347458987613",
        panel_provider_id: 3,
        name: "A child node",
        secret_code: "Ku9MfVhysJkg4/5eDEePSg==",
        inserted_at: timestamp,
        updated_at: timestamp
      },
      %{
        id: "5775d2c4-ba9b-4f7e-b942-68a00c7c1fb4",
        external_id: "0130364b-4146-4503-afa6-7ecaac509be2",
        parent_id: "916d20a6-1573-439f-8962-adc544e8851f",
        panel_provider_id: 3,
        name: "A child node",
        secret_code: "YMsPtExcIg7KYPyJwk4NLw==",
        inserted_at: timestamp,
        updated_at: timestamp
      }
    ]
  end
end
