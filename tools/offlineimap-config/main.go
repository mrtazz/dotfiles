package main

import (
	"bytes"
	"fmt"
	"io/ioutil"
	"log"
	"os"
	"strings"
	"text/template"

	"github.com/alecthomas/kong"
	"gopkg.in/yaml.v3"
)

const version = "0.1.0"

type ConfigRemote struct {
	User     string `yaml:"user"`
	PassItem string `yaml:"passitem"`
	Host     string `yaml:"host"`
}

type ConfigAccount struct {
	Name         string       `yaml:"name"`
	LocalFolder  string       `yaml:"localfolder"`
	PostSyncHook string       `yaml:"postsynchook,omitempty"`
	Remote       ConfigRemote `yaml:"remote"`
}

type ConfigData struct {
	AccountNames string
	Accounts     []ConfigAccount `yaml:"accounts"`
}

var (
	flags struct {
		Debug  bool `help:"Enable debug mode."`
		Render struct {
			Template string `required:"" help:"path to the template to use"`
			Data     string `required:"" help:"path to the yaml data"`
		} `cmd:"" help:"render the given template with the given data and print to STDOUT"`
		ValidateData struct {
			Data string `required:"" help:"path to the yaml data"`
		} `cmd:"" help:"validate format of the data file"`
		Version struct {
		} `cmd:"" help:"print version and exit."`
	}
)

func main() {

	ctx := kong.Parse(&flags)
	switch ctx.Command() {
	case "render":
		data, err := loadConfigData(flags.Render.Data)
		if err != nil {
			fmt.Printf("Error loading config data: %v\n", err)
			os.Exit(1)
		}
		tpl, err := render(flags.Render.Template, data)
		if err != nil {
		}
		fmt.Println(tpl)
	case "validate-data":
		if _, err := loadConfigData(flags.ValidateData.Data); err != nil {
			fmt.Println("Invalid data file format.")
			fmt.Printf("Error: %v\n", err)
			os.Exit(1)
		}
		fmt.Println("Data file format valid.")
	case "version":
		fmt.Printf(version)
		return
	default:
		log.Fatal("Unknown command: " + ctx.Command())
	}
}

func loadConfigData(path string) (ConfigData, error) {
	var c ConfigData
	yamlFile, err := ioutil.ReadFile(path)
	if err != nil {
		return c, err
	}
	err = yaml.Unmarshal(yamlFile, &c)

	accountNames := make([]string, 0, len(c.Accounts))
	for _, account := range c.Accounts {
		accountNames = append(accountNames, account.Name)
	}

	c.AccountNames = strings.Join(accountNames, ",")

	return c, err
}

func render(tplPath string, data ConfigData) (string, error) {

	tplFile, err := ioutil.ReadFile(tplPath)
	if err != nil {
		return "", err
	}

	if flags.Debug {
		fmt.Printf("Got the following template to render:\n%v", string(tplFile))
	}

	tmpl, err := template.New("offlineimap-config").Parse(string(tplFile))
	if err != nil {
		return "", fmt.Errorf("template error: %w", err)
	}
	var b bytes.Buffer
	err = tmpl.Execute(&b, data)
	if err != nil {
		return "", fmt.Errorf("template error: %w", err)
	}
	return b.String(), nil
}
