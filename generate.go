package main

import (
	_ "embed"
	"encoding/json"
	"io/ioutil"
	"os"
	"text/template"
)

//go:embed template.hcl
var hclTmpl string

type Config struct {
	DockerImage string
	Repo        string
	JobName     string
	Workers     []Worker
}
type Worker struct {
	DockerArch string
	NomadArch  string
	Count      uint
	Mem        uint
}

func main() {
	var config Config

	data, err := ioutil.ReadFile("in.json")
	if err != nil {
		panic(err)
	}
	err = json.Unmarshal(data, &config)
	if err != nil {
		panic(err)
	}
	tmpl, err := template.New("name").Delims("[[", "]]").Parse(hclTmpl)
	if err != nil {
		panic(err)
	}
	err = tmpl.Execute(os.Stdout, config)
	if err != nil {
		panic(err)
	}
}
