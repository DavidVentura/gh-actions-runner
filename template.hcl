job "[[$.JobName]]" {

[[range .Workers]]
  group "[[.NomadArch]]-group" {
    count = [[.Count]]

    constraint {
      attribute = "${attr.cpu.arch}"
      value     = "[[.NomadArch]]"
    }

    task "[[.NomadArch]]-task" {
	  resources {
	    memory = [[.Mem]]
	  }
      driver = "docker"

      config {
        image = "[[$.DockerImage]]:[[.DockerArch]]-latest"
      }
      env {
        GH_REPOSITORY = "[[$.Repo]]"
      }
	  template {
		env  		= true
		destination = "${NOMAD_SECRETS_DIR}/file.env"
	  	data 		= <<EOH
{{ with nomadVar "nomad/jobs/[[$.JobName]]" }}
GH_PAT="{{ .GH_PAT }}"
{{ end }}
EOH
	  }
    }
  }
[[end]]
}
