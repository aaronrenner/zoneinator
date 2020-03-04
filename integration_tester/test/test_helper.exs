base_url = System.get_env("BASE_URL", "http://localhost:4000")

Application.put_env(:wallaby, :base_url, base_url)

{:ok, _} = Application.ensure_all_started(:wallaby)

ExUnit.start()
