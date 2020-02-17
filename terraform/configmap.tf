locals {
  gen_config_sh = "gen-config.sh"
}

resource "kubernetes_config_map" "gen_config" {
  metadata {
    name = "gen-config"
  }

  data = {
    "${local.gen_config_sh}" = file("../bin/gen-config.sh")
  }
}
